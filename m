Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCB0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404920870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SZ6LOzJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8404920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeKSXKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:10:51 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:40482 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeKSXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:10:51 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1641610C157C;
        Mon, 19 Nov 2018 04:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542631639; bh=v9VBC+oYjOTcpn56Q08NVqCWGbAc/arZyoYWEYXikoA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=SZ6LOzJFFjd/h9yO1LB0cugD1hu7ah+q7mzfdtrBUI8OrIojedRtWmX+x+WN8rSfi
         tyIik7yIZMTpKOXy5+CpVyY6Lcpj4fQq5NmgZh3xLqzrhmqM89RAntvC8DcI+UdJYk
         uCcagNIm7XIzO3do0XYd65ES8stRjAklzACDS1M2keITBr4RMz0B6cSXdp6KJr1ZMj
         osl57GKD0v7bMWtKBxW9VdWvRtV72NKrP1HVuZd/rbeEEZghHiVicvo0x95DucqLGt
         2ShPA9OccSvROGkZ/pTyz6TWvfN8cpfX8qR2pnvwjmkYT2TX+AuDiJJDgIW5lXq0au
         QtOGU+CTLB5fA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 090123801;
        Mon, 19 Nov 2018 04:47:16 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 04:47:15 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 13:47:13 +0100
Received: from [10.0.2.15] (10.107.19.165) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Nov
 2018 13:47:12 +0100
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <vitor.soares@synopsys.com>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        "Cyprian Wronka" <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon> <20181115150137.GB4169@kunai>
 <20181115162826.42b54776@bbrezillon>
 <1d64f21a-ad24-94e0-2c17-25729ef59a31@synopsys.com>
 <20181115200058.1869afdb@bbrezillon>
 <5f946406-a205-3802-aefd-ebd8b5a72b0b@synopsys.com>
 <20181116141639.31074113@bbrezillon>
 <ffcc3c3d-0bfd-23e2-5fbb-00cfbcd6b7af@synopsys.com>
 <20181119134351.7f2edcc8@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <62ef73ec-ba7c-793e-d174-c6e47840142e@synopsys.com>
Date:   Mon, 19 Nov 2018 12:46:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119134351.7f2edcc8@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.165]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/18 12:43, Boris Brezillon wrote:
> I know [1], but there might be other subsystems doing the same thing.
>
> [1]https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.com_linux_v4.20-2Drc3_source_drivers_spi_spidev.c&d=DwIFaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=S_YF5FjfGFFGFa7x6nHrT6npsIFjUbYRorSANaPpaiI&s=xXnwGBSGrVxandwp6biURmXq-85iMMLd8-n2McDsIWY&e=


Thanks.

