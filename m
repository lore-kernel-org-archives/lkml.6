Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0EDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CCF245B5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rc857/zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CCF245B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeGDJxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:53:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42565 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeGDJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:53:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id 1-v6so3809866ljv.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhCFMQfYszhr7+qkmxc2d6kgcyxhQdTFxe+zevbgli4=;
        b=Rc857/zVt4gMebZxO3Sgbe8oggogjBQdwooLrQtBuYUPmdNvqeFiXe8mKZr7VYlzLg
         NZbRNRw7ypO+1iB7wwFbjtysj+cwfpyIUHogUc3KmbX0ePFQBGVErwJij0QlmcN2voJ9
         SHGoFoFE+ukWHSM2uiVe3RCemGlo3B1Psd6ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhCFMQfYszhr7+qkmxc2d6kgcyxhQdTFxe+zevbgli4=;
        b=ntezn27SUaoIm9I6CZWq2v+lqQt6tifQwmyD6lRWrRHhBM7HtoOqL7AkYtBE5rPBnj
         3Jy1qGHD/eFX7miFmD9affARkcDksJB21peCz9OHiT4aihYzMYclal3tXlVn7pjlQUsS
         gkZQ3wtMapiucmO6GHoVLZi5RvLI1BEleut/jtLwtq5/YQcRL4vq5MpZn4EV0Xnw6jcx
         xbAjxTn0mdcH+w9P3hn3n5Dk5FsGAPSP/S/OQhRU5xz1zzooojg6dwyC5gx1iUwyFSzO
         IqAxnVW9m6LCDC6ziAAdG8EgDb0fJ7Cd1GHPmXzkSnKAy/XRcbjNlhXcTLS/6iJSL9lg
         zj/Q==
X-Gm-Message-State: APt69E1u8C/15I+SGWG0Y/27h5UgAre/VTnSeO9uhIctRu//Jf14lkBx
        LcLNNCOvChvYpAjy9fmM9+j5h7LjDao=
X-Google-Smtp-Source: AAOMgpfLOaeBJrKGeyxMERF3Jwh0LKdGXfLJPgIZfkBxJvJzq1Ed92KkvsLZQHZYckaJy4RgXpJahQ==
X-Received: by 2002:a2e:83cf:: with SMTP id s15-v6mr1059307ljh.101.1530698011468;
        Wed, 04 Jul 2018 02:53:31 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id c3-v6sm512331lja.22.2018.07.04.02.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:53:30 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mark@fasheh.com, jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] fs/ocfs2/dlmglue: lockdep_keys defined but not used
Date:   Wed,  4 Jul 2018 11:53:18 +0200
Message-Id: <20180704095318.19218-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_LOCK_ALLOC isn't enabled lockdep_keys isn't used and
we get a warning:
fs/ocfs2/dlmglue.c:99:30: warning: ‘lockdep_keys’ defined but not used
    [-Wunused-variable]
 static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
                              ^~~~~~~~~~~~
Adding __maybe_unused to the declaration hids the warning.

Fixes: 1cd75cdb8fbb ("ocfs2: make several functions and variables static (and some const)")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 fs/ocfs2/dlmglue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 040ddb6e7dab..160e0b224367 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -96,7 +96,7 @@ struct ocfs2_unblock_ctl {
 };
 
 /* Lockdep class keys */
-static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
+static struct lock_class_key __maybe_unused lockdep_keys[OCFS2_NUM_LOCK_TYPES];
 
 static int ocfs2_check_meta_downconvert(struct ocfs2_lock_res *lockres,
 					int new_level);
-- 
2.18.0

