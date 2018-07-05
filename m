Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C708C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8B7241AC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8B7241AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeGEG2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:28:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeGEG2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:28:30 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faxkd-0003yC-LG; Thu, 05 Jul 2018 08:28:23 +0200
Date:   Thu, 5 Jul 2018 08:28:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bin Yang <bin.yang@intel.com>
cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
In-Reply-To: <1530769636-26603-1-git-send-email-bin.yang@intel.com>
Message-ID: <alpine.DEB.2.21.1807050815570.1579@nanos.tec.linutronix.de>
References: <1530769636-26603-1-git-send-email-bin.yang@intel.com>
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

On Thu, 5 Jul 2018, Bin Yang wrote:
>  static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
> -				   unsigned long pfn)
> +				   unsigned long pfn, unsigned long *page_num)
>  {
>  	pgprot_t forbidden = __pgprot(0);
> +	unsigned long tmp;
> +	unsigned long num = PUD_PAGE_SIZE >> PAGE_SHIFT;

Everything is a PUD? Oh well, you clearly made a lot of effort to
understand the code you are changing.

>  	/*
>  	 * The BIOS area between 640k and 1Mb needs to be executable for
>  	 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
>  	 */
>  #ifdef CONFIG_PCI_BIOS
> -	if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
> -		pgprot_val(forbidden) |= _PAGE_NX;
> +	if (pcibios_enabled) {
> +		tmp = (BIOS_BEGIN >> PAGE_SHIFT) > pfn ?
> +			(BIOS_BEGIN >> PAGE_SHIFT) - pfn : ULONG_MAX;
> +		if (within(pfn, BIOS_BEGIN >> PAGE_SHIFT,
> +		    BIOS_END >> PAGE_SHIFT)) {
> +			pgprot_val(forbidden) |= _PAGE_NX;
> +			tmp = (BIOS_END >> PAGE_SHIFT) - pfn;
> +		}
> +		num = num > tmp ? tmp : num;

What? I really gave you a hint which used a overlaps() helper in the pseudo
code. But sure open coding the same thing in 5 places is faster, right?

You managed to make this code completely unreadable and I'm not even trying
to review that mess.

> +	for (i = 0; i < (psize >> PAGE_SHIFT);
> +	    i += pnum, addr += PAGE_SIZE * pnum, pfn += pnum) {
> +		pgprot_t chk_prot =
> +			static_protections(req_prot, addr, pfn, &pnum);

When done right, then there is no need for a loop at all. And I told you so.
But that would need more effort than creating a trainwreck, right? 

Stop sending half baken and half thought out patches. I really spent a lot
of time explaining you things in detail and giving you hints how it should
be done. Feel free to ignore me, but don't be surprised if I'm ignoring you
as well.

Thanks,

	tglx


