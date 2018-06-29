Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A0C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7D4278EA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7D4278EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934469AbeF2Rbq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:31:46 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:41168 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934162AbeF2Rbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:31:45 -0400
Received: from localhost.localdomain (pD95EF0F3.dip0.t-ipconnect.de [217.94.240.243])
        by mail.bugwerft.de (Postfix) with ESMTPSA id B56AF28C411;
        Fri, 29 Jun 2018 17:28:28 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 0/4] Add devicetree functionality to w1 busses and ds2760
Date:   Fri, 29 Jun 2018 19:31:33 +0200
Message-Id: <20180629173137.12690-1-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains four small patches that bring devicetree
functionality to w1 bus masters and slaves in general. As an example,
the DS2760 driver is made aware of devicetree nodes as an example.
Other drivers can easily be ported later.

W1 masters scan their bus in order to discover slave devices. Once
one is found, a driver matching the family of the device is instanciated
which handles it.

All that's needed for now is a call to of_find_matching_node() when
a slave device is attached, so the corresponding of_node pointer is
set.

The series also contains a patch that merges the w1 slave driver for the
DS2760 battery monitor into its only user, the ds2760 supply driver.
The indirection with two drivers never had any benefit, and here is
a good opportunity to clean this up.

Patch #1 adds some DT bindings documentation
Patch #2 adds the call to of_find_matching_node()
Patch #3 merges the w1 slave and the supply driver for ds2760
Patch #4 makes the ds2760 supply driver aware of DT environments

This works fine on a PXA3xx based board with a battery attached to
the w1-gpio bus master controller.

Daniel Mack (4):
  dt-bindings: w1: document sub-node bindings for DS2760
  w1: core: match sub-nodes of bus masters in devicetree
  w1: ds2760: add devicetree matching glue
  power: ds2760_battery: add device tree glue

 .../devicetree/bindings/w1/maxim,ds2760.txt    | 15 +++++++++++++++
 .../devicetree/bindings/w1/w1-gpio.txt         |  6 ++++++
 Documentation/devicetree/bindings/w1/w1.txt    | 18 ++++++++++++++++++
 drivers/power/supply/ds2760_battery.c          |  6 +++++-
 drivers/w1/slaves/w1_ds2760.c                  |  9 +++++++++
 drivers/w1/w1.c                                |  3 +++
 include/linux/w1.h                             |  2 ++
 7 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/w1/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

-- 
2.17.1

