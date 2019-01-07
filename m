Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AA420859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ir9A+6Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfAGKex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:34:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43450 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfAGKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:34:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so357101eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S2fBYt14dlcC/w0IiypPxnKOOmJhifE8u0CPGymSKM4=;
        b=Ir9A+6UpoEqiE2uUA2qNIpi6Vdj8nmKYsaw5vJk+SAVZqMERL5GjFZ9sRWAkBSrk6E
         26g2nC3ZWiqgXAmaX9Lu6GkS7QFAzdZw7QdcSSh4QQkpWEGmec7X9poAx+66FpNxFE6a
         No4uvoDK5mGedqLHseclpHUbbH8rjhcWi1yKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=S2fBYt14dlcC/w0IiypPxnKOOmJhifE8u0CPGymSKM4=;
        b=ejZP9hndSAB+F3q1kLbpoyZA1K0SOvL7H6d0SkbJBSnnnXRLBw94d6Xza8+kn+LWBw
         6cS2XRWKhDCzBRYJKBPp1JTEVFilhNRIyEXaJSPR6z3tykfCpCJgY/90Pe19BbyBEjN4
         KCHZ9az6/SCZ9LsNbkhwGkyAl9m4mbJd1CXBXcfLKVbqNECttc4ynnSHr3MM1BjUlG/6
         OZbrBwZRfjGniFfkRE7ax+6qIpyIOLeEejiUe6dXpMMSfRGSoSxlQLyqh7hUmf0PqgY4
         e2mvlwECwiOXTrC2mMpSkWbAzsPuq2O5Jtr0DZ1V/uu6Kon7R7o793oC8/Vi2H/6uqoY
         OoVA==
X-Gm-Message-State: AA+aEWZCPjx7vZJOSmJezLyPInNKXdNIxN+6BJM6xD285gRGxiddfS0g
        HvPEhSfCHvSztLEZ/JD+126H7w==
X-Google-Smtp-Source: AFSGD/XWoATU7EC2SxhgFJVbEGibLaf0oYxgD/cPaCNLNdB3YJHLBui1ZV9Y1RUDpnTeJYZvY9LSwA==
X-Received: by 2002:a50:8bb5:: with SMTP id m50mr54022329edm.211.1546857291543;
        Mon, 07 Jan 2019 02:34:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c53sm36306819ede.26.2019.01.07.02.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 02:34:50 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:34:48 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/11] vga-switcheroo: make PCI dependency explicit
Message-ID: <20190107103448.GG21184@phenom.ffwll.local>
Mail-Followup-To: Sinan Kaya <okaya@kernel.org>, linux-next@vger.kernel.org,
        linux-acpi@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-4-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230195612.6657-4-okaya@kernel.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 07:56:04PM +0000, Sinan Kaya wrote:
> This driver depends on the PCI infrastructure but the dependency has not
> been explicitly called out.
> 
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'm assuming this goes in through the acpi tree, correct?
-Daniel

> ---
>  drivers/gpu/vga/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
> index b677e5d524e6..d5f1d8e1c6f8 100644
> --- a/drivers/gpu/vga/Kconfig
> +++ b/drivers/gpu/vga/Kconfig
> @@ -21,6 +21,7 @@ config VGA_SWITCHEROO
>  	bool "Laptop Hybrid Graphics - GPU switching support"
>  	depends on X86
>  	depends on ACPI
> +	depends on PCI
>  	select VGA_ARB
>  	help
>  	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
> -- 
> 2.19.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
