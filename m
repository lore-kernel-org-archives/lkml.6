Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278C12077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYYqzRm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278C12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGQXtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:49:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40317 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGQXtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:49:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so2398490ljc.7;
        Tue, 17 Jul 2018 16:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PIDJcCHy+v6rKaQ84eE9rtH0lKlpBdz1O5fIu6GRMro=;
        b=EYYqzRm1cHZ91uaVVDcCLd3IYNBFYcGX9Dadn4ygyepG146EZocAjc4Ji6A5nE4rjw
         OHfdxk6Q8hdOvJTLuWvYhlyAX5aJL1eMVLHPZ+fJIdBhI9bW4JSEdU0o2NChtMHdaD/y
         S6zg165iT2pn6zwQQBfAFxeu7KvaBDke6m2qxAf+zxFaPzrSttO+ngLnGok+nGL25nF9
         3qy4T2bLL/oCg1uQQeiAeq/DstmWOe/5HROtXpEob8qHEAdnTGExGnx7yeysbVdDHT1R
         vPDo12/M/azMyPZaNOBlP30ngMD0ZSNWk5ydNTJ8a78Np/+KtIvkMENtSluaRzfR8ATy
         kjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PIDJcCHy+v6rKaQ84eE9rtH0lKlpBdz1O5fIu6GRMro=;
        b=kKax2zyg5ELk1MjTmCuvaRbwgUGg1sHU4T79jZCXHv0UJmfkcCOohmZZkThCfXVhZv
         GefgHgjnTLIRhlaFf//3xvZM46cJSvkcGi0aCNhvIzC2mqcTNbtC9guP6LmJTxpz92Nb
         izMQRDAC5Ome0nPmUQ2gLj4RycuIdvkRAmpKu23wQPCkfuQUHJcNL8vssjkMilcRyVW2
         qC9kPIPn+wLfcKY9JLs4H4Han2evHxw2bw1w7qYD0bjOwZLJcs/xKSAr3jeD6MXMNrW2
         P9e0DZYXI/EkAd1RXPx52aeC+/MTxzbZdYwWuJsVqukLnGTSPYxqeT99Hcyj0AeIEEWR
         ajog==
X-Gm-Message-State: AOUpUlE7ZVVKsKn9RNTNi5wZmyLiedjg+THwGFitX715EvuERy1VGsX7
        wPVKsJCCIUCfdP+11GxERkM=
X-Google-Smtp-Source: AAOMgpcbL8lOb4NiHlBsTRWUeYOzc5YyqxHmTA2eIUXA7wxSJEZZFYqRs109YESu7m9tvQTTh9u5Og==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr2608754lja.151.1531869293427;
        Tue, 17 Jul 2018 16:14:53 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id n24-v6sm350827ljc.7.2018.07.17.16.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 16:14:52 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod migration 
Date:   Wed, 18 Jul 2018 01:14:45 +0200
Message-Id: <20180717231448.14958-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180518210954.29044-1-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a follow up of initial submission of a series consisted of 
6 changes, 3 of which have been already applied or reworkeed.

V2 changelog:
[PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
	- already in mainline, commit 68e62a15a914
[PATCH 2/6] Input: ams_delta_serio: use GPIO lookup table
	- reworked and submitted as a series, already in linux-omap,
	  commit 68e62a15a914 ("ARM: OMAP1: ams-delta: drop GPIO lookup
	  table for serio device") followed by 9 more
[PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
	- already in mainline, commit d65777d1a2cd
[PATCH 4/6] fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
	- resubmitting as [PATCH v2 1/3 v2]
	v2: Remove problematic error code conversion no longer
	    needed if used on top of commit d08605a64e67 ("ARM: OMAP1:
	    ams-delta: move late devices back to init_machine")
	    and commit 8853daf3b4ac ("gpiolib: Defer on non-DT
	    find_chip_by_name() failure") already in linux-next
[PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
	- resubmitting as [PATCH v2 2/3 v4]
	v2: Fix handling of devm_gpiod_get_optional() return values -
	    thanks to Andy Shevchenko.
	v3: Remove problematic error code conversion no longer needed
	    if used on top of commit d08605a64e67 ("ARM: OMAP1:
	    ams-delta: move late devices back to init_machine") and
	    commit 8853daf3b4ac ("gpiolib: Defer on non-DT
	    find_chip_by_name() failure") already in linux-next - thanks
	    to Boris Brezillon
	v4: fix style issue - thanks to Boris Brezillon
[PATCH 6/6] ARM: OMAP1: ams-delta: make board header file local to
	mach-omap1
	- resending as [PATCH v2 3/3]

Dependency on commit 8853daf3b4ac ("gpiolib: Defer on non-DT
find_chip_by_name() failure") is not critical - it is not needed for
clean build or run, it only prevents from potential future changes to
driver initializaton order during device_initcall.

I'm submitting the three patches in series because the last one depends
on the other two.

Thanks,
Janusz

