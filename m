Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D531CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1220849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE1220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeGFGDr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:03:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933171AbeGFFt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:49:57 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14BC286A;
        Fri,  6 Jul 2018 05:49:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.14 05/61] acpi: Add helper for deactivating memory region
Date:   Fri,  6 Jul 2018 07:46:29 +0200
Message-Id: <20180706054712.532097408@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit d2d2e3c46be5d6dd8001d0eebdf7cafb9bc7006b upstream.

Sometimes memory resource may be overlapping with
SystemMemory Operation Region by design, for example if the
memory region is used as a mailbox for communication with a
firmware in the system. One occasion of such mailboxes is
USB Type-C Connector System Software Interface (UCSI).

With regions like that, it is important that the driver is
able to map the memory with the requirements it has. For
example, the driver should be allowed to map the memory as
non-cached memory. However, if the operation region has been
accessed before the driver has mapped the memory, the memory
has been marked as write-back by the time the driver is
loaded. That means the driver will fail to map the memory
if it expects non-cached memory.

To work around the problem, introducing helper that the
drivers can use to temporarily deactivate (unmap)
SystemMemory Operation Regions that overlap with their
IO memory.

Fixes: 8243edf44152 ("usb: typec: ucsi: Add ACPI driver")
Cc: stable@vger.kernel.org
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/osl.c   |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |    3 ++
 2 files changed, 75 insertions(+)

--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -45,6 +45,8 @@
 #include <linux/uaccess.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
+#include "acpica/accommon.h"
+#include "acpica/acnamesp.h"
 #include "internal.h"
 
 #define _COMPONENT		ACPI_OS_SERVICES
@@ -1477,6 +1479,76 @@ int acpi_check_region(resource_size_t st
 }
 EXPORT_SYMBOL(acpi_check_region);
 
+static acpi_status acpi_deactivate_mem_region(acpi_handle handle, u32 level,
+					      void *_res, void **return_value)
+{
+	struct acpi_mem_space_context **mem_ctx;
+	union acpi_operand_object *handler_obj;
+	union acpi_operand_object *region_obj2;
+	union acpi_operand_object *region_obj;
+	struct resource *res = _res;
+	acpi_status status;
+
+	region_obj = acpi_ns_get_attached_object(handle);
+	if (!region_obj)
+		return AE_OK;
+
+	handler_obj = region_obj->region.handler;
+	if (!handler_obj)
+		return AE_OK;
+
+	if (region_obj->region.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		return AE_OK;
+
+	if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE))
+		return AE_OK;
+
+	region_obj2 = acpi_ns_get_secondary_object(region_obj);
+	if (!region_obj2)
+		return AE_OK;
+
+	mem_ctx = (void *)&region_obj2->extra.region_context;
+
+	if (!(mem_ctx[0]->address >= res->start &&
+	      mem_ctx[0]->address < res->end))
+		return AE_OK;
+
+	status = handler_obj->address_space.setup(region_obj,
+						  ACPI_REGION_DEACTIVATE,
+						  NULL, (void **)mem_ctx);
+	if (ACPI_SUCCESS(status))
+		region_obj->region.flags &= ~(AOPOBJ_SETUP_COMPLETE);
+
+	return status;
+}
+
+/**
+ * acpi_release_memory - Release any mappings done to a memory region
+ * @handle: Handle to namespace node
+ * @res: Memory resource
+ * @level: A level that terminates the search
+ *
+ * Walks through @handle and unmaps all SystemMemory Operation Regions that
+ * overlap with @res and that have already been activated (mapped).
+ *
+ * This is a helper that allows drivers to place special requirements on memory
+ * region that may overlap with operation regions, primarily allowing them to
+ * safely map the region as non-cached memory.
+ *
+ * The unmapped Operation Regions will be automatically remapped next time they
+ * are called, so the drivers do not need to do anything else.
+ */
+acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
+				u32 level)
+{
+	if (!(res->flags & IORESOURCE_MEM))
+		return AE_TYPE;
+
+	return acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
+				   acpi_deactivate_mem_region, NULL, res, NULL);
+}
+EXPORT_SYMBOL_GPL(acpi_release_memory);
+
 /*
  * Let drivers know whether the resource checks are effective
  */
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -441,6 +441,9 @@ int acpi_check_resource_conflict(const s
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 
+acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
+				u32 level);
+
 int acpi_resources_are_enforced(void);
 
 #ifdef CONFIG_HIBERNATION


