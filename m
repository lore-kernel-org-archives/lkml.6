Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D87EC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CB020838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544225900;
	bh=hGGvlGhuu0/oq8ahGAL6bIW8O1kCX4hsPgcyzMPA/Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qh2/YkHGTPW2qHad2xDQuNACgDhSQ4+yUHHa+/jJoI7eQVZ9WAvmRIjN97JIhMnmj
	 ocC+iNYubrq/TfIeZrKTFgt3xkn5CYIcrnwlF0iPzMWQOjkGY09q8HfdsLPcc07VQ4
	 YQFsGPRgjKWulffxV2gW9RUoMAuk+eCzw3EnjACQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CB020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeLGXiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:38:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40478 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:38:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so5389038oth.7;
        Fri, 07 Dec 2018 15:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nG8P17RN+8oM/kVAEOd7qMfzukdzmGp422c5HNUsoj4=;
        b=mxoBQbPSyk8oUk0qW83JjaQgWAoROYKRqupfI6ACevQVfwCTb99A+cdwzg6jhOYBs8
         openIihldnmUVCsLEib9kLgkI4zKSLyG9HAQUZKqgKjuRpNr/PtRfZBjLAp0k9gsCdmT
         SlnZUbpaAgenD0IeKngp5ScM5JSiCyM06U8ixL8lmX+bqMY2LXogG+exthL0ceWqf4sV
         Zp37r4K0vOofYp7JP8LHAprkEaaQIws2YVl5RC6DGR6hzsboBdvDRAQrsDIPLOE1dDce
         ZCaBQldeej3Ccf6I4/PWDjt8Atnil0WCQtWJfRR4WBHkMucV6jsoGIS77SUGqwN7rXZq
         Fo4w==
X-Gm-Message-State: AA+aEWZHfbT2LQ7S0YcLRZk11NgSAV/n56Xk12EpgQY5udhx7xqLKUGU
        dRe49XK9yhmVeNmzBD+cMA==
X-Google-Smtp-Source: AFSGD/X20Gfp0hzWG/8UOSQaXxrv+uwjl1YPSrg8QOLl525zqGscdZVPpQvQ6tb0RZ6St6NsYRtLlw==
X-Received: by 2002:a9d:c6a:: with SMTP id 97mr2605973otr.163.1544225897874;
        Fri, 07 Dec 2018 15:38:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s13sm2287255otc.40.2018.12.07.15.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:38:17 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:38:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 04/15] dt-bindings: interrupt-controller: Document
 RDA8810PL intc
Message-ID: <20181207233816.GA13681@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-5-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 19:20:55 +0530, Manivannan Sadhasivam wrote:
> Document interrupt controller in RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../interrupt-controller/rda,8810pl-intc.txt  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
