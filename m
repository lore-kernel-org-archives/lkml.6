Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242112192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EjYL4tb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfBODSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:18:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBODSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:18:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so4094860pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 19:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XNx/jniog9J0M8v7JN76wM0AM9tcXX0G2aRE+Ku4UfM=;
        b=EjYL4tb5kOVMVtnpKuVs1f/kvMQzRzpMSsiGoBN/JsyIzoZc7NriUZ+jP5SGogw0TB
         mBdo/hD3SS1KCO9PaFd4Ix37uipGxHSKqTYc9BRlqy9L+RzUCybofpkFUiYax8VrU0za
         5sPhGGyLTfe2n/VMGfaUEOh4EqfbFgVyG4+64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XNx/jniog9J0M8v7JN76wM0AM9tcXX0G2aRE+Ku4UfM=;
        b=CtDjsbCb+a346Ih1b5asSKb7afGZE/JOr0KhIXjvTMQF+O2Up7qkbh+2zE3H7Sx8dI
         VPSP7AKz87a1sVr7De9x9znNQImY2bRWe2xqeST5DBwbuRs8Q0c3KD4h2NfJHlW3tMIB
         IkgpHCzdmyiCLVJbzVupf4LzwVavIyDZbiy4phqlWDvHznXJNtEXZVeM3rKZgvzDZIX8
         sU1jeFIhIQPGJeAOh5w7lJUK2qzKnK6LX7hvNxP86tw4mLkFS87ID/hySUihnWEcazVZ
         raMGD31+0u/9OovwBWbxFseQi6GF6UZE63eWZpPbsCUZhXJNBawDn+E/zO8XclzN6ubT
         DFGw==
X-Gm-Message-State: AHQUAua/pjnR4n828l5mljS3S97Lh2IAHc0n+7LEM5cq0dZBY78Q66ks
        Fv5EQKK1aWYGec3YxfJt8HfOGA==
X-Google-Smtp-Source: AHgI3Ia0YqfOABpOyCXz+Cf6CxhBdccV8IjYY3xv0ep3SG18x0W3EoYs8HDWn7tQWzdla7iCn1gRmA==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr3264621pgv.244.1550200680641;
        Thu, 14 Feb 2019 19:18:00 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u87sm9883537pfi.2.2019.02.14.19.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 19:17:59 -0800 (PST)
Date:   Thu, 14 Feb 2019 19:17:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
Message-ID: <20190215031758.GA18776@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8099b047ecc4 ("exec: load_script: don't blindly truncate
shebang string") was trying to protect against a confused exec of a
truncated interpreter path. However, it was overeager and also refused
to truncate arguments as well, which broke userspace, and it was
reverted. This attempts the protection again, but allows arguments to
remain truncated. Lots more comments are added, since the parsing here
is rather fiddly while dealing with whitespace.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_script.c | 97 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 15 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 7cde3f46ad26..8fca59f9ee03 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -20,7 +20,9 @@ static int load_script(struct linux_binprm *bprm)
 	char *cp;
 	struct file *file;
 	int retval;
+	bool truncated = false, end_of_interp = false;
 
+	/* Not ours to exec if we don't start with "#!". */
 	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!'))
 		return -ENOEXEC;
 
@@ -33,37 +35,102 @@ static int load_script(struct linux_binprm *bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
 		return -ENOENT;
 
-	/*
-	 * This section does the #! interpretation.
-	 * Sorta complicated, but hopefully it will work.  -TYT
-	 */
-
+	/* Release since we are not mapping a binary into memory. */
 	allow_write_access(bprm->file);
 	fput(bprm->file);
 	bprm->file = NULL;
 
-	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
-	if ((cp = strchr(bprm->buf, '\n')) == NULL)
-		cp = bprm->buf+BINPRM_BUF_SIZE-1;
+	/*
+	 * This section handles parsing the #! line into separate
+	 * interpreter path and argument strings. We must be careful
+	 * because bprm->buf is not yet guaranteed to be NUL-terminated.
+	 *
+	 * Truncating interpreter arguments is okay: the interpreter
+	 * can re-read the script to parse them on its own. Truncating
+	 * the interpreter path itself, though, is bad. We can note
+	 * truncation here, but we cannot yet check for non-EOL whitespace
+	 * because any leading whitespace would not indicate the end of
+	 * the interpreter path string.
+	 */
+	for (cp = bprm->buf + 2;; cp++) {
+		if (!*cp || (*cp == '\n')) {
+			/*
+			 * If we see NUL (end of file) or newline it means
+			 * we hit the end of the #! line without truncation.
+			 */
+			end_of_interp = true;
+			break;
+		}
+		if (cp == bprm->buf + BINPRM_BUF_SIZE - 1) {
+			/*
+			 * Otherwise if we reach the end of the buffer,
+			 * we've been truncated, but we don't know if
+			 * it was in arguments or the interpreter path.
+			 */
+			truncated = true;
+			break;
+		}
+	}
 	*cp = '\0';
+	/* At this point, the bprm->buf array is a NUL-terminated string. */
+
+	/*
+	 * Truncate trailing whitespace so it cannot be included in either
+	 * interpreter or argument strings.
+	 */
 	while (cp > bprm->buf) {
 		cp--;
-		if ((*cp == ' ') || (*cp == '\t'))
+		if ((*cp == ' ') || (*cp == '\t')) {
+			/*
+			 * If we see whitespace at the end of the buffer,
+			 * we know we've at least found a full interpreter
+			 * path (even if it's zero length, which is checked
+			 * later).
+			 */
+			end_of_interp = true;
 			*cp = '\0';
-		else
+		} else
 			break;
 	}
+	/* Skip leading whitespace ahead of the interpreter path. */
 	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
-	if (*cp == '\0')
-		return -ENOEXEC; /* No interpreter name found */
-	i_name = cp;
-	i_arg = NULL;
+	/*
+	 * We've successfully found the start of the interpreter path.
+	 * Fail if the interpreter path is already empty.
+	 */
+	if (*cp)
+		i_name = cp;
+	else
+		return -ENOEXEC;
+	/*
+	 * Find the end of the interpreter path. We will either hit NUL
+	 * termination or find whitespace which signals the start of
+	 * arguments.
+	 */
 	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
 		/* nothing */ ;
-	while ((*cp == ' ') || (*cp == '\t'))
+	/*
+	 * In the case of whitespace, terminate the end of the interpreter
+	 * path and skip until we reach the start of the arguments.
+	 */
+	while ((*cp == ' ') || (*cp == '\t')) {
+		/*
+		 * Finding whitespace at the end of the interpreter path
+		 * means we've intentionally hit the end of the path
+		 * without truncation.
+		 */
+		end_of_interp = true;
 		*cp++ = '\0';
+	}
+	/* We've successfully found the start of any potential arguments. */
 	if (*cp)
 		i_arg = cp;
+	else
+		i_arg = NULL;
+	/* Fail if the interpreter path was cut off. */
+	if (truncated && !end_of_interp)
+		return -ENOEXEC;
+
 	/*
 	 * OK, we've parsed out the interpreter name and
 	 * (optional) argument.
-- 
2.17.1


-- 
Kees Cook
