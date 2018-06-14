Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 122BFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3D8208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3D8208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755421AbeFNTrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:47:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36529 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754877AbeFNTrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so3382767pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I0H/P4V3SAAFbFSXJN3E7GywKzIsxOJ5nhgPh8XBka0=;
        b=KOD3qZfqvFR+a6HyommHZFobOftbFLEwXq//eY4+AQdl4qKdvB9KcSsy0OBlNLUgo+
         IwaJQ2wZqcsGHn28q9twy0n6UpQazD9lD6zdnM4fzJtjxGGW27+Xj+gbJuIb6AgYMxRV
         b1d4Y3qjVZKbVrEloKJCEZe49ysN1VjcMUWI5ytJqQpkFwJoX7WJexpInSzWf475QoRk
         J3rGUW3MxxJEl4C5bwQBmC4pn16jTCshqKf6Rm1fZyUJx0SWp8nCvPxIIdML5BJDXl8Y
         cYNd0AyfJMj2dtb0qXRYFG1kww9uUt0EDyyI4X4LzdlvarNMcKaC3nyNaVpwTW9mZUx3
         O1YQ==
X-Gm-Message-State: APt69E2xW56izhN16jJ8aCy6TfnQFF4yB+NaZHxhtxjSrK1NKAUPIvFQ
        lU02yEkLGI0pWV5wntSEIDAZWQ==
X-Google-Smtp-Source: ADUXVKKMsC9AMnewHAHkyXpAUP7kvZo/CjpSI2QbD+t8NdkiGyOt/AJ1YGJwZwsgmWX9Qd1qguf3fg==
X-Received: by 2002:a63:be0a:: with SMTP id l10-v6mr3361959pgf.87.1529005638509;
        Thu, 14 Jun 2018 12:47:18 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:17 -0700 (PDT)
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
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 00/12] Add throttler driver for non-thermal throttling
Date:   Thu, 14 Jun 2018 12:47:00 -0700
Message-Id: <20180614194712.102134-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the throttler driver, for non-thermal throttling of
CPUs and devfreq devices. A use case for non-thermal throttling could
be the detection of a high battery discharge voltage, close to the
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
  PM / devfreg: Add support for policy notifiers
  PM / devfreq: Make update_devfreq() public
  PM / devfreq: export devfreq_class
  cpufreq: Add stub for cpufreq_update_policy()
  dt-bindings: PM / OPP: add opp-throttlers property
  misc: throttler: Add core support for non-thermal throttling
  misc: throttler: Add Chrome OS EC throttler
  mfd: cros_ec: Add throttler sub-device

 Documentation/devicetree/bindings/opp/opp.txt |   3 +
 MAINTAINERS                                   |   7 +
 drivers/devfreq/devfreq.c                     | 222 +++---
 drivers/devfreq/governor.h                    |   6 +-
 drivers/devfreq/governor_passive.c            |   4 +-
 drivers/devfreq/governor_performance.c        |   5 +-
 drivers/devfreq/governor_powersave.c          |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |  12 +-
 drivers/devfreq/governor_userspace.c          |  16 +-
 drivers/mfd/cros_ec.c                         |  16 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/throttler/Kconfig                |  33 +
 drivers/misc/throttler/Makefile               |   2 +
 drivers/misc/throttler/core.c                 | 687 ++++++++++++++++++
 drivers/misc/throttler/cros_ec_throttler.c    | 109 +++
 include/linux/cpufreq.h                       |   1 +
 include/linux/devfreq.h                       | 113 ++-
 include/linux/throttler.h                     |  21 +
 19 files changed, 1136 insertions(+), 125 deletions(-)
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
 create mode 100644 include/linux/throttler.h

-- 
2.18.0.rc1.242.g61856ae69a-goog

