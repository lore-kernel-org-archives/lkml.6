Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD65C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0320866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmkUjbFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C0320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeJQBIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbeJQBIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:08:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F1921477;
        Tue, 16 Oct 2018 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710200;
        bh=gQCWGxaUoxaf5cstrkIhRnLkKl50v8A1t5ymusIkZA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mmkUjbFf6xmtNiT8SUm6Jz5+TO4dZnsVQSeeBefRN6yoDwO2W8rblh0cpyt/Kt4Vi
         uMWGTnz6Mf9g1RKW6ylRXwX5Zt5wZ0CdqtIKFughxDDsuaQaMoJSn2DO1LzRzlfNDo
         E/PHBzlNtpaeYTkWLzmMRr15nuI7yhci7sVOwOi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.18 122/135] dm: fix report zone remapping to account for partition offset
Date:   Tue, 16 Oct 2018 19:05:52 +0200
Message-Id: <20181016170523.698713964@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 9864cd5dc54cade89fd4b0954c2e522841aa247c upstream.

If dm-linear or dm-flakey are layered on top of a partition of a zoned
block device, remapping of the start sector and write pointer position
of the zones reported by a report zones BIO must be modified to account
for the target table entry mapping (start offset within the device and
entry mapping with the dm device).  If the target's backing device is a
partition of a whole disk, the start sector on the physical device of
the partition must also be accounted for when modifying the zone
information.  However, dm_remap_zone_report() was not considering this
last case, resulting in incorrect zone information remapping with
targets using disk partitions.

Fix this by calculating the target backing device start sector using
the position of the completed report zones BIO and the unchanged
position and size of the original report zone BIO. With this value
calculated, the start sector and write pointer position of the target
zones can be correctly remapped.

Fixes: 10999307c14e ("dm: introduce dm_remap_zone_report()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1153,12 +1153,14 @@ void dm_accept_partial_bio(struct bio *b
 EXPORT_SYMBOL_GPL(dm_accept_partial_bio);
 
 /*
- * The zone descriptors obtained with a zone report indicate
- * zone positions within the target device. The zone descriptors
- * must be remapped to match their position within the dm device.
- * A target may call dm_remap_zone_report after completion of a
- * REQ_OP_ZONE_REPORT bio to remap the zone descriptors obtained
- * from the target device mapping to the dm device.
+ * The zone descriptors obtained with a zone report indicate zone positions
+ * within the target backing device, regardless of that device is a partition
+ * and regardless of the target mapping start sector on the device or partition.
+ * The zone descriptors start sector and write pointer position must be adjusted
+ * to match their relative position within the dm device.
+ * A target may call dm_remap_zone_report() after completion of a
+ * REQ_OP_ZONE_REPORT bio to remap the zone descriptors obtained from the
+ * backing device.
  */
 void dm_remap_zone_report(struct dm_target *ti, struct bio *bio, sector_t start)
 {
@@ -1169,6 +1171,7 @@ void dm_remap_zone_report(struct dm_targ
 	struct blk_zone *zone;
 	unsigned int nr_rep = 0;
 	unsigned int ofst;
+	sector_t part_offset;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	void *addr;
@@ -1177,6 +1180,15 @@ void dm_remap_zone_report(struct dm_targ
 		return;
 
 	/*
+	 * bio sector was incremented by the request size on completion. Taking
+	 * into account the original request sector, the target start offset on
+	 * the backing device and the target mapping offset (ti->begin), the
+	 * start sector of the backing device. The partition offset is always 0
+	 * if the target uses a whole device.
+	 */
+	part_offset = bio->bi_iter.bi_sector + ti->begin - (start + bio_end_sector(report_bio));
+
+	/*
 	 * Remap the start sector of the reported zones. For sequential zones,
 	 * also remap the write pointer position.
 	 */
@@ -1193,6 +1205,7 @@ void dm_remap_zone_report(struct dm_targ
 		/* Set zones start sector */
 		while (hdr->nr_zones && ofst < bvec.bv_len) {
 			zone = addr + ofst;
+			zone->start -= part_offset;
 			if (zone->start >= start + ti->len) {
 				hdr->nr_zones = 0;
 				break;
@@ -1204,7 +1217,7 @@ void dm_remap_zone_report(struct dm_targ
 				else if (zone->cond == BLK_ZONE_COND_EMPTY)
 					zone->wp = zone->start;
 				else
-					zone->wp = zone->wp + ti->begin - start;
+					zone->wp = zone->wp + ti->begin - start - part_offset;
 			}
 			ofst += sizeof(struct blk_zone);
 			hdr->nr_zones--;


