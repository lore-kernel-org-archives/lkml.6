Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20EA208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20EA208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeGQFnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:43:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53938 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeGQFnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:43:24 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ffIHi-0000KV-GS; Tue, 17 Jul 2018 07:12:26 +0200
Date:   Tue, 17 Jul 2018 07:12:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     jiang.biao2@zte.com.cn
cc:     dave.hansen@linux.intel.com, mingo@redhat.com, luto@kernel.org,
        hpa@zytor.com, x86@kernel.org, albcamus@gmail.com,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
Subject: Re: [PATCH 1/5] x86/pti: check the return value
 ofpti_user_pagetable_walk_p4d
In-Reply-To: <201807170921230159625@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1807170711580.1693@nanos.tec.linutronix.de>
References: 1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn,384c5426-8589-2931-081b-14382c83962b@linux.intel.com <201807170921230159625@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, jiang.biao2@zte.com.cn wrote:
> > On 07/15/2018 09:03 PM, Jiang Biao wrote:
> >> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> >> index 4d418e7..be9e5bc 100644
> >> --- a/arch/x86/mm/pti.c
> >> +++ b/arch/x86/mm/pti.c
> >> @@ -195,8 +195,10 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
> >>  static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
> >>  {
> >>      gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
> >> -    p4d_t *p4d = pti_user_pagetable_walk_p4d(address);
> >>      pud_t *pud;
> >> +    p4d_t *p4d = pti_user_pagetable_walk_p4d(address);
> >> +    if (WARN_ON(!p4d))
> >> +        return NULL;
> > 
> > First of all, I don't think we need the (new) warning here.
> > pti_user_pagetable_walk_p4d() only returns NULL if you try it on a
> > userspace _address_ or the page allocation fails.  It already warns on
> > the address case.
> > 
> > If you think the allocation path needs a warning, please do it as close
> > as possible to the _source_ of the warning (the failed allocation), not
> > in the caller.
> Hi,
> Just taking  pti_clone_pmds() as reference, which add warning for NULL 
> *target_pmd*. The warning does not really matter, I will remove the 
> *WARN_ON* here and add a warning close to the failed allocation. 
> Furthermore do you think we need to check  _NULL_ return value?  
> to avoid NULL pointer dereference when the return value is used later, 
> such as,
>   p4d_large(*p4d) //p4d is return value of pti_user_pagetable_walk_p4d
>   *user_p4d = *kernel_p4d;//user_p4d is return value of pti_user_pagetable_walk_p4d

The Null pointer check makes sense.

Thanks,

	tglx
