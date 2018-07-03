Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E7C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF2224CAF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E5ZAQkq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF2224CAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeGCMLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:11:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeGCMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QznyR9wbXsb1glBXc1TK84KSwK+gqIcc1tSjSFXFU3Q=; b=E5ZAQkq6LIOxOJ/+1PGeNoUZC
        2tsgn7SpwK25oMlAX4nQmtXNGKwz2GY7Qice7oZMu3qA5zDxdDTV5EwxUtY/418JZ9pI2jkO1D1aW
        XEgBhUq/YXPEdIo4Jn3Z7c2mnid0YoMxdefczZzJ9Ozwjujld2uN0BNeFbc30qKq8kvPmFN3GEZsm
        EagJD57IfUhaVRF/0ZtT/V1VHnFLXQ69rxgQidbfOJa5h3vQyXR0shIlXdTIQCCfICvMCzXtF/zqW
        fau6xmxJA6tJjR0U9GKQ4/i+xYs0CLRMw4UwHCJnBanVJ8bXRb1T28L8pdkj5oH/RbYvYOEB/HijU
        2qhjio45Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faK9S-0005DG-GX; Tue, 03 Jul 2018 12:11:22 +0000
Date:   Tue, 3 Jul 2018 05:11:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Subject: Re: [PATCH v2] x86/vdso: Change return type to vm_fault_t for fault
 handlers
Message-ID: <20180703121122.GB3544@bombadil.infradead.org>
References: <20180625175737.GA20042@jordon-HP-15-Notebook-PC>
 <20180703111735.GA3544@bombadil.infradead.org>
 <CAFqt6zaiFuHZKwp+Ou67hLX=JiqTzZ9v3hjaHj3+BYQi+-=Ebg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zaiFuHZKwp+Ou67hLX=JiqTzZ9v3hjaHj3+BYQi+-=Ebg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:18:30PM +0530, Souptick Joarder wrote:
> On Tue, Jul 3, 2018 at 4:47 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Jun 25, 2018 at 11:27:37PM +0530, Souptick Joarder wrote:
> >> Use new return type vm_fault_t for both fault handler
> >> vdso_fault() and vvar_fault(). Previously vm_insert_pfn()
> >> returns err which has to mapped into VM_FAULT_* type.
> >> The new function vmf_insert_pfn() will replace this
> >> inefficiency by returning correct VM_FAULT_* type.
> >
> >> @@ -105,10 +105,10 @@ static int vvar_fault(const struct vm_special_mapping *sm,
> >>        * the page past the end of the vvar mapping.
> >>        */
> >>       if (sym_offset == 0)
> >> -             return VM_FAULT_SIGBUS;
> >> +             return ret;
> >>
> >>       if (sym_offset == image->sym_vvar_page) {
> >> -             ret = vm_insert_pfn(vma, vmf->address,
> >> +             ret = vmf_insert_pfn(vma, vmf->address,
> >>                                   __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
> >>       } else if (sym_offset == image->sym_pvclock_page) {
> >>               struct pvclock_vsyscall_time_info *pvti =
> >> @@ -124,14 +124,11 @@ static int vvar_fault(const struct vm_special_mapping *sm,
> >
> > Haven't you missed converting vm_insert_pfn_prot() at line 117?
> > Did you test-compile this?
> >
> 
> I left it intentionally in this patch. When we will be replacing
> vm_insert_foo() with new API vmf_insert_foo(), vm_insert_pfn_prot
> need to be changed to return vm_fault_t type.
> 
> I will change the return type of vm_insert_pfn_prot() in that patch.

What?!  That's just broken.  vm_insert_pfn_prot returns an errno, so
this patch introduces a bug where sometimes 'ret' contains a vm_fault_t
and sometimes contains an errno.  That's exactly the kind of thing this
patch series is supposed to be *preventing*, not introducing!

I'll send a replacement patch series to do this properly.
