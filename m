Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8DBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5AF214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5AF214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeHVJkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:40:23 -0400
Received: from portal.weinmann.de ([62.8.140.122]:65478 "EHLO
        portal.loewensteinmedical.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728088AbeHVJkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:40:23 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 05:40:22 EDT
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Thu, 2 Aug 2018 08:29:13 +0200
Subject: [PATCH] init/do_mounts.c: add root=PARTLABEL=<name> support
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
CC:     <linux-kernel@vger.kernel.org>
Message-ID: <20180822060904.828E510665E@pc-niv.weinmann.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: a378c7e9-0079-4426-8197-7b88a526ab38
x-msw-jemd-newsletter: false
X-OriginalId: qfw7M8953p007051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support referencing the root partition label from GPT as argument
to the root= option on the kernel command line in analogy to
referencing the partition uuid as root=PARTUUID=<uuid>.

Specifying the partition label instead of the uuid is often much
easier, e.g. in embedded environments when there is an
A/B rootfs partition scheme for interruptible firmware updates
(i.e. rootfsA/ rootfsB).

The partition label can be queried with the blkid command.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 init/do_mounts.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2c71dabe5626..239b5104cff0 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -177,6 +177,24 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 	}
 	return res;
 }
+
+/**
+ * match_dev_by_label - callback for finding a partition using its label
+ * @dev:	device passed in by the caller
+ * @data:	opaque pointer to the label to match
+ *
+ * Returns 1 if the device matches, and 0 otherwise.
+ */
+static int match_dev_by_label(struct device *dev, const void *data)
+{
+	const char *label = data;
+	struct hd_struct *part = dev_to_part(dev);
+
+	if (part->info && !strcmp(label, part->info->volname))
+		return 1;
+
+	return 0;
+}
 #endif
 
 /*
@@ -200,6 +218,8 @@ static dev_t devt_from_partuuid(const char *uuid_str)
  *	   a partition with a known unique id.
  *	8) <major>:<minor> major and minor number of the device separated by
  *	   a colon.
+ *	9) PARTLABEL=<name> with name being the GPT partition label.
+ *	   MSDOS partitions do not support labels!
  *
  *	If name doesn't have fall into the categories above, we return (0,0).
  *	block_class is used to check if something is a disk name. If the disk
@@ -221,6 +241,17 @@ dev_t name_to_dev_t(const char *name)
 		if (!res)
 			goto fail;
 		goto done;
+	} else if (strncmp(name, "PARTLABEL=", 10) == 0) {
+		struct device *dev;
+
+		dev = class_find_device(&block_class, NULL, name + 10,
+					&match_dev_by_label);
+		if (!dev)
+			goto fail;
+
+		res = dev->devt;
+		put_device(dev);
+		goto done;
 	}
 #endif
 
-- 
2.17.1

