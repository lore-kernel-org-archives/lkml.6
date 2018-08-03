Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9E9216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kxa1K976"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9E9216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbeHCJkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:40:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38459 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeHCJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:40:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so5322015wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zpgbf6BQ1jnhJak24sIuPfN+mR5qqp3nZ9j+6+bwT38=;
        b=Kxa1K976UH8Ls0R+bnjcMV47JToZwMfOf7IJf0xm36faK1dUKei7DLjBKNIKZnmNK4
         9ip7jvnBUlKKaHGM1qOO1nqFSrN/c0cfJkPCPW0GA6smH4MuWdd228XhQEZUhcjH70bq
         WdWTi4jkhL5Z+4MLIQ9S7Xu3nA6S3+w698XvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zpgbf6BQ1jnhJak24sIuPfN+mR5qqp3nZ9j+6+bwT38=;
        b=N0EcdLN13l6ru7qYThLxvcuuPW5A1UWYy4e69t+q1Pma4BlMKy1JBrXtfIK4MKmZPI
         c9ywuMSvr/czPDe/8LzHNGzaKn08QHkhaV7U2oBSCRTjK41c4vYCMj70bb4Qppz0H0y3
         Fau+pdg3g6LzxtmzGmXpbKik96TmGR8H3w3bhHDNJ/gNuk7N2D4114pkevnvgbNS0uB8
         tLpCPXpe06LInxqlntespG58s6ml81FU0J3zmX+0uA8t2VHQx4MeaARimI7P6+5+ogJB
         oyb/QGa63FDYnpjdEI338u+eles7/kx4SDgv3Yom74bbDOnj+9O/b5G9zdJyWgYG4oh0
         Cf1g==
X-Gm-Message-State: AOUpUlHjtpTHFg00da6qU3doUw8tYzfRFCrxed8EezQ3s8/z0Do+Zamr
        EV6E9pUGi9qLQzYojZ/GboWi2w==
X-Google-Smtp-Source: AAOMgpfhBXRB9d7ppAdCOuASWh+quN6EXrIHx2QFiUSSrPnjuWBebrS7ZqiRnSsgUpGRDCL8+Gv3Mw==
X-Received: by 2002:a1c:3646:: with SMTP id d67-v6mr3944753wma.15.1533282306348;
        Fri, 03 Aug 2018 00:45:06 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o16-v6sm3160090wmf.10.2018.08.03.00.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 00:45:05 -0700 (PDT)
Date:   Fri, 3 Aug 2018 08:45:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     kgunda@codeaurora.org
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V4 0/8] backlight: qcom-wled: Support for QCOM wled driver
Message-ID: <20180803074503.xvjvllsejw7xq3ox@holly.lan>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <519913ec490934931b1c0b3a4539c283@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519913ec490934931b1c0b3a4539c283@codeaurora.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 12:49:34PM +0530, kgunda@codeaurora.org wrote:
> Hi Bjorn,
> Can you please help review this patch series ?
> 
> Pavel, Rob, Daniel reviewed the series except the "auto string detection"
> patch.

I did take a glance at the last patch... but in the end decided to wait
for v5 to look in depth.


Daniel.


> 
> Thanks,
> Kiran
> 
> On 2018-07-09 15:52, Kiran Gunda wrote:
> > This patch series renames the pm8941-wled.c driver to qcom-wled.c to add
> > the support for multiple PMICs supported by qualcomm. This patch series
> > supports both PM8941 and PMI8998 WLED. The PMI8998 WLED has the support
> > to handle the OVP (over voltage protection) and the SC (short circuit
> > protection)
> > interrupts. It also has the auto string detection algorithm support to
> > configure the right strings if the user specified string configuration
> > is in-correct. These three features are added in this series for
> > PMI8998.
> > 
> > changes from v1:
> >    - Fixed the commit message for
> >    - backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
> > 
> > Changes from v2:
> >    - Fixed bjorn and other reviewer's comments
> >    - Seperated the device tree bindings
> >    - Splitted out the WLED4 changes in seperate patch
> >    - Merged OVP and auto string detection patch
> > 
> > Changes from v3:
> >   - Added Reviewed-by/Acked-by tags
> >   - Fixed comments from Bjorn/Vinod/Rob
> >   - Splitting the "backlight: qcom-wled: Add support for WLED4
> > peripheral" patch
> >     to seperate the WLED3 specific restructure.
> > 
> > Kiran Gunda (8):
> >   backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
> >   backlight: qcom-wled: restructure the qcom-wled bindings
> >   backlight: qcom-wled: Add new properties for PMI8998
> >   backlight: qcom-wled: Rename PM8941* to WLED3
> >   backlight: qcom-wled: Restructure the driver for WLED3
> >   backlight: qcom-wled: Add support for WLED4 peripheral
> >   backlight: qcom-wled: add support for short circuit handling
> >   backlight: qcom-wled: Add auto string detection logic
> > 
> >  .../bindings/leds/backlight/pm8941-wled.txt        |   42 -
> >  .../bindings/leds/backlight/qcom-wled.txt          |  150 +++
> >  drivers/video/backlight/Kconfig                    |    8 +-
> >  drivers/video/backlight/Makefile                   |    2 +-
> >  drivers/video/backlight/pm8941-wled.c              |  432 -------
> >  drivers/video/backlight/qcom-wled.c                | 1298
> > ++++++++++++++++++++
> >  6 files changed, 1453 insertions(+), 479 deletions(-)
> >  delete mode 100644
> > Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> >  delete mode 100644 drivers/video/backlight/pm8941-wled.c
> >  create mode 100644 drivers/video/backlight/qcom-wled.c
