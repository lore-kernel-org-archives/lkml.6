Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDD721528
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H2oqPDja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDD721528
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeHPBBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:01:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeHPBBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:01:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so1081220pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=dQvEB/tsP4+bPuG89p4QF0G4FGRFCcSFM23knCCQyNo=;
        b=H2oqPDjaiVZoqYS9gL5IN0XpecmPGdRaKuDbcdGDj0TnwxPWLYOpTRFGyv0JTzbsfQ
         hubPwVsWu+fNim1A6iM5R2UqtzrfpPXOkTniXCBbJdBxWZ4dbWm1vJ5Yr4k7ENx+RTSO
         ZZngMIT09ZNXPok9ocHDCdxtKHLsqHfbpUEgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=dQvEB/tsP4+bPuG89p4QF0G4FGRFCcSFM23knCCQyNo=;
        b=buJnMFIB/3/eMpLr1lkhR8V/Jt4Xz57gTHX7+48AfUwKcTey4ODC8/XzLFlLfau9ip
         4AjBrHtpTzruur27yYo55CzjcOy3KLP7PrIDPNO/rW65K/ho1+qRcbJ9TO/ZTgOCpMxk
         nVuETciyo7PysLx1ZL5K0iq/V+pbqx5h0Y7cXTQlp2M5sNDmRgWQxwutN/DB1nN3W/Qj
         0Afo8dTD69Bql6aQ3p+dckoQSbgY1ZpuJB6BrjmVW1q6JsxsIKhcs9sIf6QzBX4xI1EM
         3npo3mTcK+RjPTWcCffinjhCl7dsk37ZRRBUUbPYT1U111mup5JrmmRPaQIbHzDPPoFY
         0gug==
X-Gm-Message-State: AOUpUlGxlmSJW44ldL4ZI1xjEpV1WyHSQlVmISdk5A/XayBPGvInCbMn
        WecCIA4GRIyXPrRm9q/efH/ROw==
X-Google-Smtp-Source: AA+uWPw//xV0e+CzdjuaQ7fgH7edKMOGeFxQnWnQbtexvKx/fdUBplZnwkpwz1U3myhp1/28N2Ht1g==
X-Received: by 2002:a63:9856:: with SMTP id l22-v6mr26969339pgo.208.1534370822053;
        Wed, 15 Aug 2018 15:07:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id g5-v6sm27802573pfh.63.2018.08.15.15.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:07:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180815014436.GA17200@ban.mtv.corp.google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
 <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
 <20180815014436.GA17200@ban.mtv.corp.google.com>
Message-ID: <153437082071.28926.11684780766239178367@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
Date:   Wed, 15 Aug 2018 15:07:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Norris (2018-08-14 18:44:36)
> Hi,
> =

> On Tue, Aug 14, 2018 at 05:52:49PM -0700, Florian Fainelli wrote:
> > On 08/14/2018 05:22 PM, Brian Norris wrote:
> =

> > >> Also, aliases in DT are meant to provide some stability.
> > > =

> > > How, specifically? I don't see any relevant binding description for
> > > aliases under Documentation/devicetree/bindings/net/.
> > =

> > Indeed they are not, likewise, we should probably update devicetree-spec
> > to come up with standard names that of_alias_get_id() already consumes.
> =

> A quick grep shows we already have divergence: both "eth" and "ethernet"
> are in use.
> =

> But anyway, would the idea be that you just put 'ethernet{0,1,...}' and
> 'wifi{0,1,...}' aliases in the /chosen node, then require boot firmware
> to insert any {ethernet,wifi}_mac{0,1,...} into the paths represented by
> the corresponding aliases? I suppose that would reduce the problems with
> (1), but it still doesn't really help with (2).

Yes. Aliases are the way to do this. It obviates much of this discussion
about finding things in DT by directly pointing to the node the
bootloader wants to go modify.

> > > =

> > > And finally, this may be surmountable, but the existing APIs seem very
> > > device tree centric. We use this same format on ACPI systems, and the
> > > current series would theoretically work on both [1]. I'd have to rewr=
ite
> > > the current (OF-only) helpers to get equivalent support...

Where does it go on ACPI systems? Does the firmware stick it into some
ACPI table by reading from VPD?

