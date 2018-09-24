Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CABC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B09208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="fID3/n1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B09208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeIYATz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:19:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbeIYATy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:19:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23-v6so1691706pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwPxX45gZm6RhM5vkMPVW/U8WnPtyGy8RjrhrRy6BQg=;
        b=fID3/n1o/jp9PG1h69DDVj4VLN8kHopsqh78fV9/OyBY/nD//flWC6c2JfjS9Hgth3
         0NLhjmKoM4amGC5QjfGMwydmgOZxuhAhQsWT3qSjonTobEF5bm6vhl90Ea1vEl7LR/NY
         FilXtuNJIAfWxOPFxWR08aL5u0lrGF6KqAr57+gi2Ck+BrECzvrteLiGSz7zmCLLsgQc
         8+RLOiZdP00ytLHbHXK4Ocdq3J5xW0de5Q5C8MSvm1Yusfv61Gz1nzxYPjv6cWMVpRuJ
         drZZGCJtm88NyaAjTFYKLkUt2ckGPnTKc9tzCDyrAtX/2DW1UZMYx/MX3wReP07BGXCF
         LvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwPxX45gZm6RhM5vkMPVW/U8WnPtyGy8RjrhrRy6BQg=;
        b=Mx9CYmYL+0UljgIf8/RIOU9gjXOqmAZZq4rEfMQiw0lvHxgkxjPEhmBWEmplTter9U
         Xf/f5+eLuwLR7RR+61Q6TDMWSJhSrtm8Xc5XebR0sjol2WhLnji0LpIDhlZIAJh2zn7a
         Qf627i3H6WPyYnMVBUVqk9zcJwXZaaIn84Ysb9aBM8BUuuV02Rhp9Ssbvf4xDGewymxT
         Y/XHQ2TkQFv9Sa2eiXj2kO+GHOvHGHOEjVDhcDYQ9nYNa+lFHfMD0EQBJ3rXmYRSno6m
         JqCebEIttojcedK5kZ+sXxA21QYahxS0gE6xhVEuuCJS6gZDqHamzDVRtmBOTesNYBZu
         92Wg==
X-Gm-Message-State: ABuFfojJjeXw5lvjO+oj/Tvor1r4BmN/gWpky2Xq0CS1gPPepG6yxwms
        ZkFKoGsZAiD1a5r1JDmrHK0EUw==
X-Google-Smtp-Source: ACcGV63YVLu+VgDntuhrWVQmosW8hgf8RgGvgsvQOMh8Mgs4LplU27l7EBOYYP9l24bp2JRsc4SSuQ==
X-Received: by 2002:a62:4e0a:: with SMTP id c10-v6mr35131pfb.240.1537812989947;
        Mon, 24 Sep 2018 11:16:29 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id 77-v6sm7991149pfw.159.2018.09.24.11.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:16:29 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Omer Tripp <trippo@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        stable@vger.kernel.org
Subject: [PATCH] fs: fix possible Spectre V1 indexing in __close_fd()
Date:   Mon, 24 Sep 2018 11:15:00 -0700
Message-Id: <20180924181500.125257-1-ghackmann@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__close_fd() is reachable via the close() syscall with a
userspace-controlled fd.  Ensure that it can't be used to speculatively
access past the end of current->fdt.

Reported-by: Omer Tripp <trippo@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..a80cf82be96b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
@@ -626,6 +627,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 	fdt = files_fdtable(files);
 	if (fd >= fdt->max_fds)
 		goto out_unlock;
+	fd = array_index_nospec(fd, fdt->max_fds);
 	file = fdt->fd[fd];
 	if (!file)
 		goto out_unlock;
-- 
2.19.0.397.gdd90340f6a-goog

