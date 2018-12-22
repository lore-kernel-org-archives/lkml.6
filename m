Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5059BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202E721928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erpFjPWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404232AbeLVADR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:03:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38554 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLVADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:03:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so3167165plb.5;
        Fri, 21 Dec 2018 16:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RrGEExZrjErotvNk8wICdc9iWJu5BfH17QjMu1wcK58=;
        b=erpFjPWYBras5XE2h7nsoH4CdLPoGyR60K3sIf+/V/Z5Uhladw+3XWMK0w4rMo/YvW
         KP/AnoXHgbwBnie9tO3qa1j/diPkak4KdK7Sff3Yt2Exh5mYyVtCTsS1PAIdZuSckA2f
         FkPPIDRWISiC9fUvKALg71CR7ZW9amV1g+dmdceepd1EWlkuNpdCAC9b21MpxkMrRLkY
         H0nJHqJL7d12LixuISq7r/VjArt8BU+eRwgpHVVvDNlUnCiXOjGtwfeiIX8zRmQK++rE
         6Ihu9hURk95nMuj2y04LzXKtG3GOK0BNoihZlkZxnOfEPtmlLAoz5Fs044P/05RDcrTR
         SPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RrGEExZrjErotvNk8wICdc9iWJu5BfH17QjMu1wcK58=;
        b=kbAK7TFR1eYLDat9CDbAe9N2ydPza6GA8lDo+zbPI298udt/CLfhQIv8wsjcfiZScb
         xHPxurS/k3TLLhyjpQ9KJkZkt0h++esDDZF9oHXOcOohGnrzwR6v9qzwCW7Ww3f/r90t
         HH0/D7O+qw4PlyXbHzN76nzy+zHWsuW7K0rANPBD6oTkgmKqObLjOT43ZdVctCwjLwhT
         mArMAT07I9WAcSB1xyrpPB4tQ39K6MJFFgeVyHWfivh1DFfohyRmH9prle8zDr2jvJ5k
         YVUZzxoR2hJaCgn7DmemLrfPcTHedookwLmDpUushoUhA7gYEFZ73Gfk5cWwUJDPQ4ov
         iOmQ==
X-Gm-Message-State: AJcUukfsbdgE+DYCO5hog1k1GUCTex67reRSvLqGgzdgaiBEGdDOBGW7
        Cl5MMHrkl/I6TMHPrcChxDprJMuw5ZU=
X-Google-Smtp-Source: ALg8bN75zWf4gjE6aEgez/C3w+4bl7LRi6ltSwGpaSLsgbNafexVJgCi/WxSOOlhamYDMBzcmLtxRA==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr4612870plb.332.1545436993195;
        Fri, 21 Dec 2018 16:03:13 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:608f])
        by smtp.gmail.com with ESMTPSA id 83sm36659266pgf.57.2018.12.21.16.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 16:03:12 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 3/7] cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
Date:   Fri, 21 Dec 2018 16:03:03 -0800
Message-Id: <20181222000307.28231-4-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181222000307.28231-1-guro@fb.com>
References: <20181222000307.28231-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of descendant cgroups and the number of dying
descendant cgroups are currently synchronized using the cgroup_mutex.

The number of descendant cgroups will be required by the cgroup v2
freezer, which will use it to determine if a cgroup is frozen
(depending on total number of descendants and number of frozen
descendants). It's not always acceptable to grab the cgroup_mutex,
especially from quite hot paths (e.g. exit()).

To avoid this, let's additionally synchronize these counters using
the css_set_lock.

So, it's safe to read these counters with either cgroup_mutex or
css_set_lock locked, and for changing both locks should be acquired.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 include/linux/cgroup-defs.h | 5 +++++
 kernel/cgroup/cgroup.c      | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8fcbae1b8db0..03355d7008ff 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -348,6 +348,11 @@ struct cgroup {
 	 * Dying cgroups are cgroups which were deleted by a user,
 	 * but are still existing because someone else is holding a reference.
 	 * max_descendants is a maximum allowed number of descent cgroups.
+	 *
+	 * nr_descendants and nr_dying_descendants are protected
+	 * by cgroup_mutex and css_set_lock. It's fine to read them holding
+	 * any of cgroup_mutex and css_set_lock; for writing both locks
+	 * should be held.
 	 */
 	int nr_descendants;
 	int nr_dying_descendants;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7519a4307021..f89dde50f693 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4723,9 +4723,11 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgroup_on_dfl(cgrp))
 			cgroup_rstat_flush(cgrp);
 
+		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
 		     tcgrp = cgroup_parent(tcgrp))
 			tcgrp->nr_dying_descendants--;
+		spin_unlock_irq(&css_set_lock);
 
 		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id = -1;
@@ -4943,12 +4945,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	if (ret)
 		goto out_psi_free;
 
+	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		cgrp->ancestor_ids[tcgrp->level] = tcgrp->id;
 
 		if (tcgrp != cgrp)
 			tcgrp->nr_descendants++;
 	}
+	spin_unlock_irq(&css_set_lock);
 
 	if (notify_on_release(parent))
 		set_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -5233,10 +5237,12 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	if (parent && cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
 
+	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgroup_parent(cgrp); tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		tcgrp->nr_descendants--;
 		tcgrp->nr_dying_descendants++;
 	}
+	spin_unlock_irq(&css_set_lock);
 
 	cgroup1_check_for_release(parent);
 
-- 
2.19.2

