Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt5gyXrbE7n6L9YNbhA8YyfD2ZFO+fW/zKZzJbU3CV9zR3D8HSQB4zLBP6m5Sbi/D+FucrM
ARC-Seal: i=1; a=rsa-sha256; t=1521214666; cv=none;
        d=google.com; s=arc-20160816;
        b=qqcoJtC4Pfxdwy+hi+dAO5xO/PIUm6nSjLv9vIfpRnL7uQ9ogMYcHbK9dYEECK6awi
         tw6g68KDzq0Dwn5FgSqTY5kRy75StxDksEidi7dXchhF3r+mNXROJdEaWJY/zHN2onTy
         l7Vnki5oPrUKfzxvgfPnmrKLlmv62RidRzKWcUW8gCmugw6rG9d6dBL2wevjnv29Qd78
         AiW/sxxYtd6nJXxH8WCf66SaLu1yOw96DxceJh1BF1pWFXRYK3rpuHKoSFc4wO2k10l6
         nDHJlMqWd2hrApwmsik8XOMPqCg9HSa1ukWMyl5lGsbt2XuL2FZUYljulEBwwl21rMIt
         IBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vRfUS9Z+nfZejyIXr4j7S1c3atAIbWVehX+U+FJoAPg=;
        b=H9JF95zl5rGPWHyzkKNm9YprEP0ZVcjpWCGhRvC1RebWzxt0yl0vobjihv38rNZz/8
         Tby2Erp+gQ6e5pIWR5WaQ8mV98lP647EkOV9xmZdtoWKAWCMbUmmCqcxM5IUDn8lNdM+
         BpIh7AnlpLKRiEiiRQIYNLIw7bRe2Qy6C/AToTaDuBd2l0P4pu6BH3OIicCyLcG5Wuv2
         /PfftsP++SMUsgHR4IHyDHS/VqDMeT+wi5LOuH+R0W8pNaFohUJ5pTQ692nkC9M55K59
         YLn0dTg97mVUoqYkyxaMpg8nsWH/tL3DDk7O/YfMzaq47eBcdh9uK801j0Ds9XWlNP7X
         lmnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heinz Mauelshagen <heinzm@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 086/109] dm raid: fix raid set size revalidation
Date: Fri, 16 Mar 2018 16:23:55 +0100
Message-Id: <20180316152334.604059087@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109189901426479?=
X-GMAIL-MSGID: =?utf-8?q?1595109189901426479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinz Mauelshagen <heinzm@redhat.com>


[ Upstream commit 61e06e2c3ebd986050958513bfa40dceed756f8f ]

The raid set size is being revalidated unconditionally before a
reshaping conversion is started.  MD requires the size to only be
reduced in case of a stripe removing (i.e. shrinking) reshape but not
when growing because the raid array has to stay small until after the
growing reshape finishes.

Fix by avoiding the size revalidation in preresume unless a shrinking
reshape is requested.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -675,15 +675,11 @@ static struct raid_type *get_raid_type_b
 	return NULL;
 }
 
-/*
- * Conditionally change bdev capacity of @rs
- * in case of a disk add/remove reshape
- */
-static void rs_set_capacity(struct raid_set *rs)
+/* Adjust rdev sectors */
+static void rs_set_rdev_sectors(struct raid_set *rs)
 {
 	struct mddev *mddev = &rs->md;
 	struct md_rdev *rdev;
-	struct gendisk *gendisk = dm_disk(dm_table_get_md(rs->ti->table));
 
 	/*
 	 * raid10 sets rdev->sector to the device size, which
@@ -692,8 +688,16 @@ static void rs_set_capacity(struct raid_
 	rdev_for_each(rdev, mddev)
 		if (!test_bit(Journal, &rdev->flags))
 			rdev->sectors = mddev->dev_sectors;
+}
 
-	set_capacity(gendisk, mddev->array_sectors);
+/*
+ * Change bdev capacity of @rs in case of a disk add/remove reshape
+ */
+static void rs_set_capacity(struct raid_set *rs)
+{
+	struct gendisk *gendisk = dm_disk(dm_table_get_md(rs->ti->table));
+
+	set_capacity(gendisk, rs->md.array_sectors);
 	revalidate_disk(gendisk);
 }
 
@@ -1674,8 +1678,11 @@ static void do_table_event(struct work_s
 	struct raid_set *rs = container_of(ws, struct raid_set, md.event_work);
 
 	smp_rmb(); /* Make sure we access most actual mddev properties */
-	if (!rs_is_reshaping(rs))
+	if (!rs_is_reshaping(rs)) {
+		if (rs_is_raid10(rs))
+			rs_set_rdev_sectors(rs);
 		rs_set_capacity(rs);
+	}
 	dm_table_event(rs->ti->table);
 }
 
@@ -3845,11 +3852,10 @@ static int raid_preresume(struct dm_targ
 		mddev->resync_min = mddev->recovery_cp;
 	}
 
-	rs_set_capacity(rs);
-
 	/* Check for any reshape request unless new raid set */
 	if (test_and_clear_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		/* Initiate a reshape. */
+		rs_set_rdev_sectors(rs);
 		mddev_lock_nointr(mddev);
 		r = rs_start_reshape(rs);
 		mddev_unlock(mddev);
@@ -3878,6 +3884,10 @@ static void raid_resume(struct dm_target
 	mddev->ro = 0;
 	mddev->in_sync = 0;
 
+	/* Only reduce raid set size before running a disk removing reshape. */
+	if (mddev->delta_disks < 0)
+		rs_set_capacity(rs);
+
 	/*
 	 * Keep the RAID set frozen if reshape/rebuild flags are set.
 	 * The RAID set is unfrozen once the next table load/resume,
