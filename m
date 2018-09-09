Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473B4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92873204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92873204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeIJCdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 22:33:46 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:42549 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeIJCdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 22:33:45 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D311C2800B3CC;
        Sun,  9 Sep 2018 23:42:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5443EE542; Sun,  9 Sep 2018 23:42:40 +0200 (CEST)
Message-Id: <cover.1536517047.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 9 Sep 2018 23:42:01 +0200
Subject: [PATCH 0/5] Thunderbolt material for v4.20
To:     Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt material for v4.20, comprising:

* A fix to skip disabled ports on tunnel establishment.  I am not aware
  that this has caused breakage in the real world so far, so no need to
  apply to v4.19 or backport to stable.

* Obtain PCI slot number from DROM and use it to correlate PCI devices
  with Thunderbolt ports.

* I am nominating myself as co-maintainer, see commit message for the
  reasons.

Regarding the driver's verbosity which Stephen Hemminger and Mika
Westerberg have taken exception to:

* Patch [2/5] logs the PCI slot number as well as data whose purpose is
  unknown at KERN_INFO severity.  I am not opposed to log the former at
  KERN_DEBUG severity, but the latter must stay at KERN_INFO to allow us
  to collect the data of various Thunderbolt devices in the wild and
  reverse-engineer its meaning.  If Intel divulges the data's meaning then
  it need no longer be dumped.  This would be ideal for everyone involved.

* Patch [4/5] logs a message at KERN_INFO severity whenever a PCI device
  correlates or no longer correlates with a Thunderbolt port.  I am not
  opposed to toning this down to KERN_DEBUG, subject to the introduction
  of tb_port_dbg().

Thanks,

Lukas


Lukas Wunner (5):
  thunderbolt: Skip disabled ports on tunnel establishment
  thunderbolt: Obtain PCI slot number from DROM
  thunderbolt: Move upstream_port to struct tb
  thunderbolt: Correlate PCI devices with Thunderbolt ports
  MAINTAINERS: Add Lukas Wunner as co-maintainer of thunderbolt

 MAINTAINERS                       |   1 +
 drivers/thunderbolt/Makefile      |   2 +-
 drivers/thunderbolt/adapter_pci.c | 166 ++++++++++++++++++++++++++++++
 drivers/thunderbolt/adapter_pci.h |  19 ++++
 drivers/thunderbolt/domain.c      |  12 +++
 drivers/thunderbolt/eeprom.c      |  21 ++++
 drivers/thunderbolt/icm.c         |  65 +++---------
 drivers/thunderbolt/switch.c      |  14 ++-
 drivers/thunderbolt/tb.c          |  23 ++---
 drivers/thunderbolt/tb.h          |  45 ++++++++
 include/linux/thunderbolt.h       |   2 +
 11 files changed, 305 insertions(+), 65 deletions(-)
 create mode 100644 drivers/thunderbolt/adapter_pci.c
 create mode 100644 drivers/thunderbolt/adapter_pci.h

-- 
2.18.0

