Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2060DC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A35218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="reGI0fZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfAZTbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:31:25 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:19160 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfAZTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548531080;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=puyNQkvhKVOeQZcXPzWY0Yqb517W/lLbBh7R3tRhBUI=;
        b=reGI0fZRsjQkjmpMqFnNiTruc4/O460Kb4tsGnCqcEWs/PNI/L50dOtfrJDu6SkO7v
        JGXbpqkEncijkaNGI+Nj0luojJDUI6OxES+2CL9uzmjS9Mzz0XeKrSTLxeyFtVqufwLO
        8pVP/rwwV+OTDbbKD+7lHkeT6VhUPxbs+AjtJPG/KzmGTjJh1zotlkzmsdjvr1nM8GZR
        Ym/QpDDfIMbbqeSL1udJiy7TTNLq5Q7Yz5G76jDrcV4Cx4yxv9bDaw5cPrhXfAnOgHZY
        gK7T5luPJTiOVLEeOPdvRJQalrQXvvbhcA/FvBZoZtMvjwc2IrxT/TslRA7OevEXKHfX
        yY5g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zswDuotw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v0QJUmsoz
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 26 Jan 2019 20:30:48 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190126194044.2fad4427@aktux>
Date:   Sat, 26 Jan 2019 20:30:47 +0100
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Transfer-Encoding: 7bit
Message-Id: <99532D7E-DCF3-4ECF-B65D-62C3C60E188F@goldelico.com>
References: <20190122175717.13428-1-tony@atomide.com> <20190122175717.13428-2-tony@atomide.com> <20190126194044.2fad4427@aktux>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 26.01.2019 um 19:40 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> On Tue, 22 Jan 2019 09:57:15 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
>> them with ti-sysc") moved some omap4 timers to probe with ti-sysc
>> interconnect target module. Turns out this broke pwm-omap-dmtimer
>> where we now try to reparent the clock to itself with the following:
>> 
>> omap_dm_timer_of_set_source: failed to set parent
>> 
>> With ti-sysc, we can now configure the clock sources in the dts
>> with assigned-clocks and assigned-clock-parents. So we should be able
>> to remove omap_dm_timer_of_set_source with clean-up patches later on.
>> But for now, let's just fix it first by checking if parent and fck
>> are the same and bail out of so.
>> 
> together with 2/3 it fixes things on pyra
> 
> Tested-By: Andreas Kemnade <andreas@kemnade.info>

Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
