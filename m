Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8500ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F792089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a0CuM6M6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F792089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeGPSTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:19:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40979 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:19:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id c21-v6so22036718pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2Wb9fVRQY1pxYMr5BS6W6wewSKhpfQj4e4ppGF1dSsA=;
        b=a0CuM6M65KuIRzi8huMuCYaow9GxfuEjzd1lkTrqKP5meuv2zPZX0AhPTPmMJmfQzt
         IsJruUmhIPq08y0gV5hH779Zp3W7amT9diUvbSYgagztXqXTap4ZITL4CbE4su0PFkfM
         ukz+whIGCWDOFOj0l/ze7TKbzcsbFIsJ5MeSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2Wb9fVRQY1pxYMr5BS6W6wewSKhpfQj4e4ppGF1dSsA=;
        b=J7d2+M6ZAjQw63u9SCusTP2apZ0yXjT1QalH5kAFvlpOQFVEXgL6MRF3cAhLxeKhtB
         XczzCzyI+jZmrSdFhRCDwFP3yiRFkijbvzTqYU7L2rV9x7ThruMXrWKOvnER0GYkNiVH
         RJucTeIIYxN73Et9Kx/4f6qGOl5eIl8QaDiRTo6BJ1hdpPG/FL6IRTMhg23JywJ5SRYR
         u6RAXlTpZwyLIB4DbtbMrclRc6RmW70Xt5fiejW41tUjXF5aNZSB00BrobfZX4EcVqkz
         pAEEJS18GM/MterFTm9gY1U0+ZlSYzucBb0XYbF83azw45Hj2Z05PXNpyhHaYF4Au4Yh
         wHag==
X-Gm-Message-State: AOUpUlF5K5mHwaY1PGzzzu50ReKb/vmF6SbkhkruhTxceGoml/LCQuWR
        vc9A0DX13/2tHlZaHRs3eve3Fg==
X-Google-Smtp-Source: AAOMgpflEGkHjETQZuKM+oy1nqHoYDedS10CnsA35QDmhw4KAbkhEWQVCvyMBbQaX0PYrwncBfw0iw==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr16023841pgp.200.1531763451443;
        Mon, 16 Jul 2018 10:50:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id d9-v6sm47016816pfb.86.2018.07.16.10.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:50:50 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:50:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
Message-ID: <20180716175050.GZ129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
 <20180703234705.227473-6-mka@chromium.org>
 <5B3C6C2A.1070205@samsung.com>
 <20180706175301.GG129942@google.com>
 <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
> > 
> >> Firstly,
> >> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> >>
> >> devfreq already used the OPP interface as default. It means that
> >> the outside of 'drivers/devfreq' can disable/enable the frequency
> >> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> >> drivers disable/enable the specific frequency, the devfreq core
> >> consider them.
> >>
> >> So, devfreq doesn't need to devfreq_verify_within_limits() because
> >> already support some interface to change the minimum/maximum frequency
> >> of devfreq device. 
> >>
> >> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> >> to change the minimum/maximum frequency of cpu. some device driver cannot
> >> change the minimum/maximum frequency through OPP interface.
> >>
> >> But, in case of devfreq subsystem, as I explained already, devfreq support
> >> the OPP interface as default way. devfreq subsystem doesn't need to add
> >> other way to change the minimum/maximum frequency.
> > 
> > Using the OPP interface exclusively works as long as a
> > enabling/disabling of OPPs is limited to a single driver
> > (drivers/thermal/devfreq_cooling.c). When multiple drivers are
> > involved you need a way to resolve conflicts, that's the purpose of
> > devfreq_verify_within_limits(). Please let me know if there are
> > existing mechanisms for conflict resolution that I overlooked.
> > 
> > Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
> > devfreq_verify_within_limits() instead of the OPP interface if
> > desired, however this seems beyond the scope of this series.
> 
> Actually, if we uses this approach, it doesn't support the multiple drivers too.
> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
> happen.

As long as drivers limit the max freq there is no conflict, the lowest
max freq wins. I expect this to be the usual case, apparently it
worked for cpufreq for 10+ years.

However it is correct that there would be a conflict if a driver
requests a min freq that is higher than the max freq requested by
another. In this case devfreq_verify_within_limits() resolves the
conflict by raising p->max to the min freq. Not sure if this is
something that would ever occur in practice though.

If we are really concerned about this case it would also be an option
to limit the adjustment to the max frequency.

> To resolve the conflict for multiple device driver, maybe OPP interface
> have to support 'usage_count' such as clk_enable/disable().

This would require supporting negative usage count values, since a OPP
should not be enabled if e.g. thermal enables it but the throttler
disabled it or viceversa.

Theoretically there could also be conflicts, like one driver disabling
the higher OPPs and another the lower ones, with the outcome of all
OPPs being disabled, which would be a more drastic conflict resolution
than that of devfreq_verify_within_limits().

Viresh, what do you think about an OPP usage count?

Thanks

Matthias
