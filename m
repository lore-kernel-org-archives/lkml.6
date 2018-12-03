Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436FCC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058822087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BlPjJk/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058822087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeLCPlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:41:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeLCPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=izBmKq96eItOJxUT9EkHBodHRiNUEfEnzS9ETYchqNI=; b=BlPjJk/C/Bzo7BesLsY4V836r
        NBIu0BnMlGc43g6qatUz/xQo7vh3ok6ZO0yS3vQP4PL/QvSEWt6VXUQewBDG29Qxod9gg0cSdEPTr
        KJpf2ON3mH74Q7/YuqW73Uz4WvyZ20s2nfz2qCCbxHGwuvFD2T4bc6/O5LevifC4bq5rVjhrEGHde
        z7248/duNlTn0wGRIlJK8q442BMMAK74MQ3/C+VSG5ePFp8fqQC+zB0NXHIseK9SYmJVaJ07eA0/d
        b5HHNusdyVDoxclVvgF/GNfIhpFi0mb0YMdyAR0vn86xkrc2bVDK8KBmdNkCIoa77xItN5vu7LM5a
        4m/9iqNtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTqLI-0004AH-TJ; Mon, 03 Dec 2018 15:41:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A0D62029FD58; Mon,  3 Dec 2018 16:41:02 +0100 (CET)
Date:   Mon, 3 Dec 2018 16:41:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "StDenis, Tom" <Tom.StDenis@amd.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Message-ID: <20181203154102.GI11614@hirez.programming.kicks-ass.net>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
 <20181130153128.GB11650@hirez.programming.kicks-ass.net>
 <8ee4e546-4680-e463-23ac-64489a60b946@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ee4e546-4680-e463-23ac-64489a60b946@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:19:46PM +0000, StDenis, Tom wrote:
> NAK I get a failure in TTM on init with your x86/mm branch (see attached 
> dmesg).

So the good news is that with some additional self-tests I can trivially
reproduce this. The bad news is that an otherwise straight forward
cleanup seems to make CPA horribly mad at me.

And since we're somewhat late in the release cycle, I suppose we should
do the simple thing first, and then I can try and figure out this CPA
mess later.

So how about this relatively simple partial revert to sort the problem.

---
Subject: x86/mm/cpa: Fix cpa_flush_array() TLB invalidation

In commit:

  a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")

I misread the cpa array code and incorrectly used
tlb_flush_kernel_range(), resulting in missing TLB flushes and
consequent failures.

Instead do a full invalidate in this case -- for now.

Fixes: a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")
Reported-by: "StDenis, Tom" <Tom.StDenis@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index bac35001d896..61bc7d1800d7 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,20 +285,16 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static bool __cpa_flush_range(unsigned long start, int numpages, int cache)
+static bool __inv_flush_all(int cache)
 {
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	WARN_ON(PAGE_ALIGN(start) != start);
-
 	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
 		return true;
 	}
 
-	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
-
-	return !cache;
+	return false;
 }
 
 static void cpa_flush_range(unsigned long start, int numpages, int cache)
@@ -306,7 +302,14 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	unsigned int i, level;
 	unsigned long addr;
 
-	if (__cpa_flush_range(start, numpages, cache))
+	WARN_ON(PAGE_ALIGN(start) != start);
+
+	if (__inv_flush_all(cache))
+		return;
+
+	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
+
+	if (!cache)
 		return;
 
 	/*
@@ -332,7 +335,12 @@ static void cpa_flush_array(unsigned long baddr, unsigned long *start,
 {
 	unsigned int i, level;
 
-	if (__cpa_flush_range(baddr, numpages, cache))
+	if (__inv_flush_all(cache))
+		return;
+
+	flush_tlb_all();
+
+	if (!cache)
 		return;
 
 	/*
