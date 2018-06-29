Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B47B27AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SNecGq5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B47B27AB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755106AbeF2AdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:33:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40608 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754565AbeF2AdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:33:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so3561619plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0asJfYbvMSmLeM21HjOzgKdVvDVzGK+rVRaNWLI3+Vk=;
        b=SNecGq5h1kZJEu8zg7MNXQzH7Fz5vjnXxn95uSGA98p5lKeoCfagiDeZlbx+YswWYp
         0OyxJ+nkxRtXDRj+aPAYThxS8aamdKrB6qOarDYPYo32Z83Ig5Fv19YldIQccJ/KwanY
         9tJrY0+FUPSxEPw+HIIJdLEc5W2V4KVLRTwdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0asJfYbvMSmLeM21HjOzgKdVvDVzGK+rVRaNWLI3+Vk=;
        b=kfj3fCMAv9zIPc2VrO6kZmPoRdSXuE333i68STCYc+qg1A87vA10Zf2KD5+qdhfnqq
         GASZE+dJXBSY4wVJknS9F+a603yEOgRCp6Knw8TkVctTc05W+Gx5Gd7q1ESrq+81l3ST
         vQ/eMD5a3inQSaI2AoKJ0ItCWLo8pcmousyqJg1RfI/naOnOIGs/SosUKbcCqCqUyFaL
         jwdoGmR9Y58ib2b11LvRjhF2pjfuLH0m8Juyd/st6dQh0pdM6/UWBLQpwP6Gpq1oxSW+
         Se3U4bkP3GX8jBwBO8PMAtSpn+RDgU7uXBHC8PHRRy2fdyaIa8wibMaXYOBY5pGdh+B3
         31EA==
X-Gm-Message-State: APt69E1CUCnXzM8kwHd9KeiZBxvlTMOuyy1549cBTeZuDEr4etGOdLz4
        okSRSEGnLHwZu80cpVDYNxdqIg==
X-Google-Smtp-Source: ADUXVKKbSXYj7FAss5Fg/G3jqoEdwI8aWhc2YnaIF6G+5140hT62HMRXxuVdenZGIoFl1EUjSAqF4Q==
X-Received: by 2002:a17:902:bb8a:: with SMTP id m10-v6mr12498707pls.236.1530232383802;
        Thu, 28 Jun 2018 17:33:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id g2-v6sm5537332pgr.6.2018.06.28.17.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:33:03 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:33:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, groeck@chromium.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        snanda@chromium.org, lenb@kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [RESEND PATCH v3 2/2] thermal: core: introduce thermal zone
 device mode control
Message-ID: <20180629003302.GT129942@google.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com>
 <20180226144118.24693-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180226144118.24693-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I stumbled across this patch since I'm currently poking around with
early thermal bringup on a platform and this patch has been integrated
in our development tree.

I'm seeing some unexpected behaviors, which could entirely due to
wrong expectation from my side. I only have some basic working
knowledge of the thermal framework, just want to double check and
perhaps learn a thing or two.

On Mon, Feb 26, 2018 at 03:41:18PM +0100, Enric Balletbo i Serra wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Thermal "mode" sysfs attribute is introduced to enable/disable a thermal
> zone, and .get_mode()/.set_mode() callback is introduced for platform
> thermal driver to enable/disable the hardware thermal control logic. And
> thermal core takes no action upon thermal zone enable/disable.
> 
> Actually, this is not quite right because thermal core still pokes those
> disabled thermal zones occasionally, e.g. upon system resume.
> 
> To fix this, a new flag 'mode' is introduced in struct thermal_zone_device
> to represent the thermal zone mode, and several decisions have been made
> based on this flag, including
> 1. check the thermal zone mode right after it's registered.
> 2. skip updating thermal zone if the zone is disabled
> 3. stop the polling timer when the thermal zone is disabled
> 
> Note: basically, this patch doesn't affect the existing always-enabled
> thermal zones much, with just one exception -
> thermal zone .get_mode() must be well prepared to reflect the real thermal
> zone status upon the thermal zone registration.

From my perspective this looks like a pretty significant change. For
the platform I'm working on I added a thermal zone to the device tree,
with the expectation that it would be enabled. Judging from the code
without this patch this expectation seems to be naive, since
of-thermal.c sets tz->mode to THERMAL_DEVICE_DISABLED, so apparently
either userspace or some driver should call _set_mode(tz,
THERMAL_DEVICE_ENABLED). However even without this the thermal zone
appears to be active (I didn't really test end-to-end yet, but at
least thermal_zone_device_update() is called and calls
handle_thermal_trip()). Not sure why this is the case with
THERMAL_DEVICE_DISABLED, but before I learned about the existence of
the flag my expectation was that the zone would be enabled.

With this patch thermal_zone_device_update() is skipped if the zone
hasn't been explictly enabled, which may be consistent with the state
of 'tz->mode', but effectively changes the previous/current behavior.

Not sure if I'm just dumbly overlooking something obvious or if there
is an actual problem with of_thermal (and maybe others).

Any insights?

Thanks

Matthias
