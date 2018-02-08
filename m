Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeBHPXc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:23:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:65426 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbeBHPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:23:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,479,1511856000";
   d="scan'208";a="18306797"
Date: Thu, 8 Feb 2018 08:27:30 -0700
From: Keith Busch <keith.busch@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org, axboe@fb.com,
        linux-nvme@lists.infradead.org, joshi.k@samsung.com
Subject: Re: [PATCH] blk: optimization for classic polling
Message-ID: <20180208152730.GA4906@localhost.localdomain>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2083 at 09:51:06AM +0530, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.
> 
> Reference:
> http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  fs/block_dev.c | 16 ++++++++++++----
>  fs/direct-io.c |  8 ++++++--
>  fs/iomap.c     | 10 +++++++---
>  3 files changed, 25 insertions(+), 9 deletions(-)

I think it'd be simpler to have blk_poll set it back to running if
need_resched is true rather than repeat this patter across all the
callers:

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102e2149..40285fe1c8ad 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		cpu_relax();
 	}
 
+	set_current_state(TASK_RUNNING);
 	return false;
 }
 
--
