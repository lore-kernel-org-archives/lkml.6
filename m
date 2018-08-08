Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A85C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE993216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE993216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeHHKsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:48:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHHKst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:48:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5442A40241E7;
        Wed,  8 Aug 2018 08:30:11 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-222.ams2.redhat.com [10.36.117.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C53642027047;
        Wed,  8 Aug 2018 08:30:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
Subject: [PATCH v4 0/4] i2c-multi-instantiate pseudo driver
Date:   Wed,  8 Aug 2018 10:30:02 +0200
Message-Id: <20180808083006.31919-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 08:30:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 08:30:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is v4 of my patch-series for dealing with multiple independent i2c
devices being described in a single ACPI fwnode.

Changes in v4:
-Rewrite commit message of first patch as this is NOT a bug fix for
 acpi_is_indirect_io_slave() as I thought at first, it is still necessary
 as a preperation patch for the rest of the series
-MAINTAINER and Kconfig entry fixes
-Some minor coding style fixes

Changes in v3:
-Drop the patch adding the I2C_CLIENT_IGNORE_BUSY flag/hack
-Add patches to make ACPI fwnode-s with affected acpi_ids get enumerated as
 platform device instead of i2c-client
-Change the i2c-multi-instantiate driver to a platform driver

Changes in v2:
-Rebase on 4.18-rc2

Changes in v1:
-Second attempt at dealing with this using a new design where a separate
 driver (which can be build as a module) is used to instantiate the
 i2c-clients instead of modifying the i2c core
-Add an I2C_CLIENT_IGNORE_BUSY flag to make it possible for this driver to bind
 to the client instantiated for the first i2c resource and still create a new
 client using the i2c_client_id for the actual driver for the first resource,
 resulting in 2 clients at the same address (of which one is inactive)

About merging this series, the platform-driver and ACPI patches can be
merged independently of each other, they platform driver relies on the ACPI
changes to gets its platform device instantiated, but if those changes are
not in place yet, nothing bad happens.

So if everyone is happy with this series I suggest that each part gets
merged separately through the relevant trees.

Regards,

Hans

