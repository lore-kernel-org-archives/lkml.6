Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC06C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F3F24855
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zlhs8oLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3F24855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeFVUC2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:02:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55232 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeFVUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n9I959nvzkJt0kCo15WLliKX+8fZh2FoGpTlHK3boAM=; b=zlhs8oLHkhFvCfqo9S2SIsgdtr
        XEKKh/nuJ0duc7BniCAXn6O8Hdmt2zPgavQ/cF+j3s8jcMxyWvsJNkuiR+qu359SpJEtCBxnBBWcW
        h2CMRHC+Ijl03WtCNCqHjl4pJ6p0iLC4k/zv9+KvqyDHLpJX2YfjGgrMd5Q2Lrf0cE+VhQvWMbZh8
        k4ubaqfev4OHM7QU6W4ki/5tvmdGg7/VHzWPKZDeJuhnJ0bRWgyXNRknISl5gegwupCH/k+ClwU29
        pENGsxnV9ybsL7AxL59P16mAcrcHZGlqLXeYkjUjRQSadGereRgYoq6SHjrLbfIbb8zOd0rWKCUus
        eCU1dvog==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWSFk-0003Kf-9Q; Fri, 22 Jun 2018 20:01:52 +0000
Subject: Re: [PATCH v4 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180622194315.10475-1-logang@deltatee.com>
 <20180622194315.10475-3-logang@deltatee.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1278ab2-63a8-19b6-9c8d-fed0b4f94c11@infradead.org>
Date:   Fri, 22 Jun 2018 13:01:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622194315.10475-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/22/2018 12:43 PM, Logan Gunthorpe wrote:
> When specifying PCI devices on the kernel command line using a
> BDF, the bus numbers can change when adding or replacing a device,
> changing motherboard firmware, or applying kernel parameters like
> pci=assign-buses. When this happens, it is usually undesirable to
> apply whatever command line tweak to the wrong device.
> 
> Therefore, it is useful to be able to specify devices with a base
> bus number and the path of devfns needed to get to it. (Similar to
> the "device scope" structure in the Intel VT-d spec, Section 8.3.1.)
> 
> Thus, we add an option to specify devices in the following format:
> 
> [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*

Please explain the trailing '*'.  I looked thru the code and it doesn't
seem to look for it or care.

> 
> The path can be any segment within the PCI hierarchy of any length and
> determined through the use of 'lspci -t'. When specified this way, it is
> less likely that a renumbered bus will result in a valid device specification
> and the tweak won't be applied to the wrong device.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   8 +-
>  drivers/pci/pci.c                               | 117 ++++++++++++++++++++----
>  2 files changed, 103 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e783bcefadac..a69947d9e14e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3000,7 +3000,7 @@
>  				or a set of devices (<pci_dev>). These are
>  				specified in one of the following formats:
>  
> -				[<domain>:]<bus>:<slot>.<func>
> +				[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
>  				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
>  
>  				Note: the first format specifies a PCI
> @@ -3009,7 +3009,11 @@
>  				firmware changes, or due to changes caused
>  				by other kernel parameters. If the
>  				domain is left unspecified, it is
> -				taken to be zero. The second format
> +				taken to be zero. Optionally, a path
> +				to a device through multiple slot/function
> +				addresses can be specified after the base
> +				address (this is more robust against
> +				renumbering issues). The second format
>  				selects devices using IDs from the
>  				configuration space which may match multiple
>  				devices in the system.


thanks,
-- 
~Randy
