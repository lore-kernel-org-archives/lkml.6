Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14059C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED60208DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNE5sByR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED60208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeGHVFn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43048 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933317AbeGHVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so844416pgr.10;
        Sun, 08 Jul 2018 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UFGxkFlELgjhqT2bEflX7XbN3XOBafTI2yVmVpjVghg=;
        b=tNE5sByRKXhDtRE1WuZ4c9Gokcs8/E8TKx2XGADQeaAeHwE5EqTJ3w3we7CsEuZZSZ
         iYGrWCRvuZaGAgCvUcx3bLid55hVECJ/7Bfu1HowBiHCWJp0T8N4Y4bZmNGJWi0prrF5
         03A0EOL+7A3WJ6mISZ1BijPBPQgRFQ5hmxJ4Q18REVCWN1Js/QLW4PLB4fEJ2M448W23
         OmVz6nvOybWyzLTaQSfGCtUk30poYbeViWsDVUQWE9mKKVLQGJpfbYAVkFMa+yl1CHsw
         Nem28NmzPmnDkWXPuuHkBBRn4e6+eIohOnj5Ts2cx/lBHbk580a1CJJ5Rm1dFTZPCFYt
         Pxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UFGxkFlELgjhqT2bEflX7XbN3XOBafTI2yVmVpjVghg=;
        b=V1W8P+R3UTh3fHGxljCmY5rEq3Wc1XCffaPK9mT9n3ukh/7CvONP0h5tEMJoC53ouj
         VN+/8XPLzl/bBbpvdf8t2bsLATsuk/lkoP5kkbLd/6Em23cthBNAr5z8q8B1YA+Gsucs
         NlFTb3FcsaNEOgmOa1zgzIVPOik4u0GpiH0k600wcHgmOmW2ehPItkPPxlDH5bT1W1Ky
         +xhVoKx1fRNlTL+gG812yfCcdWu2JsRlIqQFCKqAzRjrfXz9lyBi/YMZAK3MS7HDZRc9
         BZ0hsOd5TazaPUMJLLxqE0gSAs9sUjrx8BZCpz2c/Q2nTl2pBQhnHx75j7qrkTh+nlUT
         EtyA==
X-Gm-Message-State: APt69E3vUJUKdTC9XFUoeFMsuvSljEVffv85XRiOPpOBcqNYP6o9fFLN
        7DWVCBsS0W/Ea4hjP3hjw3Q=
X-Google-Smtp-Source: AAOMgpe49X618nmvr4My1rHCeoc1jBdBdJFQlXEuW8/dWnpzP5mrHR/JQ5yLErcy43UqWCf0lSifGg==
X-Received: by 2002:a62:6303:: with SMTP id x3-v6mr18710274pfb.91.1531083939531;
        Sun, 08 Jul 2018 14:05:39 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:39 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 08/18] fsmount: pass up error code from dentry_open()
Date:   Sun,  8 Jul 2018 14:01:44 -0700
Message-Id: <20180708210154.10423-9-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fixes: 0c65353ab9f5 ("vfs: Implement fsmount() to effect a pre-configured mount")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6f0701a03a2b3..9cde133d0a9c4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3333,8 +3333,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 	 * it, not just simply put it.
 	 */
 	file = dentry_open(&newmount, O_PATH, fc->cred);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
 		goto err_path;
+	}
 	file->f_mode |= FMODE_NEED_UNMOUNT;
 
 	ret = get_unused_fd_flags(flags & FSMOUNT_CLOEXEC);
-- 
2.18.0

