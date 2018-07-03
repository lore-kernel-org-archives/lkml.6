Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9231C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8593C21D25
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8593C21D25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeGCXrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:47:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37740 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeGCXrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:22 -0400
Received: by mail-pg0-f68.google.com with SMTP id n15-v6so1646279pgv.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BymC1kqxcORFbtkpj9cjjI0biLLHJb08PTzx1P5UV/U=;
        b=k7dg6hDZG1zsPUNFKHdz49hoRVfVUmSGLeLuyc/my1gY7HBaLWdVN3XiM9KQeuj5Ip
         pKzTOGOjj/huq+u2Ud0ujjyhLM1RqMfyBor0dpkjsFQeNiQJtMJXQgNZecccOKsT8aFX
         fbuZb8W1pOFIZf/RkKSR673KUb2lw79f7Xnp7RtENF4A7G1K9kNXh6kvosy4k+LGQnSA
         Yc8NTKScsDDwiuXeIhpMo77iF17UrEIylKVGXzW0tp02L6ZsI4BroLotT+x2AfV4Y3sY
         tFa42Jqi5EcYIVV1BlaTsmmDHok3IJl2Gd0VzfEVJzG9Y5stRYN3d7Y7o0BjvpBL887+
         L6wQ==
X-Gm-Message-State: APt69E1J5XtE4BQkM9WvAjJ+jiHLy1o7ifinpU8YzInRgzDbiyGABril
        UXEeDP41YpllWskkW5ZvVrsJCw==
X-Google-Smtp-Source: AAOMgpc18NgrFBa/bInGpMnzeGjSCh4Plds4c9hfEvltM0EfSYNmGLMFo1emTZKVN8K1Sf/lWQgUcA==
X-Received: by 2002:a63:b445:: with SMTP id n5-v6mr23351764pgu.104.1530661642122;
        Tue, 03 Jul 2018 16:47:22 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:21 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 00/12] Add throttler driver for non-thermal throttling
Date:   Tue,  3 Jul 2018 16:46:53 -0700
Message-Id: <20180703234705.227473-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the throttler driver, for non-thermal throttling of
CPUs and devfreq devices. A use case for non-thermal throttling could
be the detection of a high battery discharge current, close to the
over-current protection (OCP) limit of the battery.

To support throttling of devfreq devices the series introduces the
concept of a devfreq policy and the DEVFREQ_ADJUST notifier (similar
to CPUFREQ_ADJUST). Further it includes some related devfreq bugfixes
and improvements that change some of the code that is also touched
by the policy changes.

Matthias Kaehlcke (12):
  PM / devfreq: Init user limits from OPP limits, not viceversa
  PM / devfreq: Fix handling of min/max_freq == 0
  PM / devfreq: Don't adjust to user limits in governors
  PM / devfreq: Add struct devfreq_policy
  PM / devfreq: Add support for policy notifiers
  PM / devfreq: Make update_devfreq() public
  PM / devfreq: export devfreq_class
  cpufreq: Add stub for cpufreq_update_policy()
  dt-bindings: misc: add bindings for throttler
  misc: throttler: Add core support for non-thermal throttling
  misc: throttler: Add Chrome OS EC throttler
  mfd: cros_ec: Add throttler sub-device

 .../devicetree/bindings/misc/throttler.txt    |  13 +
 MAINTAINERS                                   |   7 +
 drivers/devfreq/devfreq.c                     | 222 +++---
 drivers/devfreq/governor.h                    |   6 +-
 drivers/devfreq/governor_passive.c            |   4 +-
 drivers/devfreq/governor_performance.c        |   5 +-
 drivers/devfreq/governor_powersave.c          |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |  12 +-
 drivers/devfreq/governor_userspace.c          |  16 +-
 drivers/mfd/cros_ec_dev.c                     |  19 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/throttler/Kconfig                |  33 +
 drivers/misc/throttler/Makefile               |   2 +
 drivers/misc/throttler/core.c                 | 697 ++++++++++++++++++
 drivers/misc/throttler/cros_ec_throttler.c    | 111 +++
 include/linux/cpufreq.h                       |   1 +
 include/linux/devfreq.h                       | 113 ++-
 include/linux/throttler.h                     |  21 +
 19 files changed, 1161 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
 create mode 100644 include/linux/throttler.h

-- 
2.18.0.203.gfac676dfb9-goog

