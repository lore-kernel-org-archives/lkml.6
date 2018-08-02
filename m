Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D698C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B5E21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B5E21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeHBV3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:29:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39464 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBV3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:29:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so3648643qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=6htxVkzpYwbFRd0K9Ruu7q6MTSiLsU0m6IJbm2GImF0=;
        b=N88uQCBjeIs7KnBeN+Us4JRBxQ2OrRvD6Z+VrYQs7dIVED0hBSnPKcclyHGHw8xXCT
         zeGOOPksI4ehOf6UCSXzfGQ/GGqot+2KdjFPphJ9U/U+EZExeianhoRANebAbeGJfJie
         5dO2F3G92DI5fY6oggo8+7a937HwbJ21mXXubIKbayjVa/ANOvX740zAMCtgnS53hPJp
         XRr4JStDs2F5Sc1EhI92J3WUAXcEISFDJHB1VCow3/wMkHHXs6mKGG/axxv4lFZAelm+
         EAh6c2Ucq9xxUD1E/2DcEbTUhXLlooV2M5VhT/N0rC86nSvqLQTCIUniqgqeZbcq5QM2
         86hw==
X-Gm-Message-State: AOUpUlHw42abiMMsvhn84x6Vh8I9UAXMUUGR9WuBzgJweG7+D2FLr4kV
        suKJERM46BGapf54+chePgKvgg==
X-Google-Smtp-Source: AAOMgpeICJCjnOq+ag0FKVl2w74v80XoDAMenq2A/SpZLK61xd7rwmEhonFROI/EOQ1XiMfDjPC1MA==
X-Received: by 2002:ac8:82e:: with SMTP id u43-v6mr915385qth.88.1533238634690;
        Thu, 02 Aug 2018 12:37:14 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id j86-v6sm3328458qkh.60.2018.08.02.12.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 12:37:14 -0700 (PDT)
Message-ID: <b4c5e0ae5edd09e56077ad0a098ae896571c3731.camel@redhat.com>
Subject: Re: [PATCH v4 2/8] drm/nouveau: Enable polling even if we have
 runtime PM
From:   Lyude Paul <lyude@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     nouveau@lists.freedesktop.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Aug 2018 15:37:12 -0400
In-Reply-To: <20180802191405.GB6180@wunner.de>
References: <20180801211459.7731-1-lyude@redhat.com>
         <20180801211459.7731-3-lyude@redhat.com> <20180802191405.GB6180@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oooh, thanks for pointing that out. I should have grepped for this function
before doing that commit. There also appears to be another duplicate
drm_kms_helper_poll_enable() in nouveau_vga.c which also looks equally
suspecious as being useless. I will fix this up and also remove that other
duplicate call in the next version of this

On Thu, 2018-08-02 at 21:14 +0200, Lukas Wunner wrote:
> On Wed, Aug 01, 2018 at 05:14:52PM -0400, Lyude Paul wrote:
> > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > @@ -592,10 +592,11 @@ nouveau_drm_load(struct drm_device *dev, unsigned
> > long flags)
> >  		pm_runtime_allow(dev->dev);
> >  		pm_runtime_mark_last_busy(dev->dev);
> >  		pm_runtime_put(dev->dev);
> > -	} else {
> > -		/* enable polling for external displays */
> > -		drm_kms_helper_poll_enable(dev);
> >  	}
> > +
> > +	/* enable polling for connectors without hpd */
> > +	drm_kms_helper_poll_enable(dev);
> > +
> 
> I'm wondering why drm_kms_helper_poll_enable() is called here at all.
> Does the invocation in nouveau_display_init() not suffice?  Can there
> be a situation when nouveau_display_init() is not called despite there
> being connectors that need to be polled?
> 
> Thanks,
> 
> Lukas
-- 
Cheers,
	Lyude Paul

