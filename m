Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F2CC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917972184C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551192104;
	bh=FcR3IE+Fx2w79Pk7CgTqOr0+5B1S4Bptx/5tINe0NHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPFy2N4mRZUpaCWGOTKhMwTghOfJcJDqcUbWS4szQhHCpM3dSGoFFQStCKO4lgBqu
	 FQHkBz/vm5HJxIIBYNKjQ8Vqi8sJvOu6NjGnJmEMIUygibZROgOFqn67qjaYChAdQ4
	 QoJty49/BQ0KpY1hNuHPe3n5gCfSF7vzNQeg79ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfBZOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfBZOlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:41:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0952173C;
        Tue, 26 Feb 2019 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551192098;
        bh=FcR3IE+Fx2w79Pk7CgTqOr0+5B1S4Bptx/5tINe0NHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wENuBr52hga16p0COgipqH/KbSpoOMmcoPta7UC7IJTiykl3TV4gpmmdIan/QB3lD
         IgpjBSFuJ6GvdakZz4gWVNOWepBW5BNl51Qk/FcrPGOtF7NDqhaLPDZmdA1wD6GAlV
         mwmISv71EeKXpaUDRTNb/nnfmROPfedzln0nj6xQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/2] device.h: reorganize struct device
Date:   Tue, 26 Feb 2019 15:41:08 +0100
Message-Id: <20190226144108.25891-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190226144108.25891-1-gregkh@linuxfoundation.org>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct device is big, around 760 bytes on x86_64.  It's not a critical
structure, but it is embedded everywhere, so making it smaller is always
a good thing.

With a recent patch that moved a field from struct device to the private
structure, some benchmarks showed a very odd regression, despite this
structure having nothing to do with those benchmarks.  That caused me to
look into the layout of the structure.  Using 'pahole', it showed a
number of holes and ways that the structure could be reordered in order
to align some cachelines better, as well as reduce the size of the
overall structure.

This patch removes 16 bytes from 'struct device' on a 64bit system, just
by moving things around.  Given we know there are systems with at least
30k devices in memory at once, every little byte counts, and this change
could be a savings of 480k of kernel memory for them.  On "normal"
systems the overall memory savings would be much less.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index b63165276a09..4e6b9a2ab8d0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -967,18 +967,14 @@ struct dev_links_info {
  * a higher-level representation of the device.
  */
 struct device {
+	struct kobject kobj;
 	struct device		*parent;
 
 	struct device_private	*p;
 
-	struct kobject kobj;
 	const char		*init_name; /* initial name of the device */
 	const struct device_type *type;
 
-	struct mutex		mutex;	/* mutex to synchronize calls to
-					 * its driver.
-					 */
-
 	struct bus_type	*bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
@@ -986,7 +982,14 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set/get_drvdata */
+	struct mutex		mutex;	/* mutex to synchronize calls to
+					 * its driver.
+					 */
+
 	struct dev_links_info	links;
+	spinlock_t		devres_lock;
+	struct list_head	devres_head;
+
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
@@ -1000,9 +1003,6 @@ struct device {
 	struct list_head	msi_list;
 #endif
 
-#ifdef CONFIG_NUMA
-	int		numa_node;	/* NUMA node this device is close to */
-#endif
 	const struct dma_map_ops *dma_ops;
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
@@ -1032,9 +1032,6 @@ struct device {
 	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
 	u32			id;	/* device instance */
 
-	spinlock_t		devres_lock;
-	struct list_head	devres_head;
-
 	struct klist_node	knode_class;
 	struct class		*class;
 	const struct attribute_group **groups;	/* optional groups */
@@ -1043,6 +1040,9 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct iommu_fwspec	*iommu_fwspec;
 
+#ifdef CONFIG_NUMA
+	int		numa_node;	/* NUMA node this device is close to */
+#endif
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
-- 
2.21.0

