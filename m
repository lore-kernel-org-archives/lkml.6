Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766F4218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359045;
	bh=S4cy5dcTgX4/7Le/hemwUs7NmcdyyLbgwVCWTfMxBpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mq1OLy6jHTnqbfXXpXq2Gx4RY+SjCUETqsokyH8nQ96LJ1c+ZLpE/YuYhxXFQH7X8
	 /6QtYC2lkKHhMX5rPQzqPqqF7dZaNW9iWIJlQAq4ImGSKeYxiHsOcVIaNuPcix0Zqi
	 Ify45JRMKZ41+h0MM/EzwYwSMxgJQAdH+2NzYoTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfAXToE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733233AbfAXTn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:43:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03186218D2;
        Thu, 24 Jan 2019 19:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359035;
        bh=S4cy5dcTgX4/7Le/hemwUs7NmcdyyLbgwVCWTfMxBpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qczYOTr8PWueIgJO37rGCAU1ZzWSEi8fuRsr4qSdp+URv9jNfCi/X0aA2gnmuMOMr
         Q1oMv8/fhI6kLZk2/mcuOP2dfDv7uWzvBdgQiECBXqImmJUefSuvtnbuQU1U4Lv7Sk
         z/HJoSUhWqgPHaw+HlFEUwSsDBzbJW+ESH5AKId8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 077/127] btrfs: volumes: Make sure there is no overlap of dev extents at mount time
Date:   Thu, 24 Jan 2019 20:20:23 +0100
Message-Id: <20190124190215.409737744@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5eb193812a42dc49331f25137a38dfef9612d3e4 ]

Enhance btrfs_verify_dev_extents() to remember previous checked dev
extents, so it can verify no dev extents can overlap.

Analysis from Hans:

"Imagine allocating a DATA|DUP chunk.

 In the chunk allocator, we first set...
   max_stripe_size = SZ_1G;
   max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE
 ... which is 10GiB.

 Then...
   /* we don't want a chunk larger than 10% of writeable space */
   max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
       		 max_chunk_size);

 Imagine we only have one 7880MiB block device in this filesystem. Now
 max_chunk_size is down to 788MiB.

 The next step in the code is to search for max_stripe_size * dev_stripes
 amount of free space on the device, which is in our example 1GiB * 2 =
 2GiB. Imagine the device has exactly 1578MiB free in one contiguous
 piece. This amount of bytes will be put in devices_info[ndevs - 1].max_avail

 Next we recalculate the stripe_size (which is actually the device extent
 length), based on the actual maximum amount of available raw disk space:
   stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);

 stripe_size is now 789MiB

 Next we do...
   data_stripes = num_stripes / ncopies
 ...where data_stripes ends up as 1, because num_stripes is 2 (the amount
 of device extents we're going to have), and DUP has ncopies 2.

 Next there's a check...
   if (stripe_size * data_stripes > max_chunk_size)
 ...which matches because 789MiB * 1 > 788MiB.

 We go into the if code, and next is...
   stripe_size = div_u64(max_chunk_size, data_stripes);
 ...which resets stripe_size to max_chunk_size: 788MiB

 Next is a fun one...
   /* bump the answer up to a 16MB boundary */
   stripe_size = round_up(stripe_size, SZ_16M);
 ...which changes stripe_size from 788MiB to 800MiB.

 We're not done changing stripe_size yet...
   /* But don't go higher than the limits we found while searching
    * for free extents
    */
   stripe_size = min(devices_info[ndevs - 1].max_avail,
       	      stripe_size);

 This is bad. max_avail is twice the stripe_size (we need to fit 2 device
 extents on the same device for DUP).

 The result here is that 800MiB < 1578MiB, so it's unchanged. However,
 the resulting DUP chunk will need 1600MiB disk space, which isn't there,
 and the second dev_extent might extend into the next thing (next
 dev_extent? end of device?) for 22MiB.

 The last shown line of code relies on a situation where there's twice
 the value of stripe_size present as value for the variable stripe_size
 when it's DUP. This was actually the case before commit 92e222df7b
 "btrfs: alloc_chunk: fix DUP stripe size handling", from which I quote:
   "[...] in the meantime there's a check to see if the stripe_size does
 not exceed max_chunk_size. Since during this check stripe_size is twice
 the amount as intended, the check will reduce the stripe_size to
 max_chunk_size if the actual correct to be used stripe_size is more than
 half the amount of max_chunk_size."

 In the previous version of the code, the 16MiB alignment (why is this
 done, by the way?) would result in a 50% chance that it would actually
 do an 8MiB alignment for the individual dev_extents, since it was
 operating on double the size. Does this matter?

 Does it matter that stripe_size can be set to anything which is not
 16MiB aligned because of the amount of remaining available disk space
 which is just taken?

 What is the main purpose of this round_up?

 The most straightforward thing to do seems something like...
   stripe_size = min(
       div_u64(devices_info[ndevs - 1].max_avail, dev_stripes),
       stripe_size
   )
 ..just putting half of the max_avail into stripe_size."

Link: https://lore.kernel.org/linux-btrfs/b3461a38-e5f8-f41d-c67c-2efac8129054@mendix.com/
Reported-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
[ add analysis from report ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c872adfc939e..cd426e595aac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7485,6 +7485,8 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	struct btrfs_path *path;
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_key key;
+	u64 prev_devid = 0;
+	u64 prev_dev_ext_end = 0;
 	int ret = 0;
 
 	key.objectid = 1;
@@ -7529,10 +7531,22 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 		chunk_offset = btrfs_dev_extent_chunk_offset(leaf, dext);
 		physical_len = btrfs_dev_extent_length(leaf, dext);
 
+		/* Check if this dev extent overlaps with the previous one */
+		if (devid == prev_devid && physical_offset < prev_dev_ext_end) {
+			btrfs_err(fs_info,
+"dev extent devid %llu physical offset %llu overlap with previous dev extent end %llu",
+				  devid, physical_offset, prev_dev_ext_end);
+			ret = -EUCLEAN;
+			goto out;
+		}
+
 		ret = verify_one_dev_extent(fs_info, chunk_offset, devid,
 					    physical_offset, physical_len);
 		if (ret < 0)
 			goto out;
+		prev_devid = devid;
+		prev_dev_ext_end = physical_offset + physical_len;
+
 		ret = btrfs_next_item(root, path);
 		if (ret < 0)
 			goto out;
-- 
2.19.1



