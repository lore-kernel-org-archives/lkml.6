Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7CCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D8F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZsq3DON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D8F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbeGaVKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:10:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41674 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbeGaVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:10:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so6577626pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S21VolcI5E1kI8xiEER7UKrrZ+ItWah2034vi1nFjds=;
        b=FZsq3DON5cwSJDsE3lHVC/yQtwprP3ORaHV8WQeHiGKI3ECgVzePlUX5MiochTFWX8
         0ddWwiH9ADyBZZHEGHiCblk2AXbg0ZK2ijDXbap8lrO/PfCFl0/cJyV3DIzi7JTMofX2
         09JoJtgOjIWhbBpm5sRwQicKO+GWBxIhKfT+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S21VolcI5E1kI8xiEER7UKrrZ+ItWah2034vi1nFjds=;
        b=FjmcCtyJ8lDiexKA5JPI1zt7BJ2qCTrOxnCInR8KH4bVk3jf8631RDioG7d2AZaYUv
         sfQfrTqFoiY3CUQDp8Fru9j0x5D7DfPsg6uljzHGgsfxdS9pvp81q3a3AZKB5+VO5mEe
         0fKRb1NNYaFjq0oWnX3HQvKwlJmWqnXtkE3YznPBT3BhOG+s1rC7vllVv437iBrmRJ8H
         5UD2Q/+Kg22KwqNyRfi4fFFVUpo4LqVcRt23qLBUjxC2864z5k3oNiP4iJq0pCC3B6Vq
         DWm/Ei9tObSS/U6KSju3rptrh+AVEqNamODPpmyzwuq63FAWenC3oWohdZuaeSf1SGxU
         9DPQ==
X-Gm-Message-State: AOUpUlH+Hz0LnOazC2nCp8e/JwfAXCvFz19tzAM9bOw7sH7lb9+iAWKQ
        /BMqVL/4IXOpFIIQVvTSXT312g==
X-Google-Smtp-Source: AAOMgpdYOX3jmU+JyFRBDqoZCeg27pViIaBwS/sOhnyK5I+Xbtg80cS47Za4eZmW1wLcYFBasiLgdA==
X-Received: by 2002:a62:5ec3:: with SMTP id s186-v6mr23670985pfb.129.1533065346275;
        Tue, 31 Jul 2018 12:29:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 64-v6sm24748037pfi.89.2018.07.31.12.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:29:05 -0700 (PDT)
Date:   Tue, 31 Jul 2018 12:29:04 -0700
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
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Message-ID: <20180731192904.GG68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
 <20180703234705.227473-8-mka@chromium.org>
 <5B3C5B78.6020401@samsung.com>
 <20180706180923.GH129942@google.com>
 <41164a91-b271-5f3b-b461-21ff5997cc84@samsung.com>
 <20180716194114.GA129942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716194114.GA129942@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:41:14PM -0700, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Thu, Jul 12, 2018 at 06:08:36PM +0900, Chanwoo Choi wrote:
> > Hi Matthias,
> > 
> > On 2018년 07월 07일 03:09, Matthias Kaehlcke wrote:
> > > Hi,
> > > 
> > > On Wed, Jul 04, 2018 at 02:30:32PM +0900, Chanwoo Choi wrote:
> > > 
> > >> I didn't see any framework which exporting the class instance.
> > >> It is very dangerous. Unknown device drivers is able to reset
> > >> the 'devfreq_class' instance. I can't agree this approach.
> > > 
> > > While I agree that it is potential dangerous it is actually a common
> > > practice to export the class:
> > > 
> > 
> > I tried to find the real usage of exported class instance
> > and I add the comment for each class instance. Almost exported class
> > instance are used in the their own director or some exported class
> > like rio_mport_class/switchtec_class are created from specific device driver
> > instead of subsystem.
> > 
> > Only following two cases are used on outside of subsystem directory.
> > devtmpfs.c and alarmtimer.c are core feature of linux kernel.
> > 
> > 	drivers/base/devtmpfs.c uses 'block_class'.
> > 	kernel/time/alarmtimer.c uses 'rtc_class'.
> > 
> > I cannot yet agree this approach due to only block_class and rtc_class.
> 
> I thought your main concern was that the class is exported, which is
> what several other subsystems do. That the class isn't used outside of
> the subsystem directory most likely means that there is no need for
> it, rather than that it shouldn't be done at all (depending on the
> type of use of course).
> 
> In any case not exporting the class object provides a limited
> protection against potential abuse of the class at best. To use the
> class API all that is needed is a 'struct device' of a devfreq device,
> which has a pointer to the class object (dev->class).
> 
> Theoretically I could register a fake devfreq device to obtain access
> to the class object, though that doesn't seem a very neat approach ;-)
> 
> > You added the following comment why devfreq_class instance is necessary.
> > Actullay, I don't know the best solution right now. But, all device drivers
> > can be added or removed if driver uses the module type. It is not a problem
> > for only devfreq instance.
> 
> Certainly it's not a problem limited to devfreq devices. In many other
> cases bus notifiers can be used, but since devfreq devices areen't
> tied to a specific bus this is not an option here.
> 
> If you really don't want to export the class we could add wrappers
> for (un)registering a class interface:
> 
> int devfreq_class_interface_register(struct class_interface *)
> void devfreq_class_interface_unregister(struct class_interface *)
> 
> The wrappers would have to assign ci->class since the throttler
> can't see the class object.
> 
> Or add notifiers for device addition/removal, though the throttler
> relies on the behavior of the class_interface which also notifies
> about devices added before registration. This might not be what other
> potential users of the notifiers expect.

Ping

Could we please try to find a solution/reach a conclusion for this?

Not that it should affect the outcome of this discussion, but I want
to mention that from my point of view it is a bit unfortunate that
this and other fundamental concerns were only raised after I spent
significant time on repeatedly refactoring the throttler driver to
address other comments. Since you and MyungJoo Ham previously had only
minor comments on the other devfreq patches in this series I assumed
there were no major concerns from your side :(
