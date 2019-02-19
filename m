Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D0A21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJJeF7px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfBSX3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:29:35 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39712 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:29:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id m11so16123544lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvAitqVF8YTDJoXqz+MECJPCjC0B0qtBCBm3syoZ1lY=;
        b=fJJeF7pxmhyxP5CMXJYWqYUgN8BQY7QRE8dWdogXcMMuQjawDaKEBbGQzjmCrEP68i
         Iq/3EH+VwQT5qWqcNNkysB7EFHtuO9t21eSbRI0ZukDb/r32Seq1I/7GHcznOmeI+z5A
         FGm46KPQixrj+ejLOjCFQ8yJqu51F0Frv1o4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvAitqVF8YTDJoXqz+MECJPCjC0B0qtBCBm3syoZ1lY=;
        b=QpW47dJaO54yiYjkIFQx0jqwW0kR6h7FZ/2MGMSJnshFHPzbWw2qvbTT0UWcgZc7Cu
         246sWCSQrT8rGuO7cbCLc2d1G8a1OpkbNyq1SHERHq75JOPJt8HyyzlVErX2xXrYv8+f
         MXS3/7wwzqAjxqlaqyLANJyEchcvxqdJn1FGXSHtZlp2iwwf0ZuIXaQresebCQe4Iw4b
         VbWX6qpKeiaesMYF4JCUJZnaTWErWmWWKLVZXReHGfPE3VaH4jSqBh2GAv1fKtAy8xBs
         IPsQFWg5Gl+jnJfXVsapdewUXlKVY0oiE09tYbc2EUMcBqbpehSHwzLb/GQykuOKDBsu
         8R8w==
X-Gm-Message-State: AHQUAua6xrZhbiG0RjXPHLaFnnY4EczTIAZLeQPCd/wNrRXK9F1hop/4
        xyod/p/+X5t8aL1Zi121FGlFGyiMmnE=
X-Google-Smtp-Source: AHgI3IYUINpmWwYjoAcq2+lcpaigNrnlqqDGzGMQkYOHZM0TKFGMJxEl1Ogc6F12THAkTn3gC3zFYw==
X-Received: by 2002:a19:4847:: with SMTP id v68mr17994744lfa.136.1550618972762;
        Tue, 19 Feb 2019 15:29:32 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a3-v6sm4664088ljd.20.2019.02.19.15.29.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:29:32 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id d14so7958289ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:29:31 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr2704106ljj.30.1550618970718;
 Tue, 19 Feb 2019 15:29:30 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:28:54 -0800
X-Gmail-Original-Message-ID: <CAE=gft5pp7sUHM8P3RTeFPdY-VWVLwLM6=abS6FffZU4WSOd8g@mail.gmail.com>
Message-ID: <CAE=gft5pp7sUHM8P3RTeFPdY-VWVLwLM6=abS6FffZU4WSOd8g@mail.gmail.com>
Subject: Re: [PATCH v6 01/22] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 1:06 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch adds decriptions for mt8183 IOMMU and SMI.
>
> mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
>
> The mt8183 M4U-SMI HW diagram is as below:
>
>                           EMI
>                            |
>                           M4U
>                            |
>                        ----------
>                        |        |
>                    gals0-rx   gals1-rx
>                        |        |
>                        |        |
>                    gals0-tx   gals1-tx
>                        |        |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-----+-----+--------+-----+-----+-------+-------+
>   |     |     |        |     |     |       |       |
>   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
>   |     |     |        |     |     |       |       |
>   |     |     |        |     |     |       |       |
>   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
>   |     |     |        |     |     |       |       |
> larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> disp  vdec   img     cam    venc   img    cam
>
> All the connections are HW fixed, SW can NOT adjust it.
>
> Compared with mt8173, we add a GALS(Global Async Local Sync) module
> between SMI-common and M4U, and additional GALS between larb2/3/5/6
> and SMI-common. GALS can help synchronize for the modules in different
> clock frequency, it can be seen as a "asynchronous fifo".
>
> GALS can only help transfer the command/data while it doesn't have
> the configuring register, thus it has the special "smi" clock and it
> doesn't have the "apb" clock. From the diagram above, we add "gals0"
> and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
>
> From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
