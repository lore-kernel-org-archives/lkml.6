Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C89620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C89620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbeGYVQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:16:39 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35754 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbeGYVQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:16:39 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so7370644iob.2;
        Wed, 25 Jul 2018 13:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1Cp+bH2LbHimams80Agj70VeUhrDXkgDOc9KRuROAw=;
        b=UIWaH4PogUg7+YeoKb7CDMIL71ViEcCUipO0qy2n4lXcF92svaosJNMxtvvOzTw/DL
         I8iheHfS/N7nFu+cUEExWhQhqoN7Wf3vnTfx40feYP82bpUsDBag5xFS91GWzHIMsmae
         I4g5OsZgF0B4pFqf2XK7fiXxD9fc9OBNrIicfHM7POuYkAakU9X4szLELRsRhwlYN5CK
         JUHfqT+bSo7lE3CN6h1mw8CyB184egc299DJHi6NLSeJXfFug5YAo/czCLFxLYK7lxXc
         Trs+nlDMoVQ0sUPbBNWZqe+S5RfPg0uU8BvsR1aFGTgPPFxzTuJFBQcdKVnCZ9OzevYq
         tM1Q==
X-Gm-Message-State: AOUpUlG6zpG8TnfBjUtnvImHZux/DbrSJpce7ssdxFTYRuvsQUD9aEBP
        ES4TI95FBEJVkqbiFihEsQ==
X-Google-Smtp-Source: AAOMgpe3Cii7xyn69Fz5/lOXUu4UbcUFWNsJxNlxBhICzkIfMIPic45gbQtjKL++K/pIFxOFbHei5A==
X-Received: by 2002:a6b:e619:: with SMTP id g25-v6mr17103529ioh.42.1532549006135;
        Wed, 25 Jul 2018 13:03:26 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id x94-v6sm2953767ita.18.2018.07.25.13.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 13:03:25 -0700 (PDT)
Date:   Wed, 25 Jul 2018 14:03:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, balbi@kernel.org,
        v.anuragkumar@gmail.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry
 feature in the controller
Message-ID: <20180725200325.GA21007@rob-hp-laptop>
References: <1532168920-3269-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532168920-3269-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 03:58:40PM +0530, Anurag Kumar Vulisha wrote:
> By default when core sees any transaction error(CRC or overflow)
> it replies with terminating retry ACK (Retry=1 and Nump == 0).
> Enabling this Auto Retry feature in controller, on seeing any
> transaction errors makes the core to send an non-terminating ACK
> transaction packet (that is, ACK TP with Retry=1 and Nump != 0).
> Doing so will give controller a chance to recover from the error
> condition.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |  5 +++++
>  drivers/usb/dwc3/core.c                        | 16 ++++++++++++++++
>  drivers/usb/dwc3/core.h                        |  6 ++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 7f13ebe..2ba2bc2 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -94,6 +94,11 @@ Optional properties:
>  			this and tx-thr-num-pkt-prd to a valid, non-zero value
>  			1-16 (DWC_usb31 programming guide section 1.2.3) to
>  			enable periodic ESS TX threshold.
> + - snps,enable_auto_retry: Set to enable Auto retry Feature to make the

s/_/-/

> +			controller operating in Host mode on seeing transaction
> +			errors(CRC errors or internal overrun scenerios) on IN
> +			transfers to reply to the device with a non-terminating
> +			retry ACK (i.e, an ACK TP with Retry=1 & Nump != 0)

Seems like the property is unnecessary. When would you not want this 
retry behavior? Why not just enable unconditionally in the driver?

Rob
