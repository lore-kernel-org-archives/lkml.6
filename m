Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1919C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE32215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwNBqx/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE32215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeHCCS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:18:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeHCCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:18:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so2245141pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zZM5Jpx2IOsVIogcv5OnZCGUFSkwrthIO9ixu6UL/zk=;
        b=JwNBqx/TkS5+lFcVFFYLiMRYmbod7QmLNXLkwmEDUz4oeIuHzq0PegMUPZNvN84iKw
         NXrOzmyV5VGTShOHDjdJnMIva8SgRFJmNBrSILibSOYcSAHvI89WQ5IrqnKB4ErmRy7M
         ymnHtKKiquFY5YuHtlcDJ57gKJ8WUzXgiSd+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zZM5Jpx2IOsVIogcv5OnZCGUFSkwrthIO9ixu6UL/zk=;
        b=jF+hNdsF23S0xA5O0QUL+Hv6rnN4i2BTPuteHSW+diibgu/CVGmMxvkJLxv+vxemmJ
         P5A/6WZCptDYahfvUCHLtlqSx2dcM/wgKS9CWa+QDhu5rOIE38XEVnFSutILrr2r9nPW
         mP8InqGN6H+M8TiAGpRbaaPeHVyik6wgJn7Uyt46W5WoGnPxbB7+/qpfpzy0aFFJ3jG0
         U4HmEMuXvq0AOcRkSNMxNTdfbt6gFzzA4ps/l4574/+dejgQth5H4e5s8nP6OU2JaseJ
         8QEMKwb5ubbLAXYMPGCXuYOmDsvCDGQdlKrb37GDn27h1ku2/swX9gF+/qhF+iNVbcF1
         gcPA==
X-Gm-Message-State: AOUpUlHVgV9XIWIvFxZCcEQ40gWRrpAkCN7ApcZ3wKA4USYfeE3ctvRF
        cnIwsgZr+YDCSiKSjB3XmZr1aw==
X-Google-Smtp-Source: AAOMgpcZoZ1fvS1ahbH41kCXghtxhx0sjdGR+UX2unvNSTS2KPs+OlwOZ9L74Q+/kS9gPNKomdNKVw==
X-Received: by 2002:a65:6455:: with SMTP id s21-v6mr1440532pgv.394.1533255893073;
        Thu, 02 Aug 2018 17:24:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 14-v6sm7021724pft.93.2018.08.02.17.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 17:24:52 -0700 (PDT)
Date:   Thu, 2 Aug 2018 17:24:52 -0700
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
Subject: Re: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in
 governors
Message-ID: <20180803002452.GV68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-4-mka@chromium.org>
 <CGME20180802233605epcas2p2fc6b1cef0dc773f6c7e59017721917bc@epcas2p2.samsung.com>
 <20180802233600.GT68975@google.com>
 <5B639BD2.5050008@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B639BD2.5050008@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:03:30AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 08월 03일 08:36, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > this patch and "PM / devfreq: Fix handling of min/max_freq == 0"
> > address issues not directly related with the throttler. It seems it
> > could still take a while for the throttler to move forward, do you
> > want me to spin out these two patches so that they can get merged
> > independently from the rest of the series?
> 
> How about resend the devfreq patches(patch1/2/3/4/6) which don't depend on
> throttler core with my reviewed tag? Maybe, it is easy to merge them through Myungjoo.

Sure, I can do this if you think it is reasonable to merge all these
patches without the throttler.

These are the patches we are talking about and my interpretation of
their status:

[01] PM / devfreq: Init user limits from OPP limits, not viceversa
  landed in Rafaels tree

[02] PM / devfreq: Fix handling of min/max_freq == 0
  independent fix, can land

[03] PM / devfreq: Don't adjust to user limits in governors
  independent improvement, can land

[04] PM / devfreq: Add struct devfreq_policy
  edge case, can land if devfreq maintainers think that factoring out
  some fields to the policy struct is an improvement independently of
  the throttler

[05] PM / devfreq: Add support for policy notifiers
  under heavy discussion ;-), can't land

[06] PM / devfreq: Make update_devfreq() public
  has no user without the throttler, not sure if it should be merged
  without it. up to devfreq maintainers.

Please let me know what you think

Thanks

Matthias
