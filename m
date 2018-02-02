Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224hI3KJaiHLIYGDwjbazgUaNG7um5o03/Q2xyuXWX2YHxOZIQUPdH3ElO0cW7tdLKxOWJFK
ARC-Seal: i=1; a=rsa-sha256; t=1517591110; cv=none;
        d=google.com; s=arc-20160816;
        b=lArn5AgSz37pGW0ywiviwrUMYQCsWq5arKo5gD77PJXatf8kNmTSnJTQg4hOOg3pP0
         NcBOujEbVVGVxPHsQrkhGRmOGev3L2Pkcp6EO5eMHTbuDfpkB3uVH3b65x4Zsoxw0v1y
         srfrrc06sYSkwY8Nekcp7xKCLByqeqM5M1HqWtlwHnEm4Uor7PffRFcvXag8JHx7FyYu
         E64JHZ7oxol2BeuJTmJPfkYb0PxAB+ZfpC1CCu8mmC+KjBW5LeTEyflFzYvWk+lx4dWa
         ZeJxknEijSAzRbomYoejWBQ6C1uaby8NdXCgqWmarhmd1a5ERPXE9fAGrSkbVxvOEZzq
         VeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HN3k4TMW/LH6UZfMxbKQckVtrt7WsPLEg6RzCUiCAUQ=;
        b=fxdBESp277dApn79SnTqCH1xDxQP11o3DNnLC37b4JUMSXy6Z90xL6E09GkOtwqnBy
         CD8wuPqBatycO+90AwAmPOuMWFy5//nX+gtC+bXS/mJrX3ZEuvj8UGWTPJZOBxrNJJWZ
         O8CkDYSlg4zI8rWIbotJMmPVlOdThFBZxcRtTLzLZRFIfBDmnCAdyykONB8Uq8COVxYV
         yI+koGfLdGpeYby0cauaA6p1oB+dvYZ9/P12imqQDAVDUfUxX3rMzyTqyV62/CZT1kjz
         UUNDt+7/aD/H2s/Y1uzc2ZPdAcrxWuB+HtT7y6VNzWnTnmhu45gAGr9VmHcbYs0P+5MM
         Vb3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 48/86] xfs: fortify xfs_alloc_buftarg error handling
Date: Fri,  2 Feb 2018 17:58:08 +0100
Message-Id: <20180202140826.688891482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309616616792419?=
X-GMAIL-MSGID: =?utf-8?q?1591309616616792419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>


[ Upstream commit d210a9874b8f6166579408131cb74495caff1958 ]

percpu_counter_init failure path doesn't clean up &btp->bt_lru list.
Call list_lru_destroy in that error path. Similarly register_shrinker
error path is not handled.

While it is unlikely to trigger these error path, it is not impossible
especially the later might fail with large NUMAs.  Let's handle the
failure to make the code more robust.

Noticed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_buf.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1785,22 +1785,27 @@ xfs_alloc_buftarg(
 	btp->bt_bdi = blk_get_backing_dev_info(bdev);
 
 	if (xfs_setsize_buftarg_early(btp, bdev))
-		goto error;
+		goto error_free;
 
 	if (list_lru_init(&btp->bt_lru))
-		goto error;
+		goto error_free;
 
 	if (percpu_counter_init(&btp->bt_io_count, 0, GFP_KERNEL))
-		goto error;
+		goto error_lru;
 
 	btp->bt_shrinker.count_objects = xfs_buftarg_shrink_count;
 	btp->bt_shrinker.scan_objects = xfs_buftarg_shrink_scan;
 	btp->bt_shrinker.seeks = DEFAULT_SEEKS;
 	btp->bt_shrinker.flags = SHRINKER_NUMA_AWARE;
-	register_shrinker(&btp->bt_shrinker);
+	if (register_shrinker(&btp->bt_shrinker))
+		goto error_pcpu;
 	return btp;
 
-error:
+error_pcpu:
+	percpu_counter_destroy(&btp->bt_io_count);
+error_lru:
+	list_lru_destroy(&btp->bt_lru);
+error_free:
 	kmem_free(btp);
 	return NULL;
 }
