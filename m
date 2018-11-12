Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0CEC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1014A2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm7fPh0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1014A2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbeKMI7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:59:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35518 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeKMI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:59:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so5022631pff.2;
        Mon, 12 Nov 2018 15:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4w/uS5CdZfUu32Qk39NtHIWDaBjSkhBcPb+FbjjLeZ4=;
        b=dm7fPh0acIHGQ5Z8xnOsWcFO8KhDk63z8PKG4Xsb2XmwAE/FdYTEuVpCfdPSdc7aAp
         lP5biEwRbyS1xfrtITtHOt/ZF2KOEFOwAXgNowq/Q/2pciZpzq2vha9DlXLIEEoBMJ9/
         kfKb1nZjI5NhpHMV2ZEZW2vdmhsI5u9dl6y/nb8bsHGZSdWV15UUy6h/xl62aNc9AHSs
         /NVQ9IFh9vt50wfJtHygAy0i4K2J2mn9eqZhCvb9LvkixVOnGxrdE4r+zwCKamGv/5Vw
         BXvhhLvLdpAj0Oh4Hn364HwaVyTq+24naqFNkewsYzmJHfJIkhCC9q9TfT+ZrUoreABp
         4sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4w/uS5CdZfUu32Qk39NtHIWDaBjSkhBcPb+FbjjLeZ4=;
        b=omYcrUJwoYLXG81xh5zOALF7izREQlMoCHR8C8toXvcZdE2km/989NO0zYF1am6Ozo
         bB2s20KtFCWE29ECHgiU/xYMJ8vjPv0zz09Jb8/4O+8QftCuUYTbkeQWtlnwM3AQT4n8
         zWSEhtCtohLkm9tojKREaT0rzDlji0ks4kQcR5jZRXr8SVewDW6+ic041uOpWJvLY5/4
         W+8HNDDYH7pP0/Do6fOVwgVUUVeoHuaLzSWCPRuqvxtwZAMnIAeu0NIs/viDFd0D5umj
         wVRMQkXUlX9T5HVdmVO5yw3Q3m9V62rTQQiXD/0Lqsu64j/EXfQ+9UcEDsTZ34eIsujm
         z2aw==
X-Gm-Message-State: AGRZ1gIQK33FxuUkPs/xrqxB0+uWgA9RmLmzNWsVZt9kW/I4Yse/l+wa
        Eq5+nct4b/KCw0CsDst1/is=
X-Google-Smtp-Source: AJdET5eNeRG9Hs8QwpaFNKsyxQPfGreSc4VpOpKhiHdu1lW2R3uc2YLFx40THKt1LgaPaVorlppTDQ==
X-Received: by 2002:a63:5224:: with SMTP id g36-v6mr2555997pgb.253.1542063872367;
        Mon, 12 Nov 2018 15:04:32 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:c2f7])
        by smtp.gmail.com with ESMTPSA id f64sm7192327pfh.0.2018.11.12.15.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 15:04:31 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 6/6] cgroup: document cgroup v2 freezer interface
Date:   Mon, 12 Nov 2018 15:04:22 -0800
Message-Id: <20181112230422.5911-8-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181112230422.5911-1-guro@fb.com>
References: <20181112230422.5911-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup v2 freezer interface in the cgroup v2 admin guide.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 184193bcb262..a065c0bed88c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -862,6 +862,8 @@ All cgroup core files are prefixed with "cgroup."
 	  populated
 		1 if the cgroup or its descendants contains any live
 		processes; otherwise, 0.
+	  frozen
+		1 if the cgroup is frozen; otherwise, 0.
 
   cgroup.max.descendants
 	A read-write single value files.  The default is "max".
@@ -895,6 +897,30 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+  cgroup.freeze
+	A read-write single value file which exists on non-root cgroups.
+	Allowed values are "0" and "1". The default is "0".
+
+	Writing "1" to the file causes freezing of the cgroup and all
+	descendant cgroups. This means that all belonging processes will
+	be stopped and will not run until the cgroup will be explicitly
+	unfrozen. Freezing of the cgroup may take some time; when the process
+	is complete, the "frozen" value in the cgroup.events control file
+	will be updated and the corresponding notification will be issued.
+
+	Cgroup can be frozen either by its own settings, either by settings
+	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
+	cgroup will remain frozen.
+
+	Processes in the frozen cgroup can be killed by a fatal signal.
+	They also can enter and leave a frozen cgroup: either by an explicit
+	move by a user, either if freezing of the cgroup races with fork().
+	If a cgroup is moved to a frozen cgroup, it stops. If a process is
+	moving out of a frozen cgroup, it becomes running.
+
+	Frozen status of a cgroup doesn't affect any cgroup tree operations:
+	it's possible to delete a frozen (and empty) cgroup, as well as
+	create new sub-cgroups.
 
 Controllers
 ===========
-- 
2.17.2

