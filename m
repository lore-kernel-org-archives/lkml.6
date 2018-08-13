Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197372170A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197372170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeHNBMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:12:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbeHNBMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:12:16 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M9Xn5-1fjbk83rxf-00CyzG; Tue, 14 Aug 2018 00:27:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: raid_attrs: fix unused variable warning
Date:   Tue, 14 Aug 2018 00:27:10 +0200
Message-Id: <20180813222716.757523-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:G83hKnPfELFS14NHqmVoVsyoZifnmtwcSKL1534MHASH49g7VFj
 b2xtqQzW3/dq0iSZU/R2bt7DAV54mnAyfdX5iFMmYASO4t88/bM14zk5rfcuHDdC2CSFtVc
 xZEdTX2qPIy08SbR0/7/HU/u+/apHJnCARD7RwrRltm8YaTHeMdNIqpE9j73DCbc6Og4nkP
 s8ySeLNyCw9/BCPHS280Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SsmWaniqVT0=:/t3gC+vO0QDcj0Sa9S2vPO
 0vhs2gi8r/fkko10PYZg4O2zyNCr+qo3DtNSVV4a50TDL4mR8uRcfQqPYv66UsWlB8r7YhyX9
 2kjMzY4DMZnS8GaULKZgfkBz4OrUKBx4Lwv3B9r1xkcE2ZrUJG4AhzM6Y/9pCEs0URtJiKQC0
 0IMqo6KT+EXx/bpBEvlfVV1RXkeD8GEG7jW4BXKfOewM1lBjmbmzAqK//O5sa4hr+s6RfKG6G
 IC7yGc7UvPQglIInpcImt4rG6N3VJazdRizTSYmYlCunTxOuoIyM0c203KZXctpvs2dEEru0u
 Y6vhcv2UaUQ/CAF6glWm0httyOF9gDfyRFK7RiZd5Pknf3AuJLracg0JjuCaWvBthcc61gdmf
 yQKYhDb6kLTkR5xsoWoPp8ZHuzUUZoxp4tviPq9IgMdEiltvrYWKRufFZf5iT8VxhIHXI+9vT
 AdVk4xquXGAziYoZGqe1ZkJ0cWYRNKkrer98sxa0CA38+vQjpAF2oScCE91WigzNLx8fmifKS
 ZJsSyZ1dbxubNSwdcZzojTXxB9psEVkfYdM0yjLyw0hrjLpvH/ivM9ERiUfyq/5Jlx4SvKZYf
 s3sdi2Ubink1qIHSIMSV5VBngBcAAzWlXTUZMBLDpcyYECPSS5mptrjT7Qa3C4LxR0f8mgm2b
 QGR7NnpxJAIrA2cgtrP11jZuT7u6tfcXS3uTqbqYj9uoAO7tJlqe7bjwBm+BKvCcXVIM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a new warning on randconfig kernels:

drivers/scsi/raid_class.c: In function 'raid_match':
drivers/scsi/raid_class.c:64:24: error: unused variable 'i' [-Werror=unused-variable]

This looks like a very old problem that for some reason was very
hard to run into, but it is very easy to fix, by replacing the
incorrect #ifdef with a simpler IS_ENABLED() check.

Fixes: fac829fdcaf4 ("[SCSI] raid_attrs: fix dependency problems")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/raid_class.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index ea88906d2cc5..5c3d6e1e0145 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -63,8 +63,7 @@ static int raid_match(struct attribute_container *cont, struct device *dev)
 	 * emulated RAID devices, so start with SCSI */
 	struct raid_internal *i = ac_to_raid_internal(cont);
 
-#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
-	if (scsi_is_sdev_device(dev)) {
+	if (IS_ENABLED(CONFIG_SCSI) && scsi_is_sdev_device(dev)) {
 		struct scsi_device *sdev = to_scsi_device(dev);
 
 		if (i->f->cookie != sdev->host->hostt)
@@ -72,7 +71,6 @@ static int raid_match(struct attribute_container *cont, struct device *dev)
 
 		return i->f->is_raid(dev);
 	}
-#endif
 	/* FIXME: look at other subsystems too */
 	return 0;
 }
-- 
2.18.0

