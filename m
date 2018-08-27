Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF08421746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/J2F8mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF08421746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeH0JcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbeH0JcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:32:09 -0400
Received: from localhost (unknown [106.200.197.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6FA21722;
        Mon, 27 Aug 2018 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535348821;
        bh=hJ2Hez11lZUQXXRTshl0w0ZtmiAJ4LRd+z3gj/AJJJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/J2F8mVJhPup511hjddqhDb2Ih3fCKxnc8lYcTQxMS493Ej0SvOVsL1C8aoRMoRn
         CdcFt8YqZgvr8lvNlYeeARBTbCGol9UdgP06o+CBYWTjfpuCvjguY7QO/Qm/vVMpzd
         CKd+PNeLGjuNTGJ3mRn/avsiR2uJ46/sDhdxiCuU=
Date:   Mon, 27 Aug 2018 11:16:53 +0530
From:   Vinod <vkoul@kernel.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma: mic_x100_dma: use devm_kzalloc to fix an issue
Message-ID: <20180827054652.GW2388@vkoul-mobl>
References: <20180822024027.8984-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822024027.8984-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-18, 10:40, Huang Shijie wrote:
> The following patch introduced an issue.
>     commit f6206f00d8c5 ("dmaengine: mic_x100_dma: use the new helper to simplify the code")
> 
> This issue is :
> 
> 	kfree(mic_dma_dev)
> 	.....
> 	dma_async_device_unregister(mic_dma_dev->device);
> 
> Free the memory, and use it again.
> 
> So use devm_kzalloc to allocate mic_dma_dev to fix it.
> 
> When the Devres try to release the resources, it will call release at the
> following order:
> 
> 	dma_async_device_unregister(mic_dma_dev->device);
> 	.....
> 	kfree(mic_dma_dev)

After fixing the subsystem name, applied thanks
-- 
~Vinod
