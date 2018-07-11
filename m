Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD76208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf4QdFB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD76208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeGKJBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeGKJBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:01:30 -0400
Received: from localhost (unknown [106.200.243.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED09A20B6F;
        Wed, 11 Jul 2018 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531299494;
        bh=OT79Dq9bewWG7JDy2/s0b8n6UIWMdBFhIYFZ+74AtNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mf4QdFB6yXcABPwvbZTa5ITW3l1pLDhcX+Hs9YmIt/g55cbfBhzxvbZIdpLJ5MTAR
         8iw/6zribsioWaRz6XMD+YSIezTy7l3vb9hzwrx1Bdy1lm4W+hllGG5fbmQoe9oZGk
         IEARpvjK2+uNrHefmjYGSP7gACmcBY73brA+d1Ms=
Date:   Wed, 11 Jul 2018 14:28:06 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Message-ID: <20180711085806.GP3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
 <20180710153326.GG3219@vkoul-mobl>
 <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
 <20180711071905.GN3219@vkoul-mobl>
 <DB6PR04MB3223D27E2BCA6A235733CEA5895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR04MB3223D27E2BCA6A235733CEA5895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-18, 08:16, Robin Gong wrote:

> > > The problem seems to be that we do not know whether we are doing
> > > memcpy or not. Normally we get the information how a channel is to be
> > > configured in dma_device->device_config, but this function is not
> > > called in the memcpy case.
> > 
> > Not really true, device_config only provides parameters to be configured for
> > next slave transaction
> > 
> > > An alternative might also be to do the setup in
> > dma_device->device_prep_dma_memcpy.
> > 
> > Precisely, see how other drivers do this
> > 
> > Let's roll back a bit and foresee why is this required.
> > 
> > In case of memcpy, you need to tell DMA to do transfer from src to dstn and
> > size. Additional parameters like buswidth etc should be derived for maximum
> > throughput (after all we are dma, people want it to be done
> > fastest)
> > 
> > Now for slave, you are interfacing with a peripheral and don't know how that is
> > setup. So you need to match the parameters, otherwise you get overflow or
> > underflow and hence need for device_config
> > 
> > Please do not derive additional notions from these, please do not assume
> > anything else, unless provided in documentation :)
> I will move such prepare jobs from slave_config to device_prep_dma_memcpy
> Instead of device_alloc_chan_resources as I did in v1, thus we have no 'chan->private'
> issue, just like drivers/dma/stm32-mdma.c. The only limitation is those prepare jobs
> (some register setting) will be done every time memcpy instead of only one time in slave_config
> or v1 case. Is that ok?

sounds fine to me

-- 
~Vinod
