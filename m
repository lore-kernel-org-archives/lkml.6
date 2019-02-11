Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA35C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776E2218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfBKRuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:50:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfBKRuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:50:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CBD7EBD;
        Mon, 11 Feb 2019 09:50:51 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA2C33F675;
        Mon, 11 Feb 2019 09:50:49 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, mhocko@kernel.org, akpm@linux-foundation.org,
        osalvador@suse.de
Subject: [PATCH v2] mm/memory-hotplug: Add sysfs hot-remove trigger
Date:   Mon, 11 Feb 2019 17:50:46 +0000
Message-Id: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
but being able to exercise the (arguably trickier) hot-remove path would
be even more useful. Extend the feature to allow removal of offline
sections to be triggered manually to aid development.

Since process dictates the new sysfs entry be documented, let's also
document the existing probe entry to match - better 13-and-a-half years
late than never, as they say...

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Use is_memblock_offlined() helper, write up documentation

 .../ABI/testing/sysfs-devices-memory          | 25 +++++++++++
 drivers/base/memory.c                         | 42 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index deef3b5723cf..02a4250964e0 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -91,3 +91,28 @@ Description:
 		memory section directory.  For example, the following symbolic
 		link is created for memory section 9 on node0.
 		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+
+What:		/sys/devices/system/memory/probe
+Date:		October 2005
+Contact:	Linux Memory Management list <linux-mm@kvack.org>
+Description:
+		The file /sys/devices/system/memory/probe is write-only, and
+		when written will simulate a physical hot-add of a memory
+		section at the given address. For example, assuming a section
+		of unused memory exists at physical address 0x80000000, it can
+		be introduced to the kernel with the following command:
+		# echo 0x80000000 > /sys/devices/system/memory/probe
+Users:		Memory hotplug testing and development
+
+What:		/sys/devices/system/memory/memoryX/remove
+Date:		February 2019
+Contact:	Linux Memory Management list <linux-mm@kvack.org>
+Description:
+		The file /sys/devices/system/memory/memoryX/remove is
+		write-only, and when written with a boolean 'true' value will
+		simulate a physical hot-remove of that memory section. For
+		example, assuming a 1GB section size, the section added by the
+		above "probe" example could be removed again with the following
+		command:
+		# echo 1 > /sys/devices/system/memory/memory2/remove
+Users:		Memory hotplug testing and development
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 048cbf7d5233..1ba9d1a6ba5e 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -521,7 +521,44 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
 }
 
 static DEVICE_ATTR_WO(probe);
-#endif
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct memory_block *mem = to_memory_block(dev);
+	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
+	bool remove;
+	int ret;
+
+	ret = kstrtobool(buf, &remove);
+	if (ret)
+		return ret;
+	if (!remove)
+		return count;
+
+	if (!is_memblock_offlined(mem))
+		return -EBUSY;
+
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
+	if (device_remove_file_self(dev, attr)) {
+		__remove_memory(pfn_to_nid(start_pfn), PFN_PHYS(start_pfn),
+				MIN_MEMORY_BLOCK_SIZE * sections_per_block);
+		ret = count;
+	} else {
+		ret = -EBUSY;
+	}
+
+	unlock_device_hotplug();
+	return ret;
+}
+
+static DEVICE_ATTR_WO(remove);
+#endif /* CONFIG_MEMORY_HOTREMOVE */
+#endif /* CONFIG_ARCH_MEMORY_PROBE */
 
 #ifdef CONFIG_MEMORY_FAILURE
 /*
@@ -615,6 +652,9 @@ static struct attribute *memory_memblk_attrs[] = {
 	&dev_attr_removable.attr,
 #ifdef CONFIG_MEMORY_HOTREMOVE
 	&dev_attr_valid_zones.attr,
+#ifdef CONFIG_ARCH_MEMORY_PROBE
+	&dev_attr_remove.attr,
+#endif
 #endif
 	NULL
 };
-- 
2.20.1.dirty

