Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2704AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DB720659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mXE2D0wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DB720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIEQSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:18:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60760 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeIEQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/nMfqAiw0FAmFBXAMP3SpJUZXs4gyHws8ers0ywVPoQ=; b=mXE2D0wy5YQ7NM4SPJ/yhj4i+
        R0IEpJBUm9QgbpDxRJTJySImOQmbSJnARk5iRVoGkMg8pDky6y2bpmKYyxtnRGgk9fqtmmDXkoN2g
        TG8jPXjYYfkV5/8pUwa3ZRByBHNhLetpA2cqVfel9rJ8e3GnRpTUJHnbz1quNnDj18uyEy4+3PklW
        kuv36rNK88pTVP80+fGD3kQIl7IAybdHabbH57YevMzIw4ZKP9DsKECCLq/dvVg8HX7erNA/OdG7a
        5wknyGbpnOTbfF16/QnZrWkfsVv8pMRPAFbm35yqY0COIOBE3zhxcxLk7Aqe9hCaCILy8kD1bVBdf
        NsskP/3YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxWIU-00051W-Md; Wed, 05 Sep 2018 11:48:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62B02202AFE0E; Wed,  5 Sep 2018 13:48:33 +0200 (CEST)
Date:   Wed, 5 Sep 2018 13:48:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
Message-ID: <20180905114833.GW24082@hirez.programming.kicks-ass.net>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 03:12:27PM -0700, Sai Praneeth Prakhya wrote:
> +void __init efi_save_original_memmap(void)
> +{
> +	efi_memory_desc_t *md;
> +	void *remapped_phys, *new_md;
> +	phys_addr_t new_phys, new_size;
> +
> +	new_size = efi.memmap.desc_size * efi.memmap.nr_map;
> +	new_phys = efi_memmap_alloc(efi.memmap.nr_map);
> +	if (!new_phys) {
> +		pr_err("Failed to allocate new EFI memmap\n");
> +		return;
> +	}
> +
> +	remapped_phys = memremap(new_phys, new_size, MEMREMAP_WB);
> +	if (!remapped_phys) {
> +		pr_err("Failed to remap new EFI memmap\n");
> +		__free_pages(pfn_to_page(PHYS_PFN(new_phys)), get_order(new_size));
> +		return;
> +	}
> +
> +	new_md = remapped_phys;
> +	for_each_efi_memory_desc(md) {
> +		memcpy(new_md, md, efi.memmap.desc_size);
> +		new_md += efi.memmap.desc_size;
> +	}

Should we ioremap_prot(remapped_phys, new_size, PROT_NONE), here? Such
that nobody can accidentally use this thing?

> +	original_memory_map.late = 1;
> +	original_memory_map.phys_map = new_phys;
> +	original_memory_map.map = remapped_phys;
> +	original_memory_map.nr_map = efi.memmap.nr_map;
> +	original_memory_map.desc_size = efi.memmap.desc_size;
> +	original_memory_map.map_end = remapped_phys + new_size;
> +	original_memory_map.desc_version = efi.memmap.desc_version;
> +
> +	original_memory_map_present = true;
> +}
> +#endif /* CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS */
> -- 
> 2.7.4
> 
