Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2676C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ylfcqi0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2676C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeLAJn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:43:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45422 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeLAJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:43:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3073525pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eVeEplCi2/ulbHPk4i8e7AdseSAOh5jFFGT7+gYW7vE=;
        b=Ylfcqi0Dg4VV2WjRbNKTm+2gu8DxD3SmRjva4CtT4RYiqIHgYhGi0BC858ORcC/w4h
         s3KhwcORIhhHPutyLfzjNR65I34V9CmmmsEaDfD2dS1Qg23hRAUG6IKGg+dEbIOYvAJP
         SECnBSue811eXbKoJff7rMPEph13VyhyDmNqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eVeEplCi2/ulbHPk4i8e7AdseSAOh5jFFGT7+gYW7vE=;
        b=B57vfvkYOX4plGx8MruBFWyHpYZ1r8Jlpk4SEWWxFvE4kpYoIeOsvz9vUA6NoyLXmZ
         bkkDRaAMTF9wshpFpjGh6k4So/8WZGGigULnNGdi50AcpTTqBmbbxytf0oW4ENp6kadF
         MMJcnWaNn+Kjrjb3Xh1+1RfxTpvrlMi5EcUAgjTPR4o/n3KropT6kOAOwVuy1Qjo4HKo
         x0H+fMhje4v1ZOLAygDJwNTR4yGNLCWOMQQWodHJERtK+egprRjNfNoQVKXuSVE9b32H
         y5XTWCK5E+IGJV527BCmbhYpquA02czQg0NX9kqBwps5jOFNNG8fOoT6jwUmx9J/dRHk
         1+vA==
X-Gm-Message-State: AA+aEWb56cq9LkioKWUU4qM2eMNI/vtq9GgRUYDA32+OEay2p9X5d99N
        cVdtlvIGr0z+0MgL6iUbsTIyLg==
X-Google-Smtp-Source: AFSGD/VjIeB/OUkYxhDX4oXIhoPHOvP9i3DeEWSEl2napHuLVEYlJ931MRfR9HuzdnYUvWSpTBaB1A==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr6158687pgd.110.1543617159669;
        Fri, 30 Nov 2018 14:32:39 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id q199sm18361880pfc.97.2018.11.30.14.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 14:32:39 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:32:38 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from
 the DT
Message-ID: <20181130223238.GD22824@google.com>
References: <20181126231159.122298-1-mka@chromium.org>
 <20181126231159.122298-4-mka@chromium.org>
 <CAD=FV=X5r1CCSeTDXy_cYOBDf4ExNe276pFQSC6T+WWg2=SchA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=X5r1CCSeTDXy_cYOBDf4ExNe276pFQSC6T+WWg2=SchA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:00:50PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Nov 26, 2018 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > @@ -409,8 +410,9 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
> >  static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
> >  {
> >         char *clk_name, *parent_name, *vco_name;
> > +       const char *ref_clk_name = __clk_get_name(pll_28nm->vco_ref_clk);
> 
> IMO for the 28nm PHY driver you should probably make things work OK
> even if the "ref" clock wasn't supplied.  In the spirit of the stable
> device tree it would be nice (even if nobody actually ships device
> trees separate from kernels).  ...and also it makes the whole thing
> easier to land.  If you add compatibility here then the code and
> device tree patch can go in separately.

Ok, I'll make it fall back to the 'default' values if the ref clock is
not specified.
