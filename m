Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4617FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147DF21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378935;
	bh=I36HAMjnO2LdIfKY9tYmV2N1zf7D9RSyuEpNzKq4EYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ge8b5adgarg/BCfvNu1Vn9CC99BDkC2A7sSc0l3Tt8ke2ZThSh7gS68JxRbe4mLB
	 sAzPV5uSPJ8jRHBErt3IHNJc1EI4rvOlGpzZeP8Ody7+kM76DOA8qWfCsMH/zyx7Qb
	 gEeI581m6l68B2LeFbeZ1/mp5bXvZCkkDyS5XFN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbeLUHzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732951AbeLUHzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DCE21908;
        Fri, 21 Dec 2018 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378906;
        bh=I36HAMjnO2LdIfKY9tYmV2N1zf7D9RSyuEpNzKq4EYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOafNGrONb6WpsWqVc9VrZLDNa3fqDnf3DEuglYpkEFotA3Ky3wH1D8/ZlZcV1C+H
         fCjMbdn30oJx8nzrhCmFwpw5hFxYHetEIKPyqioGBmhOKBGQXrkbXdRiXKGur9O4Eq
         RzMYmrZ9p9wVyIJRIwTJ9fBm6arHXj7gb6BRUDZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/10] block: rbd: convert to use BUS_ATTR_WO and RO
Date:   Fri, 21 Dec 2018 08:54:38 +0100
Message-Id: <20181221075442.17109-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() and the usage of that in rbd.c
can be trivially converted to use BUS_ATTR_WO and RO, so use those
macros instead.

Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Alex Elder <elder@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e5140bbf241..d871d364fdcf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -428,14 +428,13 @@ static bool single_major = true;
 module_param(single_major, bool, 0444);
 MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: true)");
 
-static ssize_t rbd_add(struct bus_type *bus, const char *buf,
-		       size_t count);
-static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
-			  size_t count);
-static ssize_t rbd_add_single_major(struct bus_type *bus, const char *buf,
-				    size_t count);
-static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
-				       size_t count);
+static ssize_t add_store(struct bus_type *bus, const char *buf, size_t count);
+static ssize_t remove_store(struct bus_type *bus, const char *buf,
+			    size_t count);
+static ssize_t add_single_major_store(struct bus_type *bus, const char *buf,
+				      size_t count);
+static ssize_t remove_single_major_store(struct bus_type *bus, const char *buf,
+					 size_t count);
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth);
 
 static int rbd_dev_id_to_minor(int dev_id)
@@ -464,16 +463,16 @@ static bool rbd_is_lock_owner(struct rbd_device *rbd_dev)
 	return is_lock_owner;
 }
 
-static ssize_t rbd_supported_features_show(struct bus_type *bus, char *buf)
+static ssize_t supported_features_show(struct bus_type *bus, char *buf)
 {
 	return sprintf(buf, "0x%llx\n", RBD_FEATURES_SUPPORTED);
 }
 
-static BUS_ATTR(add, 0200, NULL, rbd_add);
-static BUS_ATTR(remove, 0200, NULL, rbd_remove);
-static BUS_ATTR(add_single_major, 0200, NULL, rbd_add_single_major);
-static BUS_ATTR(remove_single_major, 0200, NULL, rbd_remove_single_major);
-static BUS_ATTR(supported_features, 0444, rbd_supported_features_show, NULL);
+static BUS_ATTR_WO(add);
+static BUS_ATTR_WO(remove);
+static BUS_ATTR_WO(add_single_major);
+static BUS_ATTR_WO(remove_single_major);
+static BUS_ATTR_RO(supported_features);
 
 static struct attribute *rbd_bus_attrs[] = {
 	&bus_attr_add.attr,
@@ -5934,9 +5933,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	goto out;
 }
 
-static ssize_t rbd_add(struct bus_type *bus,
-		       const char *buf,
-		       size_t count)
+static ssize_t add_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	if (single_major)
 		return -EINVAL;
@@ -5944,9 +5941,8 @@ static ssize_t rbd_add(struct bus_type *bus,
 	return do_rbd_add(bus, buf, count);
 }
 
-static ssize_t rbd_add_single_major(struct bus_type *bus,
-				    const char *buf,
-				    size_t count)
+static ssize_t add_single_major_store(struct bus_type *bus, const char *buf,
+				      size_t count)
 {
 	return do_rbd_add(bus, buf, count);
 }
@@ -6050,9 +6046,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	return count;
 }
 
-static ssize_t rbd_remove(struct bus_type *bus,
-			  const char *buf,
-			  size_t count)
+static ssize_t remove_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	if (single_major)
 		return -EINVAL;
@@ -6060,9 +6054,8 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	return do_rbd_remove(bus, buf, count);
 }
 
-static ssize_t rbd_remove_single_major(struct bus_type *bus,
-				       const char *buf,
-				       size_t count)
+static ssize_t remove_single_major_store(struct bus_type *bus, const char *buf,
+					 size_t count)
 {
 	return do_rbd_remove(bus, buf, count);
 }
-- 
2.20.1

