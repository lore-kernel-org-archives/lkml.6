Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0AFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF12C21776
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU5crpuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF12C21776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeHHUnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:43:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46105 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeHHUnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:43:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so1451639pgv.13;
        Wed, 08 Aug 2018 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwR6MJmwNMkoixqsD/kVnbrU1GniYmPyakTAnDvfAVs=;
        b=DU5crpuUQhWrH2veC0AyzODYyCB55Gg05292koPJ4Rdj5bjx6T6vjhAGDeLmJV1Ecu
         tYqWm7aoLu7blE1IO5rxfrO3xkr/cKT8WowQC+bcWtrkNjZCyB0sklVP66SB8KwpIPR9
         oF3GsLx7CJuiKoJplOaic9OopnjcrAqb1fnRYYp/n8OJ9gm99xWnqYGRp6L3022QOxOa
         epbtVgsQj7uak8UwOp5xh3Pj/SEK5PCHLLZSqW/Dv7AIhpmXMKlNILTWitWYEHGHWCIw
         qfbhYeea7BER9bb5eGkcIj+7aUY9EQckWUlrFsfrJWY8Vukb+ZzJx0ahEcwh+kswyiBr
         i6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwR6MJmwNMkoixqsD/kVnbrU1GniYmPyakTAnDvfAVs=;
        b=D6NX4PRGH8qrWCBLsvazASVjrRm1nsGFp4fDmD0/dBUT7loXInRknfRFkAFHbQG7Fw
         38B78q4GsABSukYO38HS08lDYGargIGL527YGPOslncWJy9X8oej8HfSWTg4Q792p3ZC
         bDl9+KvgqHWlve30ADbGxqTieLYDb7oAZP2d5s6ncC5mMZSNx5zTbcJL64+6UO/ffS/Q
         QRrsh2q9U4NZoK0lL9uGV9ZT+R8Z6SXRWD6yR097PYtZEG/ALGKAN2XgHEG+w/sRkN4P
         9n+rs4D76oa2tEnUY3PwJVUfHrKk4et/oN9y1y7k3AiVKnqCZBC3eU8Uot2SqB8Br4M4
         /Fug==
X-Gm-Message-State: AOUpUlGdImgo5cOBWX2iy3UpIpAwdpe7j21/VZ+P8dl5Dpd8gglhS/ix
        p+Hke/60kdpEvblMzc7Ogx8=
X-Google-Smtp-Source: AA+uWPy4wrHrY7Pt6mpmYFim5BKY4GrsUkFrk464kziWmM/vSvZJTtK8d4aRLBOY6xifSkj87S5/Tw==
X-Received: by 2002:a62:49cf:: with SMTP id r76-v6mr3993314pfi.235.1533752537555;
        Wed, 08 Aug 2018 11:22:17 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i192-v6sm6229795pfe.188.2018.08.08.11.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 11:22:16 -0700 (PDT)
Date:   Wed, 8 Aug 2018 11:22:14 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [RESEND PATCH v2] MAINTAINERS: add PhoenixRC Flight Controller
 Adapter
Message-ID: <20180808182214.GB28444@dtor-ws>
References: <20180622170605.8411-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622170605.8411-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 07:06:05PM +0200, Marcus Folkesson wrote:
> Add MAINTAINERS entry for PhoenixRC Flight Controller Adapter
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
> 
> Notes:
>     v2:
>     	Add proper mailing list
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ce5062dc028..d8b5d9f810e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11103,6 +11103,13 @@ S:	Maintained
>  F:	include/linux/personality.h
>  F:	include/uapi/linux/personality.h
>  
> +PHOENIX RC FLIGHT CONTROLLER ADAPTER
> +M:	Marcus Folkesson <marcus.folkesson@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/input/devices/pxrc.rst
> +F:	drivers/input/joystick/pxrc.c
> +
>  PHONET PROTOCOL
>  M:	Remi Denis-Courmont <courmisch@gmail.com>
>  S:	Supported
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
