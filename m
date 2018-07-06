Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759F8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2A122430
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9IU6lEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2A122430
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934573AbeGFSqx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:46:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934201AbeGFSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GEA7CST+5VE/boC3SBznfxW8L14p7kZaaBrDleiH6P0=; b=q9IU6lEy+LGSC9sRGUW04TVoX
        w89rOdnocIMWgbF9Ibiha+RvCe+G/QroyDGgWX/jW2k+qsINPRD5BaCMRE0p2aB9MjhjUdxYOQSTa
        d1t6Bbh16NDQRdtdyYxisTEBGcLsS6mJvWeGOQ+tdwrTAKDoQ8sDXXLtedZNI/UApp95U5PY++5x5
        yvrVoIGcc8lGLp6Fmqn69aBlJT8Qg+gt4O/zFUSq1FM/V5F7dhQe2DF4E74pndR347IVDN9SMNjMx
        bQQGR8MFUpR5M7WkGNWhqO1JkUMv/WhmK7Aqh9DSYRFadEY4X3Ih5KJLp9GsMVoMrd84mGvatZvtc
        HOzrF93Mw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbVko-0006jj-3T; Fri, 06 Jul 2018 18:46:50 +0000
Subject: Re: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>,
        Oliver <oohall@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
 <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a28ed01-fc76-0f08-3f8a-c2dd7f5fcd2f@infradead.org>
Date:   Fri, 6 Jul 2018 11:46:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/18 01:29, Aneesh Kumar K.V wrote:
> This patch steal system RAM and use that to emulate pmem device using the
> e820 platform driver.
> 
> This adds a new kernel command line 'pmemmap' which takes the format <size[KMG]>
> to allocate memory early in the boot. This memory is later registered as
> persistent memory range.
> 
> Based on original patch from Oliver OHalloran <oliveroh@au1.ibm.com>
> 
> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/Kconfig        |  13 ++++
>  drivers/nvdimm/Makefile       |   1 +
>  drivers/nvdimm/memblockpmem.c | 115 ++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/nvdimm/memblockpmem.c
> 
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index 50d2a33de441..cbbbcbd4506b 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -115,4 +115,17 @@ config OF_PMEM
>  config PMEM_PLATFORM_DEVICE
>         bool
>  
> +config MEMBLOCK_PMEM
> +	bool "pmemmap= parameter support"
> +	default y
> +	depends on HAVE_MEMBLOCK
> +	select PMEM_PLATFORM_DEVICE
> +	help
> +	  Add support for the pmemmap= kernel command line parameter. This is similar
> +	  to the memmap= parameter available on ACPI platforms, but it uses generic
> +	  kernel facilities (the memblock allocator) to reserve memory rather than adding
> +	  to the e820 table.
> +
> +	  Select Y if unsure.
> +
>  endif


There's a high barrier for "default y", something like if the platform or device
cannot boot without it, it can be "default y".  I have doubts that this is OK.


-- 
~Randy
