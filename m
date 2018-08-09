Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF4CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53322238C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRKjI1LW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53322238C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeHIUhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46176 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHIUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so2870611ply.13;
        Thu, 09 Aug 2018 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JDhFAs3xXtk7n4+Cx+CXUjqd+12covKCPBG+j/hN8kA=;
        b=oRKjI1LWzVGSSDlmA4Rsf9pKC+gnscv4KBYFqVpOzby5qnFjUXup5ARyijIZdXM/i8
         jsGbL2BhbGVcBMpV2W6br5KfnXGIYMTBxdFNG6A7PUYPpqDTUvWgttvM94zlWZlQqHj+
         zKIP5XMIXfKoVCJPa+Z2P+kDAoCPyRDAR8S0pHWArRYjketO1ohJXIV3Ic8izaWtuhqc
         G9Glh8XvAf/rBKIUArWkSi/ALKd/415JjEJrBlo7/WlpPZxcDfD5dkAsdosI5rCqNPdw
         jRgmyayoHc8njdc1f8TN/HXSeTFy2zZtBaPGF6ZzWu6FT/9CvSMBySiF3x0QgqPbQ8h0
         DCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JDhFAs3xXtk7n4+Cx+CXUjqd+12covKCPBG+j/hN8kA=;
        b=MnNstHgRtPZ2wJPxh4T8Dz76kH7vjnx1r26iJdxM0bXKk81qWYVdKqm6l4SD16z1z9
         k0vOW0IDUzfRRPfGWn14kbPByYr/mLk07q8rUJNFdmLyMbWfROelfiockPAL6+fyvtkK
         abIMeioM1qs6ZghgX56ieWj0XmPfp3n2vjvLGGHBqKJk0G0Hy+zJrpwsXIE7D1gDzqQo
         G2B++R16tWQAeu+pEoBFlwDRSTqjgeEpDJEY1DwWDxN2rU7t/rqO7z93F1uDKgsrhU4f
         6fniy6UNbnzZL05aHZPKGSLfqeVGUl6g3P79hwcEEznWzOduLsB3rB4a6rJbUxme3A+9
         Laxg==
X-Gm-Message-State: AOUpUlFyQqWbvNogmcXUGSntSg+KjJmw9M/ADmqVZ15DvyL+BZBNkfXg
        qAcW/w28IXfwmMPJ9nqrbm+LERkEcW8=
X-Google-Smtp-Source: AA+uWPxCIUGIzB0OZbI/B6vtTKDykdOOGurcsYy465ZZcm+UQx3BBFCs51Uk5qsGpXg2i+nDP+94GQ==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr3057166plz.26.1533838290093;
        Thu, 09 Aug 2018 11:11:30 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id 11-v6sm19059377pfq.43.2018.08.09.11.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:29 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 08/12] btrfs-progs: volume: align chunk allocation to zones
Date:   Fri, 10 Aug 2018 03:11:01 +0900
Message-Id: <20180809181105.12856-8-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate support for zoned block devices in the extent buffer
allocation, a zoned block device chunk is always aligned to a zone of the
device. With this, the zone write pointer location simply becomes a hint to
allocate new buffers.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 volumes.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/volumes.c b/volumes.c
index 2ec27cd7..ba3b45d2 100644
--- a/volumes.c
+++ b/volumes.c
@@ -379,6 +379,14 @@ int btrfs_scan_one_device(int fd, const char *path,
 	return ret;
 }
 
+/* zone size is ensured to be power of 2 */
+static u64 btrfs_zone_align(struct btrfs_zone_info *zinfo, u64 val)
+{
+	if (zinfo && zinfo->zone_size)
+		return (val + zinfo->zone_size - 1) & ~(zinfo->zone_size - 1);
+	return val;
+}
+
 /*
  * find_free_dev_extent_start - find free space in the specified device
  * @device:	  the device which we search the free space in
@@ -425,6 +433,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 */
 	min_search_start = max(root->fs_info->alloc_start, (u64)SZ_1M);
 	search_start = max(search_start, min_search_start);
+	search_start = btrfs_zone_align(&device->zinfo, search_start);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -507,7 +516,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 		extent_end = key.offset + btrfs_dev_extent_length(l,
 								  dev_extent);
 		if (extent_end > search_start)
-			search_start = extent_end;
+			search_start =  btrfs_zone_align(&device->zinfo,
+							 extent_end);
 next:
 		path->slots[0]++;
 		cond_resched();
@@ -560,6 +570,9 @@ static int btrfs_alloc_dev_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 
+	/* Align to zone for a zoned block device */
+	*start = btrfs_zone_align(&device->zinfo, *start);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -1030,9 +1043,15 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 
-	/* we don't want a chunk larger than 10% of the FS */
-	percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
-	max_chunk_size = min(percent_max, max_chunk_size);
+	if (info->fs_devices->hmzoned) {
+		/* Zoned mode uses zone aligned chunks */
+		calc_size = info->fs_devices->zone_size;
+		max_chunk_size = calc_size * num_stripes;
+	} else {
+		/* we don't want a chunk larger than 10% of the FS */
+		percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
+		max_chunk_size = min(percent_max, max_chunk_size);
+	}
 
 again:
 	if (chunk_bytes_by_type(type, calc_size, num_stripes, sub_stripes) >
@@ -1112,7 +1131,9 @@ again:
 	*num_bytes = chunk_bytes_by_type(type, calc_size,
 					 num_stripes, sub_stripes);
 	index = 0;
+	dev_offset = 0;
 	while(index < num_stripes) {
+		size_t zone_size = device->zinfo.zone_size;
 		struct btrfs_stripe *stripe;
 		BUG_ON(list_empty(&private_devs));
 		cur = private_devs.next;
@@ -1123,11 +1144,16 @@ again:
 		    (index == num_stripes - 1))
 			list_move_tail(&device->dev_list, dev_list);
 
+		if (device->zinfo.zone_size)
+			calc_size = device->zinfo.zone_size;
+
 		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
 			     calc_size, &dev_offset, 0);
 		if (ret < 0)
 			goto out_chunk_map;
 
+		WARN_ON(zone_size && !IS_ALIGNED(dev_offset, zone_size));
+
 		device->bytes_used += calc_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
-- 
2.18.0

