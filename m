Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E9C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268B320883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRWFbLVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268B320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGKOY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:24:29 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35649 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbeGKOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:24:29 -0400
Received: by mail-lf0-f66.google.com with SMTP id f18-v6so5329096lfc.2;
        Wed, 11 Jul 2018 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9kD0h0ojMpxdIm6YnKzBydpVy5fC/ZqR71yRp0phxGE=;
        b=tRWFbLVlTrASofW6UTGxOqLSUSCM6lHFeCB7AmyE95WMVv/66qvgNP9KJbVLjHBlMR
         anZJTGbXqkceYDWwGPrSGmpD4kTJzqOOGV/+5eg9P5/z8bTxEEvGXduKuaoRJNHNVFjy
         Pw4Ec2+QXpleGsfbXIqZKbpt7kqOhVQAFPQX8DOJrRawtRme+L1hKFSV1r1guvEDFgra
         A/TIKjkeiP45/3PxwEJtOGYOXbNCXXTHmQ2BY4Ob2N6+BinYi3Qmnaq0zIWe1lmKKrS1
         Etwu9SAC8JsdqShvG63hjlGAUuryMtBEiCLgXmfg8EiEdiBA10NNKftZopk9MDc+N/Zs
         zIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9kD0h0ojMpxdIm6YnKzBydpVy5fC/ZqR71yRp0phxGE=;
        b=JpxKOE81oHXJwS6K/SdxOuNO7XZ2QRZTqMjpup8tp+NpMdCuap0jrB2nHu3hguMN0g
         ElkSW/ywVznn1beIR88Z7Vs9ZWveH8T8yQZU09kyVwt+9cePp6w4/LeUfAcGD+fw9PF4
         ZD64LADwb5PAWdca+fCWahYL4746f7YQmhUi55A59MJi/pegTbvjXjJYlLk/7czW/jpS
         5XasjS97T9aNS3x3FIUnGNOOd5Yf8xhCevFfsIl/e2OCv3cZtmOmYsRoYvMIRTG9oGaq
         5Bmei8WzD+24Yq4322QvgduaMDOJqRob9KRUZbFGkB3F2ZsC4j/YDoYXoo7Pqe0ORFzw
         QeZg==
X-Gm-Message-State: APt69E1sP6702+9R8RcG5ecKBQJsMXGQKcBublRIe/WRGck/q70w261F
        1pcu0cjpwCiypmlgS4a3w67uvZLOGAKJXmeEPAA=
X-Google-Smtp-Source: AAOMgpd0Bz1pUB+P2OV09RhiryCDxUa+338ExOVGvH1DPRZVxBDSAFvySCDwQnTq3SyV2et/2+pGqi2sRx4Hmt/OPWk=
X-Received: by 2002:a19:5c06:: with SMTP id q6-v6mr6347166lfb.6.1531318792127;
 Wed, 11 Jul 2018 07:19:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 07:19:51
 -0700 (PDT)
In-Reply-To: <20180622104930.32050-8-boris.brezillon@bootlin.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com> <20180622104930.32050-8-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 16:19:51 +0200
X-Google-Sender-Auth: yO1xIOtW0l90GzrJ5ArgB_WWrtY
Message-ID: <CAK8P3a1D_crzMT8-2R9bMvMuq8F58=BgHUFSq2nntRHF0sZUQg@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] i3c: master: Add driver for Cadence IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Add a driver for Cadence I3C master IP.

The driver seems very well-written and shows that the framework got that side
of the interface right. Just one thing I noticed:

> +
> +static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
> +                                      u32 ibir)

> +
> +       for (i = 0; i < IBIR_XFER_BYTES(ibir); i += 4) {
> +               u32 tmp = readl(master->regs + IBI_DATA_FIFO);
> +
> +               for (j = 0; j < 4 && i + j < dev->ibi->max_payload_len; j++)
> +                       buf[i + j] = tmp >> (j * 8);
> +       }

This seems to be a rather inefficient way to open-code a readsl().
I suppose you need to handle length that is not a multiple of 4, right?

Maybe do it like

      size_t length = IBIR_XFER_BYTES(ibir);
      readsl(master->regs + IBI_DATA_FIFO, buf, length & ~3);
      if (length & 3) {
            u32 tmp = __raw_readl(master->regs + IBI_DATA_FIFO);
            memcpy(buf + length & ~3, length & 3);
      }

     Arnd
