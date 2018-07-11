Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5C320BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk7VrG8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5C320BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeGKHPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeGKHPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:15:04 -0400
Received: from localhost (unknown [106.200.243.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4363B208FA;
        Wed, 11 Jul 2018 07:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531293135;
        bh=XMrFWmzgYlth1uCOhEm0wcJCLjfEBwoClOjqwdBUrgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk7VrG8IxYII/a7B64KBDz/91jiB2zpCVQGm9jRkxcWXN4H/tyI9UgbkX/T5iztbI
         eOH7iyqu2Pc9p8+8532TiHwTIgvFE/kEBZdJkdiX1NU4T29mRZjWw5vwpw3XGROpkH
         0dGE1OAV5r+d1+mf/miTXHJ3D68YOLSeb6pU34gM=
Date:   Wed, 11 Jul 2018 12:42:06 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Message-ID: <20180711071206.GM3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180710152912.GE3219@vkoul-mobl>
 <DB6PR04MB32234F1EE6F457E0D8D12385895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR04MB32234F1EE6F457E0D8D12385895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-18, 05:34, Robin Gong wrote:
> > On 11-07-18, 00:23, Robin Gong wrote:
> > > Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead of
> > > '0xffff'.
> > 
> > latter part should be its own patch. Never mix things
> Okay, I will split it even for this minor change.

Yes, a patch should represent _one_ thing, describe that one thing and
do that one thing.

Anything else, doesn't matter how simple or complex should be an
individual patch

> > > +	if (!desc)
> > > +		goto err_out;
> > > +
> > > +	do {
> > > +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> > > +		bd = &desc->bd[i];
> > > +		bd->buffer_addr = dma_src;
> > > +		bd->ext_buffer_addr = dma_dst;
> > > +		bd->mode.count = count;
> > > +		desc->chn_count += count;
> > > +
> > > +		switch (sdmac->word_size) {
> > > +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> > 
> > This looks wrong, we are in memcpy, there is no SLAVE so no SLAVE widths..
> > 
> Okay, will remove check bus width.

it is not about bus_width but the fact that you are using slave
concepts. In memcpy we have _no_ slave, hence do not use anything
related to slave including dma_slave_config

-- 
~Vinod
