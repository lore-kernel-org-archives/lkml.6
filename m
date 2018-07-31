Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F5FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A0A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dXYOD1G4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A0A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbeGaVVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:21:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44278 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbeGaVVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:21:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so9576411pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FUe3Nhf5VSAEUuWdguwXDx+tbIm7HEM34i+JUv/vanw=;
        b=dXYOD1G40Ulxn538W/E1jQ5FArX7niK2hup8zUH9ZcPukj7FPIhRLbPGljuPp+2WEu
         sYUmwN57Fq+BruG4rDq5oFqxiDInR86bwxQDXhK2el4KDCEUrBdyekEMKCThEtoss9T/
         6jLDM++PGN7Jbi0BVF75RpkncbbRvQoCQ/HoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FUe3Nhf5VSAEUuWdguwXDx+tbIm7HEM34i+JUv/vanw=;
        b=dp9PO3fkCHvuda1bP2xBwSsUq7FQ4SDbs/3dBspr5iHFM0VqRciOecMKI+DN3Hx76P
         /Ts3Urr66cWT6y79KDrY8jXF211VLxTSfiFRHmDvp2wBKPEJHFMc7DvO8FGS7KkYcg3B
         RDiNIydF8C1oJTBzhZABHNhowHfvDCyfKS/kr9BaQz5wAGdha0aPid+b7YMr3O0tlRnH
         wzEZU9B+G6Ir70fGeFT8RCRbn6ffxoweC2WSMnszelcER64dXNDVaSJGMUWx3m5PpUTk
         HBkV5QJn0waRezzPm07k8GT1MRNLJtIdBkM4Xb4Il7Y66FHf8VK4ur4q+FUrs1g/nUmi
         dspw==
X-Gm-Message-State: AOUpUlErDcydeIt9yr5I4R8IYVdUjzhDo/5AKK6pp8WG/yW3XJI37EOn
        CfsBw44jqdoJtXnMHvXQUe1+Yw==
X-Google-Smtp-Source: AAOMgpfgc7In3cWm3Grp99DRwrWjvaC7K46RG3L8d7mj28Uqww5FH8ZtvIPpNc9ue1WhtPokgJIzfw==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr21843129pgq.382.1533065994377;
        Tue, 31 Jul 2018 12:39:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p26-v6sm25762173pfi.183.2018.07.31.12.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:39:53 -0700 (PDT)
Date:   Tue, 31 Jul 2018 12:39:53 -0700
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
Message-ID: <20180731193953.GH68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
 <20180703234705.227473-6-mka@chromium.org>
 <5B3C6C2A.1070205@samsung.com>
 <20180706175301.GG129942@google.com>
 <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
 <20180716175050.GZ129942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716175050.GZ129942@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
> > Hi Matthias,
> > 
> > On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
> > > Hi Chanwoo,
> > > 
> > > On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
> > > 
> > >> Firstly,
> > >> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> > >>
> > >> devfreq already used the OPP interface as default. It means that
> > >> the outside of 'drivers/devfreq' can disable/enable the frequency
> > >> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> > >> drivers disable/enable the specific frequency, the devfreq core
> > >> consider them.
> > >>
> > >> So, devfreq doesn't need to devfreq_verify_within_limits() because
> > >> already support some interface to change the minimum/maximum frequency
> > >> of devfreq device. 
> > >>
> > >> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> > >> to change the minimum/maximum frequency of cpu. some device driver cannot
> > >> change the minimum/maximum frequency through OPP interface.
> > >>
> > >> But, in case of devfreq subsystem, as I explained already, devfreq support
> > >> the OPP interface as default way. devfreq subsystem doesn't need to add
> > >> other way to change the minimum/maximum frequency.
> > > 
> > > Using the OPP interface exclusively works as long as a
> > > enabling/disabling of OPPs is limited to a single driver
> > > (drivers/thermal/devfreq_cooling.c). When multiple drivers are
> > > involved you need a way to resolve conflicts, that's the purpose of
> > > devfreq_verify_within_limits(). Please let me know if there are
> > > existing mechanisms for conflict resolution that I overlooked.
> > > 
> > > Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
> > > devfreq_verify_within_limits() instead of the OPP interface if
> > > desired, however this seems beyond the scope of this series.
> > 
> > Actually, if we uses this approach, it doesn't support the multiple drivers too.
> > If non throttler drivers uses devfreq_verify_within_limits(), the conflict
> > happen.
> 
> As long as drivers limit the max freq there is no conflict, the lowest
> max freq wins. I expect this to be the usual case, apparently it
> worked for cpufreq for 10+ years.
> 
> However it is correct that there would be a conflict if a driver
> requests a min freq that is higher than the max freq requested by
> another. In this case devfreq_verify_within_limits() resolves the
> conflict by raising p->max to the min freq. Not sure if this is
> something that would ever occur in practice though.
> 
> If we are really concerned about this case it would also be an option
> to limit the adjustment to the max frequency.
> 
> > To resolve the conflict for multiple device driver, maybe OPP interface
> > have to support 'usage_count' such as clk_enable/disable().
> 
> This would require supporting negative usage count values, since a OPP
> should not be enabled if e.g. thermal enables it but the throttler
> disabled it or viceversa.
> 
> Theoretically there could also be conflicts, like one driver disabling
> the higher OPPs and another the lower ones, with the outcome of all
> OPPs being disabled, which would be a more drastic conflict resolution
> than that of devfreq_verify_within_limits().
> 
> Viresh, what do you think about an OPP usage count?

Ping, can we try to reach a conclusion on this or at least keep the
discussion going?

Not that it matters, but my preferred solution continues to be
devfreq_verify_within_limits(). It solves conflicts in some way (which
could be adjusted if needed) and has proven to work in practice for
10+ years in a very similar sub-system.
