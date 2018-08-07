Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56066C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9D221888
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9D221888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHGKSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:18:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbeHGKSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:18:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27A878780F;
        Tue,  7 Aug 2018 08:05:43 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AE582166BA2;
        Tue,  7 Aug 2018 08:05:40 +0000 (UTC)
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
Subject: [PATCH v3 0/4] ACPI bugfix + i2c-multi-instantiate pseudo driver
Date:   Tue,  7 Aug 2018 10:05:35 +0200
Message-Id: <20180807080539.17811-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 08:05:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 08:05:43 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

So here is my third attempt at dealing with multiple i2c devices being
described in a single ACPI fwnode.

Like the second attemp This is still based on having a special driver for
these corner cases which can be a module and only loaded when on hardware
which needs this.

New this time around is that this now is a platform driver, avoiding the
need for the I2C_CLIENT_IGNORE_BUSY hack and having 2 i2c-clients at
the address of the first i2c ACPI resource.

While working on the ACPI changes for enumerating ACPI nodes which
are handled by the new i2c-multi-instantiate driver as platform devices
I found a bug caused by a combination of my:
"ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs"
and the somewhat (but not much) later added:
"ACPI / scan: Do not enumerate Indirect IO host children"
commits, specifically the second one does not work because of the first
one, I guess it was tested against a kernel without the first commit.
My changes for enumerating relevant ACPI nodes as platform devices
hit the same problem.

Thus the first patch of this series is an ACPI bugfix for that problem.
The second patch changes acpi/scan.c to enumerate relevant ACPI nodes as
platform devices.
The third patch is an ACPI cleanup patch made possible by the first patch.
All 3 these patches are new in this version of this series.

And finally the fourth patch is the actual i2c-multi-instantiate driver,
now as platform driver living under drivers/platform/x86 .

Regards,

Hans

