Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF77C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8792086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pdYupuzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8792086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbeIGUNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:13:45 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55207 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbeIGUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:13:44 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 802903F2;
        Fri,  7 Sep 2018 11:32:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 07 Sep 2018 11:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=NMk6PXoQUKoQYta4lntG2iWYQxHrW
        v0r3tp30o9uqpY=; b=pdYupuzsuC4pRdy9NxGFJ0JKRIMk0xSNZpUn4X8oupDvR
        IQAd+KaPSFV1U0slHYXUMmImYfgSKSxUw0c1cD3FOtE3Dyqew/duSC6ElXjxOzMk
        tZYvPvqgCO/PsbS/hqoS3sRrH6yhh/jkQHhQZhyRp/+8brpTJbIrMSIxj8cv7OE3
        hyLOG4lBUUglNL1GUvPau7FH1cDZBsRoV5IuIGGlqdX6rUNkJY0Yl29vzfAXnY/J
        kJKFLDuqNMjDse85HDgHph9x/adEN0pMA4ff/Ik4z3nSx2if4pakovx/i3jzSo2g
        wBCvSNc6GoxKh4A8x2gY+SQ+/hdzlD41IV2hRYezA==
X-ME-Proxy: <xmx:AJqSWxtRjC6IWYn7R5aFb-oSLSaSFNhk16Sn3nfL6SgT6mx7mH_utg>
    <xmx:AJqSW_pYvzl4YDiyOURpd8vokEW9K05lK3HYCJWZzoM2pomqDY-rzw>
    <xmx:AJqSW1p8mTOdm9r9s9dwgtf_JCVpTE_bl7MMcZl0bIwgleDiOE9PNA>
    <xmx:AJqSW-Yezg_Xt8Zh4dWIUWuTi4Rnzkjjr6SciG4M1UKN-hUP48MrvQ>
    <xmx:AJqSWz-sQQ0HLu8JqwCR9hddcnCBhymhlfXFdRyQK7dPzB2IKybjrA>
    <xmx:AZqSW2OHC64A8qs0voD_EoUdXQkCO-rrnpFR-WTzmrtv9bzZqgayRg>
X-ME-Sender: <xms:AJqSW40imRM4VyFj1lypubOUPmUSR566dmbP1WxkoFQ88mC1rMzv6Q>
Received: from localhost.localdomain (ip5b40bfaa.dynamic.kabel-deutschland.de [91.64.191.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id D58BA10292;
        Fri,  7 Sep 2018 11:32:13 -0400 (EDT)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     xen-devel@lists.xenproject.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v2] xen/balloon: add runtime control for scrubbing ballooned out pages
Date:   Fri,  7 Sep 2018 17:31:14 +0200
Message-Id: <20180907153117.17258-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scrubbing pages on initial balloon down can take some time, especially
in nested virtualization case (nested EPT is slow). When HVM/PVH guest is
started with memory= significantly lower than maxmem=, all the extra
pages will be scrubbed before returning to Xen. But since most of them
weren't used at all at that point, Xen needs to populate them first
(from populate-on-demand pool). In nested virt case (Xen inside KVM)
this slows down the guest boot by 15-30s with just 1.5GB needed to be
returned to Xen.

Add runtime parameter to enable/disable it, to allow initially disabling
scrubbing, then enable it back during boot (for example in initramfs).
Such usage relies on assumption that a) most pages ballooned out during
initial boot weren't used at all, and b) even if they were, very few
secrets are in the guest at that time (before any serious userspace
kicks in).
Convert CONFIG_XEN_SCRUB_PAGES to CONFIG_XEN_SCRUB_PAGES_DEFAULT (also
enabled by default), controlling default value for the new runtime
switch.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

---
Changes in v2:
 - move sysfs control to /sys/devices/system/xen_memory
 - use core_param() to avoid confusing prefix for the option name
 - document option
 - change CONFIG_XEN_SCRUB_PAGES to CONFIG_XEN_SCRUB_PAGES_DEFAULT,
 controlling only the default value for the runtime option
---
 .../ABI/stable/sysfs-devices-system-xen_memory         |  9 +++++++++
 Documentation/admin-guide/kernel-parameters.txt        |  6 ++++++
 drivers/xen/Kconfig                                    | 10 +++++++---
 drivers/xen/mem-reservation.c                          |  8 ++++++++
 drivers/xen/xen-balloon.c                              |  3 +++
 include/xen/mem-reservation.h                          |  7 ++++---
 6 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-system-xen_memory b/Documentation/ABI/stable/sysfs-devices-system-xen_memory
index caa311d59ac1..6d83f95a8a8e 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-xen_memory
+++ b/Documentation/ABI/stable/sysfs-devices-system-xen_memory
@@ -75,3 +75,12 @@ Contact:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 Description:
 		Amount (in KiB) of low (or normal) memory in the
 		balloon.
+
+What:		/sys/devices/system/xen_memory/xen_memory0/scrub_pages
+Date:		September 2018
+KernelVersion:	4.20
+Contact:	xen-devel@lists.xenproject.org
+Description:
+		Control scrubbing pages before returning them to Xen for others domains
+		use. Can be set with xen_scrub_pages cmdline
+		parameter. Default value controlled with CONFIG_XEN_SCRUB_PAGES_DEFAULT.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..0f20282629de 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4994,6 +4994,12 @@
 			Disables the PV optimizations forcing the HVM guest to
 			run as generic HVM guest with no PV drivers.
 
+	xen_scrub_pages=	[XEN]
+			Boolean option to control scrubbing pages before giving them back
+			to Xen, for use by other domains. Can be also changed at runtime
+			with /sys/devices/system/xen_memory/xen_memory0/scrub_pages.
+			Default value controlled with CONFIG_XEN_SCRUB_PAGES_DEFAULT.
+
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b459edfacff3..90d387b50ab7 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -79,15 +79,19 @@ config XEN_BALLOON_MEMORY_HOTPLUG_LIMIT
 	  This value is used to allocate enough space in internal
 	  tables needed for physical memory administration.
 
-config XEN_SCRUB_PAGES
-	bool "Scrub pages before returning them to system"
+config XEN_SCRUB_PAGES_DEFAULT
+	bool "Scrub pages before returning them to system by default"
 	depends on XEN_BALLOON
 	default y
 	help
 	  Scrub pages before returning them to the system for reuse by
 	  other domains.  This makes sure that any confidential data
 	  is not accidentally visible to other domains.  Is it more
-	  secure, but slightly less efficient.
+	  secure, but slightly less efficient. This can be controlled with
+	  xen_scrub_pages=0 parameter and
+	  /sys/devices/system/xen_memory/xen_memory0/scrub_pages.
+	  This option only sets the default value.
+
 	  If in doubt, say yes.
 
 config XEN_DEV_EVTCHN
diff --git a/drivers/xen/mem-reservation.c b/drivers/xen/mem-reservation.c
index 084799c6180e..14276e2d76fe 100644
--- a/drivers/xen/mem-reservation.c
+++ b/drivers/xen/mem-reservation.c
@@ -14,6 +14,14 @@
 
 #include <xen/interface/memory.h>
 #include <xen/mem-reservation.h>
+#include <linux/moduleparam.h>
+
+#ifdef CONFIG_XEN_SCRUB_PAGES_DEFAULT
+bool __read_mostly xen_scrub_pages = true;
+#else
+bool __read_mostly xen_scrub_pages = false;
+#endif
+core_param(xen_scrub_pages, xen_scrub_pages, bool, 0);
 
 /*
  * Use one extent per PAGE_SIZE to avoid to break down the page into
diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index 294f35ce9e46..63c1494a8d73 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -44,6 +44,7 @@
 #include <xen/xenbus.h>
 #include <xen/features.h>
 #include <xen/page.h>
+#include <xen/mem-reservation.h>
 
 #define PAGES2KB(_p) ((_p)<<(PAGE_SHIFT-10))
 
@@ -137,6 +138,7 @@ static DEVICE_ULONG_ATTR(schedule_delay, 0444, balloon_stats.schedule_delay);
 static DEVICE_ULONG_ATTR(max_schedule_delay, 0644, balloon_stats.max_schedule_delay);
 static DEVICE_ULONG_ATTR(retry_count, 0444, balloon_stats.retry_count);
 static DEVICE_ULONG_ATTR(max_retry_count, 0644, balloon_stats.max_retry_count);
+static DEVICE_BOOL_ATTR(scrub_pages, 0644, xen_scrub_pages);
 
 static ssize_t show_target_kb(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -203,6 +205,7 @@ static struct attribute *balloon_attrs[] = {
 	&dev_attr_max_schedule_delay.attr.attr,
 	&dev_attr_retry_count.attr.attr,
 	&dev_attr_max_retry_count.attr.attr,
+	&dev_attr_scrub_pages.attr.attr,
 	NULL
 };
 
diff --git a/include/xen/mem-reservation.h b/include/xen/mem-reservation.h
index 80b52b4945e9..a2ab516fcd2c 100644
--- a/include/xen/mem-reservation.h
+++ b/include/xen/mem-reservation.h
@@ -17,11 +17,12 @@
 
 #include <xen/page.h>
 
+extern bool xen_scrub_pages;
+
 static inline void xenmem_reservation_scrub_page(struct page *page)
 {
-#ifdef CONFIG_XEN_SCRUB_PAGES
-	clear_highpage(page);
-#endif
+	if (xen_scrub_pages)
+		clear_highpage(page);
 }
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
-- 
2.17.1

