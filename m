Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C2FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A54721473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C26h3dAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A54721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeK2Syo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:54:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeK2Syn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:54:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so1008656qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 23:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGTuw6SC+qgowATtO98R6LX6ASv+SO7GsR/WJmJuE8w=;
        b=C26h3dATz1mWQhGhD+/dHtdoSPDvqLEgmK9qmZYdtRUpI1AvnhRB++lTqh57zCDr1i
         d2PZ80XT7+iPyfVDVz32+ugRjpvCGz0ClN1F0z54rV0yKL1mzw0dtfWs+L7QYrf0zWQC
         R7bN3uMeQBEZQdWFA7X8BWLoA3Z7sS1Cdf0n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGTuw6SC+qgowATtO98R6LX6ASv+SO7GsR/WJmJuE8w=;
        b=oY7OSK1wbi2kKrsMz9YCKVl1WjrG7NzbBCh5hnOG6HAWWFyriIszUiKQV1VcXVXIQD
         616iVaXDe7a0l/DzKCTzvv/MIwvYTTzPjsmZLffw6Lo7EqqYL0aDjsKLeRhvWCAodGlQ
         /PyRH2OO9tsLI76XNsIg5v1FXcQToAH+rLZcsasxULofZByRmhI0TOIWOJHV3x1wuVlj
         y7dPtzigeRueT8hap5ZRLtSbZt3Txpu/9Vh4meEbrnAZ97mu0cOs45iZWmlhRCxfPqvt
         uuop/6evSD0QfOWSYToIHAlokzQRQ+bPM7p7X1AKS4vpM4nPhodgJ2fbOqbJRRCl0AmJ
         sing==
X-Gm-Message-State: AA+aEWb28x85owZ3i13P2/OShgdoydWVF9llUeQzr+Kq0dzfns1iUJCD
        rcJyTprY5gKTxgy7fL0TRuUSqafsY+DUAEyP91J76w==
X-Google-Smtp-Source: AFSGD/XNosAIUpW5sgW+Cz6Y8eAo2b1poRadlNSYxcdpO4vqa4E0RxErKTXA/VbXkeDEgwkIhyKXl1gFq2tbOgGNM9U=
X-Received: by 2002:a0c:b11a:: with SMTP id q26mr438548qvc.2.1543477815561;
 Wed, 28 Nov 2018 23:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20181128095358.42498-1-hsinyi@chromium.org> <20181129031627.45006-1-hsinyi@chromium.org>
 <1543472774.32173.114.camel@mhfsdcap03>
In-Reply-To: <1543472774.32173.114.camel@mhfsdcap03>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 29 Nov 2018 15:50:04 +0800
Message-ID: <CAJMQK-i0a0J54hx2ii-Zr9=LoAeOWNUfDS_vBPbDkx7sGOZ=Vg@mail.gmail.com>
Subject: Re: [PATCH v4] usb/mtu3: power down device ip at setup
To:     chunfeng.yun@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Thu, Nov 29, 2018 at 2:26 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> hi Hsin-Yi,
>
> On Thu, 2018-11-29 at 11:16 +0800, Hsin-Yi, Wang wrote:
> > Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> > so host ip sleep will fail at ssusb_host_disable.
> >
> > Power down device ip at ssusb_host_setup.
> >
> > Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> > ---
> > ChangeLog:
> > V3->V4:
> >   *update comment
> > ---
> >  drivers/usb/mtu3/mtu3_plat.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> > index 46551f6d16fd..e086630e41a9 100644
> > --- a/drivers/usb/mtu3/mtu3_plat.c
> > +++ b/drivers/usb/mtu3/mtu3_plat.c
> > @@ -200,6 +200,14 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
> >       mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> >       udelay(1);
> >       mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> > +
> > +     /*
> > +      * device ip may be powered on in firmware/BROM stage before entering
> > +      * kernel stage;
> > +      * power down device ip, otherwise ip-sleep will fail when working as
> > +      * host only mode
> > +      */
> > +     mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
> >  }
> >
> >  /* ignore the error if the clock does not exist */
>
> Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>
> Thanks a lot
>
>
>
