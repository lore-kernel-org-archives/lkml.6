Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCC82083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FY7UV3fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCC82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756852AbeFSJ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:26:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756270AbeFSJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QS+xCKoIvL2Rqc04qEuDccQx26EsRfpiNnCMNC0f/hU=; b=FY7UV3fRzFSlQGNQTNAWul/Uo
        0ePAB1NicqKpvmyN9n4btPZeDrDpEVXAg5NxCTiNrqUtPOsdNvPSOzD/nTlCth1Hu3eLbao8m8BMR
        NNyDWO0+jvlZ9qtz7lnmrvQXQsFyePlbExh9fhYDjbEm4gTmvP3oWddJfGLpSe4uj0cvhSe5CU/qd
        57A35t+2tOh5U+ZUYHHkntTAZGqEYE/BMrpllShtj0kX7dOScl2ytE9Kvw9XspIznQuvabJv2iV71
        kizvyGHN0uJXUCVt11JjlPxOrCVv1Xd5qfPQll2owhxyAIR33wkhE4B5HNYv6X+Q3QPf/IiZTh73J
        7O6aUT0XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVCu0-0002CC-KY; Tue, 19 Jun 2018 09:26:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 528452011CEBD; Tue, 19 Jun 2018 11:26:14 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:26:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] ARC: Improve cmpxchng syscall implementation
Message-ID: <20180619092614.GD2494@hirez.programming.kicks-ass.net>
References: <20180319110002.27419-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319110002.27419-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 02:00:02PM +0300, Alexey Brodkin wrote:
> diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
> index 5ac3b547453f..d7d3e16133d6 100644
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -47,7 +47,9 @@ SYSCALL_DEFINE0(arc_gettls)
>  SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>  {
>  	struct pt_regs *regs = current_pt_regs();
> +	struct page *page;
> +	u32 val;
> +	int ret;
>  
>  	/*
>  	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
> @@ -60,23 +62,48 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>  	/* Z indicates to userspace if operation succeded */
>  	regs->status32 &= ~STATUS_Z_MASK;
>  
> +	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
> +	if (!ret)
> +		goto fail;
>  
> +again:
>  	preempt_disable();
>  
> +	ret = __get_user(val, uaddr);
> +	if (ret == -EFAULT) {
> +		preempt_enable();
> +		ret = get_user_pages_fast((unsigned long)uaddr, 1, 1, &page);
> +		if (ret < 0)
> +			goto fail;
> +
> +		put_page(page);
> +		goto again;
> +	} else if (ret)
> +		goto fail;

goto fail with preempt disabled.

> +
> +	if (val == expected) {
> +		ret = __put_user(new, uaddr);
> +		if (!ret)
>  			regs->status32 |= STATUS_Z_MASK;
>  	}
>  
> -done:
>  	preempt_enable();
>  
> -	return uval;
> +	if (ret == -EFAULT) {
> +		ret = get_user_pages_fast((unsigned long)uaddr, 1, 1, &page);
> +		if (ret < 0)
> +			goto fail;
> +
> +		put_page(page);
> +		goto again;
> +	} else if (ret)
> +		goto fail;
> +
> +	return val;
> +
> +fail:
> +	force_sig(SIGSEGV, current);
> +	return ret;
>  }

Sorry for the delay, but I would write it like:

--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -47,7 +47,9 @@ SYSCALL_DEFINE0(arc_gettls)
 SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 {
 	struct pt_regs *regs = current_pt_regs();
-	int uval = -EFAULT;
+	struct page *page;
+	u32 val;
+	int ret;
 
 	/*
 	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
@@ -60,23 +62,46 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *,
 	/* Z indicates to userspace if operation succeded */
 	regs->status32 &= ~STATUS_Z_MASK;
 
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
+	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
+	if (!ret)
+		goto fail;
 
+again:
 	preempt_disable();
 
-	if (__get_user(uval, uaddr))
-		goto done;
+	ret = __get_user(val, uaddr);
+	if (ret)
+		goto fault;
 
-	if (uval == expected) {
-		if (!__put_user(new, uaddr))
-			regs->status32 |= STATUS_Z_MASK;
-	}
+	if (val != expected)
+		goto out;
 
-done:
+	ret = __put_user(new, uaddr);
+	if (ret)
+		goto fault;
+
+	regs->status32 |= STATUS_Z_MASK;
+
+out:
 	preempt_enable();
+	return val;
+
+fault:
+	preempt_enable();
+
+	if (unlikely(ret != -EFAULT))
+		goto fail;
 
-	return uval;
+	down_read(&current->mm->mmap_sem);
+	ret = fixup_user_fault(current, current->mm, uaddr, FAULT_FLAG_WRITE, NULL);
+	up_read(&current->mm->mmap_sem);
+
+	if (likely(!ret))
+		goto again;
+
+fail:
+	force_sig(SIGSEGV, current);
+	return ret;
 }
 
 #ifdef CONFIG_ISA_ARCV2
