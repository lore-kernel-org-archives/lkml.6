Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4F1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C92084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0C92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeGSLLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:11:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeGSLLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:11:50 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fg6BJ-0005ST-Lf; Thu, 19 Jul 2018 12:29:09 +0200
Date:   Thu, 19 Jul 2018 12:29:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiang Biao <jiang.biao2@zte.com.cn>
cc:     mingo@redhat.com, dave.hansen@linux.intel.com, luto@kernel.org,
        hpa@zytor.com, x86@kernel.org, albcamus@gmail.com,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
Subject: Re: [PATCH v3 1/2] x86/pti: check the return value of
 pti_user_pagetable_walk_p4d
In-Reply-To: <1531870163-39088-1-git-send-email-jiang.biao2@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1807191225230.1602@nanos.tec.linutronix.de>
References: <1531870163-39088-1-git-send-email-jiang.biao2@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Jiang Biao wrote:

> pti_user_pagetable_walk_p4d() may return NULL, we should check the
> return value to avoid NULL pointer dereference. And add warning
> for fail allocation where NULL returned.
> 
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  arch/x86/mm/pti.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 4d418e7..5c33a16 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -176,7 +176,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
>  
>  	if (pgd_none(*pgd)) {
>  		unsigned long new_p4d_page = __get_free_page(gfp);
> -		if (!new_p4d_page)
> +		if (WARN_ON(!new_p4d_page))

WARN_ON_ONCE() please

>  			return NULL;
>  
>  		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
> @@ -195,9 +195,12 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
>  static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
>  {
>  	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
> -	p4d_t *p4d = pti_user_pagetable_walk_p4d(address);
>  	pud_t *pud;
>  
> +	p4d_t *p4d = pti_user_pagetable_walk_p4d(address);

No. This really is not how it should be done.

  	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	p4d_t *p4d = pti_user_pagetable_walk_p4d(address);
+	p4d_t *p4d;
  	pud_t *pud;

+	p4d = pti_user_pagetable_walk_p4d(address);
+	if (!p4d)
+		return NULL;

Ditto for patch 2/2.

>  	BUILD_BUG_ON(p4d_large(*p4d) != 0);
>  	if (p4d_none(*p4d)) {
>  		unsigned long new_pud_page = __get_free_page(gfp);
> @@ -354,6 +357,9 @@ static void __init pti_clone_p4d(unsigned long addr)
>  	pgd_t *kernel_pgd;
>  
>  	user_p4d = pti_user_pagetable_walk_p4d(addr);
> +	if (!user_p4d)
> +		return;	
> +
>  	kernel_pgd = pgd_offset_k(addr);
>  	kernel_p4d = p4d_offset(kernel_pgd, addr);
>  	*user_p4d = *kernel_p4d;

Aside of that the patch has trailing white space in 2 places. Please take
the patch and apply it to your git tree localy before submitting it.

Thanks,

	tglx
