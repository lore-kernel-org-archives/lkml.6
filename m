Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9553214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9553214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLCLQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:16:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCLQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:16:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D33D30015FE;
        Mon,  3 Dec 2018 11:16:16 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE66B5C23A;
        Mon,  3 Dec 2018 11:16:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1] drivers/base/memory.c: Use DEVICE_ATTR_RO and friends
Date:   Mon,  3 Dec 2018 12:16:11 +0100
Message-Id: <20181203111611.10633-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 03 Dec 2018 11:16:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the easier to read (and not mess up) variants:
- Use DEVICE_ATTR_RO
- Use DEVICE_ATTR_WO
- Use DEVICE_ATTR_RW
instead of the more generic DEVICE_ATTR() we're using right now.

We have to rename most callback functions. By fixing the intendations we
can even save some LOCs.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c | 79 ++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 0c290f86ab20..c9c1ee564edb 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -109,8 +109,8 @@ static unsigned long get_memory_block_size(void)
  * uses.
  */
 
-static ssize_t show_mem_start_phys_index(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t phys_index_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
 	unsigned long phys_index;
@@ -122,8 +122,8 @@ static ssize_t show_mem_start_phys_index(struct device *dev,
 /*
  * Show whether the section of memory is likely to be hot-removable
  */
-static ssize_t show_mem_removable(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	unsigned long i, pfn;
 	int ret = 1;
@@ -146,8 +146,8 @@ static ssize_t show_mem_removable(struct device *dev,
 /*
  * online, offline, going offline, etc.
  */
-static ssize_t show_mem_state(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
 	ssize_t len = 0;
@@ -286,7 +286,7 @@ static int memory_subsys_online(struct device *dev)
 		return 0;
 
 	/*
-	 * If we are called from store_mem_state(), online_type will be
+	 * If we are called from state_store(), online_type will be
 	 * set >= 0 Otherwise we were called from the device online
 	 * attribute and need to set the online_type.
 	 */
@@ -315,9 +315,8 @@ static int memory_subsys_offline(struct device *dev)
 	return memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
 }
 
-static ssize_t
-store_mem_state(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t state_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct memory_block *mem = to_memory_block(dev);
 	int ret, online_type;
@@ -374,7 +373,7 @@ store_mem_state(struct device *dev,
  * s.t. if I offline all of these sections I can then
  * remove the physical device?
  */
-static ssize_t show_phys_device(struct device *dev,
+static ssize_t phys_device_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
@@ -395,7 +394,7 @@ static void print_allowed_zone(char *buf, int nid, unsigned long start_pfn,
 	}
 }
 
-static ssize_t show_valid_zones(struct device *dev,
+static ssize_t valid_zones_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
@@ -435,33 +434,31 @@ static ssize_t show_valid_zones(struct device *dev,
 
 	return strlen(buf);
 }
-static DEVICE_ATTR(valid_zones, 0444, show_valid_zones, NULL);
+static DEVICE_ATTR_RO(valid_zones);
 #endif
 
-static DEVICE_ATTR(phys_index, 0444, show_mem_start_phys_index, NULL);
-static DEVICE_ATTR(state, 0644, show_mem_state, store_mem_state);
-static DEVICE_ATTR(phys_device, 0444, show_phys_device, NULL);
-static DEVICE_ATTR(removable, 0444, show_mem_removable, NULL);
+static DEVICE_ATTR_RO(phys_index);
+static DEVICE_ATTR_RW(state);
+static DEVICE_ATTR_RO(phys_device);
+static DEVICE_ATTR_RO(removable);
 
 /*
  * Block size attribute stuff
  */
-static ssize_t
-print_block_size(struct device *dev, struct device_attribute *attr,
-		 char *buf)
+static ssize_t block_size_bytes_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%lx\n", get_memory_block_size());
 }
 
-static DEVICE_ATTR(block_size_bytes, 0444, print_block_size, NULL);
+static DEVICE_ATTR_RO(block_size_bytes);
 
 /*
  * Memory auto online policy.
  */
 
-static ssize_t
-show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
-			char *buf)
+static ssize_t auto_online_blocks_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
 	if (memhp_auto_online)
 		return sprintf(buf, "online\n");
@@ -469,9 +466,9 @@ show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
 		return sprintf(buf, "offline\n");
 }
 
-static ssize_t
-store_auto_online_blocks(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
+static ssize_t auto_online_blocks_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
 {
 	if (sysfs_streq(buf, "online"))
 		memhp_auto_online = true;
@@ -483,8 +480,7 @@ store_auto_online_blocks(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(auto_online_blocks, 0644, show_auto_online_blocks,
-		   store_auto_online_blocks);
+static DEVICE_ATTR_RW(auto_online_blocks);
 
 /*
  * Some architectures will have custom drivers to do this, and
@@ -493,9 +489,8 @@ static DEVICE_ATTR(auto_online_blocks, 0644, show_auto_online_blocks,
  * and will require this interface.
  */
 #ifdef CONFIG_ARCH_MEMORY_PROBE
-static ssize_t
-memory_probe_store(struct device *dev, struct device_attribute *attr,
-		   const char *buf, size_t count)
+static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	u64 phys_addr;
 	int nid, ret;
@@ -525,7 +520,7 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 	return ret;
 }
 
-static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
+static DEVICE_ATTR_WO(probe);
 #endif
 
 #ifdef CONFIG_MEMORY_FAILURE
@@ -534,10 +529,9 @@ static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
  */
 
 /* Soft offline a page */
-static ssize_t
-store_soft_offline_page(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t soft_offline_page_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
 {
 	int ret;
 	u64 pfn;
@@ -553,10 +547,9 @@ store_soft_offline_page(struct device *dev,
 }
 
 /* Forcibly offline a page, including killing processes. */
-static ssize_t
-store_hard_offline_page(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t hard_offline_page_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
 {
 	int ret;
 	u64 pfn;
@@ -569,8 +562,8 @@ store_hard_offline_page(struct device *dev,
 	return ret ? ret : count;
 }
 
-static DEVICE_ATTR(soft_offline_page, S_IWUSR, NULL, store_soft_offline_page);
-static DEVICE_ATTR(hard_offline_page, S_IWUSR, NULL, store_hard_offline_page);
+static DEVICE_ATTR_WO(soft_offline_page);
+static DEVICE_ATTR_WO(hard_offline_page);
 #endif
 
 /*
-- 
2.17.2

