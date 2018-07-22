Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEFBC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD40620875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFW431KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD40620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeGVMC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 08:02:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34027 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeGVMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 08:02:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so14546417ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z6Iq+RBFK+A+7zPklX/+s0pqpHF8NUF3irjT+CJ2aDM=;
        b=NFW431KQdEpXa+aHcZRSkoNB7q37R838YVzExvSsZudqyYuMUokG2ygKVTcj2engLk
         ZEcX+7t4eXRUxIows/j7ajFgXU07tl9dkxF4gb4f4EIWLl1s/vWMqmAeUZ1KSEHCQ6Re
         QB/dXaEt62BFp2iF7rgLp31uwq32S9s/5dsr733fZceUowuMM2y4m7pqW859u/RhfXRp
         29VqkPwWUlawbDlLZ9F3yVXXtVq2WrNGjlx3XQNJIoMZTuwHAvgYEdwYigR2kqGK5epY
         9qjUF9y70kaFro8OgPu2HtSfKllHTphc9LIzQRuitaJT7Q2BrRBFsLPVvyCyRlTbKdZv
         dbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z6Iq+RBFK+A+7zPklX/+s0pqpHF8NUF3irjT+CJ2aDM=;
        b=ZS0YdaekLFIyE+zBCB85mr8cUAOjeWp8hvk82whMSbQc5Bk84rtHCwotq2v3llZX12
         29Q9mOVLOPVuL9jFV+990/fqvZdqnofeWqC0WN6fKtbilcNIzCysX+8ydWtPdrl47SVB
         5at7q9R8YBJi0YMSjXgGWd/KDzSHngYCQymTfaIqBMSG+KZJWW2xAxtxIxZy9C1MbEFr
         ewBuWmhRiqK6eDiL26+Y0uh4eYCpezdgyPtu1GVROnRXPMAB01xyqmF4eeL7uPaKho4d
         fMO8pji+T4HMS10b+SoOSoaY+sIhoQ5EcDCdNITolFG1Rq8tjv0I0+0wXx/ZUCxQNh6K
         jlbg==
X-Gm-Message-State: AOUpUlE9rKg63klV5TGUQNevsqitdypnQQNqoVKhWJKz4BBJb8WfhMLV
        qUXUpl9O2V5jFu6s0JHXEZU=
X-Google-Smtp-Source: AAOMgpeLP10wy9guGKC6uqkKG8AF/VqX9NqekmxayAAzjLCM6fbBvI0uyurMxiUdseVzCFDC9hsJpw==
X-Received: by 2002:a2e:740f:: with SMTP id p15-v6mr6544418ljc.130.1532257595792;
        Sun, 22 Jul 2018 04:06:35 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id u19-v6sm1291458lje.51.2018.07.22.04.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 04:06:34 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] fscache: fscache_set_key() - align alloc and usage
Date:   Sun, 22 Jul 2018 13:05:19 +0200
Message-Id: <20180722110519.23917-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fscache_set_key() function allocates the buf pointer if index_key_len > sizeof(cookie->inline_key).
In such cases the allocated space might not be aligned with the pointer type.
This may result in an out-of-bound in the for-loop later in the same function, as the counter is rounded up.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com
---
 fs/fscache/cookie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 97137d7ec5ee..ed28bfb6a0fe 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -98,7 +98,7 @@ static int fscache_set_key(struct fscache_cookie *cookie,
 	cookie->key_len = index_key_len;
 
 	if (index_key_len > sizeof(cookie->inline_key)) {
-		buf = kzalloc(index_key_len, GFP_KERNEL);
+		buf = kzalloc(round_up(index_key_len, sizeof(u32)), GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 		cookie->key = buf;
-- 
2.11.0

