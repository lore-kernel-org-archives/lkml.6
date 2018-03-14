Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELtC6v7mRYybV64Xlqr/jv1ug33nzbypRQXkwo1FaV2A/ZzUj081lqIY3ZKpQNUvjXxrwfR2
ARC-Seal: i=1; a=rsa-sha256; t=1521018142; cv=none;
        d=google.com; s=arc-20160816;
        b=HgRgpSCSb/N091NYHz6bggCytAxX6C+3JHXDxKGlvLS07tFKqIduXv0CKQ4RHAbICf
         RgdkxUCPTnrtZbgfkrnXFtIK0gtcZ69mA7xrs8zzSI6K1Z9xiJEvF4KOtdeVoKM3B07/
         8bqwRCtFzOhVEn0XxURuRnTkK31ID8efowQI3FSFDWWbMXs8OS/XsQ6NDlGv7AbS1mV1
         oKi2HMbSCUYAVYP6eIYiiwoVHo6GBcua9ji+h+8zo2Y7kV60waUBP4AiLiy4srP6q8Lh
         enrNGABR22WObsTM5sPdBcNBHXoXA8hS+H9gSlpXzYB4//uwvH9XVQ1cxSiweTXSl5td
         bgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ew7LVs147ApHkG86MFf4FmjjhQukourrvb3GGYF+ZiM=;
        b=K2LPagcXzqhPQC6bUtO8y96qn6srXRiu3gpfCTU/1iLqWvvpkOqze3I65VABZjr2ZX
         8ldSP1epWp9gvi+oDJIuhzBFpNvQ5MDVyttTs0FBvNzLVEmZKcJ8r/uwEy3zeKP73PNL
         vEem/bUo6exobKzWyOOVEENLs6joCKUqHwg9hbqonT3UNfFwhS2itO4SX96vvkz5vONV
         DPsc9lDMl0b+nd30n/ngU6/yatCxXAxnWVSM+qObSrlNVmH/D22hcP3EW0+dreOad0UN
         X/kXUaMZkC5jwn3PH9/F2XDZrALJsJ6s9buHACUQ4svnyN5oYR8j8jlzd22Kl2GX2cQn
         MzhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Wed, 14 Mar 2018 10:02:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, hch@lst.de, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, dmitry.torokhov@gmail.com,
	rafael.j.wysocki@intel.com, jarkko.sakkinen@linux.intel.com,
	linus.walleij@linaro.org, johan@kernel.org, msuchanek@suse.de,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180314090221.GE28983@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <a6cd83c9-d769-2994-5230-0a97de1897e5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6cd83c9-d769-2994-5230-0a97de1897e5@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594903120428213980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> +	.dev_groups		= amba_dev_groups,
>> +	.match			= amba_match,
>> +	.uevent			= amba_uevent,
>> +	.pm			= &amba_pm,
>> +	.dma_configure		= amba_dma_configure,
>> +	.dma_deconfigure	= amba_dma_deconfigure,
>> +	.force_dma		= true,
>
> This patch should also be removing force_dma because it no longer makes 
> sense. If DMA configuration is now done by a bus-level callback, then a bus 
> which wants its children to get DMA configuration needs to implement that 
> callback; there's nowhere to force a "default" global behaviour any more.

Btw, we don't really know how many busses currently rely on OF or ACPI
configuration.  So maybe we need to keep those as a default?
