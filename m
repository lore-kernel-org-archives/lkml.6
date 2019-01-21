Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B8C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB6C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="P1yVJr1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfAULBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:01:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39007 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAULBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:01:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so16216325edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6F0jPoHpy95MVgtjW7lO9ldsjOWbZkfccZykrw9HgUI=;
        b=P1yVJr1Q9CoJ9O/YtacINo7iCtYKw93mM8osdGir4f7+ZU0HiSflyhskkWx6JjCQo0
         Ei6DROh0HRHfoAjmnn9gVxquMJKabang+CPWsTKPgZUUYA2PX4UXyyx8dU9xdIJwYD4+
         qm7UfNKOrGECdPl5E+RQXqiU/cbbr5JVkIwW1pDh4G5YujCgeYDKSOgjXoLgzBrA1ZIQ
         63Hqi6SnLk0vxHY8p5k6IbitKH1xZDu2SFM+7LmH6osojauPHlcf/T14yId09CFHEwRM
         jfkyvoSw7m2VoJO+X5tKxkeqQ+vVS1bMxf2YFV29EQSHxHFhkKICXJXTWrsM0T/vc63o
         4SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6F0jPoHpy95MVgtjW7lO9ldsjOWbZkfccZykrw9HgUI=;
        b=VEASiEZpc2B9UpE0BmVF/dYhSF2CR7uM1cTBkV9rzz2oMziq+/LXyv58sT6G97+HQ1
         JKCYt4zFipJmvKEp636o6xBt8TU7M3ilfuIOcSRQydHm0LNgJEhUKVwFcY5YIXgKZFWA
         wFYvc6LiV/ZwHb41KHdt2bEgQlBxGkhyK26+rIu+DG7UfWYwiUf1s8MolLa5kSEGciAM
         g4reabsOjq/B5t11+rP37tuV45QB1NsnQtkS2gMNVGcHB+FHa55AALOMmW+n98nVX28a
         iN4U1LtaZpcYpcHzv5yeCxnCwuH1bXzTDWWl9QV6pNEImeLO4L0PNT0R2rSqh/e2MoeA
         u2ug==
X-Gm-Message-State: AJcUukftI657ksnJ+SLkjgFmlSAU/VQ6ntMvLElfGJ9uUilu4bdKKZGn
        zXieqPlrBRBdvdFm5fdWsqSSvA==
X-Google-Smtp-Source: ALg8bN5gUB5PDSF2RY508d9YuoMC93hs8orAI4jQqzVAt3N7MfUCjTUGayV2pDN55+RVLslTVC5CaQ==
X-Received: by 2002:a50:8bb5:: with SMTP id m50mr25978833edm.211.1548068489827;
        Mon, 21 Jan 2019 03:01:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id t24sm8970080edb.7.2019.01.21.03.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 03:01:29 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/2] binderfs: use correct include guards in header
Date:   Mon, 21 Jan 2019 12:01:19 +0100
Message-Id: <20190121110120.27003-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we switched over from binder_ctl.h to binderfs.h we forgot to change
the include guards. It's minor but it's obviously correct.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 include/uapi/linux/android/binderfs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/android/binderfs.h b/include/uapi/linux/android/binderfs.h
index 65b2efd1a0a5..b41628b77120 100644
--- a/include/uapi/linux/android/binderfs.h
+++ b/include/uapi/linux/android/binderfs.h
@@ -4,8 +4,8 @@
  *
  */
 
-#ifndef _UAPI_LINUX_BINDER_CTL_H
-#define _UAPI_LINUX_BINDER_CTL_H
+#ifndef _UAPI_LINUX_BINDERFS_H
+#define _UAPI_LINUX_BINDERFS_H
 
 #include <linux/android/binder.h>
 #include <linux/types.h>
@@ -31,5 +31,5 @@ struct binderfs_device {
  */
 #define BINDER_CTL_ADD _IOWR('b', 1, struct binderfs_device)
 
-#endif /* _UAPI_LINUX_BINDER_CTL_H */
+#endif /* _UAPI_LINUX_BINDERFS_H */
 
-- 
2.19.1

