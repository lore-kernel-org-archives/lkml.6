Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8085DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A549218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfBFRD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:03:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55516 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbfBFRD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:03:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74766EBD;
        Wed,  6 Feb 2019 09:03:58 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40E853F675;
        Wed,  6 Feb 2019 09:03:57 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, mhocko@kernel.org, akpm@linux-foundation.org
Subject: [PATCH] mm/memory-hotplug: Add sysfs hot-remove trigger
Date:   Wed,  6 Feb 2019 17:03:53 +0000
Message-Id: <29ed519902512319bcc62e071d52b712fa97e306.1549469965.git.robin.murphy@arm.com>
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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

This is inspired by a previous proposal[1], but in coming up with a
more robust interface I ended up rewriting the whole thing from
scratch. The lack of documentation is semi-deliberate, since I don't
like the idea of anyone actually relying on this interface as ABI, but
as a handy tool it felt useful enough to be worth sharing :)

Robin.

[1] https://lore.kernel.org/lkml/22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com/

 drivers/base/memory.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 048cbf7d5233..26344cb9f045 100644
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
+	if (mem->state != MEM_OFFLINE)
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

