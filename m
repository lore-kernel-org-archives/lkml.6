Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326043-2-3253451247373433393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326043; b=ahkUv7YldMrXGX/Fupcd56aBX0PgtanfpbFhM4rY1133QxQ
    QKSASsMsZC0QX0tEWnfUDELI1KhUSn4tZ00SjB1A7g+nsvcKxmiiDNhGZ+0JxKtN
    7BiATO1iyZRkvfgrQG7aMaAZKddCLiBcQ7Ir5/y3iK0i2/1xK2C/osY9rDgN5Jed
    PUyALfBPitbb00dj4lyhfotQghwg7aHa62n7qNgAXStBbTZCb7AykjZ8e5lVPWrr
    CUmXld0LuE65XNcaM+AyIXFsh5LMVzoSRtlPRTZg4/nlF7uvKyyHCtOszRw93+kb
    PqJRkCoCetdgziDpV9BMXv22Nm9Q60SbK9h9Euw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326043; bh=cH7maObCjXLl6LJXthF
    /TofwFb+axSCTPTa/wWMKPVc=; b=CiPqMMIbWVFfu9W+fTcHDi+AFmdpRz/eDuf
    sEqz2XEtuw1Ffx5HRVTzjZqrsPoiH9FMtC65cx4Z64gkKg4DCcB3xiyl8SClBMq7
    BbmCfAAodfbBysLWXFQpvO4tG4rSiA4saGmmOgt9SnEdJaNIYlnLhtZjfb7Sl6YU
    VOmtlk4+ibFryWn7DUJySnT4UDaZnxuP4MyZtjgol6snJHige5NA/O0IG1OA0GrL
    wgJj5VA1MvUXzpTy9TMytTmgc5AvNzjM1Nnv5csoAyk7q3lMkA3omEv8GTX7Gruv
    2xupatxPJnrlXAQ9YUJV8o25ipeaJGbrEGuR3in6W6nIK4JVq5w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbeBKFMY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:12:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41415 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752632AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.269953005@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 44/79] dm: discard support requires all targets in a
 table support discards
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit 8a74d29d541cd86569139c6f3f44b2d210458071 upstream.

A DM device with a mix of discard capabilities (due to some underlying
devices not having discard support) _should_ just return -EOPNOTSUPP for
the region of the device that doesn't support discards (even if only by
way of the underlying driver formally not supporting discards).  BUT,
that does ask the underlying driver to handle something that it never
advertised support for.  In doing so we're exposing users to the
potential for a underlying disk driver hanging if/when a discard is
issued a the device that is incapable and never claimed to support
discards.

Fix this by requiring that each DM target in a DM table provide discard
support as a prereq for a DM device to advertise support for discards.

This may cause some configurations that were happily supporting discards
(even in the face of a mix of discard support) to stop supporting
discards -- but the risk of users hitting driver hangs, and forced
reboots, outweighs supporting those fringe mixed discard
configurations.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-table.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1584,12 +1584,12 @@ struct mapped_device *dm_table_get_md(st
 }
 EXPORT_SYMBOL(dm_table_get_md);
 
-static int device_discard_capable(struct dm_target *ti, struct dm_dev *dev,
-				  sector_t start, sector_t len, void *data)
+static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
+				      sector_t start, sector_t len, void *data)
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 
-	return q && blk_queue_discard(q);
+	return q && !blk_queue_discard(q);
 }
 
 bool dm_table_supports_discards(struct dm_table *t)
@@ -1597,26 +1597,22 @@ bool dm_table_supports_discards(struct d
 	struct dm_target *ti;
 	unsigned i = 0;
 
-	/*
-	 * Unless any target used by the table set discards_supported,
-	 * require at least one underlying device to support discards.
-	 * t->devices includes internal dm devices such as mirror logs
-	 * so we need to use iterate_devices here, which targets
-	 * supporting discard selectively must provide.
-	 */
 	while (i < dm_table_get_num_targets(t)) {
 		ti = dm_table_get_target(t, i++);
 
 		if (!ti->num_discard_requests)
-			continue;
+			return false;
 
-		if (ti->discards_supported)
-			return 1;
-
-		if (ti->type->iterate_devices &&
-		    ti->type->iterate_devices(ti, device_discard_capable, NULL))
-			return 1;
+		/*
+		 * Either the target provides discard support (as implied by setting
+		 * 'discards_supported') or it relies on _all_ data devices having
+		 * discard support.
+		 */
+		if (!ti->discards_supported &&
+		    (!ti->type->iterate_devices ||
+		     ti->type->iterate_devices(ti, device_not_discard_capable, NULL)))
+			return false;
 	}
 
-	return 0;
+	return true;
 }
