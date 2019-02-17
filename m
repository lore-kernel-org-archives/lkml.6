Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C83621900
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQp6rhFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfBQJJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:09:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfBQJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:09:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id h11so4605891pgl.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 01:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=p/I6/LqGUBbuuID0jaGYlqYqa2oWBMLzS3FYo+Q0TSs=;
        b=gQp6rhFLZ5lwnQycdujwiveZNsrNBF86/lHxAA/zWuQsP0UIwVHLDSgNMZxxchhFMj
         6oKNqtDJGUOiD2IPHNRVTvkVF1OTijmlFcD0C+sKGQGe6QkSFa/Srz+TvXx0uhY79YJc
         HHnwKXuMZKacXqo6ozz4aVCA8wer2zAiaPzhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=p/I6/LqGUBbuuID0jaGYlqYqa2oWBMLzS3FYo+Q0TSs=;
        b=nIxXJ1v7HR+54AaDw6Zdpwy/zfp8K2s/C1L9Z2/QFkXEF5uEizEgDlU2m/jYSow1uw
         Nh5E5dLXwTwVYTs35jy7QKl1QqbBAXoPqvNl9qNi2e9O7vZAwGNZ66+bj14mcFqtzJSk
         LcHZ8kK/aYfJD0BpchRLjEwqhmd9zGBqWSO2RgEaiePZUVrxg7fH953RfMK6NXmCNGoo
         cuFHps6v7UBlqCfNmKYahVIwfKTKses1wwO3BGwFIcBB+TFPNkN5u5UqCSX+MhmQD7px
         wOmDTvDypHg/4n+YClf/3H1BQzg8KWyyDgoymnqsJOtu72sdncqyvM1vyb7dkd+3LfzO
         Sp8A==
X-Gm-Message-State: AHQUAubJevZKrfGXJVrxYKX8nmQJbgO/nIpFDMA5P7H5udlg3LEjMcnr
        J4kwLUYZ9u7IN3MPb1zi9xHDNdgSLaE=
X-Google-Smtp-Source: AHgI3Ib3cDiwv/lswYK4agv61v34NDzfkNddmx9f55UrPSmgY2ZITgBS1ABARM/lU7VDzMFvtvR9aQ==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr13781190pgv.438.1550394545928;
        Sun, 17 Feb 2019 01:09:05 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a20sm9949248pfj.5.2019.02.17.01.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 01:09:04 -0800 (PST)
Date:   Sun, 17 Feb 2019 01:09:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] exec: load_script: Do not exec truncated interpreter path
Message-ID: <20190217090903.GA17600@beast>
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
 fs/binfmt_script.c | 57 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 7cde3f46ad26..32cdf6ee1f75 100644
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
+static inline char *next_spacetab(char *first, const char *last)
+{
+	for (; first <= last; first++)
+		if (spacetab(*first))
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
+		 * Without later spaces/tabs and a non-NUL final byte we
+		 * must assume the interpreter path is truncated.
+		 */
+		if (!next_spacetab(cp, buf_end) && *buf_end)
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
