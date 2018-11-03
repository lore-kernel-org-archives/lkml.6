Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B6FC65C22
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B0C2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B0C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeKCNEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 09:04:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37922 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKCNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 09:04:08 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:2bff:decf:69f2:c4e6:79a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 56B4E27E83A;
        Sat,  3 Nov 2018 03:54:08 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     dm-devel@redhat.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, wad@chromium.org,
        linux-doc@vger.kernel.org, linux-lvm@redhat.com,
        kernel@collabora.com, richard.weinberger@gmail.com,
        keescook@chromium.org
Subject: [PATCH v10 1/2] dm ioctl: add a device mapper ioctl function.
Date:   Sat,  3 Nov 2018 00:53:40 -0300
Message-Id: <20181103035341.16893-2-helen.koike@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181103035341.16893-1-helen.koike@collabora.com>
References: <20181103035341.16893-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Add a dm_ioctl_cmd to issue the equivalent of a DM ioctl call in kernel.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

---

Changes since v9:
 - https://www.redhat.com/archives/linux-lvm/2018-September/msg00016.html
 - Reorganize variables
---
 drivers/md/dm-ioctl.c         | 49 +++++++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  6 +++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index f666778ad237..ae34c2030a9c 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -2018,3 +2018,52 @@ int dm_copy_name_and_uuid(struct mapped_device *md, char *name, char *uuid)
 
 	return r;
 }
+
+/**
+ * dm_ioctl_cmd - Device mapper ioctl's
+ * @command: ioctl command
+ * @param: Pointer to device mapped ioctl struct
+ */
+int dm_ioctl_cmd(uint command, struct dm_ioctl *param)
+{
+	struct file *filp = NULL;
+	size_t input_param_size;
+	int ioctl_flags, r;
+	unsigned int cmd;
+	ioctl_fn fn;
+
+	if (_IOC_TYPE(command) != DM_IOCTL)
+		return -ENOTTY;
+
+	/* DM_DEV_ARM_POLL is not supported */
+	if (command == DM_DEV_ARM_POLL)
+		return -EINVAL;
+
+	cmd = _IOC_NR(command);
+
+	/*
+	 * Nothing more to do for the version command.
+	 */
+	if (cmd == DM_VERSION_CMD)
+		return 0;
+
+	fn = lookup_ioctl(cmd, &ioctl_flags);
+	if (!fn) {
+		DMWARN("dm_ioctl: unknown command 0x%x", command);
+		return -ENOTTY;
+	}
+
+	input_param_size = param->data_size;
+	r = validate_params(cmd, param);
+	if (r)
+		return r;
+
+	param->data_size = sizeof(*param);
+	r = fn(filp, param, input_param_size);
+
+	if (unlikely(param->flags & DM_BUFFER_FULL_FLAG) &&
+	    unlikely(ioctl_flags & IOCTL_FLAGS_NO_PARAMS))
+		DMERR("ioctl %d tried to output some data but has IOCTL_FLAGS_NO_PARAMS set", cmd);
+
+	return r;
+}
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index d7bee8669f10..8b2e4ae6a498 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/math64.h>
 #include <linux/ratelimit.h>
+#include <linux/dm-ioctl.h>
 
 struct dm_dev;
 struct dm_target;
@@ -423,6 +424,11 @@ void dm_remap_zone_report(struct dm_target *ti, struct bio *bio,
 			  sector_t start);
 union map_info *dm_get_rq_mapinfo(struct request *rq);
 
+/*
+ * Device mapper ioctl function.
+ */
+int dm_ioctl_cmd(unsigned int command, struct dm_ioctl *param);
+
 struct queue_limits *dm_get_queue_limits(struct mapped_device *md);
 
 /*
-- 
2.19.1

