Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsBSecxTXld4cErhqNYkskT5FJ13J+Pwc+ohB7mHJdxvY4twfRCpkzf99ePwbXV+2IWHYDQ
ARC-Seal: i=1; a=rsa-sha256; t=1521484225; cv=none;
        d=google.com; s=arc-20160816;
        b=SY6rbQTZb8fUng5sXobAFni/3sZMNEVIQItlld0Nc+SSoohFj5XRlvGdasOKMgND2D
         6l0OrzYYnMp2ypndbp1uXbQKLm6yhKk1uFSurkU+citJVvsGe5nm1caocP8xtkFXFV3E
         yEXDKP5jMq2eHoG2DyuP/+BzAREbPW/APhLdxJAEuLSndMGxMNa1R3010o8dd7LOQvaK
         H6HLArbvqaVLCU5viQoEYASbBXIDbP3iS5DIHMJO32YpJXhfrIGNqlJGO0KKgDD+7XNZ
         rfnEjDiosvizVB41nkes6tGlJjU2ZbxuXR0AWBkX4TdZUHZhmcuHy9AGsmInyy+rBUYL
         opmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fB3HErIUUC/XKPssuXRCvelrfgtoDMsdkQ15WqT415M=;
        b=bFMmoEaJ+2Uv5Jq60SHlgPB6Uv3AN+oYfh6EJyxmhuUXAB7dWCZ5MwGY0M6+87X96j
         iGyLRnCxkUKCd1nYwMlTWjn8y2GZkrmZv+Iku+Wt0L4K3YZOl/tmzgkD1nT/qp1X68zP
         DT68A1uMJC1PTtmxKowMN+lq7JmMhnGbJ4d0arfuJOryIo0Hr/gCsnNciOUIUgf6fngI
         ztyvXNeAoqDM4EWbOZUhsqKNviGe532wNb35zUNr1D9U8G3oNnp6rl74n4jcZ4bgyAkQ
         0/Ne+eQY5k2jVtEUtNrWAmQnOiBovJACi4cSX5HVa/8RHBIepE+eYvBcerntTLc/hR6w
         vhbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 35/41] btrfs: Fix memory barriers usage with device stats counters
Date: Mon, 19 Mar 2018 19:08:35 +0100
Message-Id: <20180319180734.512334467@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391842925372502?=
X-GMAIL-MSGID: =?utf-8?q?1595391842925372502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit 9deae9689231964972a94bb56a79b669f9d47ac1 upstream.

Commit addc3fa74e5b ("Btrfs: Fix the problem that the dirty flag of dev
stats is cleared") reworked the way device stats changes are tracked. A
new atomic dev_stats_ccnt counter was introduced which is incremented
every time any of the device stats counters are changed. This serves as
a flag whether there are any pending stats changes. However, this patch
only partially implemented the correct memory barriers necessary:

- It only ordered the stores to the counters but not the reads e.g.
  btrfs_run_dev_stats
- It completely omitted any comments documenting the intended design and
  how the memory barriers pair with each-other

This patch provides the necessary comments as well as adds a missing
smp_rmb in btrfs_run_dev_stats. Furthermore since dev_stats_cnt is only
a snapshot at best there was no point in reading the counter twice -
once in btrfs_dev_stats_dirty and then again when assigning stats_cnt.
Just collapse both reads into 1.

Fixes: addc3fa74e5b ("Btrfs: Fix the problem that the dirty flag of dev stats is cleared")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |   18 ++++++++++++++++--
 fs/btrfs/volumes.h |   12 ++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7082,10 +7082,24 @@ int btrfs_run_dev_stats(struct btrfs_tra
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		if (!device->dev_stats_valid || !btrfs_dev_stats_dirty(device))
+		stats_cnt = atomic_read(&device->dev_stats_ccnt);
+		if (!device->dev_stats_valid || stats_cnt == 0)
 			continue;
 
-		stats_cnt = atomic_read(&device->dev_stats_ccnt);
+
+		/*
+		 * There is a LOAD-LOAD control dependency between the value of
+		 * dev_stats_ccnt and updating the on-disk values which requires
+		 * reading the in-memory counters. Such control dependencies
+		 * require explicit read memory barriers.
+		 *
+		 * This memory barriers pairs with smp_mb__before_atomic in
+		 * btrfs_dev_stat_inc/btrfs_dev_stat_set and with the full
+		 * barrier implied by atomic_xchg in
+		 * btrfs_dev_stats_read_and_reset
+		 */
+		smp_rmb();
+
 		ret = update_dev_stat_item(trans, fs_info, device);
 		if (!ret)
 			atomic_sub(stats_cnt, &device->dev_stats_ccnt);
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -498,6 +498,12 @@ static inline void btrfs_dev_stat_inc(st
 				      int index)
 {
 	atomic_inc(dev->dev_stat_values + index);
+	/*
+	 * This memory barrier orders stores updating statistics before stores
+	 * updating dev_stats_ccnt.
+	 *
+	 * It pairs with smp_rmb() in btrfs_run_dev_stats().
+	 */
 	smp_mb__before_atomic();
 	atomic_inc(&dev->dev_stats_ccnt);
 }
@@ -523,6 +529,12 @@ static inline void btrfs_dev_stat_set(st
 				      int index, unsigned long val)
 {
 	atomic_set(dev->dev_stat_values + index, val);
+	/*
+	 * This memory barrier orders stores updating statistics before stores
+	 * updating dev_stats_ccnt.
+	 *
+	 * It pairs with smp_rmb() in btrfs_run_dev_stats().
+	 */
 	smp_mb__before_atomic();
 	atomic_inc(&dev->dev_stats_ccnt);
 }
