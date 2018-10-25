Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C65C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB692085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USNy79lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB692085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJYXNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:13:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46293 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeJYXNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:13:39 -0400
Received: by mail-yb1-f196.google.com with SMTP id o8-v6so3762815ybk.13;
        Thu, 25 Oct 2018 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3Pr3Agipq1HgsWB1/EX0mPKM0oZZs1CkGWymDB9IVU4=;
        b=USNy79lcPcl7+v8ZYz4OQc76n7FOmc68XM71rGMAzdrjLq5tQbpHDACzZga9Ug+ZgD
         C4kdAotKbyZz74nEcufCuQQuotpMqK6MZRejl0yRb72VSC5Ik037AxFemfsANWyvU8/3
         2CYOoZsZl7T0uWY99VhCyKbDimrlnR/zKsbRrTgT5ampRG4zX1/cOBGXeeIq1fgpmI1B
         zyBEz3iIWjjcLmeKCo+/zmWQrqoYQo3itEb2Y2rVE8gp7vZF2j0WSsxVtbJsAKNDNQxd
         bUDtDuqnEqQ9F36AEjFbk7qYx1iymRXubKGU/jOceDQs1CsAYWOQBaxntn/QEYMEDblX
         euGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3Pr3Agipq1HgsWB1/EX0mPKM0oZZs1CkGWymDB9IVU4=;
        b=hSn4pBOZ8L6TL8Y38+/ISMgX9hOredEZoYKYn5y9iUBEshFzcZiiVJG7BHqWDzkPni
         8PAFAo3hpE82n1Bb4OLA6a9K+YW3dtzWXXlb4wnjJS87Rm2aMml15iIm/U/vIDrO+jDM
         /IKtx8hmXHnzNsSnqt1090erwtXzK7E5oGy9R975QBz+PeTWdl3P5LRA7yBrce9UiQKT
         c3O7dHu8E2RyxHbHlpR0j5tWiO99pWkcLXy4ibGn6p4HTWIusKF+0vq0aDGwXgAFcwA2
         YP9EoM4mYzthdADHKeLeZ1jB+n9C4iD0jerRmHrcuUeMmVSWs57pnOmmqd3KH51BcZYc
         dPSg==
X-Gm-Message-State: AGRZ1gKgtCkd2sRVovlgSWaIfznu72ucx1QFX3l0m5bhfrYZFge2LDdZ
        YaryCIqzpfBxd6mEgc15c7Y=
X-Google-Smtp-Source: AJdET5dPa3kp8QAwkn4HZ6zzukaPIREIotnWbdqyM1pO1tVvtR0ij9hB2AGtjhx3Gsb4XZP1BJ61NA==
X-Received: by 2002:a25:37cf:: with SMTP id e198-v6mr1658469yba.243.1540478434092;
        Thu, 25 Oct 2018 07:40:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:319d])
        by smtp.gmail.com with ESMTPSA id m65-v6sm449416ywm.42.2018.10.25.07.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 07:40:33 -0700 (PDT)
Date:   Thu, 25 Oct 2018 07:40:29 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [GIT PULL] cgroup changes for v4.20-rc1
Message-ID: <20181025144029.GE4182586@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

All trivial changes - simplification, typo fix and adding
cond_resched() in a netclassid update loop.

Thanks.

The following changes since commit 02214bfc89c71bcc5167f653994cfa5c57f10ff1:

  Merge tag 'media/v4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-09-24 15:16:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.20

for you to fetch changes up to a90e90b7d55e789c71d85b946ffb5c1ab2f137ca:

  cgroup, netclassid: add a preemption point to write_classid (2018-10-23 12:58:17 -0700)

----------------------------------------------------------------
Andrey Ignatov (1):
      cgroup: Simplify cgroup_ancestor

Michal Hocko (1):
      cgroup, netclassid: add a preemption point to write_classid

Rami Rosen (1):
      rdmacg: fix a typo in rdmacg documentation

 Documentation/cgroup-v1/rdma.txt |  2 +-
 include/linux/cgroup.h           | 15 +++------------
 net/core/netclassid_cgroup.c     |  1 +
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/Documentation/cgroup-v1/rdma.txt b/Documentation/cgroup-v1/rdma.txt
index af618171e0eb..9bdb7fd03f83 100644
--- a/Documentation/cgroup-v1/rdma.txt
+++ b/Documentation/cgroup-v1/rdma.txt
@@ -27,7 +27,7 @@ cgroup.
 Currently user space applications can easily take away all the rdma verb
 specific resources such as AH, CQ, QP, MR etc. Due to which other applications
 in other cgroup or kernel space ULPs may not even get chance to allocate any
-rdma resources. This can leads to service unavailability.
+rdma resources. This can lead to service unavailability.
 
 Therefore RDMA controller is needed through which resource consumption
 of processes can be limited. Through this controller different rdma
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 32c553556bbd..e03a92430383 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -567,20 +567,11 @@ static inline bool cgroup_is_descendant(struct cgroup *cgrp,
 static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
 					     int ancestor_level)
 {
-	struct cgroup *ptr;
-
 	if (cgrp->level < ancestor_level)
 		return NULL;
-
-	for (ptr = cgrp;
-	     ptr && ptr->level > ancestor_level;
-	     ptr = cgroup_parent(ptr))
-		;
-
-	if (ptr && ptr->level == ancestor_level)
-		return ptr;
-
-	return NULL;
+	while (cgrp && cgrp->level > ancestor_level)
+		cgrp = cgroup_parent(cgrp);
+	return cgrp;
 }
 
 /**
diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index 5e4f04004a49..7bf833598615 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -106,6 +106,7 @@ static int write_classid(struct cgroup_subsys_state *css, struct cftype *cft,
 		iterate_fd(p->files, 0, update_classid_sock,
 			   (void *)(unsigned long)cs->classid);
 		task_unlock(p);
+		cond_resched();
 	}
 	css_task_iter_end(&it);
 
