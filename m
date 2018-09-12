Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FABC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5C20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjyVFiOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC5C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeILOC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:02:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33253 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeILOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:02:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so9885657wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=utjrDQYOPGTLWFcviqfNiFNrMydzE13vlZqYl071ucs=;
        b=jjyVFiOL0v5rsPSpAdhPGHtuqP5pr/rQb+6wQZrS/Z2btiZ164d3VpdettBPWZb3IW
         cNVz/B2ju5Zs/Eyp/xzKqzCQVNTNjVlXT+ZU9YSwLIbKhZjb4FYmHr+fGWl11GIoiF8p
         I4xDWTX5snmKsKmSg1OlChweUTiKAEcRzpwgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=utjrDQYOPGTLWFcviqfNiFNrMydzE13vlZqYl071ucs=;
        b=eKWrxCKfBcMxBJGfV+2GK+XWeR+AvjxyhWnr0EsfRAdxQDtoQupnFRmSPESEWaui1S
         llxHSWjOIdW11Gco90tuz47BgLQqEl7kxZlv81uYKm6cxYKNkAWGqI4PAbszs16Ew4uf
         t9cG4cvGhwQDWfAeOIVLA7pzHgqvjhfrNgdKeCEwnzhBtIXvGooGvu0vg3BMBG46Np1w
         mP+VNYiCuyomzhbF78sehz4z8K13N8Egz102r1py1/OZWlf3r4MSmruQWekaJJFgJZ9S
         49/6cD1kegSTdUFCSd8biec5R7UDGwFPhF5wiKjdV2GD2718zeUCQlrBoLXdI7CAyIU3
         hhlA==
X-Gm-Message-State: APzg51AC1oQ/O+iktujYOsKIWBtHfkFGVfMO4vlj0Nt1D3SZtl+khZ1Q
        /s3qbhMI7iZZXIiJ+gdpz5GoKKi4/znb911X
X-Google-Smtp-Source: ANB0VdbmhKtuDRCkF5vxS/1UVosxN71+cFnSpGe706ruiiZHWeQJgnoKbCA62Zl1XJ3HpgquJjyUeA==
X-Received: by 2002:a1c:f913:: with SMTP id x19-v6mr939228wmh.63.1536742731784;
        Wed, 12 Sep 2018 01:58:51 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id d12-v6sm850306wru.36.2018.09.12.01.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 01:58:50 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:58:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180912085848.GP4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94c68436-b618-40fc-46d6-165799312289@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Srinivas Kandagatla wrote:
> On 11/09/18 16:33, Lee Jones wrote:
> > On Tue, 04 Sep 2018, Srinivas Kandagatla wrote:
> > 
> > > Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
> > > It has mulitple blocks like Soundwire controller, codec,
> > > Codec processing engine, ClassH controller, interrupt mux.
> > > It supports both I2S/I2C and SLIMbus audio interfaces.
> > > 
> > > This patch adds support to SLIMbus audio interface.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >   drivers/mfd/Kconfig                   |  14 +
> > >   drivers/mfd/Makefile                  |   4 +
> > >   drivers/mfd/wcd9335-core.c            | 291 ++++++++++++
> > >   include/linux/mfd/wcd9335/registers.h | 627 ++++++++++++++++++++++++++
> > >   include/linux/mfd/wcd9335/wcd9335.h   |  32 ++
> > >   5 files changed, 968 insertions(+)
> > >   create mode 100644 drivers/mfd/wcd9335-core.c
> > >   create mode 100644 include/linux/mfd/wcd9335/registers.h
> > >   create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
[...]

> > > +static const struct mfd_cell wcd9335_devices[] = {
> > > +	{ .name = "wcd9335-codec", },
> > > +};
> > 
> > Are there more devices to come?
> > 
> Yes, that is the plan, we are kind of limited in hardware setup to test few
> things like soundwire controller. We are exploring other ways to test these.

I normally don't accept MFDs with just one device enabled.  Since it's
not really an MFD (M == Multi) until it has more than one function.

[...]

> > > +	struct device_node *ifc_dev_np;
> > 
> > ifc isn't very forthcoming.  Any way you can improve the name?
> ifc was suggested in dt bindings by Rob,  I can proably rename to
> interface_node.

ifc is a horrible variable name - just sayin'.

[...]

> > > +	ret = wcd9335_bring_up(wcd);
> > 
> > So the device_status call-back brings up the hardware?
> > 
> 
> device status reports the device status at runtime. We can not communicate
> with the device until it is up, enumerated by slimbus and a logical address
> is assigned to it. So the best place to initialize it is in status callback
> where all the above are expected to be done.

Right, I understand what's happening.  I just think the semantics are
wrong.  The Subsystem (I'm assuming it's a Subsystem) requests for
status and it ends up initiating a start-up sequence.  Just from a
purist's point of view (I understand that it "works"), it's not good
practice.

> Probe is expected to setup the external configurations like regulators/pins
> and so on which gets the device out of reset and ready to be enumerated by
> the slimbus controller.

I suggest fully starting the device in probe() is a better approach.

[...]

> > > +struct wcd9335 {
> > > +	int version;
> > > +	int intr1;
> > 
> > What's this?  If I have to ask, it's probably not a good name.
> > 
> This is a hardware pin name for interrupt line 1.

I don't see how this is used, so it's difficult for me to advise
fully, but I find this confusing.  Pin name/number?  Shouldn't this be
handed by Pinctrl?

intr1 could be quite ambiguous.  Especually as the '1' could easily be
read as an 'l'.  Suggest that 'irq1' or 'irq_1' or 'irq_one'.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
