Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755438AbeEHRtI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:49:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeEHRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:49:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FC516085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 0/4] drivers/thermal: support for multiple TZ for sensor
Date: Tue,  8 May 2018 11:48:55 -0600
Message-Id: <20180508174859.26539-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt at introducing multiple thermal zones for each thermal
sensor. The usecase behind this is that, a sensor may involved in monitoring a
region that could have different mitigative actions. For example, a sensor
placed between audio and camera IP, will involve different mitigative actions
on these blocks. Sometimes it is also desirable to employ different governors
and different mitigative strategies for the same sensor. For example, using
step-wise governor for temperatures > 0 and a userspace governor for
temperatures < 0 degC.

The idea presented in this patchset involves linking thermal zones together
that share the same underlying sensor. The sensor still interacts with one
thermal zone that we deem as the primary thermal sensor. The low thresholds set
on a sensor is the max of min thresholds for the high trip threshold while the
low trip thresholds for the sensor is the min of max thresholds from the
different thermal zones of the sensor around the current sensor temperature.
When the sensor temperature crosses the threshold, the thermal zone is notified
and the new thresholds is evaluated again.

These patches continue to return a struct thermal_zone * back to the sensor
when the sensor registers. While this prevents breaking the existing
interaction, it is not very clean and optimal. This is something to think about
as we review the patches. The breakdown of the patches in this set is -

- Patch #1 refactors the current data structures to help with the new support
- Patch #2 allows probing and set up of multiple thermal zones when a sensor is
  registered.
- Patch #3 aggregates across multiple thermal zones to figure out the mitigation
  and set new thresholds on the sensor. Sensor low and high thresholds are set
  based on thresholds from any thermal zone of the sensor.
- Patch #4 notifies the framework and the related thermal zones when the sensor
  is tripped

Please consider reviewing these patches. We have seen benefits of this idea and
is implemented and used in mobile products.

Lina Iyer (4):
  drivers: of-thermal: abstract sensor related information
  drivers: of-thermal: allow multiple thermal zones for a sensor
  drivers: of-thermal: aggregate sensor trips across thermal zones
  drivers: of-thermal: notify framework when sensor is tripped

 drivers/thermal/of-thermal.c      | 205 ++++++++++++++++++++++++++----
 drivers/thermal/thermal_helpers.c |  37 +++---
 include/linux/thermal.h           |  10 ++
 3 files changed, 209 insertions(+), 43 deletions(-)

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
