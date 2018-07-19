Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC990C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D89A20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V44ZFpgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D89A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbeGSLkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:40:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45898 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeGSLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:40:42 -0400
Received: by mail-pl0-f65.google.com with SMTP id 94-v6so3486550ple.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fgpk1lAw9JshMu9xYJa4h5v5izVsqq/6MCvIN53eUpU=;
        b=V44ZFpghtwC8eXn5GdH3cow1bFiYNPFgTwztt5UIBz5Po6WQ4SS93agrcb+bk4gSDq
         1qfu3tRz8+GplSk9qVivswaBqNRsHLTLjJRyuqhEt/23av+sA6IajMvP7J1WBI6yPn3c
         PLWKwyTvXyigd/QfFiIB7a9FEr5B9x4DDhM/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fgpk1lAw9JshMu9xYJa4h5v5izVsqq/6MCvIN53eUpU=;
        b=c1k5fYDZ913d3gIhtDr45tpZtf9roB/fJ1kQFqqqKQKfurcQT/ODI0aBdg0fpoSFUI
         OnLAJ12daqDKOwdbGkl9OUFiu0vDMBJekdVwZhCVHTGP1G/ZwK0rP2L1DC2UySAf6dTi
         wLF/fKEv/ibXXnGbLARMoVqmfCB/irD+qhrueILPklIUh6HygWKimi45Tlwg+Ba6vVmM
         pPSqzMDWtOPM1Bc/jW435QmAbVgHJmzZLflSCLg5BxkFhtBMbKPi88E5zgONNnFSJHq/
         /SXfxgRY4CXws9+w7VuBQvGgpeKVKNGRrHoowc5MK8emApk1RlN6H/q5AmIgZL3Psf8v
         ucmQ==
X-Gm-Message-State: AOUpUlGuF0T1fTnVN8Fam5o4X5qZpi51MpXtpKTF37nuTppaiA5dQyPK
        NN286GQnLYPk6Bz+RzMZ3qaB
X-Google-Smtp-Source: AAOMgpcwXqxFZuoxIdmijDGZZKTn0uxTRG7G7jXHRhf1kaisGy932m4ygY+QFu5/fo7wvYaLZRxo5w==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9-v6mr9608949plk.302.1531997884873;
        Thu, 19 Jul 2018 03:58:04 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id l27-v6sm10694526pfi.180.2018.07.19.03.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:58:04 -0700 (PDT)
Date:   Thu, 19 Jul 2018 16:27:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com
Subject: Re: [PATCH v2 2/2] arm64: dts: Add Mediatek X20 Development Board
 support
Message-ID: <20180719105756.GA6106@mani>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
 <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
 <d88504b4-409c-c42b-f816-bedefce2a819@gmail.com>
 <20180717140453.GA19076@mani>
 <a48b0735-ff75-6228-22ba-c8e868240f0c@gmail.com>
 <20180718164304.GA4902@Mani-XPS-13-9360>
 <e60134a3-0bd6-fadb-3ed4-1db28d6543cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60134a3-0bd6-fadb-3ed4-1db28d6543cc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:03:54AM +0200, Matthias Brugger wrote:
> 
> 
> On 18/07/18 18:43, Manivannan Sadhasivam wrote:
> > Hi Matthias,
> > 
> > On Wed, Jul 18, 2018 at 05:07:38PM +0200, Matthias Brugger wrote:
> >>
> >>
> >> On 17/07/18 16:04, Manivannan Sadhasivam wrote:
> >>> Hi Matthias,
> >>>
> >>> On Mon, Jul 16, 2018 at 03:24:44PM +0200, Matthias Brugger wrote:
> >>>> Hi Manivanna,
> >>>>
> >>>> On 05/06/18 18:34, Manivannan Sadhasivam wrote:
> >>>>> Add initial device tree support for Mediatek X20 Development Board
> >>>>> based on MT6797 Deca core SoC. This board is one of the 96Boards
> >>>>> Consumer Edition platform.
> >>>>>
> >>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> >>>>>  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
> >>>>>  2 files changed, 34 insertions(+)
> >>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> >>>>> index ac17f60f998c..5b7fd6ad96e4 100644
> >>>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >>>>> @@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> >>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>>>> new file mode 100644
> >>>>> index 000000000000..2c09ca95d9e2
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>>>> @@ -0,0 +1,33 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +/*
> >>>>> + * Device Tree Source for MediaTek X20 Development Board
> >>>>> + *
> >>>>> + * Copyright (C) 2018, Linaro Ltd.
> >>>>> + *
> >>>>> + */
> >>>>> +
> >>>>> +/dts-v1/;
> >>>>> +
> >>>>> +#include "mt6797.dtsi"
> >>>>> +
> >>>>> +/ {
> >>>>> +	model = "Mediatek X20 Development Board";
> >>>>> +	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
> >>>>> +
> >>>>> +	aliases {
> >>>>> +		serial0 = &uart1;
> >>>>> +	};
> >>>>
> >>>> Sorry for the late answer.
> >>>> Why did you use uart1 instead of uart0?
> >>>> I know that uart0 is used by the bootloader, but because of their exotic flash
> >>>> procedure I find it quite useful to see this messages in my serial connection.
> >>>> Of course you can only use 921600 baudrate then.
> >>>>
> >>>
> >>> The reason is, most of the Mezzanine boards use USB to UART bridge on the
> >>> UART1 port available on the Low Speed Expansion header. Additionally, the
> >>> convention followed by most of the Consumer Edition 96Boards is to use UART1
> >>> as the debug serial port. That's why eventhough the bootloader is using UART0,
> >>> I forced the kernel to use UART1.
> >>>
> >>
> >> Sounds reasonable, I don't have this 96 boards adapter and I forgot about it.
> >>
> > 
> > That's fine :)
> > 
> >>>>> +
> >>>>> +	memory@40000000 {
> >>>>> +		device_type = "memory";
> >>>>> +		reg = <0 0x40000000 0 0x1e605000>;
> >>>>
> >>>> How comes this strange number for the memory size?
> >>>>
> >>>
> >>> Actually, the memory size is extracted from the downstream kernel [1].
> >>>
> >>
> >> Hm, Archermind "Helio X20 Development Board Hardware Manual" talks about 2GB
> >> LPDDR3-SDRAM. Would you mind to check if that is actually true?
> >>
> > 
> > Yes, it is 2GB. Shall I change the size to 0x80000000?
> > 
> 
> Best would be if you boot the machine with this value and see if things look
> sane. Then resubmit. The other option is to resubmit and I'll check it tomorrow :)
> 

Tested with the modified size, 0x80000000. Board is booting without any issues, so
pushed out the v3.

Thanks,
Mani

> Let me know if you can't do it for tomorrow morning. I plan to submit the pull
> requests tomorrow as I'm through nearly all open patches (yes, two days earlier
> \o/ )
> 
> Best regards,
> Matthias
> 
> > Thanks,
> > Mani
> > 
> >>>> BTW do you know the differences between the EVB board and the x20 one?
> >>>> I used the evb dts for booting up to now.
> >>>>
> >>>
> >>> Sorry, I don't know the difference between both boards!
> >>
> >> Sure, no problem :)
> >>
> >> Regards,
> >> Matthias
> >>
> >>>
> >>> Thanks,
> >>> Mani
> >>>
> >>> [1] https://github.com/helio-x20/linux/blob/helio-x20/arch/arm64/boot/dts/amt6797_64_open.dts#L8
> >>>
> >>>> Best regards,
> >>>> Matthias
> >>>>
> >>>>> +	};
> >>>>> +
> >>>>> +	chosen {
> >>>>> +		stdout-path = "serial0:115200n8";
> >>>>> +	};
> >>>>> +};
> >>>>> +
> >>>>> +&uart1 {
> >>>>> +	status = "okay";
> >>>>> +};
> >>>>>
