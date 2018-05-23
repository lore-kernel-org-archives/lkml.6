Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935105AbeEWXZO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:25:14 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44284 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934671AbeEWXZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:25:11 -0400
X-Google-Smtp-Source: AB8JxZrCiGSSm7G6Q7eIlGINALTGgxdpJ3qemhBx2/tScjc+7NfWte17zu7jlnSFunbS2cxA+YX6Qg==
Date: Wed, 23 May 2018 16:25:08 -0700
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH] bdi: Increase the concurrecy level of cgwb_release_wq
Message-ID: <20180523232508.GA1351649@devbig577.frc2.facebook.com>
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgwb_release_wq was added to isolate and limit the concurrency level
of cgwb release work items.  The max concurrency was set to 1 per CPU
but we do want some level of concurrency as otherwise it ends up
calling, through bdi_unregister(), synchronize_sched_expedited()
back-to-back for each release work item.

Let's allow them to bunch up a bit.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Rik van Riel <riel@surriel.com>
---
 mm/backing-dev.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8fe3ebd..f9a2268 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -790,9 +790,10 @@ static int __init cgwb_init(void)
 	/*
 	 * There can be many concurrent release work items overwhelming
 	 * system_wq.  Put them in a separate wq and limit concurrency.
-	 * There's no point in executing many of these in parallel.
+	 * Allow some level of concurrency so that we can batch on
+	 * synchronize_rcu_expedited() calls in bdi_unregister().
 	 */
-	cgwb_release_wq = alloc_workqueue("cgwb_release", 0, 1);
+	cgwb_release_wq = alloc_workqueue("cgwb_release", 0, 16);
 	if (!cgwb_release_wq)
 		return -ENOMEM;
 
