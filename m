Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B29C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C4B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIYq26II"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C4B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJPHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:07:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39235 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJJPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:07:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so2201978pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fa8C2Ai2uDY9/3sx+KDEeqo2UaeLH7btXGGqU2j38o=;
        b=dIYq26IIac5C+uOHKNN68vjdhoOR5prvoKxQbuSaApX8HqshwXCBVDLB83JkXBgfjN
         FhtsEan+NOqDVC5LAV5+A3Gq/p+glhvg7C6JsA65uN7BaD8myLoiDQEtO6PggkriZVdZ
         rgL7YsTZ6lSeec4zufhpB9pOCp/+ma/zTXf9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fa8C2Ai2uDY9/3sx+KDEeqo2UaeLH7btXGGqU2j38o=;
        b=Xg4jIFWmorMX+J8oWMCvEvio08hvY46Wz3TIc+cIfD3lJ1sqIrgY4dUuBlyrm2OYz2
         VW4I9QUk7PkuAhvUDxTukjI0ucrKXCJKsYs8+kZz9Ng7keXImOqw8QrRQyVX7ve7Qr77
         /6ppo1n3JWKWtR2z99DLwT1R8/0Rs8SmqfL03C/DD8aeKg1O9ZgwCzRmcxbcYZD9e70v
         tCgGCsgLkZ+uznmi+HFCF/ZeFxjoqC1D1wqWzgLSvDFDPMw9CJy9xXSisV+Se6tzITDD
         5qBma0ZcpMISE0+qePtwFgMEJ78D+rXA3NNaJNqIJRmP64LMSJDpyqZTDa84qV090AMe
         msfA==
X-Gm-Message-State: ABuFfojkHa0b4anOFTBEGFRzjBvDXNap01jqcJX1RKfkwngJVD/viwiS
        alWwWXDRvS/c5q7RCX9VnXWU
X-Google-Smtp-Source: ACcGV60e4P3MmVewF4f5Z3R1GYHQj+Z84vpGFlFpuubIiFv1na3gXKOWnjkXW9s7fJGD3fdadl4yvw==
X-Received: by 2002:aa7:850d:: with SMTP id v13-v6mr34005638pfn.83.1539157610498;
        Wed, 10 Oct 2018 00:46:50 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 72-v6sm45219798pfr.115.2018.10.10.00.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 00:46:49 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:16:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michal Simek <michal.simek@xilinx.com>, robh+dt@kernel.org
Cc:     heiko@sntech.de, ezequiel@collabora.com, xuwei5@hisilicon.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org
Subject: Re: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
Message-ID: <20181010074641.GB11462@mani>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
 <20181010073546.GA11462@mani>
 <b35d87b8-b9f0-ead1-2755-0562fa1d7f3e@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35d87b8-b9f0-ead1-2755-0562fa1d7f3e@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:40:22AM +0200, Michal Simek wrote:
> On 10.10.2018 09:35, Manivannan Sadhasivam wrote:
> > Hi Michal,
> > 
> > On Wed, Oct 10, 2018 at 09:25:24AM +0200, Michal Simek wrote:
> >> On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
> >>> For all 96Boards, the following standard is used for onboard LEDs.
> >>>
> >>> device-name:green:user1  default-trigger: heartbeat
> >>> device-name:green:user2  default-trigger: mmc0/disk-activity
> >>>                                           (onboard-storage)
> >>> device-name:green:user3  default-trigger: mmc1 (SD-card)
> >>> device-name:green:user4  default-trigger: none, panic-indicator
> >>> device-name:yellow:wlan  default-trigger: phy0tx
> >>> device-name:blue:bt      default-trigger: hci0-power
> >>>
> >>> So lets adopt the same for Ultra96, which is one of the 96Boards
> >>> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
> >>> consolidate only User LEDs.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> ---
> >>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
> >>>  1 file changed, 8 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >>> index eb5e8bddb610..565ceb390f99 100644
> >>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >>> @@ -57,29 +57,30 @@
> >>>  	leds {
> >>>  		compatible = "gpio-leds";
> >>>  		ds2 {
> >>> -			label = "ds2";
> >>> +			label = "zynqmp-zcu100-revC:green:user1";
> >>
> >> The purpose of this series should be standardize Led labels that's why I
> >> would expect that leds will be called in the same way on all these
> >> boards that's why I am not getting why there is board name.
> >>
> >> green:user1 or just user1 should be enough.
> >>
> > 
> > Hmm. That's a good point. My proposal to standardize the labels is inspired from
> > Dragonboard410c dts [1]. They had the device name in label and I decided to
> > go with that. But as you said, the board name is not needed and just 
> > `color:led-name` should be fine.
> > 
> > Will modify this in next interation.
> 
> The second part of this is that all current DTSes are using some names
> and by changing it you will break compatibility which is something what
> you should avoid.
> That's why it is really a question if this change should be accepted.
>

You mean userspace compatibility? If yes, then the affected boards are using
MRAA library for providing the userspace access and I will ensure that it will
get updated to the new labels.

But for other userspace scripts which users might be depending on, it will
break for sure. So, I would like to get some feedback here from Rob.

Thanks,
Mani
 
> Thanks,
> Michal
> 
