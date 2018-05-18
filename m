Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbeERIZD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:25:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeERIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:24:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3531C60D81
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
From: Saravana Kannan <skannan@codeaurora.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Saravana Kannan <skannan@codeaurora.org>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Adding support for scaling cache/memory based on CPU frequency
Date: Fri, 18 May 2018 01:24:46 -0700
Message-Id: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
X-Mailer: git-send-email 1.8.2.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many CPU architectures have caches that can scale independent of the CPUs.
Frequency scaling of the caches is necessary to make sure the cache is not
a performance bottleneck that leads to poor performance and power. The same
idea applies for RAM/DDR.

To achieve this, this patch series adds a generic devfreq governor that can
listen to the frequency transitions of each CPU frequency domain and then
adjusts the frequency of the cache (or any devfreq device) based on the
frequency of the CPUs.

To decide the frequency of the device, the governor does one of the
following:

* Uses a CPU frequency to device frequency mapping table
  - Either one mapping table used for all CPU freq policies (typically used
    for system with homogeneous cores/clusters that have the same OPPs.
  - One mapping table per CPU freq policy (typically used for ASMP systems
    with heterogeneous CPUs with different OPPs)

OR

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its max
  frequency.  If the CPUs are running at their min frequency, the device
  runs at its min frequency. And interpolated for frequencies in between.

Since CPUs/clusters can be hotplugged and their policies disables, this
devfreq governor also has to listen to CPU freq policy notifiers for these
events. So, this patch brings back the policy CREATE/REMOVE notifiers.

Saravana Kannan (2):
  Revert "cpufreq: Remove policy create/remove notifiers"
  PM / devfreq: Generic cpufreq governor

 .../bindings/devfreq/devfreq-cpufreq.txt           |  53 ++
 drivers/cpufreq/cpufreq.c                          |  16 +-
 drivers/devfreq/Kconfig                            |   8 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/governor_cpufreq.c                 | 628 +++++++++++++++++++++
 include/linux/cpufreq.h                            |   3 +
 6 files changed, 704 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
 create mode 100644 drivers/devfreq/governor_cpufreq.c

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
