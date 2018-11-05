Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B8C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231022085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231022085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeKFATi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:19:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:50023 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKFATi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:19:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 06:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="105410053"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2018 06:59:29 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/6] device property: Introducing software nodes
Date:   Mon,  5 Nov 2018 17:59:22 +0300
Message-Id: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the final version of my proposal for the "software nodes".
I've dropped the property sysfs group as agreed (with Andy). We'll add
it separately once we've agreed on the output format.

The original RFC can be checked from here:
https://lkml.org/lkml/2018/10/12/518

And this was the origin commit message:

To continue the discussion started by Dmitry [1], this is my proposal
that I mentioned in my last mail. In short, the idea is that instead
of trying to extend the support for the currently used struct
property_set, I'm proposing that we introduce a completely new,
independent type of fwnode, and replace the struct property_set with
it. I'm calling the type "software node" here.

The reason for a complete separation of the software nodes from the
generic property handling code is the need to be able to create the
nodes independently from the devices that they are bind to.

The way this works is that every node that is created will have a
kobject registered. That will take care the ref counting for us, and
also allow us to for example display the properties in sysfs.

There are a few more details in patch 3/5 about the software nodes in
the commit message.

[1] https://lkml.org/lkml/2018/9/17/1067

--
heikki


Heikki Krogerus (6):
  driver core: platform: Remove duplicated device_remove_properties()
    call
  drivers core: Prepare support for multiple platform notifications
  ACPI / glue: Add acpi_platform_notify() function
  drivers: base: Introducing software nodes to the firmware node
    framework
  device property: Move device_add_properties() to swnode.c
  device property: Remove struct property_set

 .../ABI/testing/sysfs-devices-software_node   |  10 +
 drivers/acpi/bus.c                            |   1 -
 drivers/acpi/glue.c                           |  21 +-
 drivers/acpi/internal.h                       |   1 -
 drivers/base/Makefile                         |   2 +-
 drivers/base/core.c                           |  34 +-
 drivers/base/platform.c                       |   1 -
 drivers/base/property.c                       | 525 +-------------
 drivers/base/swnode.c                         | 677 ++++++++++++++++++
 include/linux/acpi.h                          |  10 +
 include/linux/property.h                      |  12 +
 11 files changed, 774 insertions(+), 520 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-software_node
 create mode 100644 drivers/base/swnode.c

-- 
2.19.1

