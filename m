Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DABC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8672075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaupO1ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8672075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeJLQfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:35:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43810 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJLQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:35:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so12568302wrt.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Pj6GCKZE5XNSDMqE8HFsvmBPv7ZzsPNM1w90BCqJAIk=;
        b=ZaupO1ZWxMJiOQ1jhWSxSykF3gQRsrMbsS21B0GdIUOekmcQOWFzNKnyeYbMnihlEw
         ExG4Rs2Rl6tY6oKUqpdgMIOyme96PjpGCnt6GN2QQ9N7GZwHV63uLVHGc138JhyGghFO
         Cx2eI89cdT5rcZOrbajsKvhdXE/vx/7Wlbh2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pj6GCKZE5XNSDMqE8HFsvmBPv7ZzsPNM1w90BCqJAIk=;
        b=O02ViPZGN197PSbAMGtJ2NHoimKvVl7COt9F8oyzL5k8t3+iW3npFHGLU2wm/R1agL
         mJ0aVUIdEgCDiBYEWtUEFUumT+PZYbzMjNEmUqNtzz9UjN9t+BhbdQggFdi9FxNtilet
         eDWNGDxjT/tY2DkgwzVkGq+fJG3YWD/tagVmqSRohIZ/N3zXuPK7WhZc5FMhn1k9gwyp
         Gp3WHINxNIv+Wy47HhmE7X+WopNUrB2VWCQkiBoEcuziCv73aOv+lithv+FOiSI2HVat
         dIMfHxPmL/BK11XXc8UQVC+6jc6yUfLEoObkVpQ8o4yun4dFgZctftXh1ubi70BNDPSG
         pysw==
X-Gm-Message-State: ABuFfoi7GLeNEM1KCXK2LhJxoCF/2K99GmA+o7z8QZ5/DpYtQz+YfBPe
        SNRR/PHz9Mo/VhPaP+qW6rPvJg==
X-Google-Smtp-Source: ACcGV63f6sfwOM0h3kH5RVG4wcOF6IDo++Q8r8BdJ2EvHKsomMS0WN88OJ3oHnIPz2egqmiydven1A==
X-Received: by 2002:adf:cf0b:: with SMTP id o11-v6mr4478026wrj.272.1539335013444;
        Fri, 12 Oct 2018 02:03:33 -0700 (PDT)
Received: from dell (89-145-231-171.xdsl.murphx.net. [89.145.231.171])
        by smtp.gmail.com with ESMTPSA id l11-v6sm636829wrn.61.2018.10.12.02.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 02:03:32 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:03:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mfd: ds90ux9xx: add I2C bridge/alias and link
 connection driver
Message-ID: <20181012090329.GX4939@dell>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-6-vz@mleia.com>
 <20181012060455.GV4939@dell>
 <c8f01b88-c14f-867d-d796-7464b2e8ccfb@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8f01b88-c14f-867d-d796-7464b2e8ccfb@mentor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:
> On 10/12/2018 09:04 AM, Lee Jones wrote:
> > On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> > 
> >> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>
> >> The change adds TI DS90Ux9xx I2C bridge/alias subdevice driver and
> >> FPD Link connection handling mechanism.
> >>
> >> Access to I2C devices connected to a remote de-/serializer is done in
> >> a transparent way, on established link detection event such devices
> >> are registered on an I2C bus, which serves a local de-/serializer IC.
> >>
> >> The development of the driver was a collaborative work, the
> >> contribution done by Balasubramani Vivekanandan includes:
> >> * original simplistic implementation of the driver,
> >> * support of implicitly specified devices in device tree,
> >> * support of multiple FPD links for TI DS90Ux9xx,
> >> * other kind of valuable review comments, clean-ups and fixes.
> >>
> >> Also Steve Longerbeam made the following changes:
> >> * clear address maps after linked device removal,
> >> * disable pass-through in disconnection,
> >> * qualify locked status with non-zero remote address.
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> ---
> >>  drivers/mfd/Kconfig                |   8 +
> >>  drivers/mfd/Makefile               |   1 +
> >>  drivers/mfd/ds90ux9xx-i2c-bridge.c | 764 +++++++++++++++++++++++++++++
> >>  3 files changed, 773 insertions(+)
> >>  create mode 100644 drivers/mfd/ds90ux9xx-i2c-bridge.c
> > 
> > Shouldn't this live in drivers/i2c?
> 
> no, the driver is not for an I2C controller of any kind, and the driver does
> not register itself in the I2C subsystem by calling i2c_add_adapter() or
> i2c_add_numbered_adapter() or i2c_mux_add_adapter() etc, this topic was
> discussed with Wolfram also.
> 
> Formally the driver converts the managed IC into a multi-address I2C
> slave device, I understand that it does not sound like a well suited driver
> for MFD, but ds90ux9xx-core.c and ds90ux9xx-i2c-bridge.c drivers are quite
> tightly coupled.

Using MFD as the default dumping ground for anything which does more
than one thing has also been discussed before. :)

You need to figure out what function this device provides and
re-locate it into the subsystem which it best fits.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
