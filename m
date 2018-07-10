Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B18C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2942208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eD8Sd/WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2942208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbeGJWZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:25:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39649 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbeGJWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:25:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id s21-v6so17038007pfm.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1PKlXgPssjbxOwXZtieTzlWr8uOIlaa+Smbc7Lc+DbU=;
        b=eD8Sd/WPShUVSobJGPDsgmR+ZJisWSUw9VqscW2bFLZ83IN+bf0ZGtNDAKsSCTudjP
         VCOJbe4082/wSUCnWBvJzO05UwsdEOKgLICTOubBYVpkfEQtpfYiyOIvymy9O+YP0Ugy
         CrImZ8ZuhW5B47HZzGLG5HBQghhPFLmUtOhyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1PKlXgPssjbxOwXZtieTzlWr8uOIlaa+Smbc7Lc+DbU=;
        b=UbjwRzH6SIXkBXH4l8UG07mlenQNeHR03KcgW+nD0wmUsxa1sC55udh17JaZZfML3F
         9HqqkQEhfO4wAFqvIQqBpMHifUvhw6VHdDG2fXxTmUq+bWYsWGBOfh2ndYIyKbBAELXl
         QLo7HhpOh7pKvAkY2EvFS5aSYtsRdwBfX3kTQanE9+spb3QppAGgTG7jenIntEUg1Yem
         rbdio/3+H/YFeAvXxV4ZaEZNjdzwg4DwVPk5zDJRkz+BVlU/dblc9ggQi42TdcsVc2az
         r7eKh2ahAbedWWETMEkzwZCV0vrwgysy6ntVxnog17Etzk3Fdscy5NQuU/00/q8IOGFY
         ITaA==
X-Gm-Message-State: APt69E3MZ6I2bS0R3QIPVbUb3tk2K5w5n/d8Koh1Z7KtfjfyZr80VaIo
        htfhwaGGobvB8zilpgG5dm/FBw==
X-Google-Smtp-Source: AAOMgpf4oDZoo6CYuitGRb+AhCZBhmQOGZd70OJa46Tgo5eQ0Ab+nJgnzC+07OqQn5m//2UxaT8+HQ==
X-Received: by 2002:a63:64c2:: with SMTP id y185-v6mr24039214pgb.126.1531261460536;
        Tue, 10 Jul 2018 15:24:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 4-v6sm12432515pgj.22.2018.07.10.15.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 15:24:19 -0700 (PDT)
Date:   Tue, 10 Jul 2018 15:24:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 08/12] cpufreq: Add stub for cpufreq_update_policy()
Message-ID: <20180710222419.GR129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-9-mka@chromium.org>
 <2392356.ug1cyb9g3O@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2392356.ug1cyb9g3O@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:41:21PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 4, 2018 1:47:01 AM CEST Matthias Kaehlcke wrote:
> > cpufreq stubs out some functions when CONFIG_CPU_FREQ=n , but
> > cpufreq_update_policy() is not among them. The throttler driver
> > (https://patchwork.kernel.org/patch/10453351/) uses cpufreq as one
> > possible throttling mechanism, but it can still be useful without
> > cpufreq. Stubbing out cpufreq_update_policy() allows the throttler
> > driver to be built without ugly #ifdef'ery when cpufreq is disabled.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Changes in v5:
> > - none
> > 
> > Changes in v4:
> > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > 
> > Changes in v3:
> > - patch added to series
> > ---
> >  include/linux/cpufreq.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 882a9b9e34bc..dba8c4951e2e 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -210,6 +210,7 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
> >  	return 0;
> >  }
> >  static inline void disable_cpufreq(void) { }
> > +static inline void cpufreq_update_policy(unsigned int cpu) { }
> >  #endif
> >  
> >  #ifdef CONFIG_CPU_FREQ_STAT
> > 
> 
> I can take this patch if you want me to.

Sounds good.

This series is moving forward slower than I had hoped and there are a
few patches that are useful independently of the throttler at the end
of the series. It probably makes sense to start integrating them
rather than carrying them around unchanged from version to version and
repeatedly spam <world>.

Thanks

Matthias
