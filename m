Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3194C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D292081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BzM35mhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D292081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeKHCrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:47:41 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:49332 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHCrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:47:41 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 22B8324E0372;
        Wed,  7 Nov 2018 09:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541610983; bh=M5fTyR4ZdkZypVDxzlDWk94TVstF4kI7osU4Ap4uT4w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=BzM35mhFlyS2gTFv82Knxh8WOqKI6lbR+5xPO16ysqi56hDbQURlgofpNbQesuA0b
         FcoKIqNYXF+0aDhHdptJOtvqGrTsfpi7+SX7uDwJSovaLblEKsC6EudquJZY6yxr5P
         lLOt0zpB5QsFgKycHXIjH+RPClh3Kgj+CTZR1tdX1ML5IOUZrV/DcU4UyAVte+Zhe8
         xnZPABkH9H4NLS0op4HLnrijLRYUuzblbrq0oYBDu4TWvb+K03p5VJfqLSEL0ESXgp
         iXIkkEr+IOXz+hRhyXPIL4UOHCYiSCb8vdD8VstegOK2alAHGHliw2aU+iByF3HoSu
         lZcTpZ4a3umiQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 016CC57A2;
        Wed,  7 Nov 2018 09:16:18 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 09:16:18 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 18:16:16 +0100
Received: from [10.0.2.15] (10.107.19.141) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 7 Nov
 2018 18:16:16 +0100
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vitor Soares <vitor.soares@synopsys.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        "Kumar Gala" <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>, <mshettel@codeaurora.org>,
        <swboyd@chromium.org>, <joao.pinto@synopsys.com>,
        <luis.oliveira@synopsys.com>, <manuel.abreu@synopsys.com>,
        <gustavo.pimentel@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
 <20181029134100.GD28520@bombadil.infradead.org>
 <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
 <CAMuHMdUO5_-TsGiu3otuLqNtLNgdnw=1QdKjTzPmSxHp9QotxQ@mail.gmail.com>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <4e05e568-c010-a6db-92b1-4c26ad503333@synopsys.com>
Date:   Wed, 7 Nov 2018 17:16:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUO5_-TsGiu3otuLqNtLNgdnw=1QdKjTzPmSxHp9QotxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.141]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 07/11/18 15:34, Geert Uytterhoeven wrote:
> Hi Vitor,
>
> On Wed, Nov 7, 2018 at 4:15 PM vitor <vitor.soares@synopsys.com> wrote:
>> On 29/10/18 13:41, Matthew Wilcox wrote:
>>> On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
>>>> +config DW_I3C_MASTER
>>>> +    tristate "Synospsys DesignWare I3C master driver"
>>>> +    depends on I3C
>>>> +    depends on !(ALPHA || PARISC)
>>> why?
>> Please check this email thread: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_10_8_393&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=dVPXOATdi751iTXEXYcWuChJA6hcIkXr8tF-i9hrv4E&s=Nk3lXNpRMzhvKMnlXUsFySTr5VYAr2228vXaZfiGBgM&e=
> Hence this deserves a comment, so we know when/what to do to drop the
> dependency:
>
>      depends on  !(ALPHA || PARISC) # needs {read,write}sl()
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
I agree with you, I just didn't know if I should comment or not. I will 
do that next version.


Best regards,

Vitor Soares

