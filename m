Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E408C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D149120837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544225857;
	bh=QPWxlUqIFKil7uRgi7iwOcxWfYELahr2nEgxqn7nMns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DoFaf4zm0IVytqZmtkb2IY/kgJkUgkEeSHHgw9+Fsg6lwVAEEcqLuvBG5E9CJ29jO
	 rDk5xYqhIDx1q7vSpJPLofgMHlgj6bmDGdYRSvtHrZWPj7YjwVa1m8bkfQskNMSqDe
	 g6Ol1N7XbH75rgq9IE10F1nSU0i8CbSwZrNo7TiM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D149120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLGXhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:37:36 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45961 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:37:36 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so2979232oie.12;
        Fri, 07 Dec 2018 15:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Rrd7MDVTnaV4Z0GM+C9S5z4a3W+VtssK9ylligjK7Ck=;
        b=PNRsFkR3vAjBLN0Ts4tQNM8pPbdtVUWiGwWw1Q3RgC9FPPZvj0JI43ARshFyySSThl
         SIlFNMiZ2r+W9h0XdhgPPnhfXuI9Vcn0CpM+GGd5K2n5HjuGPN/J14b678FHsqfUBhu8
         GAyQKTH8xTwg5eQ3C/lJ9nw2kMA1V4sMS5kOhthkJduRlMBnLGiUri4Cx+wzGBsGW5G9
         Pxk9IX1xE9amIekEABV2jQQYoBVre3LMq8C/eRQgb+z+d4/jz2D5MyL2Rs49jUeiFFx4
         1YVhuUh1PmCzzxjD4JE481xsdc3OyqK0rYbkdgAdyhu81fW3kwRQpBqxjJLIh/D5wu83
         i+zQ==
X-Gm-Message-State: AA+aEWZ7g8FLN/P8URD8fF4DBE1++u6lKz+qiZVxXFuTs+jZ/96hn4aW
        7eYWwA+3cYHUPPXAH/wlLQ==
X-Google-Smtp-Source: AFSGD/VxWSy0obDKSoJESNkwqfc0jgIAk85MGT+AMYk+elUSh1k4SvPZB5iLvA2t7xFW+8mMysEkpg==
X-Received: by 2002:aca:aa81:: with SMTP id t123mr2567075oie.218.1544225854073;
        Fri, 07 Dec 2018 15:37:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t201sm2264800oie.37.2018.12.07.15.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:37:33 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:37:32 -0600
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
Subject: Re: [PATCH v3 02/15] dt-bindings: arm: Document RDA8810PL and
 reference boards
Message-ID: <20181207233732.GA12638@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128135106.9255-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 19:20:53 +0530, Manivannan Sadhasivam wrote:
> From: Andreas Färber <afaerber@suse.de>
> 
> Add bindings for RDA Micro RDA8810PL SoC and below reference boards:
> 
> 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> 
> Cc: overseas.sales@unisoc.com
> Cc: zhao_steven@263.net
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rda.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
