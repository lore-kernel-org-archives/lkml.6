Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9C4208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1ST1KJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9C4208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGMSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:06:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34538 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeGMSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so63737892ois.1;
        Fri, 13 Jul 2018 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KIdcACCaa1u/r4tVBHxv5L2dyrngIFmx4X91t/G5x0c=;
        b=k1ST1KJfi8jttWgnHWEEjQAsa1dV+PbzL+opMA1UMdy6SH6wYauo1mDGF231fsRcli
         JlGA6ay68fZqqlSywe78sIhkayt1kpDvgNYGJL0AXPCUVPATLoZJWEUKcXJMEjX1rYmb
         6R+isDNcnE3net6pN4KykpNT15HiifrJj16fM9nJ9uWMUcs8mUsciHXJqvlg6hmhNQB9
         mZk4AUvBU0j+xdRtruf7GwtOLrUk6hSC90P462a/fiaE9KUjcGzboljdf2Q8N5iAB7da
         IHdCx0k3y3XTXFZsKCPd4IDydDUQCm5WybwzVk1Y70HfYgIgAc00ZGMNn6H/KEytCbKz
         60CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KIdcACCaa1u/r4tVBHxv5L2dyrngIFmx4X91t/G5x0c=;
        b=T4GZixEkDs+7jW3Hbi2oqhutA8BNe+hMNLElsNx+KeFoeI7OfdiKL8Cqcg8TUnIlc/
         uiB3KjrH9ienwgq2yyWbhxiOzdT8FIjN2TeJky07c2Zr4fz9yEixCwy3EimsofP7O++B
         ujGD1TkNita2dyuVgQrTzTlB9xSCYP9AtyHMZSPBG0GC4wUDmmR6WRGr0g8rc1qnD1qC
         NaN1qVgKsvICod/HZyB2Wc2prxOGb8b/u5az5ElUgcoicjSmf0oltDlv0lu+dvPTyuK7
         6KMOwznIM8eG5/PoRCzAtyuHl1SntWb6/berpRS5iJrKiT8RUoeVD5lerPmw40D/Myes
         kA5w==
X-Gm-Message-State: AOUpUlGuOjaC5hzIIqu4RCxBCs5dOfCdHTqQddS0ZAoR5MSfGgc7U+rr
        dvrjHJo39BeqbQr7FQFD4Jsysw3UFq2PE03gCyo=
X-Google-Smtp-Source: AAOMgpei4FIso3HGXYYTqqLKEI0K4U53tZIixz48sF7ZI7RqxWNv4/LdDFPciGl3U8Of2SW699hMpy3QnmgTuNj2kho=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr8532603oif.9.1531504234715;
 Fri, 13 Jul 2018 10:50:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:50:34
 -0700 (PDT)
In-Reply-To: <20180713173005.19552-2-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com> <20180713173005.19552-2-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 14:50:34 -0300
Message-ID: <CAOMZO5BiSG2kRnTgda1ob5bP8-yhc7j0a5kndVcJMr=UwRaDjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 2:30 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Instead of relying on default values, configure PAD_AUD3_BB_CK to be a
> GPIO explicitly. While at, it change the pad configuration to enable
> a 100K pull-down (the pin is used as IRQ_TYPE_LEVEL_HIGH).
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy@gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
