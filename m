Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225f795YqlnXRELgvs3zNYBrVWTyfytO8wwm+SWOx1EatMzwthwcFrmE7+B8aCPCEso4nicW
ARC-Seal: i=1; a=rsa-sha256; t=1517591496; cv=none;
        d=google.com; s=arc-20160816;
        b=Ug4j7IX3fR5bkZu87i88cRdGKNFh4ZMpS61YbIEoL1fIJZKhAHtuw4NmNyj0joxy6Z
         PdDIad6NGc0yhYm1gmDkTTjI6PqAH5T3sbNOAj/sFnaaHoXASohYBMl+q8XkrV5Glyuf
         a0vnPB3x8RQjUc2cb57FTj5/aZby6hVtxBMkcU74gpvS6a7mhYDG8CbCZQN8C7lNE+zv
         5mKIhPcjvenPClGXxD7H+/pe1F4oBDONIJjHI51edFEM75F95DAFGldVTC/M6yQti36B
         Ixdd2P8HQIOl0Zw1Aok3wULDx8Ol1wMgs0gfdAcXQHGYD+8m1AvDvo30TggnIxCZvASB
         TIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zaKbRa+T4U0XzoW8jaMvirD5R7lkbeG4spSOCb4/o38=;
        b=pO7WPIF+A+HtCityrinrqd7dPlV95wV6J3EmB67YJOht4eD351Aj/x6VFkIPlf+AlL
         7u9b/S2X17H9frYj7e1Zd+PhgfBs5QYNQmUut1Si1oL554XLEs1cs2x8RHk0edWjnVXn
         xvWY4F+ftSexgk5MSum00GvOkMH5YLtvq273xWHCtYqNFkS7DxV+cwC74ERmk4KZXflM
         VixfH5FqXN0e1/gkNrWDW/bUPCrTp0gwrv0wvCgBX1sBSByhwQGThNW2zN/gOB/95oSe
         p+QPMi3AiigzhUw/T2vVfxWB5syiGv1YYpp8+zDr1T26p/iVT4Xeika1pRl73/BgZo2O
         GivA==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 098/156] xfs: fortify xfs_alloc_buftarg error handling
Date: Fri,  2 Feb 2018 17:57:59 +0100
Message-Id: <20180202140844.647380902@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309616616792419?=
X-GMAIL-MSGID: =?utf-8?q?1591310020425344115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_buf.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1813,22 +1813,27 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = dax_dev;
 
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
