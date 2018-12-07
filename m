Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA940C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7CD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226517;
	bh=tIbm6l2vuoHEX+xmyRVx3v2aWsPTv6/QN02Es5xen4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jad6AJ7elAeIMnEL1fon78Oq7blh2KoSetCSMI9t9UzFs2Sn1/6wde7BrxI5+3Nc6
	 ycmPoK1avHjnTPbsNJcUPuaIxgKHQjAeIdkegYaAlpzjt+ggtL4QNex+8VZcMdGHhU
	 pRPH4WXV57LzZ+JzokjtU5RALKDgdjbJzfCP1WbE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7CD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLGXsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:48:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33483 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:48:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so5447994otl.0;
        Fri, 07 Dec 2018 15:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fzCzl/65tvmZFauhKWp5zjohQjwhB4mb0SUi5YOpnUc=;
        b=RCqzTMKC/QGTHdJ4kN1A5eCZKGeCSvkNwTupDYYTVj0KxLGLos6T9pQ1JRnQR7yRUo
         9NTK8Nbvn7zF+dKT6pY9te1DwMfSrel1TyRaqH3CeHCuKrhqSBRxhAyGrMUKtXsIP9hs
         ZBMC+CmdmZnB/o9+ukx4GotBFIfhv6icr4u86+aT130P54OJ2GgltBwFNJkCyknhvy3+
         xSJclM2WzPqStj4ef/vjwjk6Ha5D+OgFBIM4bv1F/w/EvpeJkY7g08H2VoiqiGSPf4Lk
         HgUdSa1jvJR9D1ERjeww1LGgBWSoPQHETNzfQR0Ep9hJqxTRxSCsUAcOw1RUKlBUbjtA
         lqFg==
X-Gm-Message-State: AA+aEWaTG0Awikq79/0tN4xVz0g1LhaBBjeWulfa10HlgqIAJ+uP7fz/
        2nj4Gx4h8sMCOua0ooDtIQ==
X-Google-Smtp-Source: AFSGD/WnLfEg74sCwk9cOMH1HAZMam8b6HBe/9N2On/XXa19A+N0aUu4fd6iOdOgRhfYoZSKn4MrIA==
X-Received: by 2002:a9d:172e:: with SMTP id i46mr2700886ota.322.1544226515252;
        Fri, 07 Dec 2018 15:48:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v3sm7302040oib.57.2018.12.07.15.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:48:34 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:48:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 1/5] dt-bindings: soc: Add a new binding for the
 BCM2835 PM node.
Message-ID: <20181207234833.GA27917@bogus>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130202743.20585-2-eric@anholt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 12:27:39 -0800, Eric Anholt wrote:
> This binding supersedes the bcm2835-pm-wdt binding which only covered
> enough to provide a watchdog, but the HW block is actually mostly
> about power domains.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
