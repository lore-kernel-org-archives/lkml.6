Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5FEE6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB9C208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB9C208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeFLDaJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:30:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932757AbeFLDaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C82F8401EF30;
        Tue, 12 Jun 2018 03:30:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C4FF1134CA2;
        Tue, 12 Jun 2018 03:29:44 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com,
        nicolas.pitre@linaro.org, josh@joshtriplett.org,
        fengguang.wu@intel.com, bp@suse.de
Cc:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        dmitry.torokhov@gmail.com, frowand.list@gmail.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
        brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, devel@linuxdriverproject.org,
        linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
        yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
        davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 3/4] resource: add walk_system_ram_res_rev()
Date:   Tue, 12 Jun 2018 11:28:30 +0800
Message-Id: <20180612032831.29747-4-bhe@redhat.com>
In-Reply-To: <20180612032831.29747-1-bhe@redhat.com>
References: <20180612032831.29747-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 12 Jun 2018 03:30:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 12 Jun 2018 03:30:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file code.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index b7456ae889dd..066cc263e2cc 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -279,6 +279,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index ef9a20b75234..3128ac938f38 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -443,6 +445,44 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 }
 
 /*
+ * This function, being a variant of walk_system_ram_res(), calls the @func
+ * callback against all memory ranges of type System RAM which are marked as
+ * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
+ * higher to lower.
+ */
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	unsigned long flags;
+	struct resource *res;
+	int ret = -1;
+
+	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	read_lock(&resource_lock);
+	list_for_each_entry_reverse(res, &iomem_resource.child, sibling) {
+		if (start >= end)
+			break;
+		if ((res->flags & flags) != flags)
+			continue;
+		if (res->desc != IORES_DESC_NONE)
+			continue;
+		if (res->end < start)
+			break;
+
+		if ((res->end >= start) && (res->start < end)) {
+			ret = (*func)(res, arg);
+			if (ret)
+				break;
+		}
+		end = res->start - 1;
+
+	}
+	read_unlock(&resource_lock);
+	return ret;
+}
+
+/*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
  */
-- 
2.13.6

