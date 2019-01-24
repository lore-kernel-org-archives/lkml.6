Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9AEC282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5AD21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358641;
	bh=IuQENAwQCJScWEvnGRBc8wiLDBkf0YbhfVXeTO31Xz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ChmzKxpjc2t+2bmedvXLeIAg1NffMIu/0NAWwmsSwvReoIEYuC+ILXGv16AfXrENE
	 eGeEcOtPAzotKQmPhyGLrS9kZRKNvy7numXo0cHzB/qg+7e7gaJNg5jc9KT1/mZqB7
	 uWAJu8VIp2rzU3FYcvzVccu+RVwU/zIrJFnIcg1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbfAXThT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbfAXThQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613AA218FC;
        Thu, 24 Jan 2019 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358635;
        bh=IuQENAwQCJScWEvnGRBc8wiLDBkf0YbhfVXeTO31Xz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsK2/HrAAzcyJUT5lnW6Go9IDGzxeQdgP7k7ce7On74FEbmdMAF+hrYr/CfQrO1Pe
         PFg7/tV0ivBZlOVTUMPpdRHw+rj+oIn6DQv0+7aHvrZjx19OLI2eapwMiF4N7h8Dd0
         IwB+Wj2wRLyAe3RI8Xoxr2JItyLNDxCi1133CGa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/106] btrfs: alloc_chunk: fix more DUP stripe size handling
Date:   Thu, 24 Jan 2019 20:20:18 +0100
Message-Id: <20190124190210.297276953@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit baf92114c7e6dd6124aa3d506e4bc4b694da3bc3 ]

Commit 92e222df7b "btrfs: alloc_chunk: fix DUP stripe size handling"
fixed calculating the stripe_size for a new DUP chunk.

However, the same calculation reappears a bit later, and that one was
not changed yet. The resulting bug that is exposed is that the newly
allocated device extents ('stripes') can have a few MiB overlap with the
next thing stored after them, which is another device extent or the end
of the disk.

The scenario in which this can happen is:
* The block device for the filesystem is less than 10GiB in size.
* The amount of contiguous free unallocated disk space chosen to use for
  chunk allocation is 20% of the total device size, or a few MiB more or
  less.

An example:
- The filesystem device is 7880MiB (max_chunk_size gets set to 788MiB)
- There's 1578MiB unallocated raw disk space left in one contiguous
  piece.

In this case stripe_size is first calculated as 789MiB, (half of
1578MiB).

Since 789MiB (stripe_size * data_stripes) > 788MiB (max_chunk_size), we
enter the if block. Now stripe_size value is immediately overwritten
while calculating an adjusted value based on max_chunk_size, which ends
up as 788MiB.

Next, the value is rounded up to a 16MiB boundary, 800MiB, which is
actually more than the value we had before. However, the last comparison
fails to detect this, because it's comparing the value with the total
amount of free space, which is about twice the size of stripe_size.

In the example above, this means that the resulting raw disk space being
allocated is 1600MiB, while only a gap of 1578MiB has been found. The
second device extent object for this DUP chunk will overlap for 22MiB
with whatever comes next.

The underlying problem here is that the stripe_size is reused all the
time for different things. So, when entering the code in the if block,
stripe_size is immediately overwritten with something else. If later we
decide we want to have the previous value back, then the logic to
compute it was copy pasted in again.

With this change, the value in stripe_size is not unnecessarily
destroyed, so the duplicated calculation is not needed any more.

Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dbb893d0ae81..0ee1cd4b56fb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4768,19 +4768,17 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	/*
 	 * Use the number of data stripes to figure out how big this chunk
 	 * is really going to be in terms of logical address space,
-	 * and compare that answer with the max chunk size
+	 * and compare that answer with the max chunk size. If it's higher,
+	 * we try to reduce stripe_size.
 	 */
 	if (stripe_size * data_stripes > max_chunk_size) {
-		stripe_size = div_u64(max_chunk_size, data_stripes);
-
-		/* bump the answer up to a 16MB boundary */
-		stripe_size = round_up(stripe_size, SZ_16M);
-
 		/*
-		 * But don't go higher than the limits we found while searching
-		 * for free extents
+		 * Reduce stripe_size, round it up to a 16MB boundary again and
+		 * then use it, unless it ends up being even bigger than the
+		 * previous value we had already.
 		 */
-		stripe_size = min(devices_info[ndevs - 1].max_avail,
+		stripe_size = min(round_up(div_u64(max_chunk_size,
+						   data_stripes), SZ_16M),
 				  stripe_size);
 	}
 
-- 
2.19.1



