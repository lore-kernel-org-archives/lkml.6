Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50702C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD2121917
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCB/zVzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394438AbfBPEPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:15:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36682 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394416AbfBPEPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:15:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so5821254pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 20:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7zOY7rJcyPkYN02Whkr/mHU6wjS0SWfiF1kM+cR67EI=;
        b=PCB/zVzFFC4VyesOFx7iBqctUvJ+ATC1wmof6jXHXtfOvtcQhapyvy2CMpc53gay5A
         N4kFEfufpDM1jfxCITojOPRLnbS+TMvu4bQxyKubXSOWLyKdULMR0sDCAren53U6QEAx
         re+yL4T7HgMdtpT0GZ6ph0YhQXOA0qYVIjo2sqdRhFwaG2WcfvdcyxYn0Hz//rOQ8BE1
         yCsiZ5OeiPiF/na3uRGwNbtbBsQhGaz8E0ib+1IPo2cn1uB+R9QTNv3alywORlIaR0h/
         iSDuV4CBq0XVjwyTE044vFYHsWwpoTo+1Tw79ICMxQOFXtOS7RZhtA08nGS3/FEqUSuZ
         nMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7zOY7rJcyPkYN02Whkr/mHU6wjS0SWfiF1kM+cR67EI=;
        b=p0mxjvHQP/r1Lyu2DKdlGtu69rUpXkvhNkQx5OPmfhdc5yqA4lMRNMPWFaCZZbACzX
         CZLlDprVO2DlVbOR0bvg5nzAdL7Gaxhv8ifKLgnUhgb/l5NakQwN4OG08hibplrt7Jxb
         IgD3G2IAHmITE5FjBYnjv59tBR+3HpqIs8KVuc/0P4sjGNLh/fvrxsfs0pqcOn7nYeRr
         E6ghpBD0WsuOHFWAF78SwU45g/+/yX1moI2NpouaUpexg+vx2hE6dXRdtcciS8v3chFO
         WtSvwlwktBdjLS70ykxzN5YVq1OBcXajXCFe3B0BW6BIkL0EZ5ckb8WqE1ZOtmc/VTRu
         xbyA==
X-Gm-Message-State: AHQUAuYfcaTmScYHlZRD3C2W+lvdDxvoJrBGcE348KpxE2urCzPj/wFB
        zHtKD2lJwoPI+J5sh9E4Hw5l
X-Google-Smtp-Source: AHgI3IYtahhOfevSDnucFXm0FKCMF6V5aYRvcR3TbNLUwibqRjkfeZDvRWPSVJgpX9yWoZcyoVpq4A==
X-Received: by 2002:a62:444b:: with SMTP id r72mr13316658pfa.184.1550290550447;
        Fri, 15 Feb 2019 20:15:50 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6190:e85b:d8eb:c013:fd6d:7b1d])
        by smtp.gmail.com with ESMTPSA id n75sm2889719pfb.39.2019.02.15.20.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 20:15:49 -0800 (PST)
Date:   Sat, 16 Feb 2019 09:45:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, afaerber@suse.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add clock support for Actions Semi S500 SoC
Message-ID: <20190216041541.GB3054@Mani-XPS-13-9360>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
 <20190201035343.GB4283@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201035343.GB4283@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Feb 01, 2019 at 09:23:43AM +0530, Manivannan Sadhasivam wrote:
> Hi Stephen,
> 
> On Tue, Jan 15, 2019 at 09:03:34AM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This patchset adds common clock support for Actions Semi S500 SoC of
> > the Owl family SoCs. This series is based on the initial work done
> > by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> > 
> > Since there isn't any update from him for long time, I took the liberty
> > to modify his patches, address review comments and send to list for review.
> > 
> > This series has been tested on Allo Sparky SBC.
> > 
> 
> Can you please merge the clk patches so that I can take the DT bits through
> Actions sub-tree?
> 

Any update on this patchset?

Thanks,
Mani

> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > Changes in v2:
> > 
> > * Incorporated review comments from Stephen for driver cleanup.
> > 
> > Edgar Bernardi Righi (1):
> >   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> > 
> > Manivannan Sadhasivam (5):
> >   clk: actions: Add configurable PLL delay
> >   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
> >   ARM: dts: Remove fake UART clock for S500 based SBCs
> >   clk: actions: Add clock driver for S500 SoC
> >   MAINTAINERS: Add linux-actions mailing list for Actions Semi
> > 
> >  .../bindings/clock/actions,owl-cmu.txt        |   7 +-
> >  MAINTAINERS                                   |   1 +
> >  arch/arm/boot/dts/owl-s500-cubieboard6.dts    |   7 -
> >  .../arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   7 -
> >  arch/arm/boot/dts/owl-s500-sparky.dts         |   7 -
> >  arch/arm/boot/dts/owl-s500.dtsi               |  22 +
> >  drivers/clk/actions/Kconfig                   |   5 +
> >  drivers/clk/actions/Makefile                  |   1 +
> >  drivers/clk/actions/owl-pll.c                 |   2 +-
> >  drivers/clk/actions/owl-pll.h                 |  30 +-
> >  drivers/clk/actions/owl-s500.c                | 525 ++++++++++++++++++
> >  include/dt-bindings/clock/actions,s500-cmu.h  |  78 +++
> >  12 files changed, 661 insertions(+), 31 deletions(-)
> >  create mode 100644 drivers/clk/actions/owl-s500.c
> >  create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h
> > 
> > -- 
> > 2.17.1
> > 
