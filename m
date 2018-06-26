Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B97F25018
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B97F25018
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeFZLE5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:04:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34804 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932888AbeFZLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:04:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so14951772wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M6z+i6FIjp7gbh6Z9Fnp1s2+Rqk2PbSGRHqLs3BXJ5Q=;
        b=lrPYPcDbIys3F5Xnuadtw6YOUhXPDdSklADB+BFU0tasnc38Q2zAwYN/GpkJclthVT
         yA/r/AgZ7LKj5egSCyOoFeZVjPWX5u1GUjDfMpzf6djMkpTheulAs1T/oXIfSp9Zu1KX
         ymPTzDnKiw1Cu6umVUyXyu15ESrbrxjAM9coIu7Lww+NHN+yaYrLeZhsGxb4wy24oVGa
         Eztj8w4JbeOy+lxRHJBzBGY8X/L5Oe52wKRENDVo+Lp8UEag9enD83ZM2gKx/A9DiMlv
         jOpgyuH5YLpa5v1qPM3RPS8L1YF4ZIgPxSOXLK43DpSC2KnUbuqlimrzG8jFsqZq8xh+
         XIPA==
X-Gm-Message-State: APt69E11uFY7Dke6TFfL13MYjyY9FKP/O2PkJ5HP/oBlODNXkPLrIGcv
        JVo5ynoiPwggcShqM1dqyy1uXA==
X-Google-Smtp-Source: AAOMgpd8WVV5sEPvTM7KXYJDEjpbca8d4jKkq4fwxb6sJ7DXGla4Orp3QzbSdBcBF7hn+iISR17b7w==
X-Received: by 2002:a1c:d004:: with SMTP id h4-v6mr1198391wmg.151.1530011094016;
        Tue, 26 Jun 2018 04:04:54 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q17-v6sm1430997wrs.5.2018.06.26.04.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 04:04:53 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-audit@redhat.com
Subject: [PATCH -next v3] cred: conditionally declare groups-related functions
Date:   Tue, 26 Jun 2018 13:04:42 +0200
Message-Id: <20180626110442.21014-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
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
security/keys/permissions.c, where the call is (by coincidence)
optimized away in case CONFIG_MULTIUSER=n. However, the audit subsystem
(which does not depend on CONFIG_MULTIUSER) calls this function in
-next, so the fallback will be needed to avoid compilation errors or
ugly workarounds.

See also:
https://lkml.org/lkml/2018/6/20/670
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=next&id=af85d1772e31fed34165a1b3decef340cf4080c0

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changes:
    v2->v3: commit message corrections
    v1->v2: change default return value of groups_search() to 1

 include/linux/cred.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 631286535d0f..7eed6101c791 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
 
 extern int in_group_p(kgid_t);
 extern int in_egroup_p(kgid_t);
+extern int groups_search(const struct group_info *, kgid_t);
+
+extern int set_current_groups(struct group_info *);
+extern void set_groups(struct cred *, struct group_info *);
+extern bool may_setgroups(void);
+extern void groups_sort(struct group_info *);
 #else
 static inline void groups_free(struct group_info *group_info)
 {
@@ -78,12 +84,11 @@ static inline int in_egroup_p(kgid_t grp)
 {
         return 1;
 }
+static inline int groups_search(const struct group_info *group_info, kgid_t grp)
+{
+	return 1;
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

