Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6786C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BB72133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244107;
	bh=5+7cmEEExecfkj0lkr5Xv2DeYVDav1jNOM2lHT8a4GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iBsqUa4UDj+huaCIGWrSOg/O5U4ZZcDHwlkEdcTlhtn3UGwnkN6+Zw/LkjmEjLlkR
	 CZGMYFLwaddHH6NfQykzGX6I4dqjw4WW5oqa/peiZ0ka4T1NXswNi1tC4Q77UW/hhU
	 lLituX6fiq04gixhZTjIuyif8xyxkU0nXGqEjWV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfAKWBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:01:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44343 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:01:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so13429685oig.11;
        Fri, 11 Jan 2019 14:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0tStMa96wWRBx/17NVFv5fNcGi6PQn9ez/Jg7jJbYYY=;
        b=qk0VefjSXUQeFBSfiS+0BwgDU5SvCbfNCQIsi0lqonKzetmMUpig5G21NRxninG0a2
         cqt4Py3k4LANQ2KzK8/px02E+J9LlsvOtpCcqc8aWUFJfR/2s5Se9t/Yt1bFrPgamgbZ
         ZK9PCuGuxiN5hykdSoTXR4i34I4kCeZ4gOFzvQHNngMec8lyI2m4kZVcASOpCX+F+dW4
         TJr41PnCEZTuaBAvGvTMcOY4E4OuFUek8fnlAH+kh/6QcBboZMpsD3IKxuJmp7Ug0B/S
         uIoZAM/2oKZdbXOs0JsrEmGvDhydGGzYxVnCPX9kKCxt23s70+BSV2xPE1trPiCC2cOQ
         VPww==
X-Gm-Message-State: AJcUukeMxxvnPTPJ7nUfB5KpCst007ExeSqeVlqmZXsAK3+uWv+k70o4
        8edko+WI2Tm1nnLADZy2qA==
X-Google-Smtp-Source: ALg8bN63za8BAGWhUqzOFOZZ1QY+ffJb1ewVbVuep621A7M3Sr9g6Jym+AFehu9hvqD5aCFKyg6sog==
X-Received: by 2002:aca:408b:: with SMTP id n133mr10616927oia.44.1547244105188;
        Fri, 11 Jan 2019 14:01:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s186sm37393055oif.0.2019.01.11.14.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:01:44 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:01:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pragnesh_Patel@mentor.com
Cc:     heiko@sntech.de, Akash Gajjar <Akash_Gajjar@mentor.com>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, Levin Du <djw@t-chip.com.cn>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liang Chen <cl@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Message-ID: <20190111220143.GA9773@bogus>
References: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2019 10:10:10 +0530, <Pragnesh_Patel@mentor.com> wrote:
> From: Akash Gajjar <Akash_Gajjar@mentor.com>
> 
> ROCK Pi 4 is RK3399 based SBC from radxa.com. board has a 1G/2G/4G lpddr4, CSI,
> DSI, HDMI, OTG, USB 2.0, USB 3.0, 10/100/1000 RGMII Ethernet Phy, es8316 codec,
> POE, WIFI (for Model B only), PCIE M.2 support on board.
> 
> This patch enables
> - HDMI Display
> - Console
> - MMC, EMMC
> - USB 2.0, USB-3.0
> - Ethernet
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> Signed-off-by: Pragnesh Patel <Pragnesh_Patel@mentor.com>
> ---
> changes in v2
> - hdmi regulator name correction
> - replace gpio pin number with appropriate macro
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-rock-pi-4.dts    | 606 ++++++++++++++++++
>  3 files changed, 612 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
