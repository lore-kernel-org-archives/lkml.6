Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C5C282C8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC41420855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9vTRET6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfAVEXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:23:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35774 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfAVEXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:23:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so18230686edx.2;
        Mon, 21 Jan 2019 20:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+VsBAtwHVveBAlU+LmHaJMNKKzJT1pXEt8lxZ6uzzc=;
        b=O9vTRET65dMor96lLjRzEqj0R3eF6F8kgmqwIGHa9gGjJLPHB0y3D5U+QkutsU39RH
         wXbvUI2k8ic7TvqP4H3sSuyIMJI/MgVgeZrzBtXsn8ofg2NLON3CTD7NL4y4bnNxMPsg
         6gEK8/4xrWsNGZ6WCNjoAsthP0PaxoNQ8ry3dlI6JLWtyZjYMwdb8Auf+DaywrHVvk+L
         bybBe95l+l5Odjify3ZiL6Yt3VFxnQxI1hELT+hTNMpJ8R9IOJ4V9zPaTlKHTlcTrsEN
         XrobF7/1ormmVmuAGYaU7mz+XhAPkUR4YUTcLbmki2Orr7vW5wDQLrwaq3b7kL+nnDfY
         g/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+VsBAtwHVveBAlU+LmHaJMNKKzJT1pXEt8lxZ6uzzc=;
        b=Dsw82hfS7NKV0oME3XQqQAJkNdXvl2sqA9b5JMMCyzJtYXrB6QNwfsqrXZ31iV5DrX
         qcNssxMshMdK/4NhLqimBxQBgfrtb1KyJH2qkxF350W86MklqeqDS8oEVFVx4puz5aBu
         qvcfoUoAFSMEDTGxCv4d3nH3EwQ+3MoEaRF+8cTGkrbTG7IUlBjP+q0cqEGGkpOwAAPK
         EYEnW64aukZChSt4rYIERu1WuvOfn+HRWdb5ronaX7ODJ5I88ew8KpO8eus7o2lLzQjV
         TN7vIIt7L+eI8g9Y+Z41lvaTs9epreuNEINGc+Q9S6pFcnReETiOqI/F16rujS+bN1PY
         i9tQ==
X-Gm-Message-State: AJcUukehNqHY4K+qoZL4vFmzewR0FGWPneht0kqZL5J0P4A+iyKAjaGA
        jnFkszSi9q+T3mVgylzCkBI=
X-Google-Smtp-Source: ALg8bN5khzEGalm0//YgDq5cLRHwBr4rR7DUveI8mKKee2MLIuM92oH1IF3UlUC2W/+a5Vk3nlodyA==
X-Received: by 2002:a50:fa0c:: with SMTP id b12mr28181212edq.138.1548131001013;
        Mon, 21 Jan 2019 20:23:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm5260289eju.61.2019.01.21.20.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 20:23:20 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eran Ben Elisha <eranbe@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] devlink: Use DIV_ROUND_UP_ULL in DEVLINK_HEALTH_SIZE_TO_BUFFERS
Date:   Mon, 21 Jan 2019 21:23:01 -0700
Message-Id: <20190122042301.14142-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building this code on a 32-bit platform such as ARM, there is a
link time error (lld error shown, happpens with ld.bfd too):

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by devlink.c
>>>               net/core/devlink.o:(devlink_health_buffers_create) in archive built-in.a

This happens when using a regular division symbol with a u64 dividend.
Use DIV_ROUND_UP_ULL, which wraps do_div, to avoid this situation.

Fixes: cb5ccfbe73b3 ("devlink: Add health buffer support")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 net/core/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 60248a53c0ad..9ee25dfbc09d 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3599,7 +3599,7 @@ static int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
 
 #define DEVLINK_HEALTH_BUFFER_SIZE (4096 - GENL_HDRLEN)
 #define DEVLINK_HEALTH_BUFFER_DATA_SIZE (DEVLINK_HEALTH_BUFFER_SIZE / 2)
-#define DEVLINK_HEALTH_SIZE_TO_BUFFERS(size) DIV_ROUND_UP(size, DEVLINK_HEALTH_BUFFER_DATA_SIZE)
+#define DEVLINK_HEALTH_SIZE_TO_BUFFERS(size) DIV_ROUND_UP_ULL(size, DEVLINK_HEALTH_BUFFER_DATA_SIZE)
 #define DEVLINK_HEALTH_BUFFER_MAX_CHUNK 1024
 
 struct devlink_health_buffer {
-- 
2.20.1

