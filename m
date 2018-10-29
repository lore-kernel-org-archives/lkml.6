Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A25FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72172082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yxiFEKYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72172082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ2X34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:29:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36558 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeJ2X34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vHH+C4yV6AQ6wDGHaH4p8JPVdMLPOx3K5lhBCq8hS1c=; b=yxiFEKYzcg0e9s/CBs+iCEUbK
        +keMreh4JHT+HGuKiXkQiHQUKxyu7BVe9+RGmdMINz+4IdEgDroRh3HN/sVwx5FsIn4LdvpQmBFe7
        /XGyDsv4kLF0MXZphTAVEHwEMXeYp+Tlz7V1175Lt53eAJd1bdaD9bSKAOQcds632cUkpOkx+i1Li
        R4arGNDDdkFmd0Zxi/TEof0j4aKEmJ8FYlK1vrQZ4HNMV35Hpg2Ww0wtqjmf53VHJWgFn5E4lMIMr
        GPKZzaWFbnakijV7umBw+MHDjBfA/GOa3syOLRWaiptQMsfn6Cim3jNlaf4wlXLOiTAAwFJL1JE4k
        qhTV02mAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gH8im-0005U4-UK; Mon, 29 Oct 2018 14:40:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE3A8202A40B7; Mon, 29 Oct 2018 15:40:46 +0100 (CET)
Date:   Mon, 29 Oct 2018 15:40:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Message-ID: <20181029144046.GC744@hirez.programming.kicks-ass.net>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com>
 <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 02:38:44PM -0700, Sai Praneeth Prakhya wrote:
> +int kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
> +			      unsigned long numpages)
> +{
> +	int retval;
> +
> +	/*
> +	 * The typical sequence for unmapping is to find a pte through
> +	 * lookup_address_in_pgd() (ideally, it should never return NULL because
> +	 * the address is already mapped) and change it's protections.
> +	 * As pfn is the *target* of a mapping, it's not useful while unmapping.
> +	 */
> +	struct cpa_data cpa = {
> +		.vaddr		= &address,
> +		.pgd		= pgd,
> +		.numpages	= numpages,
> +		.mask_set	= __pgprot(0),
> +		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
> +		.flags		= 0,
> +	};
> +
> +	retval = __change_page_attr_set_clr(&cpa, 0);
> +	__flush_tlb_all();

How is that not a TLB invalidation bug ?

> +
> +	return retval;
> +}
