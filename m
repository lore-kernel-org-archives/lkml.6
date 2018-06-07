Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jNQxI3p2GVveFwAAmS7hNA
	; Thu, 07 Jun 2018 18:17:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E13EC606FA; Thu,  7 Jun 2018 18:17:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4FCDB601C3;
	Thu,  7 Jun 2018 18:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FCDB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935480AbeFGSMz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:12:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34207 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932731AbeFGSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:12:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so6639898plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yhnBfLjC+QA0p9ug2P1HVLCjmzzo1HOog/zgXDzzwcw=;
        b=SL/w9+xkvIDHX/1HepV34+pPqxeD37kNwu+6kXIi3S89DoR6TErjW2cu5dsN7n4LFi
         myvGoKN8YDQxlPDstz9kRp5BUY0VSq53rOa/I9F/GQSY2dixh2kDYSRUstT8aKHNfgoW
         KtWKU6SJp2obX5ih8c26CPD5ZmLS+8AxvHfpJ/H+anwJv5fXiOSwmTtg4rGADA8JowV5
         7S7jszJyNNgsl3kUQcTMGcu8Uh5FN74xRVBl5YOfbh0fvWdBsQP6Jvc7FDOUVMDr/fhD
         YxXNr8wzfpfWypW5wMVd/aTBrGrXDwvakU9BUxo5wLfUy+ZLOKox6rJanKjKlr9nF5+S
         0Uxw==
X-Gm-Message-State: APt69E0eFjyRcBcYbTvpWrF2fUa5nzt8T2a//Es46jNAkViOiwjSbTSP
        k517hCMtteTKD4sVZAWDo3nvyw==
X-Google-Smtp-Source: ADUXVKKtC/kcfBMM4zUs5wvo9pasEBlm7QeJ4s9INjgJyVu/Dd3HxZTkYaEQa0qUGdkmnl0mPyb/bA==
X-Received: by 2002:a17:902:650a:: with SMTP id b10-v6mr3147610plk.45.1528395171743;
        Thu, 07 Jun 2018 11:12:51 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:12:50 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 00/11] Add throttler driver for non-thermal throttling
Date: Thu,  7 Jun 2018 11:12:03 -0700
Message-Id: <20180607181214.30338-1-mka@chromium.org>
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

Matthias Kaehlcke (11):
  PM / devfreq: Init user limits from OPP limits, not viceversa
  PM / devfreq: Fix handling of min/max_freq == 0
  PM / devfreq: Don't adjust to user limits in governors
  PM / devfreq: Add struct devfreq_policy
  PM / devfreg: Add support for policy notifiers
  PM / devfreq: Make update_devfreq() public
  PM / devfreq: export devfreq_class
  dt-bindings: PM / OPP: add opp-throttlers property
  misc: throttler: Add core support for non-thermal throttling
  dt-bindings: misc: add bindings for cros_ec_throttler
  misc: throttler: Add Chrome OS EC throttler

 .../bindings/misc/cros_ec_throttler.txt       |   4 +
 Documentation/devicetree/bindings/opp/opp.txt |   3 +
 MAINTAINERS                                   |   7 +
 drivers/devfreq/devfreq.c                     | 222 +++---
 drivers/devfreq/governor.h                    |   6 +-
 drivers/devfreq/governor_passive.c            |   4 +-
 drivers/devfreq/governor_performance.c        |   5 +-
 drivers/devfreq/governor_powersave.c          |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |  12 +-
 drivers/devfreq/governor_userspace.c          |  16 +-
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/throttler/Kconfig                |  28 +
 drivers/misc/throttler/Makefile               |   2 +
 drivers/misc/throttler/core.c                 | 642 ++++++++++++++++++
 drivers/misc/throttler/cros_ec_throttler.c    | 116 ++++
 include/linux/devfreq.h                       | 113 ++-
 include/linux/throttler.h                     |  11 +
 18 files changed, 1070 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
 create mode 100644 include/linux/throttler.h

-- 
2.18.0.rc1.242.g61856ae69a-goog
