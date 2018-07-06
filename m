Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF21423FDC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF21423FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeGFFgD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:36:03 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:37574 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932300AbeGFFgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:36:00 -0400
Received: from localhost.localdomain (pD95EF57F.dip0.t-ipconnect.de [217.94.245.127])
        by mail.bugwerft.de (Postfix) with ESMTPSA id A468728DBF6;
        Fri,  6 Jul 2018 05:35:56 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 0/5] Add devicetree functionality to w1 busses and ds2760
Date:   Fri,  6 Jul 2018 07:35:47 +0200
Message-Id: <20180706053552.11438-1-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains five patches that bring devicetree
functionality to w1 bus masters and slaves in general. As an example,
the ds2760 driver is made aware of devicetree probing. Other drivers
can easily be ported later.

W1 masters scan their bus in order to discover slave devices. Once
one is found, a driver matching the family of the device is instanciated
which handles it. To add devicetree functionality, all that's needed
for now is a call to of_find_matching_node() when a slave device is
attached, so the corresponding of_node pointer is set.

The series also contains a patch that merges the w1 slave driver for the
ds2760 battery monitor into its only user, the ds2760 supply driver.
The indirection with two drivers never had any benefit, and here is
a good opportunity to clean this up.

Patch #1 and #2 add DT bindings documentation
Patch #3 adds the call to of_find_matching_node()
Patch #4 merges the w1 slave and the supply driver for ds2760
Patch #5 makes the ds2760 supply driver aware of DT environments

This works fine on a PXA3xx based board with a battery attached to
the w1-gpio bus master controller.

Changelog:

v3 → v4:
* Property name cleanups
* Dropped maxim,current-accumulator property
* Split 1st patch of v3 in two

v2 → v3:
* Fixed a typo in the documentation and added more real-world
  example for the bindings. Pointed out by Rob Herring.

Daniel Mack (4):
  dt-bindings: w1: document generic onewire and DS2760 bindings
  w1: core: match sub-nodes of bus masters in devicetree
  power: supply: ds2760_battery: merge ds2760 supply driver with its w1
    slave companion
  power: supply: ds2760_battery: add devicetree probing


Daniel Mack (5):
  dt-bindings: w1: document generic onewire bindings
  dt-bindings: w1: document bindings for ds2760 battery monitor
  w1: core: match sub-nodes of bus masters in devicetree
  power: supply: ds2760_battery: merge ds2760 supply driver with its w1
    slave companion
  power: supply: ds2760_battery: add devicetree probing

 .../bindings/power/supply/maxim,ds2760.txt    |  26 ++
 .../devicetree/bindings/w1/w1-gpio.txt        |  11 +-
 Documentation/devicetree/bindings/w1/w1.txt   |  25 ++
 drivers/power/supply/Kconfig                  |   2 +-
 drivers/power/supply/ds2760_battery.c         | 348 +++++++++++++-----
 drivers/w1/slaves/Kconfig                     |  12 -
 drivers/w1/slaves/Makefile                    |   1 -
 drivers/w1/slaves/w1_ds2760.c                 | 175 ---------
 drivers/w1/slaves/w1_ds2760.h                 |  59 ---
 drivers/w1/w1.c                               |   3 +
 include/linux/w1.h                            |   2 +
 11 files changed, 323 insertions(+), 341 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
 delete mode 100644 drivers/w1/slaves/w1_ds2760.c
 delete mode 100644 drivers/w1/slaves/w1_ds2760.h

-- 
2.17.1

