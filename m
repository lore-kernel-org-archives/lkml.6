Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B1CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2882320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mmp+dtBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2882320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbeHASKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:10:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46738 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbeHASKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wdkQz0ZkLYt54fvU11F3mRcDZOTKFRUiJbAH3YozcIE=; b=Mmp+dtBUwwBuq6nh5PflLu/sXD
        z+Wj5nSJovvLODUwOc3iSCkj25BzI/px2vfSkU2f5WMFfnFwkX+CQ6jJ9Zfe5MPiepfbEdOnuWq/0
        F0frS1V8Wmwdw5ByVoLX3XfzRKs7onQPTASkIa1TfRrFpw8R17V/5DrhssHrotlpK1fVPGD34x21p
        Z4u4RkhAojvszzAZMpATklIxrOHqmNFg7w8LC83phCbS+u+JfD+8NJqfIUhCmY5LZPdRqlYUTNjoS
        9bwFN2D3oTPrAY/wGozZ4RXXzyJAazW2bf9KzlIxb+fYvZ2P4BmxEBSWE9g1WIXEyIzyIn+S5RqGy
        Ndd4Oj4w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fktun-0007JX-0n; Wed, 01 Aug 2018 16:23:57 +0000
Subject: Re: [RFC PATCH 3/7] vfio: add spimdev support
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc:     linuxarm@huawei.com
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-4-nek.in.cn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d11c7745-2f31-0f33-1bd8-78379dc66e6e@infradead.org>
Date:   Wed, 1 Aug 2018 09:23:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801102221.5308-4-nek.in.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 03:22 AM, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> SPIMDEV is "Share Parent IOMMU Mdev". It is a vfio-mdev. But differ from
> the general vfio-mdev:
> 
> 1. It shares its parent's IOMMU.
> 2. There is no hardware resource attached to the mdev is created. The
> hardware resource (A `queue') is allocated only when the mdev is
> opened.
> 
> Currently only the vfio type-1 driver is updated to make it to be aware
> of.
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/vfio/Kconfig                |   1 +
>  drivers/vfio/Makefile               |   1 +
>  drivers/vfio/spimdev/Kconfig        |  10 +
>  drivers/vfio/spimdev/Makefile       |   3 +
>  drivers/vfio/spimdev/vfio_spimdev.c | 421 ++++++++++++++++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c     | 136 ++++++++-
>  include/linux/vfio_spimdev.h        |  95 +++++++
>  include/uapi/linux/vfio_spimdev.h   |  28 ++
>  8 files changed, 689 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/vfio/spimdev/Kconfig
>  create mode 100644 drivers/vfio/spimdev/Makefile
>  create mode 100644 drivers/vfio/spimdev/vfio_spimdev.c
>  create mode 100644 include/linux/vfio_spimdev.h
>  create mode 100644 include/uapi/linux/vfio_spimdev.h
> 
> diff --git a/drivers/vfio/spimdev/Kconfig b/drivers/vfio/spimdev/Kconfig
> new file mode 100644
> index 000000000000..1226301f9d0e
> --- /dev/null
> +++ b/drivers/vfio/spimdev/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config VFIO_SPIMDEV
> +	tristate "Support for Share Parent IOMMU MDEV"
> +	depends on VFIO_MDEV_DEVICE
> +	help
> +	  Support for VFIO Share Parent IOMMU MDEV, which enable the kernel to

	                                                  enables

> +	  support for the light weight hardware accelerator framework, WrapDrive.

	  support the lightweight hardware accelerator framework, WrapDrive.

> +
> +	  To compile this as a module, choose M here: the module will be called
> +	  spimdev.


-- 
~Randy
