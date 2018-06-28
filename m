Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6AAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FE12745D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOiqXPLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FE12745D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966137AbeF1Nfx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:35:53 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40239 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965482AbeF1Nfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:35:52 -0400
Received: by mail-ot0-f194.google.com with SMTP id f17-v6so6143129otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WGHJe90gfzDzfxicE2Cmq39nLoE44KEiCSUFAJUrwGg=;
        b=NOiqXPLkynFhCH4iu41B/tRYNhr9KvL9aSLxvAT3OYqrrnXOnBlocOEGeQqqVlarRe
         ReaKy6henhvnyijKnAVfkFVsXBdbbXYOtlJ39T7fQwgxteK53HhNZkoHjwPSwCYsAvBF
         dyGyh6aciQBoaqNC4S7TKTunCLMMEjYnkYept1mnXRiMWnQ6D0NhTciGwYRCijY+pZtY
         OdqrR+oNbQL1B9Eju2i+kiFoXXaSbuDy7pMTyEjTQ6iUQzySkXF4HD2eAB2ALjEygMpA
         Rwq1UiBfqYkehrBJ41kYc9eAfa79HJ17XuRxZyIK2BZYnNlBosbybDbUpnRgQj/Clnne
         zcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WGHJe90gfzDzfxicE2Cmq39nLoE44KEiCSUFAJUrwGg=;
        b=WPOPRH2XABOgiK9Z5j8Q8olS4fmV+A26bGe7XbbljCBNIhauFLjq4ByviropuzT3pB
         CX1rkegiT/mlCeqvwOExenuhzKgmaXfDPkuR+fKlXqWvvgN/KpyZryvKCNp4J9kpVx7y
         onqPq/JCPDBYjkDqF30sznK61W17JT2RsnTd20b997ClMWxKuvgey/Ogwj9KvBWjYm7C
         cKVUIj/epGIUYcJpdvzqTmHzo6GckOF3MWnDlZh+IB0LDfhkeQqNW0Txz4EhVDa3Bbho
         eac4WhXhzTBxl16mnmGqph8PAPGUtg63Lr9gWP3UxHGN7zx+kjB3Wpyyl5pDBKW0cXDY
         CdSw==
X-Gm-Message-State: APt69E1bWjZVlvLsC1McZfgs0X/vgsA6WYQKk62vq0wAzu8xkjj7mWh1
        kQdrv7VOMBdXv1CO3Qtf5ARKN08j4cwDXDKquRM=
X-Google-Smtp-Source: AAOMgpeO9U2Yr3YUH+3T/qzRiC2myjeeBGGQUbx5Z7Zgh2aScFR3fl8bVC10WFPS2bEqIpYwXGHNfB15l9A7Wkat7xU=
X-Received: by 2002:a9d:30c2:: with SMTP id r2-v6mr6274266otg.25.1530192951556;
 Thu, 28 Jun 2018 06:35:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 06:35:51
 -0700 (PDT)
In-Reply-To: <20180628043713.14425-1-andrew.smirnov@gmail.com>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Jun 2018 10:35:51 -0300
Message-ID: <CAOMZO5DqkfotddSRbibD0UE2R=QZMef2-4Gr3LaeGT=Fq9qMyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx51-babbage: Fix reg for usbh1phy
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Jun 28, 2018 at 1:37 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> There's already a USB PHY with reg of zero on that bus - usbphy0, used
> by usbotg (included from imx51.dtsi). Move usbh1phy to @1 avoid
> address collision.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index b8ca73d3d379..541c6e67ad1a 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -175,9 +175,9 @@
>                 #size-cells = <0>;
>                 compatible = "simple-bus";
>
> -               usbh1phy: usbh1phy@0 {
> +               usbh1phy: usbh1phy@1 {
>                         compatible = "usb-nop-xceiv";
> -                       reg = <0>;
> +                       reg = <1>;

We don't really need the 'reg' property here.

I have sent a previous fix for this on an attempt to fix dtc warnings
with W=1,  so let me send a v2 based on the feedback I got previously:
https://patchwork.kernel.org/patch/10399085/

Thanks
