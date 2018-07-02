Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4604C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF6253A0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6VKBfTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDF6253A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeGBBAY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:00:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44909 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeGBBAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:00:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so9491785oih.11;
        Sun, 01 Jul 2018 18:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RVJFcv2eKNfH/DL//sN0qEcpS0iIEDh4Mzh/BtUhdV8=;
        b=D6VKBfTKz5YLDThHyCyshlL5i2Go6noihXkxNiT36XS6A8thATTuAlRyUDptCjr5oR
         MsvqXpCynUva5Yo+JlgEnNln8IUR0QegSt3EclyBdAMYv/GeVnBnNeQ+1ahshN7N8gIa
         lUti5FR2SaOxVWwTRt7FQ+v7kWwmjleh4l6VTuE3nLXj5rJgnRLjvUVoffv3/PoiHj2/
         MSyP5XGPpS2fPVGPwykJp+SkPhhy8106hliNHijw6vn+iEfOfovOmLeLGeejGwdOycXv
         Haa+Cn6/chJR6CSJTGDx7luWBJuBKqJtdWj/SVjE7HOiiExgfutMmzg5DuyqYEry8sG9
         47tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RVJFcv2eKNfH/DL//sN0qEcpS0iIEDh4Mzh/BtUhdV8=;
        b=iqICwtcgMKqjMobr04U9hz+G3aB6J+9vQ//ZkEEjQG4vvU+0vsCunFprtOSBoTOfLW
         e6F6e3O+VdrJxu35b9Zyli76ZLHwXA8sxEjRA68UP7R0g4PCaytUy44vd4wVgcvz7qWV
         ws50dvsX6QhnMJ6uCxlur8v8FQgj61Xcsvtt2YwEX60K/PDq9a7TepDEZw/OGw49sbuN
         Sbdo4lRprbj6BYweTDWisLDTv7YYGoyogBgOMSK6u4jSQud+/tZ98xykrgSRqLPbNFki
         lSd69xcqDkZ2ZSVURKussJ0MSebrLOAPF27lH+9V4Xh7i7P2w8F3Cvohcmdhd/CHelk5
         73Fg==
X-Gm-Message-State: APt69E1s2Q0cP8Mj2is5Ng7K1wlC0lpiHavJ/4wToZiimSHjpcgFjfPB
        2dHTyJPT/KSyE8RHAzdnZABjBFEGKizflws+EU8=
X-Google-Smtp-Source: AAOMgpdBrjl7G2DWfK8z8yxwmPv4F89nNeUgf+wfO/07Pdsuyoe1zR9hVzVGinSL/mVnA1rkSlRXyq1+5ZJAzCZBBjE=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr13871953oii.198.1530493221818;
 Sun, 01 Jul 2018 18:00:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 18:00:21 -0700 (PDT)
In-Reply-To: <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon> <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com> <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 1 Jul 2018 22:00:21 -0300
Message-ID: <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Sun, Jul 1, 2018 at 9:57 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Just want to know how to handle such case? The kernel patch will never
> be applied or is there any way to make kernel patch and dtb patch applied
> together to avoid any breakage?

We always want to avoid breaking a working dtb when it is used with a
newer kernel.

In this case we need to revert the kernel patch as it causes
regression with old dtbs.
