Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1773FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C822720892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maFrqRoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C822720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLGUPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:15:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41357 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeLGUPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:15:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so2177340pgh.8;
        Fri, 07 Dec 2018 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6XRT3PIBruu3XRiswo1BJ+me6VnnM1g5UdR6upb//c0=;
        b=maFrqRoQMw6RJAiN+/YYnssncI3k9OlpsrMUv7FEh16SuZ45JstfYzUf9uMlPh9WRA
         /zd75KPy6OVK8X70t6tpl5nDDe2cdd7Dh4nh2Ku0fhUkyCTqfO019AIL6PEP7H1lxcHp
         g57AXbNAM1Aq4yA8Vj/EqJ7qbPUQEFiKZl6aZd29F1V4nT4oMcNnXfN1TEAh7pb9H/8R
         U8jFjCapNI8+hUfeQ6r0Oc9lKd3HNFo/5wT0LsgaFx9v0EUr3ew1apeThc8hOM/yX6cH
         WmsOeJvNXAcx91miWcdDhPui/STM9WNivjzuxP5shd5r5JaXmLT6w/Ib6eOVHbdSQgd9
         rHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6XRT3PIBruu3XRiswo1BJ+me6VnnM1g5UdR6upb//c0=;
        b=U60VNyyb1R+ikiXMDTCwz95pGdcNvKSN4YQ4SnvOtdUAXkcEB51VtDzTYTPkUUhyNi
         5Nik6emnFnKR+FC0hSE91H3nZJhECYK8WQATiXodH+1/u4C6FsiyRlq3M+tr456cO+Ms
         u++uZ9/luJpO3IhVCmn2eb+r9foRToqzdI/WPl0o1wdsb68PWsImQNhEv5pArx1Fut2i
         VoO3/vrfb7tioh7UESPrm15CvXy1iRrF6VpTsa43lqTEbmvAVPmlZU2XNtkzCtnVeCS+
         jvcxBqhMtMkl91nTXwTH7+SlMUI5vgO/afqbo4Bm62QO+5MB7rYuzt0xmP8d1s3CGs4W
         upjA==
X-Gm-Message-State: AA+aEWaADSGjt0GDs1xvZWoqVyer2/Vt7/MFcusV3ZVGZ49LR2Z5mczJ
        q8ShtEMqGxHUVdfUyp4HNHY=
X-Google-Smtp-Source: AFSGD/VdMEYyNiUoHkJYeeMUxvH9SlaNto4w0ncm3zWYJFeAYCkVgOgrHBp9lNwdAyEXXXbMvQ1ejg==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr3138914pgf.33.1544213743049;
        Fri, 07 Dec 2018 12:15:43 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c090:200::6:d83b])
        by smtp.gmail.com with ESMTPSA id q75sm5870898pfa.38.2018.12.07.12.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 12:15:42 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 7/7] cgroup: document cgroup v2 freezer interface
Date:   Fri,  7 Dec 2018 12:15:31 -0800
Message-Id: <20181207201531.1665-8-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181207201531.1665-1-guro@fb.com>
References: <20181207201531.1665-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup v2 freezer interface in the cgroup v2 admin guide.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 07e06136a550..f8335e26b362 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -864,6 +864,8 @@ All cgroup core files are prefixed with "cgroup."
 	  populated
 		1 if the cgroup or its descendants contains any live
 		processes; otherwise, 0.
+	  frozen
+		1 if the cgroup is frozen; otherwise, 0.
 
   cgroup.max.descendants
 	A read-write single value files.  The default is "max".
@@ -897,6 +899,31 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+  cgroup.freeze
+	A read-write single value file which exists on non-root cgroups.
+	Allowed values are "0" and "1". The default is "0".
+
+	Writing "1" to the file causes freezing of the cgroup and all
+	descendant cgroups. This means that all belonging processes will
+	be stopped and will not run until the cgroup will be explicitly
+	unfrozen. Freezing of the cgroup may take some time; when this action
+	is completed, the "frozen" value in the cgroup.events control file
+	will be updated to "1" and the corresponding notification will be
+	issued.
+
+	A cgroup can be frozen either by its own settings, or by settings
+	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
+	cgroup will remain frozen.
+
+	Processes in the frozen cgroup can be killed by a fatal signal.
+	They also can enter and leave a frozen cgroup: either by an explicit
+	move by a user, or if freezing of the cgroup races with fork().
+	If a process is moved to a frozen cgroup, it stops. If a process is
+	moved out of a frozen cgroup, it becomes running.
+
+	Frozen status of a cgroup doesn't affect any cgroup tree operations:
+	it's possible to delete a frozen (and empty) cgroup, as well as
+	create new sub-cgroups.
 
 Controllers
 ===========
-- 
2.17.2

