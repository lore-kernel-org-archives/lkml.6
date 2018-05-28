Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034043AbeE1PN4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033634AbeE1KXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:23:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 205/268] ACPICA: Events: add a return on failure from acpi_hw_register_read
Date: Mon, 28 May 2018 12:02:59 +0200
Message-Id: <20180528100225.483459544@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schmauss <erik.schmauss@intel.com>

[ Upstream commit b4c0de312613ca676db5bd7e696a44b56795612a ]

This ensures that acpi_ev_fixed_event_detect() does not use fixed_status
and and fixed_enable as uninitialized variables.

Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpica/evevent.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -204,6 +204,7 @@ u32 acpi_ev_fixed_event_detect(void)
 	u32 fixed_status;
 	u32 fixed_enable;
 	u32 i;
+	acpi_status status;
 
 	ACPI_FUNCTION_NAME(ev_fixed_event_detect);
 
@@ -211,8 +212,12 @@ u32 acpi_ev_fixed_event_detect(void)
 	 * Read the fixed feature status and enable registers, as all the cases
 	 * depend on their values. Ignore errors here.
 	 */
-	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &fixed_status);
-	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &fixed_enable);
+	status = acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &fixed_status);
+	status |=
+	    acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &fixed_enable);
+	if (ACPI_FAILURE(status)) {
+		return (int_status);
+	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
