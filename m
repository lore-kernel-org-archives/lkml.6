Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F869C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506FF2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506FF2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbeJBUUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:20:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbeJBUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:01 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC3489D9;
        Tue,  2 Oct 2018 13:36:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 4.9 66/94] slub: make ->cpu_partial unsigned int
Date:   Tue,  2 Oct 2018 06:25:20 -0700
Message-Id: <20181002132505.075810407@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Dobriyan <adobriyan@gmail.com>

commit e5d9998f3e09359b372a037a6ac55ba235d95d57 upstream.

	/*
	 * cpu_partial determined the maximum number of objects
	 * kept in the per cpu partial lists of a processor.
	 */

Can't be negative.

Link: http://lkml.kernel.org/r/20180305200730.15812-15-adobriyan@gmail.com
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/slub_def.h |    3 ++-
 mm/slub.c                |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -67,7 +67,8 @@ struct kmem_cache {
 	int size;		/* The size of an object including meta data */
 	int object_size;	/* The size of an object without meta data */
 	int offset;		/* Free pointer offset. */
-	int cpu_partial;	/* Number of per cpu partial objects to keep around */
+	/* Number of per cpu partial objects to keep around */
+	unsigned int cpu_partial;
 	struct kmem_cache_order_objects oo;
 
 	/* Allocation and freeing of slabs */
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1793,7 +1793,7 @@ static void *get_partial_node(struct kme
 {
 	struct page *page, *page2;
 	void *object = NULL;
-	int available = 0;
+	unsigned int available = 0;
 	int objects;
 
 	/*
@@ -4870,10 +4870,10 @@ static ssize_t cpu_partial_show(struct k
 static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
 				 size_t length)
 {
-	unsigned long objects;
+	unsigned int objects;
 	int err;
 
-	err = kstrtoul(buf, 10, &objects);
+	err = kstrtouint(buf, 10, &objects);
 	if (err)
 		return err;
 	if (objects && !kmem_cache_has_cpu_partial(s))


