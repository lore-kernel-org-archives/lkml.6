Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB10C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82940254F0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82940254F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeFYG4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:56:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34793 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeFYG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:56:11 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so12427289wro.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nXgUbtaQjmaxHVJj2ZCmCg0JnadMHF9auX4+FXJv9HA=;
        b=TSIOHjHK4aDCcwNDZVenaWYdmSDEnxqWxTmzY0gs/6hnIw5dDX2na+4jpW42D74oKs
         S1hvbiN+fLSLmAQWt/nTp8FZ2wvAT1qGwKRWu0IUfiO5MVKGK5j9MMwd85mlYhsBDdBi
         5QU6qJFpg1Ee1N8NoY9D5rhcAdSvgLEB3IOGl9qYOXX6T3Kn6B/Uc8GNBre3wwv5qELW
         /Y+AwWXkLN0Ev1r6P2yecRxLTEocr+owIgw2dHoSnIs+aKZvhiZY9CRp5fp8HKpmbhky
         HWs5TlJ9VFRC1JKfQMG/x2RP3zmzjBhNASXCb+UCOG9G4ef1KQ0PFie20PNmMsDBqqD1
         bxwQ==
X-Gm-Message-State: APt69E2+NW9Yx1pyivDZxtsiumH9gTeyJx55q0W8bX7Yr2OsKs5l6Y4C
        4loFRRZTesyIGI1RjP8KAPfk0w==
X-Google-Smtp-Source: AAOMgpfuNUqs9P1+WxSIQOqltjwXJBgetGEBRp5zml510kh3VBAvqTA7EAZk6tWQzl/FsoFARYc9xQ==
X-Received: by 2002:adf:d4c5:: with SMTP id w5-v6mr8643203wrk.185.1529909769924;
        Sun, 24 Jun 2018 23:56:09 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u204-v6sm3299992wmd.7.2018.06.24.23.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 23:56:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH -next v2] cred: conditionally declare groups-related functions
Date:   Mon, 25 Jun 2018 08:55:32 +0200
Message-Id: <20180625065532.7268-1-omosnace@redhat.com>
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

