Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A884C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7563218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfBLCMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:12:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:63677 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfBLCMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:12:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 18:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="142618119"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2019 18:12:48 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or,
        tglx@linutronix.de, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 0/6] x86, mm: refine split_mem_range a little
Date:   Tue, 12 Feb 2019 10:12:09 +0800
Message-Id: <20190212021215.13247-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split_mem_range is used to prepare range before mapping kernel page table.
Here are some patches to refine it.

Patch [1-2] are trivial clean up.
Patch [3]   add some comment to illustrate the split process and prepare for
            following refine work.
Patch [4-6] are the interesting refine.

There are totally 3 kinds of ranges, while 1G range is only valid on x86_64.
Because of this, the code needs to handle two different configurations. The
conditional macro makes it a little difficult to understand the logic.

We could simplify the logic with a different perception of those ranges, this
is done in Patch [4]. The change is a little, while the result is neat and
clean.

After this, the refreshed code shows we could skip some redundant work when
the range doesn't span PMD or PUD. This is in Patch [4-5].

Wei Yang (6):
  x86, mm: remove second argument of split_mem_range()
  x86, mm: remove check in save_mr
  x86, mm: add comment for split_mem_range to help understanding
  x86, mm: make split_mem_range() more easy to read
  x86, mm: skip 1G range if the range doesn't span PUD
  x86, mm: x86, mm: jump to split only 4K range when range doesn't span
    PMD

 arch/x86/mm/init.c | 87 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 26 deletions(-)

-- 
2.19.1

