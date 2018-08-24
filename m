Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830C5208E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C5208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeHXG15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:27:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:64509 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725735AbeHXG15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:27:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 19:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,280,1531810800"; 
   d="scan'208";a="65624766"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.198]) ([10.238.232.198])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2018 19:55:04 -0700
Subject: Re: [PATCH 1/2] media: ipu3-cio2: Use dma_zalloc_coherent to replace
 dma_alloc_coherent + memset
To:     zhong jiang <zhongjiang@huawei.com>, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        mchehab@kernel.org, matthias.bgg@gmail.com
Cc:     tian.shu.qiu@intel.com, jian.xu.zheng@intel.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <1534605415-11452-1-git-send-email-zhongjiang@huawei.com>
 <1534605415-11452-2-git-send-email-zhongjiang@huawei.com>
From:   Bing Bu Cao <bingbu.cao@linux.intel.com>
Message-ID: <541b8c22-018f-4df6-85d1-82a72d9ab669@linux.intel.com>
Date:   Fri, 24 Aug 2018 10:58:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1534605415-11452-2-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jiang

This looks fine for me in ipu3-cio2.
Actually, we already have this change locally, but I think we miss submit it to community.
Thanks!

On 08/18/2018 11:16 PM, zhong jiang wrote:
> dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset(),
> We prefer to dma_zalloc_coherent instead of open-codeing.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> index 2902715..f0c6374 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> @@ -218,13 +218,11 @@ static int cio2_fbpt_init(struct cio2_device *cio2, struct cio2_queue *q)
>  {
>  	struct device *dev = &cio2->pci_dev->dev;
>  
> -	q->fbpt = dma_alloc_coherent(dev, CIO2_FBPT_SIZE, &q->fbpt_bus_addr,
> -				     GFP_KERNEL);
> +	q->fbpt = dma_zalloc_coherent(dev, CIO2_FBPT_SIZE, &q->fbpt_bus_addr,
> +				      GFP_KERNEL);
>  	if (!q->fbpt)
>  		return -ENOMEM;
>  
> -	memset(q->fbpt, 0, CIO2_FBPT_SIZE);
> -
>  	return 0;
>  }
>  

