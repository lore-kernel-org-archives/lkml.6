Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E67C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC736204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC736204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeIMTHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:07:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbeIMTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:07:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9545D0E;
        Thu, 13 Sep 2018 13:58:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 105/197] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
Date:   Thu, 13 Sep 2018 15:30:54 +0200
Message-Id: <20180913131845.745743701@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 5971b0c1594d6c34e257101ed5fdffec65205c50 ]

Since commit 63347db0affa "ACPI / scan: Use acpi_bus_get_status() to
initialize ACPI_TYPE_DEVICE devs" the status field of normal acpi_devices
gets set to 0 by acpi_bus_type_and_status() and filled with its actual
value later when acpi_add_single_object() calls acpi_bus_get_status().

This means that any acpi_match_device_ids() calls in between will always
fail with -ENOENT.

We already have a workaround for this, which temporary forces status to
ACPI_STA_DEFAULT in drivers/acpi/x86/utils.c: acpi_device_always_present()
and the next commit in this series adds another acpi_match_device_ids()
call between status being initialized as 0 and the acpi_bus_get_status()
call.

Rather then adding another workaround, this commit makes
acpi_bus_type_and_status() initialize status to ACPI_STA_DEFAULT, this is
safe to do as the only code looking at status between the initialization
and the acpi_bus_get_status() call is those acpi_match_device_ids() calls.

Note this does mean that we need to (re)set status to 0 in case the
acpi_bus_get_status() call fails.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/scan.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1612,7 +1612,8 @@ static int acpi_add_single_object(struct
 	 * Note this must be done before the get power-/wakeup_dev-flags calls.
 	 */
 	if (type == ACPI_BUS_TYPE_DEVICE)
-		acpi_bus_get_status(device);
+		if (acpi_bus_get_status(device) < 0)
+			acpi_set_device_status(device, 0);
 
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
@@ -1690,7 +1691,7 @@ static int acpi_bus_type_and_status(acpi
 		 * acpi_add_single_object updates this once we've an acpi_device
 		 * so that acpi_bus_get_status' quirk handling can be used.
 		 */
-		*sta = 0;
+		*sta = ACPI_STA_DEFAULT;
 		break;
 	case ACPI_TYPE_PROCESSOR:
 		*type = ACPI_BUS_TYPE_PROCESSOR;


