Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24510C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE16B218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ZWpiw3i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAaTYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:24:30 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46010 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfAaTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:24:30 -0500
Received: by mail-yb1-f196.google.com with SMTP id t11so1752959ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GOkTc082x66zQ8MWiASHM9atPoq5PEh05sfEPHmgtBg=;
        b=ZWpiw3i2UHaie+rcOcp4cdVdERseP7Ir1KbtBad2OlJFiFswIDqFGJnwnnRP8XwRNR
         syMdVZV6IoaE/sUB74/tgfuufIpPGavYvDe4VyR5Q0mAfqF5tV4qw0oE+9/mInGa0qVK
         7lP+qhdn0D5/WvpxmVgWMM4TpTcVIbBuj6wfnQ9k3fyiKWF4TlpJUf+rJ+6O3myGQ9xg
         pitITSmbhZLcO872zAn5OzO1qVpX4urszjqagqJDRopSqkHkad56qb6Rol7MdoCRWX9p
         8VCEZ10l1u0hJVrCurBLBWPV1Oq79saCcAu7FIloCUIiZYCw32fIiABOSrny0XiqMoJP
         p6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GOkTc082x66zQ8MWiASHM9atPoq5PEh05sfEPHmgtBg=;
        b=BnzBtretl6IjTdHeBAhuTxRnfZYolq7harnzTFq6311FWMWMDqs5lHhpkAI7EacPZe
         XTQQ8rH7oocGRmzZ5dRdqAZd2saqHOS8smUpjmdYpzgu2Rco0yufhlSPOeZewydUvBqD
         X1OFD5yxPHpJ/peqhZ92iPaj+aOGAGu9Lq6bdoxoEH2Il2fyhKFKpNQ91b/5kNXch+Ur
         fty8rBQVw9707kbtVUFrzwx/khGsBOsZqDG0GH42bwsuhSvDZitZd8WksRrEuKJyAbCc
         wR7v2R9JGbMEFrdigK05D60lHvnpmSLWEtaAc55HVza72ZwbtV95r5BUNMwv2mE7Mo5S
         YWJw==
X-Gm-Message-State: AJcUukfM87W/ko44ui0EvtxFdyh7lC7GdpsM36ctt8o+8OFuDFK17UfK
        iwvdNHTrKEoxZ/7liHNHA20cDQ==
X-Google-Smtp-Source: ALg8bN4uSwX5ARKdB5q8/OAF374EkUepCTE0MiwaCESnFbG21oWlqDtsJ+W4dNUMPKjkxqghZIEPkw==
X-Received: by 2002:a25:bfd2:: with SMTP id q18mr27698046ybm.271.1548962668925;
        Thu, 31 Jan 2019 11:24:28 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id z37sm2058302ywj.3.2019.01.31.11.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 11:24:28 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:24:27 -0500
From:   Sean Paul <sean@poorly.run>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>
Subject: Re: [PATCH v5 0/8] drm/msm/dsi: Get PHY ref clocks from the DT
Message-ID: <20190131192427.GY114153@art_vandelay>
References: <20181219235528.114830-1-mka@chromium.org>
 <20190129000534.GJ81583@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129000534.GJ81583@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:05:34PM -0800, Matthias Kaehlcke wrote:
> Hi,
> 
> this series has gone through multiple rounds of review and there are
> no outstanding comments. It seems it should be ready to land, or is
> there anything left that needs to be addressed?

From the drm side, I think we'll need Andy to pick up the dt-bindings
and dts changes, and then the msm/dsi changes can be picked once that's
merged. We could also do a topic branch if that suits everyone.

Sean

> 
> Thanks
> 
> Matthias
> 
> On Wed, Dec 19, 2018 at 03:55:20PM -0800, Matthias Kaehlcke wrote:
> > The MSM DSI PHY drivers currently hardcode the name and the rate of
> > the PHY ref clock. Get the ref clock from the device tree instead.
> > 
> > Note: testing of this series was limited to SDM845 and the 10nm PHY
> > 
> > Major changes in v5:
> > - none (see per-patch change log for minor changes)
> > 
> > Major changes in v4:
> > - always use parent rate for 28nm and 28nm 8960 PHYs
> > 
> > Major changes in v3:
> > - keep supporting DTs without ref clock for the 28nm and the 28nm
> >   8960 PHYs
> > - added patch to add ref clock to qcom-apq8064.dtsi
> > 
> > Major changes in v2:
> > - apply to all MSM DSI PHY drivers, not only 10nm
> > 
> > Matthias Kaehlcke (8):
> >   dt-bindings: msm/dsi: Add ref clock for PHYs
> >   drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
> >   drm/msm/dsi: 28nm PHY: Get ref clock from the DT
> >   drm/msm/dsi: 14nm PHY: Get ref clock from the DT
> >   drm/msm/dsi: 10nm PHY: Get ref clock from the DT
> >   arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
> >   arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
> >   ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY
> > 
> >  .../devicetree/bindings/display/msm/dsi.txt   |  1 +
> >  arch/arm/boot/dts/qcom-apq8064.dtsi           |  5 +--
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  5 +--
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 10 +++---
> >  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c    | 20 +++++++++--
> >  drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c    | 23 +++++++++---
> >  drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c    | 36 +++++++++++++------
> >  .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 24 ++++++++++---
> >  8 files changed, 92 insertions(+), 32 deletions(-)
> > 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
