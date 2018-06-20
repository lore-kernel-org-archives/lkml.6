Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22888208A6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AEqU61ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22888208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeFTJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:18:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeFTJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eMR7ibTmNe3ELDK64esigCjsQC4vZ1gIcPqREVgCnZk=; b=AEqU61ph9g6gnWPKf+wdsQvn2
        72+NWq3ih/NAd75Bpruke9Ker9fOHNJOgAoXn0pLTC1qEGMJEtNcrWGEJSRIeJITCCUenAwbucHpB
        Qs3OP4zA7KyXkHSdtsisJbGOt2Rew3WDjYKX/xd4oTpfngIIZka8ynpL7CvDsK85RZ11GSaOkfzxw
        q1INf38HksTau737ccrhVORjIJvXOHD/dP2t0jBAk3Lq+ww/kNi0qKWmL5bN4P5tDP8H8J/Yure+j
        UHEpqb0EQTEj0aw0+NcNVgfJar53RssQ4im5mYMz8sjBjofuMz+WuBeuiet9szkU9XodCZLNoUXb2
        tMdsd7t1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVZFR-00007G-Tu; Wed, 20 Jun 2018 09:17:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 496122029F1DD; Wed, 20 Jun 2018 11:17:52 +0200 (CEST)
Date:   Wed, 20 Jun 2018 11:17:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] locking/rwsem: Fix up_read_non_owner() warning with
 DEBUG_RWSEMS
Message-ID: <20180620091752.GL2476@hirez.programming.kicks-ass.net>
References: <1527168398-4291-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527168398-4291-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 09:26:38AM -0400, Waiman Long wrote:
> It was found that the use of up_read_non_owner() in NFS was causing
> the following warning when DEBUG_RWSEMS was configured.
> 
>   DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)(1UL << 0)))
> 
> Looking into the rwsem.c file, it was discovered that the corresponding
> down_read_non_owner() function was not setting the owner field properly.
> This is fixed now, and the warning should be gone.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/locking/rwsem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index bc1e507..776308d 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -181,6 +181,7 @@ void down_read_non_owner(struct rw_semaphore *sem)
>  	might_sleep();
>  
>  	__down_read(sem);
> +	rwsem_set_reader_owned(sem);
>  }
>  
>  EXPORT_SYMBOL(down_read_non_owner);
> -- 
> 1.8.3.1
> 
