Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F298BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C307E21928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJwGFDCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404652AbeLVADY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:03:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43751 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404127AbeLVADT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:03:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so3158331plb.10;
        Fri, 21 Dec 2018 16:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvoTTqePPOt3Bq4d9Skj0YSKEIcvqgD14v+eA23Gmu0=;
        b=kJwGFDCtuUu22XvgCASPd5aQpVLY5SOIZy8lm6PM13SbizDkHnFVzZI5NH+yJWfj0V
         UROwuVVNAgZ1RdlmfVpM3SqLvqw8P9nPFt3OfA6aafTmWduvAnMv+AskCObv6MFjd8GT
         AGqAw7O7N57m3ssuAgrIMfyDneIJY1jgM5e7IRMU1IWOVEvM16lwkNYE7AVz8EJRcLeN
         fI+vRN4OETrz4vNXhgf9Yal3y9iQ1S5CgRY+F0/CykLVmMPYTK6VB+N3o9WhE7zND68Y
         ImMXBkp7FbCtmfl85Ksz386t//MT2wPJuIluSo2/yE2O108T2RZQfQFLy1obtcn/yVRo
         3Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvoTTqePPOt3Bq4d9Skj0YSKEIcvqgD14v+eA23Gmu0=;
        b=mu+Uj/JIyQNBQQtUJhN+KhGeITw+ha6Iw6XvByy8+tRnoeJbRlEszmP+YJ4IqaBfsJ
         17aPjA1icZ2psaHmhNqkTD9tSEj170DQ4ILjbruFhqG/aByZ/S1uFbnWk6QJ4NQF7rdo
         r7sE3vGus5qjdkz7lgHA9HuS9HUlTp1X+DDH5gWs5t+1TA9bFkv11/R5rNS//crBpemI
         CkS3D2xDbZtImuoAiwNzGoAo4+EvqSt0lGyOQH2qUKG2rPU9Q/Vxxx0C+dIqyoXjCDyp
         u/KG4KX6DeCWBNUSyaf9jAlDYfJbNyoYTrlHUDlCHnGmY1mUbTlQ4rBuNEimIsWzADUg
         iwTA==
X-Gm-Message-State: AJcUukeLXy/JNWCsqjByYIiPoDzmq4I+TA4T49Yared4KNWqGPDD4TWO
        Qt+G/FV94tXo9Oyejuq/hNk=
X-Google-Smtp-Source: ALg8bN4OtXnzql/JtGefZH3drcan1qn1HWBvI0mHz825swZDtmwfJ6590gAjWvpYI0ShJxgWJBwnhg==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr4390343ply.143.1545436998419;
        Fri, 21 Dec 2018 16:03:18 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:608f])
        by smtp.gmail.com with ESMTPSA id 83sm36659266pgf.57.2018.12.21.16.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 16:03:17 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 7/7] cgroup: document cgroup v2 freezer interface
Date:   Fri, 21 Dec 2018 16:03:07 -0800
Message-Id: <20181222000307.28231-8-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181222000307.28231-1-guro@fb.com>
References: <20181222000307.28231-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.2

