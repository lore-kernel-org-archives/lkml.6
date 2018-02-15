Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756535AbeBOXB4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:01:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756495AbeBOXBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:01:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 716D26079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
To: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, cme@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, rananta@codeaurora.org, skannan@codeaurora.org
Subject: [PATCH 0/1] perf: Add CPU hotplug support for events
Date: Thu, 15 Feb 2018 15:01:40 -0800
Message-Id: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The embedded world, specifically Android mobile SoCs, rely on CPU
hotplugs to manage power and thermal constraints. These hotplugs
can happen at a very rapid pace. Adjacently, they also relies on
many perf event counters for its management. Therefore, there is
a need to preserve these events across hotplugs.

In such a scenario, a perf client (kernel or user-space) can create
events even when the CPU is offline. If the CPU comes online during
the lifetime of the event, the registered event can start counting
spontaneously. As an extension to this, the events' count can also
be preserved across CPU hotplugs. This takes the burden off of the
clients to monitor the state of the CPU.

The tests were conducted on x86_64 PC. Sample results:
/* CPU-1 is offline: Event created when CPU is offline */
# ./perf stat -C 1 -e cycles -v -I 1000
Using CPUID GenuineIntel-6-5E
cycles: 0 0 0
#           time             counts unit events
     1.000143727      <not counted>      cycles
cycles: 0 0 0
     2.000309394      <not counted>      cycles
cycles: 0 0 0
     3.000466412      <not counted>      cycles
cycles: 0 0 0
     4.000599885      <not counted>      cycles
cycles: 0 0 0
     5.000750095      <not counted>      cycles
cycles: 0 0 0
     6.000901789      <not counted>      cycles
cycles: 0 0 0
     7.001035315      <not counted>      cycles
cycles: 0 0 0
     8.001195270      <not counted>      cycles

/* CPU-1 made online: Event started counting */

cycles: 21046256 719464572 719464572
     9.001379820         21,046,256      cycles
cycles: 19537953 1000222653 1000222653
    10.001634052         19,537,953      cycles
cycles: 27480135 1000095468 1000095468
    11.001764556         27,480,135      cycles
cycles: 27723233 1000108008 1000108008
    12.001909310         27,723,233      cycles
cycles: 19137349 1000133462 1000133462
    13.002079041         19,137,349      cycles
cycles: 48913285 1000101268 1000101268
    14.002218928         48,913,285      cycles
cycles: 27259199 1000128972 1000128972
    15.002388700         27,259,199      cycles
cycles: 19249055 1000095789 1000095789
    16.002514765         19,249,055      cycles
cycles: 27530051 1000246860 1000246860
    17.002801610         27,530,051      cycles
cycles: 34348072 1000272874 1000272874
    18.003110100         34,348,072      cycles
cycles: 11526457 107984264 107984264
    19.003435811         11,526,457      cycles

/* CPU-1 made offline */

cycles: 0 0 0
    20.003582803      <not counted>      cycles
cycles: 0 0 0
    21.003896484      <not counted>      cycles
cycles: 0 0 0
    22.004212989      <not counted>      cycles
cycles: 0 0 0
    23.004346689      <not counted>      cycles
cycles: 0 0 0
    24.004668259      <not counted>      cycles
cycles: 0 0 0
    25.004983504      <not counted>      cycles
cycles: 0 0 0
#           time             counts unit events
    26.005315741      <not counted>      cycles

/* CPU-1 made online: Event preserved across hotplug */

cycles: 27210082 933493459 933493459
    27.005652287         27,210,082      cycles
cycles: 41950431 1000112865 1000112865
    28.005805475         41,950,431      cycles
cycles: 35075124 1000141146 1000141146
    29.005974101         35,075,124      cycles
cycles: 45240055 1000132743 1000132743
    30.006140008         45,240,055      cycles
cycles: 43426180 1000077828 1000077828
    31.006253035         43,426,180      cycles
cycles: 34593167 1000315835 1000315835
    32.006605393         34,593,167      cycles
cycles: 105078270 1000136171 1000136171
    33.006773971        105,078,270      cycles

Raghavendra Rao Ananta (1):
  perf: Add CPU hotplug support for events

 include/linux/perf_event.h |   7 +++
 kernel/events/core.c       | 123 +++++++++++++++++++++++++++++++++------------
 2 files changed, 97 insertions(+), 33 deletions(-)

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
