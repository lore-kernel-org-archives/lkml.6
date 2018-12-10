Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC4EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4712082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480741;
	bh=aHNL/oIXEK5ny6Y+lYroAXDg7BripBWW9RoNHNUlBFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wPlxxJaE5LbqxsK9410JkjPlItyy1/8JDfEE1lG0chWlBmbObRgqTS+n3uVQv7P46
	 25KfDSjKmTKaF53qeTjlznRmkJ7qxmWGfBS6Xx5xFw1E6axY37R5/y0JcFZLmaRm6p
	 daU93np7oAIxohKnaYpkRFCZKRAJPwNkTFgQN0LY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4712082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeLJWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:25:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39592 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbeLJWZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:25:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so12075647otl.6;
        Mon, 10 Dec 2018 14:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dcrwqDt+BOSt60/oApLq93K6QJ2/knMWlj+10Je9AN4=;
        b=qnnb/gJVz8m3gucvkM9YUb3hawiG+Ne5RLqaLS512PYTiV2O0nR5nTRk5HT406C6Su
         kW+bUXp5JyKcJ5B/mnqHGRFvLy9Bpm6GGpl31wTz85hI2lds0Aa1ZD1hCwTB6iYhdouE
         iBUQoe0YN5Ymq5H8HYwZdFSmTLFGy5cGZdqPCyYJvMtIFd+6VOaHBQ6kgSvz/ZWZYNaC
         qYcqjY+MYfo/lQQ1ytDLPiL87nyILOm1x4QUXzUYv7/6O+sLUJb68R+rZvcYeabRysE/
         HWs/XUwmZm8g8onx4RTTXQDn6PUqYgcQCArkuPuxSbs+6eJUaP9R/4yiLmVI8DvaseB/
         p/Nw==
X-Gm-Message-State: AA+aEWaF/dTFeGbcbKpFbYsE/QQVVnpGSgRvatvObNtyFOhoUzOoJAr9
        ykouJ7wNINGUROlf7pesag==
X-Google-Smtp-Source: AFSGD/VcZW49TwEtJwCT6hRinpqvtsSfSSS5F0fFYxQS6TK9meO9IRpllAEhDVY1nMYaE0+tp46edw==
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr10369049otc.358.1544480738297;
        Mon, 10 Dec 2018 14:25:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h24sm8437671otm.72.2018.12.10.14.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:25:37 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:25:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-unisoc@lists.infradead.org,
        afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 12/15] dt-bindings: serial: Document RDA Micro UART
Message-ID: <20181210222537.GA2223@bogus>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-13-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210173550.29643-13-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 23:05:47 +0530, Manivannan Sadhasivam wrote:
> From: Andreas Färber <afaerber@suse.de>
> 
> Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
