Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2DDC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F3208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6F3208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeFUIeR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:34:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50607 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeFUIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:33:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so3707259wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ggu6XTOWV1am8HGIqVvDEC2PINXd6g/D3PZtPRZLoUI=;
        b=q+Nv0VKZ3hRjUwi7vQ57q5yunFBvUnDDRbSNOuNSwa+Z4XD1dU0rX7b1dL5PuArYs6
         Nb+P1es99HVH0c1GSPUNg/kkx3OrmrpL2Ij5HVFB4uRMI6qNYuWNPqunuxpK16nO8nwm
         2YZ2Nct5AxmxH/njyDKD5msXj+5aw5USno17RiV7dtHaoAwfRskcOHtTU7OiefLmPXQX
         rBaj6BBBbxGVjP9l/P9ULt8a94oOe2SC/9ZyQqaMUWkyae6F4xgBnzxYrWRXQWbYhayl
         Hj7mC5G69C42fTeJLwnEQvmrYCIPXCBWO1HEbqx4sE3zXHsYKgPglx+m7rPs55+rsH7Y
         tXdA==
X-Gm-Message-State: APt69E3h1ZxUCT4qGxEZa0LisKyB5fsMO3Sfq6tLjxBmo4v3830HeVXP
        yxify5sYTRcdpAtdo+tYVTDDDQ==
X-Google-Smtp-Source: ADUXVKL3cTZXrKdxNlIiNVrYNynI0AYIL2jxGzFUBGnAVlL2rhi+tlNcSL3QEPM7rNiVlxcQokKYOw==
X-Received: by 2002:a1c:6545:: with SMTP id z66-v6mr3945860wmb.86.1529570032220;
        Thu, 21 Jun 2018 01:33:52 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h77-v6sm7773766wmd.9.2018.06.21.01.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 01:33:51 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH -next] cred: conditionally declare groups-related functions
Date:   Thu, 21 Jun 2018 10:33:16 +0200
Message-Id: <20180621083316.8765-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
References: <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The groups-related functions declared in include/linux/cred.h are
defined in kernel/groups.c, which is compiled only when
CONFIG_MULTIUSER=y. Move all these function declarations under #ifdef
CONFIG_MULTIUSER to help avoid accidental usage in contexts where
CONFIG_MULTIUSER might be disabled.

This patch also adds a fallback for groups_search(). Currently this
function is only called from kernel/groups.c itself and
keys/permissions.c, which depends on CONFIG_MULTIUSER. However, the
audit subsystem (which does not depend on CONFIG_MULTIUSER) calls this
function in -next, so the fallback will be needed to avoid compilation
errors or ugly workarounds.

See also:
https://lkml.org/lkml/2018/6/20/670
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=next&id=af85d1772e31fed34165a1b3decef340cf4080c0

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/cred.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 631286535d0f..8917768453cc 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
 
 extern int in_group_p(kgid_t);
 extern int in_egroup_p(kgid_t);
+
+extern int set_current_groups(struct group_info *);
+extern void set_groups(struct cred *, struct group_info *);
+extern int groups_search(const struct group_info *, kgid_t);
+extern bool may_setgroups(void);
+extern void groups_sort(struct group_info *);
 #else
 static inline void groups_free(struct group_info *group_info)
 {
@@ -78,12 +84,12 @@ static inline int in_egroup_p(kgid_t grp)
 {
         return 1;
 }
+
+static inline int groups_search(const struct group_info *group_info, kgid_t grp)
+{
+	return 0;
+}
 #endif
-extern int set_current_groups(struct group_info *);
-extern void set_groups(struct cred *, struct group_info *);
-extern int groups_search(const struct group_info *, kgid_t);
-extern bool may_setgroups(void);
-extern void groups_sort(struct group_info *);
 
 /*
  * The security context of a task
-- 
2.17.1

