Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C55C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE92D2402E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2EDyGD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE92D2402E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGFGLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753287AbeGFGJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:09:47 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F73E2402E;
        Fri,  6 Jul 2018 06:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530857387;
        bh=UFn4zduuWz1/khnzf/5hzGTE7uJXKdoQGeD+EaszxpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2EDyGD6uaQUJ5GSDMwuQpMPho/fltuYvinvcWZq+nGHa8tnl2XK8tHSujO8ZpntY
         0wY+n/vayTSgUa6nYWfpGSTy/64vaRyq+nqdY9P+HAQwtl6xG3mVCTB/AqMgQdoKKR
         qjSNVk+HSp2gSWIlo3hVjnIjK8ldSCeEBaFwlncM=
Date:   Fri, 6 Jul 2018 11:39:38 +0530
From:   Vinod <vkoul@kernel.org>
To:     Guodong Xu <guodong.xu@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dan.j.williams@intel.com,
        liyu65@hisilicon.com, Suzhuangluan <suzhuangluan@hisilicon.com>,
        "xuhongtao (A)" <xuhongtao8@hisilicon.com>,
        zhongkaihua <zhongkaihua@huawei.com>,
        Xuezhiliang <xuezhiliang@hisilicon.com>,
        "xupeng (Q)" <xupeng7@huawei.com>, sunliang10@huawei.com,
        "Fengbaopeng (kevin, Kirin Solution Dept)" 
        <fengbaopeng@hisilicon.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] k3dma: add support to reserved minimum channels
Message-ID: <20180706060938.GU22377@vkoul-mobl>
References: <20180622032416.20133-1-guodong.xu@linaro.org>
 <20180622032416.20133-3-guodong.xu@linaro.org>
 <20180628060239.GO22377@vkoul-mobl>
 <CAFGCpxwkdJQAf9bwHTLp+Zc5ASbnFQn9UDsA+zFCH7UZJy9aBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFGCpxwkdJQAf9bwHTLp+Zc5ASbnFQn9UDsA+zFCH7UZJy9aBQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-18, 11:05, Guodong Xu wrote:
> On Thu, Jun 28, 2018 at 2:02 PM Vinod <vkoul@kernel.org> wrote:
> >
> > On 22-06-18, 11:24, Guodong Xu wrote:
> > > From: Li Yu <liyu65@hisilicon.com>
> > >
> > > On k3 series of SoC, DMA controller reserves some channels for
> > > other on-chip coprocessors. By adding support to dma_min_chan, kernel
> > > will not be able to use these reserved channels.
> > >
> > > One example is on Hi3660 platform, channel 0 is reserved to lpm3.
> > >
> > > Please also refer to Documentation/devicetree/bindings/dma/k3dma.txt
> >
> > and if some other platform has channel X marked for co-processor, maybe
> > a last channel or something in middle, how will this work then?
> >
> Hi， Vinod
> 
> Sorry for delayed response. We checked with Kirin hardware design
> team, so far their design strategy is all Kirin SoC series reserve
> only from minimum side, saying channel 0, then 1, then 2. That impacts
> the current SoC in upstreaming, Kirin960 (Hi3660), and next versions
> in Kirin SoC, Kirin970 and 980, which may hit upstream later.

And what guarantees that they will not change their mind..

> > I am thinking this should be a mask, rather than min.
> >
> 
> So, since this driver k3dma.c is only used by Kirin SoC DMA
> controllers, I would prefer to keep the current design dma_min_chan
> unchanged.
> 
> What do you think?

I would still prefer bitmask to expose the channels you are supposed to
use

-- 
~Vinod
