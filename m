Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E96C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CF920C0B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvwITouF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CF920C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeGCRNd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:13:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43355 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933960AbeGCRN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:13:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id v13-v6so1262130pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V+Hu1q0PLFbR/vIYabfV+u580j8aAvB27Y6v/AzHNHU=;
        b=lvwITouFaNX0cgjEVO/Sq4L56HZr1FkXtgZYSRaWrxpHL1t7tY8ms5sBuWIMx8TNqf
         3ubcO11G2DBwS6n+alwAA7ZSobf5UTmlmSCHsVAyRZKnO3LMITSRuTFaWe6aAnCVmMop
         v72vvN+j1zs/yA5j4Xk7cxitijHLcByucVG6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+Hu1q0PLFbR/vIYabfV+u580j8aAvB27Y6v/AzHNHU=;
        b=B9T+AkZuLpdp0D4eR9lj6vzgdRLOxX/fC5Z4oI7hOlUWQUsOb063SjL/KNN6ZjNfQp
         AqdzbJ+BPDxDG3ixUet3XsphhXy8jDNqXu8sqnpnsV/MZZEwIOoL/E3bq88UNTH2HrgE
         kjvBD3yGwKB7JGsbfs+iSawnbC4xisxZtnbVXxZ+gtagOP5uPa+Vf8qgTsydioISHmMA
         2xU6u3Q1a0O8vEWLDoL4eVeIDhKNpEiyZJHYAdvHBbR4adZuLdX7fcBi/iUPy6lC6Vza
         Ounh4nh9wPsjL7Ud8maGLGvY12ZlgH6zli4ljCP6gM1pQ3thVeNDRAZdJ5vzX9/Xn9HR
         JDiQ==
X-Gm-Message-State: APt69E3hBzYz4kpJWyhJ4LTBLInJkcEPX+be/vpPl5tNXolP4vME6Jbf
        srcx7FmXQ/C/bdDf36adHydPYQ==
X-Google-Smtp-Source: ADUXVKJY86ndCuOZofPisED2lbouqmD2NgyjLqQcXwSdQ/EQJS9DnuTDPG0LhLMGhJqcTvPVtrAIIA==
X-Received: by 2002:a65:4a92:: with SMTP id b18-v6mr25960927pgu.107.1530638006631;
        Tue, 03 Jul 2018 10:13:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id r4-v6sm5771799pfj.53.2018.07.03.10.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 10:13:25 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:13:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, groeck@chromium.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        snanda@chromium.org, lenb@kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [RESEND PATCH v3 2/2] thermal: core: introduce thermal zone
 device mode control
Message-ID: <20180703171325.GC129942@google.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com>
 <20180226144118.24693-2-enric.balletbo@collabora.com>
 <20180629003302.GT129942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180629003302.GT129942@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:33:02PM -0700, Matthias Kaehlcke wrote:
> Hi,
> 
> I stumbled across this patch since I'm currently poking around with
> early thermal bringup on a platform and this patch has been integrated
> in our development tree.
> 
> I'm seeing some unexpected behaviors, which could entirely due to
> wrong expectation from my side. I only have some basic working
> knowledge of the thermal framework, just want to double check and
> perhaps learn a thing or two.
> 
> On Mon, Feb 26, 2018 at 03:41:18PM +0100, Enric Balletbo i Serra wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > Thermal "mode" sysfs attribute is introduced to enable/disable a thermal
> > zone, and .get_mode()/.set_mode() callback is introduced for platform
> > thermal driver to enable/disable the hardware thermal control logic. And
> > thermal core takes no action upon thermal zone enable/disable.
> > 
> > Actually, this is not quite right because thermal core still pokes those
> > disabled thermal zones occasionally, e.g. upon system resume.
> > 
> > To fix this, a new flag 'mode' is introduced in struct thermal_zone_device
> > to represent the thermal zone mode, and several decisions have been made
> > based on this flag, including
> > 1. check the thermal zone mode right after it's registered.
> > 2. skip updating thermal zone if the zone is disabled
> > 3. stop the polling timer when the thermal zone is disabled
> > 
> > Note: basically, this patch doesn't affect the existing always-enabled
> > thermal zones much, with just one exception -
> > thermal zone .get_mode() must be well prepared to reflect the real thermal
> > zone status upon the thermal zone registration.
> 
> From my perspective this looks like a pretty significant change. For
> the platform I'm working on I added a thermal zone to the device tree,
> with the expectation that it would be enabled. Judging from the code
> without this patch this expectation seems to be naive, since
> of-thermal.c sets tz->mode to THERMAL_DEVICE_DISABLED, so apparently
> either userspace or some driver should call _set_mode(tz,
> THERMAL_DEVICE_ENABLED). However even without this the thermal zone
> appears to be active (I didn't really test end-to-end yet, but at
> least thermal_zone_device_update() is called and calls
> handle_thermal_trip()). Not sure why this is the case with
> THERMAL_DEVICE_DISABLED, but before I learned about the existence of
> the flag my expectation was that the zone would be enabled.
> 
> With this patch thermal_zone_device_update() is skipped if the zone
> hasn't been explictly enabled, which may be consistent with the state
> of 'tz->mode', but effectively changes the previous/current behavior.
> 
> Not sure if I'm just dumbly overlooking something obvious or if there
> is an actual problem with of_thermal (and maybe others).

The problem is that there are now two 'mode' fields, tzd->mode and the
other typically tzd->devdata->mode, and tzd->mode is never set to enabled.

> thermal zone .get_mode() must be well prepared to reflect the real thermal
> zone status upon the thermal zone registration.

For of_thermal tzd->mode is initialized with the result of .get_mode()
when the zone is registered. At this time no sensor has been added
to the zone, hence the zone is disabled. When a sensor is added later
tzd->devdata->mode is set to enabled, however tzd->mode remains disabled:

tzd->mode = DISABLED
tzd->devdata->mode = DISABLED

of_parse_thermal_zones
  thermal_zone_device_register
    tzd->mode = tzd->get_mode() // => DISABLED

<sensor>_probe
  thermal_zone_of_sensor_register
    tzd->set_mode(THERMAL_DEVICE_ENABLED)
      tzd->devdata->mode = ENABLED

One way to fix this for of_thermal could be to setting tzd->mode in
.set_mode() in addition to setting tzd->devdata->mode. However this
feels like a workaround/hack. Personally I find it confusing to have
two mode fields for a thermal zone device. Maybe tzd->mode should
replace tzd->devdata->mode?
