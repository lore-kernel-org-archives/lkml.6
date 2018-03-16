Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs5VdA5dH2V7cDLVf/rOD2OhgGqRXOgeTX/ZUFNF+upc6uI6ytNiFFy+Ogrj8EY8lRv3wBv
ARC-Seal: i=1; a=rsa-sha256; t=1521215037; cv=none;
        d=google.com; s=arc-20160816;
        b=cCi/LswiWJXhK5EwZcOv8lKWOr0JLMsB7n50Xd+0kNpokVVNAOTXuDXEe0pUB9wIzu
         vPHeZfBdwNsf4fQhCqmGC/Xlp/yu4y1H+6IMkNEc+gUcCjhFd/Ev7Oumbx9XmVbiZaw9
         DSdtUomWEwPEzLALEDMkyGldJ/M/sZLvQYbt3GYuGzFYswZwZnwfpC40PoW+gZnoVE8x
         ktyTALkDtlTrvek9/PZ+VHf42CuHD6rLDlSrEd9m1WOEqD5J5DwTPTUYCmc12vb4hc2h
         CHL8WvhDFfyV19bxeEeoX0g8AKsoTl83B7Q5v0/AXtkF6CwUa7N0UrlAIiHzo52G7o2G
         ka+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XRHrCeKX/JHSetyGRBh1msINKUTQXk5ulRtQWl9aHwM=;
        b=GPZmUs2Nt9QT5Cj46zEHrXSJ7onIczIUKVPfLHml9HvV+/QlmsK9qazsRnO+DV5xrf
         HNZZTg9kMrhFOK7HuglW+FZ2XIbHatAxzBSn47CnCW9WoVMqRB+4CS463LJ4VvSxGUCa
         HI82vZ9Z6Bc9I/kcGD9Xsp2CIbmpAi+frWu7ldZB77jdd9zSGaKA05qUk2K8RzlRz5uX
         yzj8XK/HeXclzthqrVMR7eaUNpfEa0lJF3i4u9HbSdwsXtYzK20ZmFOnAXXTnjiJBkxe
         p2P8KjstxE/M6H02HlJk8RC9qJg95MmqP9Fkgd6/y42V1DEU+brY0QTTGPdIxAcInyDY
         X48g==
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
Subject: [PATCH 4.15 105/128] dm raid: fix raid set size revalidation
Date: Fri, 16 Mar 2018 16:24:06 +0100
Message-Id: <20180316152341.774921469@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109189901426479?=
X-GMAIL-MSGID: =?utf-8?q?1595109578661343919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -3842,11 +3849,10 @@ static int raid_preresume(struct dm_targ
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
@@ -3875,6 +3881,10 @@ static void raid_resume(struct dm_target
 	mddev->ro = 0;
 	mddev->in_sync = 0;
 
+	/* Only reduce raid set size before running a disk removing reshape. */
+	if (mddev->delta_disks < 0)
+		rs_set_capacity(rs);
+
 	/*
 	 * Keep the RAID set frozen if reshape/rebuild flags are set.
 	 * The RAID set is unfrozen once the next table load/resume,
