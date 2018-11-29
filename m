Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C243C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268552081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ci8VZ6vE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268552081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeK2MYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:24:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45130 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2MYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:24:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so136179pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xeZCQx8Bek24GNSlNmyGJrjGq152qs+3Ax4KuvAKhk=;
        b=Ci8VZ6vEoWKGziFNYyGMj5Z80tkIQEcJURY9V48gh8VY4r7DKqTaaX8es6gy841viv
         BDjOeOWvKD78wilGiiArv3dF59uvFXH4wWGoEpQJ2yo7HdvSwQ18TicrNGvG0Jhm5sv4
         WEfSfBVl0WpIAVIoHjNRU6xe8TeE98/w6QPWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xeZCQx8Bek24GNSlNmyGJrjGq152qs+3Ax4KuvAKhk=;
        b=Ya3WcTJig12Ls8ezJyk7/duObLYDJy+o3WzmaLxndl8f6W2OsS7zA76SdpPN+xA+6b
         dxvQA/7wfP6t/LYfVSw+PPQZlC+wjRr1oj7x0O7EzgI4egVhufjgd2OYW4WDu3jldW2z
         IgTeJzICRLiiwvy9JfD8rXihyfczSpSs+GXkp+5+yrS0htuh0Gh6D8JOwtDfW96aTQcW
         GnOVWupD8qFWR1edOPKfao8WiGMh52D0xGedTHDxWX25YdSw/o/Shc0pBwLUnCZnGwJP
         jo4NJOQjRadkrXcn+E6BNcbGpdGaDfVrv8gs07xm/w/c6ejmXto10N75rOzhF0KWvGrP
         sMhg==
X-Gm-Message-State: AA+aEWbTBODqJFrODOGnkgpnBGzn7VdTLPSpw+324yBZTL5VoqDdT2T5
        n4mLLzvy/gicozAmsJYD/DZ3uYxiO2rIy/p1uT04ng==
X-Google-Smtp-Source: AFSGD/UTSH8tgDQpcoVSN9AZIjZk/EPyY8nXXnmWwDvks4XRVxyAKMVmuaIRoKQJVD0LnBAcl1HUvkoT453T9BFdkoc=
X-Received: by 2002:a63:6645:: with SMTP id a66mr34529994pgc.390.1543454467697;
 Wed, 28 Nov 2018 17:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20181128092953.41541-1-hsinyi@chromium.org> <20181128095358.42498-1-hsinyi@chromium.org>
In-Reply-To: <20181128095358.42498-1-hsinyi@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 29 Nov 2018 09:20:56 +0800
Message-ID: <CANMq1KDNqLrsGWOtgvN+auD8TcVJ60jz5gNT99rxxa4rUg8OnA@mail.gmail.com>
Subject: Re: [V3] usb/mtu3: power down device ip at setup
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        chunfeng.yun@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, the subject line should be [PATCH v3] (not just [V3])

On Wed, Nov 28, 2018 at 5:54 PM Hsin-Yi, Wang <hsinyi@chromium.org> wrote:
>
> Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> so host ip sleep will fail at ssusb_host_disable.
>
> Power down device ip at ssusb_host_setup.
>
> Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> ---

Next time, add a changelog here (e.g. changes from v1: - ...).

>  drivers/usb/mtu3/mtu3_plat.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 46551f6d16fd..792c420fd4ad 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -200,6 +200,13 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
>         mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
>         udelay(1);
>         mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> +
> +       /*
> +        * device ip maybe poweron in LK/BROM stage before enter kernel stage;

I'd replace LK with a more generic "firmware" term. e.g.
"device ip may be powered on in firmware/BROM stage before entering
kernel stage;"

> +        * power down device ip, otherwise ip-sleep will fail when works as host

s/works/working/

> +        * only mode
> +        */
> +       mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
>  }
>
>  /* ignore the error if the clock does not exist */
> --
> 2.18.1
>

Thanks.
