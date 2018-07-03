Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9035E219EE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QL4di3Mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9035E219EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeGCLRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:17:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeGCLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Ep0tW4vUtLnYU64cD9RJOusNXEsO/tQXoetF5LZQQI=; b=QL4di3MvpN7FEvW8/OkECcoEg
        ECH1pIyrdwdCUFhgB9v7jv8GlfYcBcXYizEemL9a3dODF+TfnLuRDbyVMOHpau+cBulq87c2BERzG
        A7LeBUeOLyJrggH5RFRk2wSwfBG/uGD+B3a44XQLlMXRwc6WSJt3iobU4BffUobGSy4OOeTwQZbKd
        QeKnYHXqJsQ9YIH6hUsE7VF5/o4rA38P5YByh7/C+7hBlXjVwWjI/jXerWKpNbh3WbN9Dcjw8fC0X
        BZKKfKtGLNkZqKjh2ZvcDEUtpvmQJbx5YbFcJkKkAvTzSBb3RYtrusnron1t3qpd9+m1xb9H+WdTN
        YVToudiqg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faJJP-0007F0-PA; Tue, 03 Jul 2018 11:17:35 +0000
Date:   Tue, 3 Jul 2018 04:17:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     luto@amacapital.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: Re: [PATCH v2] x86/vdso: Change return type to vm_fault_t for fault
 handlers
Message-ID: <20180703111735.GA3544@bombadil.infradead.org>
References: <20180625175737.GA20042@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625175737.GA20042@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:27:37PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for both fault handler
> vdso_fault() and vvar_fault(). Previously vm_insert_pfn()
> returns err which has to mapped into VM_FAULT_* type.
> The new function vmf_insert_pfn() will replace this
> inefficiency by returning correct VM_FAULT_* type.

> @@ -105,10 +105,10 @@ static int vvar_fault(const struct vm_special_mapping *sm,
>  	 * the page past the end of the vvar mapping.
>  	 */
>  	if (sym_offset == 0)
> -		return VM_FAULT_SIGBUS;
> +		return ret;
>  
>  	if (sym_offset == image->sym_vvar_page) {
> -		ret = vm_insert_pfn(vma, vmf->address,
> +		ret = vmf_insert_pfn(vma, vmf->address,
>  				    __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
>  	} else if (sym_offset == image->sym_pvclock_page) {
>  		struct pvclock_vsyscall_time_info *pvti =
> @@ -124,14 +124,11 @@ static int vvar_fault(const struct vm_special_mapping *sm,

Haven't you missed converting vm_insert_pfn_prot() at line 117?
Did you test-compile this?

