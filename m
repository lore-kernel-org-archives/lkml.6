Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6152177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n08SMBL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbfBSAgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:36:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38385 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfBSAgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:36:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so6965277pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=l4pldehbbMCuwM5ivBYlNedZrBlnvyPYK+QPcYmd6mQ=;
        b=n08SMBL/glAnctWyZGO9+5TQ0/y3wlfPo5+rcMexIrdxyB4ByIJT/nU/6Vq6bc69hW
         NOnPmoErLoMGGSunqnmiQyCvVnj6cN9KyHym8QMY776vCkpqkB+4pF5E3neRJHYM7+JG
         SQBPUJpFX5A4Y05FhWZo84SxK0vQUD5C5N6S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=l4pldehbbMCuwM5ivBYlNedZrBlnvyPYK+QPcYmd6mQ=;
        b=APVRgDiOkWxXkZwEUFJpC+faq3YzvvL5LJQxwUQUHSy0hPOztb4boI3ZBBT+kw5AV9
         wgcOHYuQXf9q+wmvawRGdLaL+2fjVBNoVafir9zszl3jOWfwHZazJwh84hdoX7XsbEdl
         zSLIy0o+YQhjW1DUa53GOoTv3JShsdQrCk4D7CQLaRqsIs7y4J/F4HCPOhiIJpwqJf3j
         b+1aQh3c1v2AyqKVZIXkDBjvuvbYfJmd9NnQHr3R4fx9VLBCuHJyRfGcoAEtV62kkTdw
         On50IW4ly90xb4ajXjxPUQ3D+UzY0HQzRm4Q4TVexY53bc3ivafW6pKikFrJ/xndLm1u
         0HRg==
X-Gm-Message-State: AHQUAubLAwemZFIbZPOW/DKkhYbbPZCgDuHRKrg4HLoU0dO1k6gpbbyj
        Nxmx0v6z6cKDAK2qW2BFr0G1Wg==
X-Google-Smtp-Source: AHgI3IbdPCpLUP62bPJoxMt8Qn6m7NtaSJj0TFXWTnHzqWIJ9HCVA9Yko6WSApoMNiWW6QUXrwVUHA==
X-Received: by 2002:a63:c0e:: with SMTP id b14mr25257162pgl.236.1550536610429;
        Mon, 18 Feb 2019 16:36:50 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n6sm16101331pgv.86.2019.02.18.16.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 16:36:49 -0800 (PST)
Date:   Mon, 18 Feb 2019 16:36:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] exec: load_script: Do not exec truncated interpreter path
Message-ID: <20190219003648.GA26354@beast>
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
remain truncated. In an effort to improve readability, helper functions
and comments have been added.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v5: consolidate NUL test and rename to "next_terminator"
v4: use helper functions and minimize changes
---
 fs/binfmt_script.c | 57 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 7cde3f46ad26..e996174cbfc0 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -14,13 +14,30 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 
+static inline bool spacetab(char c) { return c == ' ' || c == '\t'; }
+static inline char *next_non_spacetab(char *first, const char *last)
+{
+	for (; first <= last; first++)
+		if (!spacetab(*first))
+			return first;
+	return NULL;
+}
+static inline char *next_terminator(char *first, const char *last)
+{
+	for (; first <= last; first++)
+		if (spacetab(*first) || !*first)
+			return first;
+	return NULL;
+}
+
 static int load_script(struct linux_binprm *bprm)
 {
 	const char *i_arg, *i_name;
-	char *cp;
+	char *cp, *buf_end;
 	struct file *file;
 	int retval;
 
+	/* Not ours to exec if we don't start with "#!". */
 	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!'))
 		return -ENOEXEC;
 
@@ -33,18 +50,40 @@ static int load_script(struct linux_binprm *bprm)
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
+	 * because bprm->buf is not yet guaranteed to be NUL-terminated
+	 * (though the buffer will have trailing NUL padding when the
+	 * file size was smaller than the buffer size).
+	 *
+	 * We do not want to exec a truncated interpreter path, so either
+	 * we find a newline (which indicates nothing is truncated), or
+	 * we find a space/tab/NUL after the interpreter path (which
+	 * itself may be preceded by spaces/tabs). Truncating the
+	 * arguments is fine: the interpreter can re-read the script to
+	 * parse them on its own.
+	 */
+	buf_end = bprm->buf + sizeof(bprm->buf) - 1;
+	cp = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
+	if (!cp) {
+		cp = next_non_spacetab(bprm->buf + 2, buf_end);
+		if (!cp)
+			return -ENOEXEC; /* Entire buf is spaces/tabs */
+		/*
+		 * If there is no later space/tab/NUL we must assume the
+		 * interpreter path is truncated.
+		 */
+		if (!next_terminator(cp, buf_end))
+			return -ENOEXEC;
+		cp = buf_end;
+	}
+	/* NUL-terminate the buffer and any trailing spaces/tabs. */
 	*cp = '\0';
 	while (cp > bprm->buf) {
 		cp--;
-- 
2.17.1


-- 
Kees Cook
