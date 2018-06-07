Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BHw+FOFHGVuIQQAAmS7hNA
	; Thu, 07 Jun 2018 14:58:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 81C9B607E7; Thu,  7 Jun 2018 14:58:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C16BF606DD;
	Thu,  7 Jun 2018 14:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C16BF606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935534AbeFGO6T (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:58:19 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41172 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933329AbeFGO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:12 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbV-0005hJ-T9; Thu, 07 Jun 2018 15:09:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003Ao-2V; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Naohiro Aota" <naohiro.aota@wdc.com>,
        "Hans van Kranenburg" <hans.van.kranenburg@mendix.com>,
        "David Sterba" <dsterba@suse.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.238070794@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 314/410] btrfs: alloc_chunk: fix DUP stripe size handling
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

commit 92e222df7b8f05c565009c7383321b593eca488b upstream.

In case of using DUP, we search for enough unallocated disk space on a
device to hold two stripes.

The devices_info[ndevs-1].max_avail that holds the amount of unallocated
space found is directly assigned to stripe_size, while it's actually
twice the stripe size.

Later on in the code, an unconditional division of stripe_size by
dev_stripes corrects the value, but in the meantime there's a check to
see if the stripe_size does not exceed max_chunk_size. Since during this
check stripe_size is twice the amount as intended, the check will reduce
the stripe_size to max_chunk_size if the actual correct to be used
stripe_size is more than half the amount of max_chunk_size.

The unconditional division later tries to correct stripe_size, but will
actually make sure we can't allocate more than half the max_chunk_size.

Fix this by moving the division by dev_stripes before the max chunk size
check, so it always contains the right value, instead of putting a duct
tape division in further on to get it fixed again.

Since in all other cases than DUP, dev_stripes is 1, this change only
affects DUP.

Other attempts in the past were made to fix this:
* 37db63a400 "Btrfs: fix max chunk size check in chunk allocator" tried
to fix the same problem, but still resulted in part of the code acting
on a wrongly doubled stripe_size value.
* 86db25785a "Btrfs: fix max chunk size on raid5/6" unintentionally
broke this fix again.

The real problem was already introduced with the rest of the code in
73c5de0051.

The user visible result however will be that the max chunk size for DUP
will suddenly double, while it's actually acting according to the limits
in the code again like it was 5 years ago.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Link: https://www.spinics.net/lists/linux-btrfs/msg69752.html
Fixes: 73c5de0051 ("btrfs: quasi-round-robin for chunk allocation")
Fixes: 86db25785a ("Btrfs: fix max chunk size on raid5/6")
Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: We were using do_div() here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/volumes.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4241,10 +4241,13 @@ static int __btrfs_alloc_chunk(struct bt
 	if (devs_max && ndevs > devs_max)
 		ndevs = devs_max;
 	/*
-	 * the primary goal is to maximize the number of stripes, so use as many
-	 * devices as possible, even if the stripes are not maximum sized.
+	 * The primary goal is to maximize the number of stripes, so use as
+	 * many devices as possible, even if the stripes are not maximum sized.
+	 *
+	 * The DUP profile stores more than one stripe per device, the
+	 * max_avail is the total size so we have to adjust.
 	 */
-	stripe_size = devices_info[ndevs-1].max_avail;
+	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
 	num_stripes = ndevs * dev_stripes;
 
 	/*
@@ -4284,8 +4287,6 @@ static int __btrfs_alloc_chunk(struct bt
 			stripe_size = devices_info[ndevs-1].max_avail;
 	}
 
-	do_div(stripe_size, dev_stripes);
-
 	/* align to BTRFS_STRIPE_LEN */
 	do_div(stripe_size, raid_stripe_len);
 	stripe_size *= raid_stripe_len;
