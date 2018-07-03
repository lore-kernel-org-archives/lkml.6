Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A13DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF38521468
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+AqvPMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF38521468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbeGCGqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:46:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37773 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeGCGqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:46:23 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so1629151itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6+CaxXTEHQf5L8Gz9JuVF73vko1T6hfDZ53RLKgwRMs=;
        b=N+AqvPMwX/RxAwymy4wjKHXIRCo3+EeJBx/oKEggBo83G5R0xqSYOWzDRz0xYeIerT
         ZOUIkqemkAVQedYP3JAC2LrAJIoNdZqldm+IzejLCUcSnaI2ulC/FJ/5ALMg680vUUMw
         f0eJwCqd5u6K27VV6eOH7fwFV7qupujzUPUAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6+CaxXTEHQf5L8Gz9JuVF73vko1T6hfDZ53RLKgwRMs=;
        b=LRo9obrNf/kYkzFXf245B0zEabUvYO+IzY3o4LWBzgR2FiGKXhSwPmFALUdfuXcspU
         iI1SP7WgFEH/AtLFI0+CBe81yhLpIDbrgCyiPvl6mkzcEX2wOfeV7f0JDa1kvGektNgX
         PMXwrpJ/mhf99QJ4D1PEQQ/0JpW4VQWgk/TnqjAOOab2mNAMZDXlHvNahayZaVW/Asis
         oUM0euPucSCYT/5a4rQPbJ+Qv3IessDcV+iklYGyiamQKv+EPrPZyOpIGmbs7p/ribBK
         VKlirTz04ouyxEU5QR65J1D9dcTh1HK4OsJNFGlDjxtI9MQm09YLrh0fD3s6m/akaKeQ
         QPBw==
X-Gm-Message-State: APt69E0tnwuS8JWX9FlLfG8BW4QznomvucfS+Rbn+JImfOVQc+T/YD5m
        8xS8quQZeySd/8AoTJjywAcPwasERnI=
X-Google-Smtp-Source: AAOMgpcBDsbaSP4AmPTN+GREB2uvIpQQGvkIag0nz5fcCedjZpJkhPDNa6yfvHR1Q+5hU7TWaluFiA==
X-Received: by 2002:a24:cf57:: with SMTP id y84-v6mr8486920itf.98.1530600382141;
        Mon, 02 Jul 2018 23:46:22 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id i193-v6sm165936ioi.38.2018.07.02.23.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 23:46:21 -0700 (PDT)
Date:   Tue, 3 Jul 2018 15:47:27 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org,
        al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
Message-ID: <20180703064726.GU23681@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org,
        al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com,
        linux-arm-kernel@lists.infradead.org
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
 <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
 <ca9e5d9d-e090-f9e0-bc10-3297c9e3b7e1@arm.com>
 <891c3e5a-9760-1353-4a2c-0900082dd245@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891c3e5a-9760-1353-4a2c-0900082dd245@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:22:46AM -0500, Dave Kleikamp wrote:
> On 06/19/2018 10:00 AM, James Morse wrote:
> > Hi Dave,
> > 
> > On 19/06/18 14:37, Dave Kleikamp wrote:
> >> On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:
> >>> +static int __init reserve_memblock_reserved_regions(void)
> >>> +{
> >>> +	phys_addr_t start, end, roundup_end = 0;
> >>> +	struct resource *mem, *res;
> >>> +	u64 i;
> >>> +
> >>> +	for_each_reserved_mem_region(i, &start, &end) {
> >>> +		if (end <= roundup_end)
> >>> +			continue; /* done already */
> >>> +
> >>> +		start = __pfn_to_phys(PFN_DOWN(start));
> >>> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
> >>> +		roundup_end = end;
> >>> +
> >>> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> >>> +		if (WARN_ON(!res))
> >>> +			return -ENOMEM;
> >>> +		res->start = start;
> >>> +		res->end = end;
> >>> +		res->name  = "reserved";
> >>> +		res->flags = IORESOURCE_MEM;
> >>> +
> >>> +		mem = request_resource_conflict(&iomem_resource, res);
> >>> +		/*
> >>> +		 * We expected memblock_reserve() regions to conflict with
> >>> +		 * memory created by request_standard_resources().
> >>> +		 */
> >>> +		if (WARN_ON_ONCE(!mem))
> >>> +			continue;
> >>> +		kfree(res);
> >>
> >> Why is kfree() after the conditional continue? This is a memory leak.
> > 
> > request_resource_conflict() inserts res into the iomem_resource tree, or returns
> > the conflict if there is already something at this address.
> > 
> > We expect something at this address: a 'System RAM' section added by
> > request_resource(). This code wants the conflicting 'System RAM' entry so that
> > reserve_region_with_split() can fill in the gaps below it with 'reserved'. See
> > the commit-message for an example.
> > 
> > If there was no conflict, it means the memory map doesn't look like we expect,
> > we can't pass NULL to reserve_region_with_split(), and we just inserted the
> > 'reserved' at the top level. Freeing res at this point would be a use-after-free
> > hanging from /proc/iomem.
> > This code generates a WARN_ON_ONCE() and leaves the 'reserved' description where
> > it is.
> 
> Okay. I get it.
> 
> > Trying to cleanup here is pointless, we can remove the resource entry and free
> > it ... but we still want to report it as reserved, which is what just happened,
> > just not quite how we we wanted it.
> > 
> > If you ever see this warning, it means some RAM stopped being nomap between
> > request_resources() and reserve_memblock_reserved_regions(). I can't find any
> > case where that ever happens.
> > 
> > 
> > If all that makes sense: how can I improve the comment above the WARN_ON_ONCE()
> > to make it clearer?
> 
> I guess something like you described above.
> 
> /*
>  * We expect a 'System RAM' section at this address. In the unexpected
>  * case where one is not found, request_resource_conflict() will insert
>  * res into the iomem_resource tree.
>  */
> 
> Do you think this is clearer?

If this is the only change needed in my patchset, I'd like the maintainers
to take care of it instead of my posting another version.

Thanks,
-Takahiro AKASHI

> > 
> > 
> > Thanks,
> > 
> > James
> > 
> > 
> >>> +
> >>> +		reserve_region_with_split(mem, start, end, "reserved");
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +arch_initcall(reserve_memblock_reserved_regions);
> >>> +
> >>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> >>>  
> >>>  void __init setup_arch(char **cmdline_p)
> >>>
> > 
