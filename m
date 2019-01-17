Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39852C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D8B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbbjY6YU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfAQWZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:25:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40418 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfAQWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:25:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so5378930plq.7;
        Thu, 17 Jan 2019 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ja01K34YvVKV97X4JIcwkhIC9kBYMpmVCBRsRoM7qWM=;
        b=JbbjY6YU0Fu+itmrSj6IjuiiUeS4yXFAEXlYBmyKMH74AzNvYXtFat5zlgoAq9Lyk+
         +8mheQ5qAfX1hELedeTZzyYplrlju0H4XEABkxYUIpMn6AgvnADp+to8yZCcMW2YHBll
         AHsrWzQB4+rPDYjsdZIJE9ecf+gOp3JC11LxrcXNmogqepG09RiAimh7PAUosMNrj5Rv
         C/RfWJcdw3pAMHIpTJhEEVRLCZuX7d9PAPZVnzcZecl0rdwRQvkaC7Iqu2z3DUEzkYgC
         yF8mpBWQAhJs4Qb+Cg5SVc1tjE9fXMz7sKmWBZIC5l+fM9xex109/F+WAU3k81y10v6/
         VymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ja01K34YvVKV97X4JIcwkhIC9kBYMpmVCBRsRoM7qWM=;
        b=rCdBueivNOEvxrRHDtpgpLvQI/tx5KehmFhMXUVga6kTxdQq76XJTkDN/BuCWQyj3a
         /KEdKguY0GopPAF0qyawg4CsgJqnzEejN4JbWb1u6InuOUKXv0c1EK7T4syuGiqPYCkp
         WCCm6ob3WuKHBiqKIuc8W869jWziUzq3IdwsKHA1yX0gZKbr/WlKjxmcqo57dX8SwDDF
         GvSoV9zyS4/Mf+2KR2TRtT4pmjtKEIcAPTt2T/BfAS4evSxqih4zH4o4rGNeoWva853C
         wF1h2PKNYdMjPHVE/3dyK5iCbZKcZaa6LKjRx5Kp0S/BEq5jHrBQY+vCSxRlQYtwacUz
         wUmg==
X-Gm-Message-State: AJcUukepIC4fnsUIf/Nkh/OXKzr9LrCoQ1F+6Vipd9MRxlBFamKOEW5W
        mISu611XPO9ZJ4jxs3UfOqI=
X-Google-Smtp-Source: ALg8bN45mDgTS+6IDIWy92W+1lBIWzgKkBpPj5IYpWQ1PSSAwsauspnaD0GO9CBLBIcZUYlvnIw2GQ==
X-Received: by 2002:a17:902:f20b:: with SMTP id gn11mr16168541plb.274.1547763901431;
        Thu, 17 Jan 2019 14:25:01 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q1sm4165517pfb.96.2019.01.17.14.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:25:01 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:24:58 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190117222458.GG16918@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117222218.GF16918@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117222218.GF16918@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:22:18PM -0800, Nicolin Chen wrote:
> On Thu, Jan 17, 2019 at 12:46:25PM +0000, Viorel Suman wrote:
> > The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> > drivers and related DT bindings documentation.
> > 
> > Changes since V2:
> > 1. Moved "dais" node from machine driver DTS node to device driver DTS node
> >   as suggested by Rob.
> 
> Yea, it makes a lot of sense. Otherwise, since the connection
> between IP blocks is fixed inside the SoC, the virtual sound
> node would need to be put in the soc-level dtsi, which sounds
> odd to me.
> 
> > Changes since V1:
> > 1. Original patch split into distinct patches for the device driver and
> >   DT binding documentation.
> > 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
> >   RM-compliant.
> > 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> > 4. Added machine driver and related DT binding documentation.
> > 
> > Viorel Suman (4):
> >   ASoC: fsl: Add Audio Mixer CPU DAI driver
> >   ASoC: add fsl_audmix DT binding documentation
> >   ASoC: fsl: Add Audio Mixer machine driver
> >   ASoC: add imx-audmix DT binding documentation
> 
> Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

Oops. Just saw Rob's new reply. The drivers look good to me though.
