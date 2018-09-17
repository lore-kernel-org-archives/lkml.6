Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F423ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511CD214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511CD214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeIQUEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:04:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeIQUEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:04:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1ue5-0008SA-UJ; Mon, 17 Sep 2018 16:37:02 +0200
Message-Id: <20180917142906.384767038@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 17 Sep 2018 16:29:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch V3 00/11] x86/mm/cpa: Improve large page preservation handling
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd revision of this series. Previous versions are here:

  https://lkml.kernel.org/r/20180907150119.325866892@linutronix.de
  https://lkml.kernel.org/r/20180914130917.155416208@linutronix.de

Changes since v2:

  - Fix the print format so it works for 32bit(PAE) and 64bit

  - Make mark_rodata_do() on 32bit convert text and rodata in one go to
    prevent the 'invalid existing mapping' check to trigger

Bin reported that try_preserve_large_page() in the page attribute code
consumes an large amount of CPU time. His initial attempts of addressing
this made me look deeper into the code.

The logic in this code is not really intelligent. It requires to check a
large page in 4k steps for conflicts. That's insane as most operations do
not conflict at all.

The code also lacks sanity checks which allow to detect whether the
existing mapping is incorrect vs. the static protections.

Any form of debugging or statistics is missing as well.

The following series addresses this:

  - Clean up the code so it becomes extensible

  - Provide the ability to check a full range for conflicts

  - Add debug output and statistics to quantify the changes and to allow
    observation of the mechanism in the future.

  - Add a sanity check for existing mappings with a fixup for the 2M case
    and a warning for the 1G case. The 2M case is trivial to address, the
    1G case requires larger changes and is just warned about for now.

  - Avoid conflict checks for operations which clear the PRESENT bit

  - Utilize the range checks to detect conflicts in one operation

  - Drop the 4k wise checking which turned out to provide no extra large
    page preservation in testing. There might be corner cases where a page
    would be preserved, but that's overkill for the common cases.

Before:
 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800770
 4K pages set-checked:             7668

After:
 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  538
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages set-checked:             7668

This gets rid of ~800000 checks whether a particular address is with a
static protection region. Each check tests against 4 different regions,
which adds up to several million instructions.

Thanks,

	tglx

8<---------------------
 Kconfig       |    8 
 mm/init_32.c  |   23 --
 mm/pageattr.c |  516 +++++++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 396 insertions(+), 151 deletions(-)

