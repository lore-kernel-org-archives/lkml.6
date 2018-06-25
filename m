Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33FFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A43E25E27
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLaO/ble"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A43E25E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbeFYQWH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbeFYQWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:22:05 -0400
Received: from localhost (unknown [223.226.41.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BC825E27;
        Mon, 25 Jun 2018 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529943725;
        bh=fqBojp8kiTt2Av9Fe8SOF4Ar3/KfyiJHpFKRIRYaKoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLaO/bleZzQQWdTJH39+vrnd0TgKtMqmavKaBuIIDXYpoY5gpZMxfTDqA5Ptg3lEY
         rb5+dNV9vXytYFBtBtEIlcO1HVJKM8tZFxYeOWCqPd9gz+rYBoDuNi2Nk6qAmBuEc8
         gNUW+xbTXhngjGHkjUsLnN4cjaRPaeYgL54mqMoM=
Date:   Mon, 25 Jun 2018 21:51:56 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, broonie@kernel.org,
        sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
Message-ID: <20180625162156.GC2404@vkoul-mobl>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <20180622125050.GO27187@vkoul-mobl>
 <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-18, 11:11, Srinivas Kandagatla wrote:

> > > +struct slim_stream_runtime *slim_stream_allocate(struct slim_device *dev,
> > > +						 const char *name)
> > > +{
> > > +	struct slim_stream_runtime *rt;
> > > +	unsigned long flags;
> > > +
> > > +	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
> > > +	if (!rt)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	rt->name = kasprintf(GFP_KERNEL, "slim-%s", name);
> > > +	if (!rt->name) {
> > > +		kfree(rt);
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	rt->dev = dev;
> > > +	rt->state = SLIM_STREAM_STATE_ALLOCATED;
> > > +	spin_lock_irqsave(&dev->stream_list_lock, flags);
> > > +	list_add_tail(&rt->node, &dev->stream_list);
> > > +	spin_unlock_irqrestore(&dev->stream_list_lock, flags);
> > 
> > Any reason for _irqsave variant? Do you expect stream APIs to be called
> > from ISR?We can move to non irqsave variant here, as i do not see a case
> > where
> this list would be interrupted from irq context.

That's interesting can you please describe how?
Also, won't it be modified from bottom half...

> > > +/*
> > > + * slim_stream_enable() - Enable a prepared SLIMbus Stream
> > 
> > Do you want to check if it is already prepared ..?
> Yep, I think most of the code needs similar state machine check, I will add
> this in next version.

so if you are tying to snd stream states then I don't think you need a
state machine here. ALSA already does that for you so you can skip it :D

-- 
~Vinod
