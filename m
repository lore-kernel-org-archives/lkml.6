Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD65BC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7442082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QhgbQnoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7442082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJYAcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:32:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39632 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:32:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so5962886wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uakhBrY531/j4OdHxUTixjyJNgXwLaLCskWZ1x1whFI=;
        b=QhgbQnoTjdqXpHn0EJSS9qRSPkwhXwmOC3yXrO877K9Z0wrMS+aDvM7cAN5KrNWtBw
         iAbblGLcf8Uh3Zo5On8KGPLOUhXKVoj+6dUK53SuLjCxM71LYjomeVrtfQ6EUUNzPsB8
         wAnrSv24y8uOKNCHIrQoX3G0qTb6sM5LDb6Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uakhBrY531/j4OdHxUTixjyJNgXwLaLCskWZ1x1whFI=;
        b=AP/TFMKYONeMHHeKKO/0YzZFB7OzhrJ0i4tXyDvDRejkIl7hNqD7QXCDxzEJisyV98
         ZmoFA+VFB+tjlfvJw/cMKZhLfkSLlN/CyoJBehyoRdyX5jdU2e2F+KmdT37jBWl0hMzv
         /HAIpvhcLFL6FOmghzlYNyhAW9XFqlVo0TjR9dPKLFDjEySv9BleUNCsgtUeuIBNolkL
         Z5NAF8EvLf6smybWUgUoU1JCFiB0GlyLKNAzbdIboHaaLLQtVrxcdB0qzPD5avZXAD8B
         2xLxOlq7AQPTRGWZcZK4KvmDrDmhhBB9dp8/7Gq6aZrOiP+LIz32vv/0rgXOSyNWGhDL
         dKEA==
X-Gm-Message-State: AGRZ1gI+HKNjb6hvw2hAdKWBGvbcY0vOms7OdLGImTupd4EcentPm8B/
        b79Qr4pfVVUz5ybiCTC9//DUSw==
X-Google-Smtp-Source: AJdET5dW1JDOKq+oA5jnRRv5xRcPWLvHInBUzhyZ7dmtiWPtDyaF1FOQ0t7Bjhz04D/veiSvSdVtbw==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr3043939wmd.99.1540397033533;
        Wed, 24 Oct 2018 09:03:53 -0700 (PDT)
Received: from prevas-ravi.event.pylonone.net ([185.7.230.213])
        by smtp.gmail.com with ESMTPSA id 203-v6sm7133098wmn.34.2018.10.24.09.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 09:03:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/file.c: make more use of cloexec bits not being cleared
Date:   Wed, 24 Oct 2018 17:01:58 +0100
Message-Id: <20181024160159.25884-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can expand somewhat on 529790827054 (vfs: stop clearing close on exec
when closing a fd). First, since we now leave the cloexec bits set,
similar to how we try to avoid dirtying a cache line in the !O_CLOEXEC
case, test whether the bit is set before setting it.

Furthermore, we don't care about the state of close_on_exec in the new
bits when we expand the fdtable, we don't need to clear close_on_exec[i]
in do_close_on_exec, and since we may have quite a few bits set in
close_on_exec[i] without an actual open file, mask the set with
open_fds[i].

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..7bc44e7084e5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -56,7 +56,6 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
 	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
 	memset((char *)nfdt->open_fds + cpy, 0, set);
 	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
-	memset((char *)nfdt->close_on_exec + cpy, 0, set);
 
 	cpy = BITBIT_SIZE(count);
 	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
@@ -227,7 +226,8 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 
 static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt)
 {
-	__set_bit(fd, fdt->close_on_exec);
+	if (!test_bit(fd, fdt->close_on_exec))
+		__set_bit(fd, fdt->close_on_exec);
 }
 
 static inline void __clear_close_on_exec(unsigned int fd, struct fdtable *fdt)
@@ -653,10 +653,9 @@ void do_close_on_exec(struct files_struct *files)
 		fdt = files_fdtable(files);
 		if (fd >= fdt->max_fds)
 			break;
-		set = fdt->close_on_exec[i];
+		set = fdt->close_on_exec[i] & fdt->open_fds[i];
 		if (!set)
 			continue;
-		fdt->close_on_exec[i] = 0;
 		for ( ; set ; fd++, set >>= 1) {
 			struct file *file;
 			if (!(set & 1))
-- 
2.19.1.6.gbde171bbf5

