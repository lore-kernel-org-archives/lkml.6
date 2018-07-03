Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F13FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE99B2478A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQvtYUuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE99B2478A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeGCJDo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:03:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45248 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeGCJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:03:40 -0400
Received: by mail-wr0-f193.google.com with SMTP id u7-v6so1111171wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vy10XTgWi9bbXVb6g0YNKOtgUx3JRAsrOqnWFZZ8tcs=;
        b=iQvtYUuFrXVTUeIuoIGzi6emAaYE7m7FgrDee6KjsQComsZ1+rcUc7PTU+RMlzBJVP
         De2ZGQW2p5467UnmifPcxmw6nseS5VAvIXbTdzAyi7b3PUREDrAoOnWgPT15+18PV1tT
         wQG8dZASBsLfQo4mi73xSi/hq/MBWOEKI1l5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vy10XTgWi9bbXVb6g0YNKOtgUx3JRAsrOqnWFZZ8tcs=;
        b=r7u3k6NwOR3Yyj/Ph4kfnap7mr+qffQuotG7kTLy1h08YSslsyXXzPUoi8IoC8Xixs
         yAzXtR34mV9J8Z47dQzVwzJV0ereMX9RonCov1cLXm/APwLeq1WApqHR5U5U15Uv0v/9
         qorXNqgWUQ7KS2U8bFIrQmBAhroFTl1lLt9Q3JxZStpOQ+a6otG4X+t5CMD+6e2T8zRH
         BZlYFJLPbsenDU3gwfsBt7PT4X3NyFG1ja3phbL6/0REK3CQ1De4pcX3m57dkowgzZIE
         uCQUfcMlvlqdkkaEvJWo+p60irB8kM8/o0qSiE6xhTkGKyK4nbuwsDWnYWAxN6VEkcWG
         JAiQ==
X-Gm-Message-State: APt69E0lRN8i8d3h3uBCfDqbI4RY5I8rzdo4tQmtCuw08Wh/VBy1kjq+
        yJruHpZElU5a50oNki68h1cq+Q==
X-Google-Smtp-Source: AAOMgpeXOBMVRB7zHyyta1rkyIeiGnJvlwt3dneWRSKYsH2GGxuIJoXZL0ixSmRpA+Ow/SZnISMLcQ==
X-Received: by 2002:adf:c383:: with SMTP id p3-v6mr17561977wrf.68.1530608618843;
        Tue, 03 Jul 2018 02:03:38 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id s41-v6sm1764871wrc.5.2018.07.03.02.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:03:30 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:03:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH v2 2/2] cros_ec: Move cros_ec_dev module to drivers/mfd
Message-ID: <20180703090329.GL20176@dell>
References: <1511194526-3729-1-git-send-email-thierry.escande@collabora.com>
 <1511194526-3729-3-git-send-email-thierry.escande@collabora.com>
 <CAKdAkRRtv41c-s7vunaBde9Oj8L5b5YdfHcOFEueGYenHV=byg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKdAkRRtv41c-s7vunaBde9Oj8L5b5YdfHcOFEueGYenHV=byg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Dmitry Torokhov wrote:
> On Mon, Nov 20, 2017 at 8:18 AM Thierry Escande
> <thierry.escande@collabora.com> wrote:
> >
> > The cros_ec_dev module is responsible for registering the MFD devices
> > attached to the ChromeOS EC. This patch moves this module to drivers/mfd
> > so calls to mfd_add_devices() are not done from outside the MFD subtree
> > anymore.
> 
> I am quite a bit late to the party, but what's the rationale for not
> using mfd_add_devices() from outside of MFD tree? We do allow
> registering i2c clients from outside of i2c core, and spi from outside
> of spi core, etc, etc.

The rationale for not using the MFD API outside of drivers/mfd is the
avoidance of (mild) chaos, since the aforementioned API lends itself to
abuse if not diligently monitored - preferably by someone who knows
about MFDs.  Contributors regularly attempt to (ab)use the MFD API to
hack around various problems relating to the registration of devices.
Most of which receive a "this is not an MFD" review comment and sent
on their way!

MFD is not like anything else in the kernel, so comparing it bus types
such as SPI and I2C does not carry much weight.  The MFD Subsystem's
job is simple; slice multi-function ICs into separate functional areas
and register the resultant sub-devices whist managing shared
resources.  The parent drivers should all reside in drivers/mfd.

> Right now I see cros_ec being split, quite haphazardly, between
> drivers/platform/chrome and drivers/mfd, with some transport drivers
> (i2C, SPI) and some interfaces living in MFD, while LPC transport and
> host of other stuff living in drivers/platform. On top of that we have
> cros_ec_keyb in input, RTC drivers, CEC, and god knows what else
> spread across various subsystems:

AFAICS, there aren't any compelling reasons for the CROS drivers to
continue to reside in drivers/mfd or their use of the MFD API.  It
would be better if they moved into drivers/platform and dropped the
use of the MFD API entirely.  Simply use platform_device_add() in its
place.

> dtor@dtor-ws:~/kernel/linus $ find -name 'cros_ec*.c'
> ./drivers/iio/light/cros_ec_light_prox.c
> ./drivers/iio/accel/cros_ec_accel_legacy.c
> ./drivers/iio/pressure/cros_ec_baro.c
> ./drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> ./drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> ./drivers/mfd/cros_ec_spi.c
> ./drivers/mfd/cros_ec.c
> ./drivers/mfd/cros_ec_i2c.c
> ./drivers/mfd/cros_ec_dev.c
> ./drivers/input/keyboard/cros_ec_keyb.c
> ./drivers/platform/chrome/cros_ec_vbc.c
> ./drivers/platform/chrome/cros_ec_debugfs.c
> ./drivers/platform/chrome/cros_ec_lpc.c
> ./drivers/platform/chrome/cros_ec_lightbar.c
> ./drivers/platform/chrome/cros_ec_lpc_reg.c
> ./drivers/platform/chrome/cros_ec_proto.c
> ./drivers/platform/chrome/cros_ec_lpc_mec.c
> ./drivers/platform/chrome/cros_ec_sysfs.c
> 
> The fact that sysfs/debugfs code is in platform but we instantiate it
> from MFD is pure madness (it's driver private data, there is no reason
> why it should be exported to nclude/linux/mfd/cros_ec.h). This all
> creates unnecessary friction and I would love to move most of the code
> into drivers/platform/chrome.
> 
> I see the wisdom of having code that could potentially be used in
> several systems in respective subsystems code (pretty much majority of
> drivers/mfd/ drivers are for chips/IP blocks that are used and reused
> by different systems and boards), but I think cros ec is quite
> different in that regard as it is only used by ChromeOS devices and
> has little to no chance to be useful anywhere else.
> 
> Thanks.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
