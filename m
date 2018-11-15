Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4324BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DC5223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WkhpOeeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DC5223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbeKPBdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:33:46 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:40282 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:33:46 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CC66A10C0EC0;
        Thu, 15 Nov 2018 07:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542295529; bh=Q6NZD9Wbv7WgydIrv8pmXT6UfxGOHaZoRwnr+aqlxzI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=WkhpOeeMzUiGcFxAUo3hdOvPo6+rDzAgScnncer6Q2KVCZ2Kv2Pbyb/RUScI6vwdg
         D3WMrCLb5VJrJoWyuSEDPNehaqx6hW8p/TNRkIvAUivBpMMbutZ8NyjPFJnhLKmyls
         C0ksBahZmnYM513OQkYj7NWRGbLUSkH2/0TNu6TkzYnYBy5T37wRoxn/qc8l80mEVl
         HtWoKEycg6NkcNnbtGLjr259wl8ItffaOeclhciEvnHdS8V1PTIuf69dyiYwxtvFjr
         aOIKeUvcv859xczqLzTvaP6cZvdz5j1iaGRNBuOnMv3dHgJkdRRcMffF50PMCwB9xN
         SbSraXrKERgBA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1FE393CFD;
        Thu, 15 Nov 2018 07:25:28 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 07:25:28 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 16:25:25 +0100
Received: from [10.0.2.15] (10.107.19.116) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 15 Nov
 2018 16:25:25 +0100
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Vitor Soares <vitor.soares@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        "Alicja Jurasik-Urbaniak" <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon>
 <CAK8P3a0gmCtMac7ctKZ3r=2Dxo03pYvuXkQ7c4Vnt9yMoLDMSQ@mail.gmail.com>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <08a591ae-c75b-80b4-b608-ca92f6d932f9@synopsys.com>
Date:   Thu, 15 Nov 2018 15:25:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0gmCtMac7ctKZ3r=2Dxo03pYvuXkQ7c4Vnt9yMoLDMSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.116]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 15/11/18 14:25, Arnd Bergmann wrote:
> I agree about better not exposing the bus as a /dev/i3c* node, and that we
> probably do need to expose individual devices in some form to allow
> writing complete user space drivers that can do everything a kernel driver
> can do.
>
> Can you describe what a low-level interface to the device looks like
> in the kernel? Can this be abstracted as simply pread()/pwrite() plus
> an interrupt mechanism, or do we need a set of ioctl() operations as
> well?

Like in i2c is likely to need the ioctl() too.


Best regards,

Vitor Soares

