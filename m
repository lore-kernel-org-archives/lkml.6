Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E4E21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548259013;
	bh=G3Ca8GuuS5k8n1POXOFs0XWw+9mQk5SNjXGrgF/Voj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Se+SFrEHgOJDWjCFeD2UlXzspmhbbzGuWnc0wSCdnXqmTSLk8Cmt/zFhJsMmqSoJp
	 oQGffyKKzKyqWjJ1CC822MQA4V7ClREKC+1T1pyvW32Z1zE1Zz15tsPUU5aqUDsRYK
	 KNi5l+C9AP7UkI4WH+jb4ERx8MZs7hL53plJlxZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfAWP4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:56:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfAWP4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:56:50 -0500
Received: from localhost (unknown [106.200.229.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1314A21019;
        Wed, 23 Jan 2019 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548259009;
        bh=G3Ca8GuuS5k8n1POXOFs0XWw+9mQk5SNjXGrgF/Voj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxOt14X63mduhbkXQbIOlowO+iDCT3P5NJDSZcWYq2f7S5b5vWew+iNKteVSXDj1/
         NDYSTFdRVVunMuLOYC0rvzxIXh0ZxJXGlLtSPxS09MvhiYHAR5Lz+1uRqBAzbztl8V
         sLte/PdvW7921O5vt+dHbY5gHUXoDg3Ex6/XDOw8=
Date:   Wed, 23 Jan 2019 21:25:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Lucas Stach <l.stach@pengutronix.de>, angus.ainslie@puri.sm,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 4/5] dma: imx-sdma: add an index for imx8mq multi sdma
 devices
Message-ID: <20190123155517.GR4635@vkoul-mobl>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
 <20190123152310.11680-5-angus@akkea.ca>
 <1548257514.28802.3.camel@pengutronix.de>
 <d5f73096cf62ef379e27c11e024c52ff@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f73096cf62ef379e27c11e024c52ff@www.akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19, 08:42, Angus Ainslie wrote:
> On 2019-01-23 08:31, Lucas Stach wrote:
> > Hi Angus,
> > 
> > Am Mittwoch, den 23.01.2019, 08:23 -0700 schrieb Angus Ainslie (Purism):
> > > On i.mx8mq, there are two sdma instances, and the common dma framework
> > > will get a channel dynamically from any available sdma instance
> > > whether
> > > it's the first sdma device or the second sdma device. Some IPs like
> > > SAI only work with sdma2 not sdma1. To make sure the sdma channel is
> > > from
> > > the correct sdma device, use an index to match.
> > > 
> > > Based on MLK-16104-2 by Robin Gong <yibin.gong@nxp.com>
> > 
> > This relies on the probe order of the devices (which should be treated
> > as random) for the match to find the right device. This is not
> > acceptable upstream.
> > 
> > The DT "dmas" property already specifies the correct SDMA device to use
> >  for a consumer, so the filter function should really match the OF node
> > of the SDMA device with the node specified in the dmas phandle in order
> > to pick the right SDMA engine.
> > 
> 
> Thanks Lucas, I'll fix it for rev 4

And fix the subsystem name, it is 'dmaengine: ...' not 'dma: ...'. git
log of the subsystem should give you good clue of the tags to be used..

Thanks

-- 
~Vinod
