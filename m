Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A67C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E11B218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfBKNW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:22:26 -0500
Received: from foss.arm.com ([217.140.101.70]:48362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfBKNWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:22:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A6FE80D;
        Mon, 11 Feb 2019 05:22:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A157D3F557;
        Mon, 11 Feb 2019 05:22:23 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org
Cc:     akpm@linux-foundation.org, anders.roxell@linaro.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        naresh.kamboju@linaro.org, peterz@infradead.org,
        will.deacon@arm.com
Subject: [PATCHv2 0/2] locking/atomics: fix and improvement
Date:   Mon, 11 Feb 2019 13:22:11 +0000
Message-Id: <20190211132213.15249-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

[Apologies for the duplicate send of this, I typo'd LKML in my initial attempt]

I hope that these atomic scripting patches address your concerns with
the atomics scripting infrastructure. These are based on the tip master
branch, leaving the headers checked-in.

Since v1 [1]:
* rebase (and retest) atop of tip:master
* fold in acks

The primary improvement is using a hash to detect when the headers have
been erroneously modified, meaning check-atomics.sh takes ~0.15s, which
I believe should be palatable.

It also turns out that some people are building without coreutils, so
I've picked up Anders' fix for this. Since sha1sum is part of coreutils,
the checks are skipped when this isn't present, on the assumption that
anyone actually sending patches will have a working coreutils.

Are you happy to pick these up?

Thanks,
Mark.

[1] https://lore.kernel.org/lkml/20181210175035.45096-1-mark.rutland@arm.com/T/#m39ee97e01a02b5d054cca4d028445bb3a9818e91

Anders Roxell (1):
  locking/atomics: Change 'fold' to 'grep'

Mark Rutland (1):
  locking/atomics: Check atomic headers with sha1sum

 include/asm-generic/atomic-instrumented.h |  1 +
 include/asm-generic/atomic-long.h         |  1 +
 include/linux/atomic-fallback.h           |  1 +
 scripts/atomic/atomic-tbl.sh              |  2 +-
 scripts/atomic/check-atomics.sh           | 26 ++++++++++++++++++++------
 scripts/atomic/gen-atomics.sh             | 20 ++++++++++++++++++++
 6 files changed, 44 insertions(+), 7 deletions(-)
 create mode 100755 scripts/atomic/gen-atomics.sh

-- 
2.11.0

