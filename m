Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB63AC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E762089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E762089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJAEim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:38:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48558 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeJAEim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:38:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DBDF6260A8A
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Milo Kim <milo.kim@ti.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Breck <kernel@networkimprov.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 00/14] power: supply: Fix custom sysfs attribute registration
Date:   Mon,  1 Oct 2018 00:03:35 +0200
Message-Id: <20180930220349.10515-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Udev may not detect sysfs attributes, that have been added
after the device has been created. Code doing that is racy [0].
The power-supply class properly registers its attributes
when the device is created, but some drivers add additional
custom attributes in a racy way.

The first patch from this series adds native support for custom
sysfs attributes to the power-supply subsystem. This feature
allows cleaner code and avoids a race condition preventing udev
from noticing the custom properties.

The following patches replace all instances of sysfs_create_*
in drivers/power/supply to use the new feature and a couple
of small cleanups.

TL;DR: This patchsets replaces all sysfs_create_* in power-supply.

[0] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

-- Sebastian

Sebastian Reichel (14):
  power: supply: core: add support for custom sysfs attributes
  power: supply: bq2415x: fix race-condition in sysfs registration
  power: supply: ds2780: fix race-condition in sysfs registration
  power: supply: ds2781: fix race-condition in sysfs registration
  power: supply: lp8788: fix race-condition in sysfs registration
  power: supply: bq24190_charger: fix race-condition in sysfs
    registration
  power: supply: bq24257: fix race-condition in sysfs registration
  power: supply: charger-manager: simplify generation of sysfs attribute
    group name
  power: supply: charger-manager: fix race-condition in sysfs
    registration
  power: supply: pcf50633: fix race-condition in sysfs registration
  power: supply: ds2780: fix race-condition in bin attribute
    registration
  power: supply: ds2781: fix race-condition in bin attribute
    registration
  power: supply: ds2780: switch to devm_power_supply_register
  power: supply: ds2781: switch to devm_power_supply_register

 drivers/power/supply/bq2415x_charger.c   | 119 ++++++++++-------------
 drivers/power/supply/bq24190_charger.c   |  43 ++------
 drivers/power/supply/bq24257_charger.c   |  15 +--
 drivers/power/supply/charger-manager.c   |  62 +++++-------
 drivers/power/supply/ds2780_battery.c    |  87 +++++------------
 drivers/power/supply/ds2781_battery.c    |  82 +++++-----------
 drivers/power/supply/lp8788-charger.c    |  62 +++++-------
 drivers/power/supply/pcf50633-charger.c  |  17 ++--
 drivers/power/supply/power_supply_core.c |   1 +
 include/linux/power/charger-manager.h    |   3 +-
 include/linux/power_supply.h             |   3 +
 11 files changed, 172 insertions(+), 322 deletions(-)

-- 
2.19.0

