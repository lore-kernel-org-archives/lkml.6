Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6FA218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="OHCLLzJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbeLTTWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:22:03 -0500
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:54192 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389324AbeLTTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1545333717;
        h=Message-Id:Date:From:To:Cc:Cc:Cc:CC:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:References:MIME-Version:Content-Type:Feedback-ID;
        bh=9RbM/jvYgrX3laKFEpjCMiN+ksJv3eWbjUkCaqrfwkE=;
        b=OHCLLzJ6oPFtcW68XCABgoUNOPVk6+3UQC2JsdbyVQyPQYljUakQzjMHr+tVlzug
        2Vhpy7LZgA18mSKFfdg/iDG1ZWq+wKqvZZ43b68MiSQdWISkARuNc5UnrfGittJIxn7
        ZDgfT1On7RLQBhryQyuP+CQHfiloPZZBUn9hI4OU=
Message-ID: <01000167cd113a49-ada7b71e-0fa9-4897-b324-b7a2e1bd0f1c-000000@email.amazonses.com>
User-Agent: quilt/0.65
Date:   Thu, 20 Dec 2018 19:21:57 +0000
From:   Christoph Lameter <cl@linux.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Cc:     Pekka Enberg <penberg@cs.helsinki.fi>
CC:     akpm@linux-foundation.org
Cc:     Mel Gorman <mel@skynet.ie>
Cc:     andi@firstfloor.org
Cc:     Rik van Riel <riel@redhat.com>
Cc:     Dave Chinner <dchinner@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC 2/7] slub: Add defrag_ratio field and sysfs support
References: <20181220192145.023162076@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=defrag_ratio
X-SES-Outgoing: 2018.12.20-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"defrag_ratio" is used to set the threshold at which defragmentation
should be attempted on a slab page.

"defrag_ratio" is percentage in the range of 1 - 100. If more than
that percentage of slots in a slab page are unused the the slab page
will become subject to defragmentation.

Add a defrag ratio field and set it to 30% by default. A limit of 30% specifies
that less than 3 out of 10 available slots for objects need to be leftover
before slab defragmentation will be attempted on the remaining objects.

Signed-off-by: Christoph Lameter <cl@linux.com>

---
 Documentation/ABI/testing/sysfs-kernel-slab |   13 +++++++++++++
 include/linux/slub_def.h                    |    6 ++++++
 mm/slub.c                                   |   23 +++++++++++++++++++++++
 3 files changed, 42 insertions(+)

Index: linux/mm/slub.c
===================================================================
--- linux.orig/mm/slub.c
+++ linux/mm/slub.c
@@ -3628,6 +3628,7 @@ static int kmem_cache_open(struct kmem_c
 
 	set_cpu_partial(s);
 
+	s->defrag_ratio = 30;
 #ifdef CONFIG_NUMA
 	s->remote_node_defrag_ratio = 1000;
 #endif
@@ -5113,6 +5114,27 @@ static ssize_t destroy_by_rcu_show(struc
 }
 SLAB_ATTR_RO(destroy_by_rcu);
 
+static ssize_t defrag_ratio_show(struct kmem_cache *s, char *buf)
+{
+	return sprintf(buf, "%d\n", s->defrag_ratio);
+}
+
+static ssize_t defrag_ratio_store(struct kmem_cache *s,
+				const char *buf, size_t length)
+{
+	unsigned long ratio;
+	int err;
+
+	err = kstrtoul(buf, 10, &ratio);
+	if (err)
+		return err;
+
+	if (ratio < 100)
+		s->defrag_ratio = ratio;
+	return length;
+}
+SLAB_ATTR(defrag_ratio);
+
 #ifdef CONFIG_SLUB_DEBUG
 static ssize_t slabs_show(struct kmem_cache *s, char *buf)
 {
@@ -5437,6 +5459,7 @@ static struct attribute *slab_attrs[] =
 	&validate_attr.attr,
 	&alloc_calls_attr.attr,
 	&free_calls_attr.attr,
+	&defrag_ratio_attr.attr,
 #endif
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
Index: linux/Documentation/ABI/testing/sysfs-kernel-slab
===================================================================
--- linux.orig/Documentation/ABI/testing/sysfs-kernel-slab
+++ linux/Documentation/ABI/testing/sysfs-kernel-slab
@@ -180,6 +180,19 @@ Description:
 		list.  It can be written to clear the current count.
 		Available when CONFIG_SLUB_STATS is enabled.
 
+What:		/sys/kernel/slab/cache/defrag_ratio
+Date:		December 2018
+KernelVersion:	4.18
+Contact:	Christoph Lameter <cl@linux-foundation.org>
+		Pekka Enberg <penberg@cs.helsinki.fi>,
+Description:
+		The defrag_ratio files allows the control of how agressive
+		slab fragmentation reduction works at reclaiming objects from
+		sparsely populated slabs. This is a percentage. If a slab
+		has more than this percentage of available object then reclaim
+		will attempt to reclaim objects so that the whole slab
+		page can be freed. The default is 30%.
+
 What:		/sys/kernel/slab/cache/deactivate_to_tail
 Date:		February 2008
 KernelVersion:	2.6.25
Index: linux/include/linux/slub_def.h
===================================================================
--- linux.orig/include/linux/slub_def.h
+++ linux/include/linux/slub_def.h
@@ -104,6 +104,12 @@ struct kmem_cache {
 	unsigned int red_left_pad;	/* Left redzone padding size */
 	const char *name;	/* Name (only for display!) */
 	struct list_head list;	/* List of slab caches */
+	int defrag_ratio;	/*
+				 * Ratio used to check the percentage of
+				 * objects allocate in a slab page.
+				 * If less than this ratio is allocated
+				 * then reclaim attempts are made.
+				 */
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;	/* For sysfs */
 	struct work_struct kobj_remove_work;

