Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA5AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55A520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EqxMONlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55A520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbeHAJhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:37:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37590 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbeHAJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2C2UJNS6WnwgwTaRtJU/8pBAOObVjcFNdgI/rLA1WLs=; b=EqxMONlRa2V482aibu3BKWs/F
        GaGmLaaJJDd3p6qRzStZL6s7HX/9nprV5+jWRFl0+Q1f6EheDixFnJDHl/O+DOkYKzMH7UY14mtdY
        oo5Cd+o36NK1m5QRSVW4JInjGl90mxKbw99KglkjvL5D9Kv1AG7Bs+CXQLlCFGF/Ui64sbdhXWqT1
        tlZY+4D8YuQCpXwHySk3Xv4/yB5grUDk8lLZVQA/ydIFADVD1Pvu4mnOWhgA9DtIAKmmqFVQKG1ln
        RioGSetB9As3gl8WSf5MBl+4GWanUR4+MZ4OhWYJHstHhL9tz8zMKntpD5MQbXhk9KQw5HV/5Kg4m
        eV720tM6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fklwe-0002My-6l; Wed, 01 Aug 2018 07:53:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3C992027585B; Wed,  1 Aug 2018 09:53:17 +0200 (CEST)
Date:   Wed, 1 Aug 2018 09:53:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: ARC show_regs() triggers preempt debug splat, lockdep
Message-ID: <20180801075317.GZ2494@hirez.programming.kicks-ass.net>
References: <5c3cfd4d-46d2-d817-a29a-1890d84c1fbb@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3cfd4d-46d2-d817-a29a-1890d84c1fbb@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 02:26:32PM -0700, Vineet Gupta wrote:
> Hi Peter, Al,
> 
> Reaching out about a problem I understand, but not quite sure how to fix it.
> Its the weird feeling of how was this working all along, if at all.
> 
> With print-fatal-signals enabled, there's CONFIG_DEBUG_PREEMPT splat all over,
> even with a simple single threaded segv inducing program (console log below). This
> originally came to light with a glibc test suite tst-tls3-malloc which is a
> multi-threaded monster.
> 
> ARC show_regs() is a bit more fancy as it tries to print the executable path,
> faulting vma name (in case it was a shared lib etc). This involves taking a bunch
> of customary locks which seems to be tripping the debug infra.

Right, so I think that that is a fairly dodgy thing to do. As shown in
your subsequent email, if a pagefault generates a signal we might
already be holding the mmap_sem.

The thing you could do is maybe use down_read_trylock() there.

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 783b20354f8b..bb7bde11d2c8 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -92,7 +92,10 @@ static void show_faulting_vma(unsigned long address, char *buf)
 	/* can't use print_vma_addr() yet as it doesn't check for
 	 * non-inclusive vma
 	 */
-	down_read(&active_mm->mmap_sem);
+	if (!down_read_trylock(&active_mm->mmap_sem)) {
+		pr_info("    @Trylock failed\n");
+		return;
+	}
 	vma = find_vma(active_mm, address);
 
 	/* check against the find_vma( ) behaviour which returns the next VMA
