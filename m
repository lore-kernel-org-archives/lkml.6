Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D57C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0501220989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RWSPXcaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0501220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeKUUFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:05:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38174 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeKUUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:05:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so4309420ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zk5t2WdxiLCWopvqPOonjAwL59r3331+hDT7DigNnL0=;
        b=RWSPXcaKREf1zWaRDnNDxHaPvvxZAhU4BPOzmQKV/NMlp249iGM4zebCc3968sAe6A
         BFwhB4JeGyZys/4B+mKy8fZ43DUOJ+HecMisbh1jgMs09JnzL84cHXhlkS0FIuBm+4tS
         ErSzLn2M1WG0AqNEPGVCJyi4cKkdvDigtELig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Zk5t2WdxiLCWopvqPOonjAwL59r3331+hDT7DigNnL0=;
        b=O/isBgQ70RFCtEpTNi6XxpudJR9iM7WH/cAU9bTmp6wyIW7V2ahZRUBQj4Rx5315LJ
         eu+pcJ2iwjWpi+O8gmp/+F2JesSXg4HkyYuMgQMvO6RoUg3H5SbRL8N18YtRuMB3721e
         9Idxp9AEA5/ZxiRdsnPIvW8OTBETsbeQ3GRLnvJhBwCqj5/AzonVZgUyhcOl49OVt0GI
         oTJDInRnBhvDDFoKRnHh4EIORudEi71LzoZ0iiR0mkIrbziD0/JqsB5+NJqEFlApfBnu
         7ktjyC0E21Pq6DQR3G1mDQEHbSFN6BRgM1KsZnRNM5kfiacUKS409y8TYNOIEnpN5/6z
         FRFQ==
X-Gm-Message-State: AA+aEWbmh4K+e6H02PmFgAsViXm15p6LoUWiMk0wkTqcwVf7aaKKifWi
        bWBk+czR9k3Y9qAR9baOcGwupQ==
X-Google-Smtp-Source: AFSGD/WPmPGzsbpQCZUvwdE3UUQKGH48maTjCcDNs6Hm7lUElbb0N2NtQt6mAyeOlaeBkoklOm+v9A==
X-Received: by 2002:a50:ab82:: with SMTP id u2mr5112908edc.111.1542792688992;
        Wed, 21 Nov 2018 01:31:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n34-v6sm13471963edc.34.2018.11.21.01.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 01:31:28 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:31:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Cooper Chiou <cooper.chiou@intel.com>, Lee@phenom.ffwll.local,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.9 08/17] drm/edid: Add 6 bpc quirk for BOE
 panel.
Message-ID: <20181121093126.GJ4266@phenom.ffwll.local>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Cooper Chiou <cooper.chiou@intel.com>, Lee@phenom.ffwll.local,
        dri-devel@lists.freedesktop.org
References: <20181113055223.79060-1-sashal@kernel.org>
 <20181113055223.79060-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113055223.79060-8-sashal@kernel.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:52:14AM -0500, Sasha Levin wrote:
> From: "Lee, Shawn C" <shawn.c.lee@intel.com>
> 
> [ Upstream commit 922dceff8dc1fb4dafc9af78139ba65671408103 ]
> 
> BOE panel (ID: 0x0771) that reports "DFP 1.x compliant TMDS".
> But it's 6bpc panel only instead of 8 bpc.
> 
> Add panel ID to edid quirk list and set 6 bpc as default to
> work around this issue.
> 
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Cooper Chiou <cooper.chiou@intel.com>
> Signed-off-by: Lee, Shawn C <shawn.c.lee@intel.com>>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Link: https://patchwork.freedesktop.org/patch/msgid/1540792173-7288-1-git-send-email-shawn.c.lee@intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Given that I'm not a fan of AUTOSEL at all: This one here is correctly
cherry-picked for stable, ack.
-Daniel

> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 83d2f43b5a2f..c93dcfedc219 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -116,6 +116,9 @@ static const struct edid_quirk {
>  	/* SDC panel of Lenovo B50-80 reports 8 bpc, but is a 6 bpc panel */
>  	{ "SDC", 0x3652, EDID_QUIRK_FORCE_6BPC },
>  
> +	/* BOE model 0x0771 reports 8 bpc, but is a 6 bpc panel */
> +	{ "BOE", 0x0771, EDID_QUIRK_FORCE_6BPC },
> +
>  	/* Belinea 10 15 55 */
>  	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
>  	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
