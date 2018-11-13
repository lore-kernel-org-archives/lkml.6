Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEA121780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvkPzukP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEA121780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeKNGN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:13:28 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37019 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeKNGN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:13:27 -0500
Received: by mail-yw1-f66.google.com with SMTP id v77-v6so6343572ywc.4;
        Tue, 13 Nov 2018 12:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2ZrBBNm0u84HZ38qh08jp3zITb1XB0WpVsLPVfRiw/w=;
        b=kvkPzukP6X+WB0lrK9Kb15QmO+Y28dYN4/HwZwFWSZiLwAiQucsf5UiCKQrssc52Eu
         Y4anHzde6DWnJ09mBznlH0PToeqI9ZfNx0ZZSoF+fqy73xVQXw7QHAOAfCwXU5sEl6ft
         9xj5ygEqPamdm5kgG1eOdsuGoXtmFOVuHwx3NZSrhopzkxh1k2qqS97KsfCCqWamx+iY
         OQGHPyfq98gg5H0/YXGkiLj7kmAytyDeLGwzbem8azd4hSwzDGNP6J8JjPBE1Bujl0Xz
         nXQWcNxNVSLN4NtVtb67CAU4OS/J9hcnzBqQdJoLu9nS2Q3ve/30hd7esALp0qMCDdxJ
         xeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=2ZrBBNm0u84HZ38qh08jp3zITb1XB0WpVsLPVfRiw/w=;
        b=b/BjhLo7NemwDf6NrAW+XRAhKuQt5PyMLDM5DelktnuSQD3EMJMiAIIz753FwcruXv
         REBZyE1F19lcaeQFh/89n8rYV4Zc0FsLeDYt1Btkw9mwsg+idLuCCCXk3lO/jUJnofJM
         WWohxpqm754Drz2zFVAwsAiYUpKewD3Bl6LQMg6fqetl1rVRakLtF2jy5HRiUXobXEAl
         WmdW1qOfABGFFLdVaf75veBPInbKffbuUrLQHNprz3nUtIzbLgowwoudR5VRUojojcQW
         wBlssKO/oBFropOVG5PX1UtU1pi1opa94P2THLJP3CtxqzE83Xz8dHZd0YquCr5Aw+cM
         DO7g==
X-Gm-Message-State: AGRZ1gLbhPPrtPZT6z0NCOsXEr7RH32F4WB4qN2pnoRCjleg0AaVUb7s
        B02rLsD1R2zVH15I7STIZ1Q=
X-Google-Smtp-Source: AJdET5ekWUR6z7RLbXon7jo80PZ30HAvFYiRgRigx+aDztQ6IhCa9gPlxOdv9bBpENl7PlAXoWNz8w==
X-Received: by 2002:a0d:ff03:: with SMTP id p3-v6mr6523008ywf.228.1542140023216;
        Tue, 13 Nov 2018 12:13:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id f1-v6sm6935738ywb.89.2018.11.13.12.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:13:42 -0800 (PST)
Date:   Tue, 13 Nov 2018 12:13:39 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-4.21 1/2] cpuset: Minor cgroup2 interface updates
Message-ID: <20181113201339.GN2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From b1e3aeb11c5e86ee0988a038c4e7682d6beaa977 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 13 Nov 2018 12:03:33 -0800

* Rename the partition file from "cpuset.sched.partition" to
  "cpuset.cpus.partition".

* When writing to the partition file, drop "0" and "1" and only accept
  "member" and "root".

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
---
Two minor cpuset interface followup patches.  Applying to
cgroup/for-4.21.

Thanks.

 Documentation/admin-guide/cgroup-v2.rst | 6 +++---
 kernel/cgroup/cpuset.c                  | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f83a5231bbe3..07e06136a550 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1708,15 +1708,15 @@ Cpuset Interface Files
 
 	Its value will be affected by memory nodes hotplug events.
 
-  cpuset.sched.partition
+  cpuset.cpus.partition
 	A read-write single value file which exists on non-root
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
 	and is not delegatable.
 
         It accepts only the following input values when written to.
 
-        "root" or "1"   - a paritition root
-        "member" or "0" - a non-root member of a partition
+        "root"   - a paritition root
+        "member" - a non-root member of a partition
 
 	When set to be a partition root, the current cgroup is the
 	root of a new partition or scheduling domain that comprises
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b897314bab53..1151e93d71b6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2468,11 +2468,11 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	buf = strstrip(buf);
 
 	/*
-	 * Convert "root"/"1" to 1, and convert "member"/"0" to 0.
+	 * Convert "root" to ENABLED, and convert "member" to DISABLED.
 	 */
-	if (!strcmp(buf, "root") || !strcmp(buf, "1"))
+	if (!strcmp(buf, "root"))
 		val = PRS_ENABLED;
-	else if (!strcmp(buf, "member") || !strcmp(buf, "0"))
+	else if (!strcmp(buf, "member"))
 		val = PRS_DISABLED;
 	else
 		return -EINVAL;
@@ -2631,7 +2631,7 @@ static struct cftype dfl_files[] = {
 	},
 
 	{
-		.name = "sched.partition",
+		.name = "cpus.partition",
 		.seq_show = sched_partition_show,
 		.write = sched_partition_write,
 		.private = FILE_PARTITION_ROOT,
-- 
2.17.1

