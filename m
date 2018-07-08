Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2035BC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4B220693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn96XFdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4B220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933561AbeGHVIk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:08:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46735 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933273AbeGHVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so12138357pfl.13;
        Sun, 08 Jul 2018 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hb6nvnZREFFBtwaeRQ3owfpA/RvD/JqI9k4XfoZgEFc=;
        b=Gn96XFdru/z4nSNKambdxUrbB2HphI/9tCjcOEuaR7zEbsTEoIj5J0tN7ipHwxsVqE
         aK1tgVa4Y/vIuT3rB6nC0LHUwCmTHy5vKoLVOgbx+PzsKFc1ObN7gXC9NkeSc23VZcYJ
         yUEjawfM0E0NcDTRjZlD/rg+MWxmKAbPDuYPD0Dvd6gPJcoTjTyHPEaBxonS8X16B7Mh
         l0OEwXu1gOL8xKx28z0FB818T1pmDw8KmXix2vLKBwzLvjOxK2WXnauLG0OvBqVmNuy3
         9ZPVObuMT6vhtwOqxP0Tvtn1/laCCF/irzq3B2brmV4VLwD1o/kA2SNvJPOhWHvnD4vH
         y6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hb6nvnZREFFBtwaeRQ3owfpA/RvD/JqI9k4XfoZgEFc=;
        b=Gx6vULu/aj+BPevK3H6w3s2TPUakz4lAwBx1i9jqahOzTd1y8/dsDxkwJ6+2sswzD4
         dxWSonKo1a22YaGYL4bLw34kjEAnY6pT9RIHSIZT/1RdtTJFnIIYOteQcesi+TINBK8o
         xWwQ012xVhj4BWGXuuFjqBYeGn8PKO5KeQukENrdMbou+8nOVacEg45BtVkok+OckZS4
         C1lg+vW+nB7s3nSVtUaepxsyrocoxoPsuWSpZu/7XlkE6cYLejO1b0Xuw5oA/GfPZUbT
         t4qGOrTPpcCNoJwfvXpHN84fOYB23zV3Cqa9XfkuTN/NqF2idcyoE6TXIonoWcoJF5/P
         tdWg==
X-Gm-Message-State: APt69E0XaUMQ8THa+mLaj60qlCuJmMhPN1zO7z2/hSmfLR4FYxvWq3Q0
        +HJC/14Uqw28dDKzPOUNBdAYOp8g
X-Google-Smtp-Source: AAOMgpdau8Y9Lo4DqmwzpbdrsQZj/ntjR3DjgAG82JoxlHjXeOK4/Gpa2GbXSq8fiePZJs5xI2FgPg==
X-Received: by 2002:a63:524e:: with SMTP id s14-v6mr15415258pgl.35.1531083937902;
        Sun, 08 Jul 2018 14:05:37 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:37 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 06/18] fs_context: fix memory leak with 's' (source) command
Date:   Sun,  8 Jul 2018 14:01:42 -0700
Message-Id: <20180708210154.10423-7-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fixes: 5f417428a312 ("vfs: Implement fsopen() to prepare for a mount")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 5d346ac78d504..8d6fa4ba8fb55 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -98,7 +98,6 @@ static ssize_t fscontext_write(struct file *file,
 		ret = vfs_set_fs_source(fc, data, len - 2);
 		if (ret < 0)
 			goto err_unlock;
-		data = NULL;
 		break;
 
 	case 'o':
-- 
2.18.0

