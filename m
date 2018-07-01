Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A17C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC1253E8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECC1253E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032356AbeGAQnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:43:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032077AbeGAQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:43:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4085CA73;
        Sun,  1 Jul 2018 16:43:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Elliott <elliott@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.17 145/220] linvdimm, pmem: Preserve read-only setting for pmem devices
Date:   Sun,  1 Jul 2018 18:22:49 +0200
Message-Id: <20180701160914.368620326@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Elliott <elliott@hpe.com>

commit 254a4cd50b9fe2291a12b8902e08e56dcc4e9b10 upstream.

The pmem driver does not honor a forced read-only setting for very long:
	$ blockdev --setro /dev/pmem0
	$ blockdev --getro /dev/pmem0
	1

followed by various commands like these:
	$ blockdev --rereadpt /dev/pmem0
	or
	$ mkfs.ext4 /dev/pmem0

results in this in the kernel serial log:
	 nd_pmem namespace0.0: region0 read-write, marking pmem0 read-write

with the read-only setting lost:
	$ blockdev --getro /dev/pmem0
	0

That's from bus.c nvdimm_revalidate_disk(), which always applies the
setting from nd_region (which is initially based on the ACPI NFIT
NVDIMM state flags not_armed bit).

In contrast, commit 20bd1d026aac ("scsi: sd: Keep disk read-only when
re-reading partition") fixed this issue for SCSI devices to preserve
the previous setting if it was set to read-only.

This patch modifies bus.c to preserve any previous read-only setting.
It also eliminates the kernel serial log print except for cases where
read-write is changed to read-only, so it doesn't print read-only to
read-only non-changes.

Cc: <stable@vger.kernel.org>
Fixes: 581388209405 ("libnvdimm, nfit: handle unarmed dimms, mark namespaces read-only")
Signed-off-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/bus.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -566,14 +566,18 @@ int nvdimm_revalidate_disk(struct gendis
 {
 	struct device *dev = disk_to_dev(disk)->parent;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
-	const char *pol = nd_region->ro ? "only" : "write";
+	int disk_ro = get_disk_ro(disk);
 
-	if (nd_region->ro == get_disk_ro(disk))
+	/*
+	 * Upgrade to read-only if the region is read-only preserve as
+	 * read-only if the disk is already read-only.
+	 */
+	if (disk_ro || nd_region->ro == disk_ro)
 		return 0;
 
-	dev_info(dev, "%s read-%s, marking %s read-%s\n",
-			dev_name(&nd_region->dev), pol, disk->disk_name, pol);
-	set_disk_ro(disk, nd_region->ro);
+	dev_info(dev, "%s read-only, marking %s read-only\n",
+			dev_name(&nd_region->dev), disk->disk_name);
+	set_disk_ro(disk, 1);
 
 	return 0;
 


