Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35A8222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kyFYLvVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfBNQne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:43:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39559 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfBNQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:43:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so3317865pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=X/AWYPWQo6K1J1aVloOZCO2rRoIeRf4PJDZGFQ/EOkc=;
        b=kyFYLvVMXiYQ/Z82bm3zdoAiv4Fc8k47BNwKsXRHQTHBOu5oi94hgL8EXAqIHOcUnx
         mg1xGwbSOQ5aE7QX+p847765BbLarsgnVEOYvJdP/bQRN1+9GceF/7og7lHe7H3MdtFs
         EciR02t8A8BeltFGNna10FT+DZhMDnax++PXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=X/AWYPWQo6K1J1aVloOZCO2rRoIeRf4PJDZGFQ/EOkc=;
        b=XxpVdgspJS72ZXr8GcVa16RNC1OE4LoPc1NqiRmlQn8xeW0NqkwLABEZwhUFiyJ7bE
         Mu5rOoQ4NLPqU3Tz1RIEZg2GitPG6dwN3KaG6DxK48K3sf5H6ByrOtzJrJExQd2d8VLB
         8AsLVfmOni+k0qJNzioDmZFR68oR0lBxvZnzNuW5JRQVx8yzzAvC3Gzw2bV6YwKzhDmS
         l2q8+7E0NE923/LzFMfJEYTmjs/A2T9xEMRm8rRdMwNsfdS3Q58D9fN2Iwh7nG3Rf+fn
         7v9rVT9Tymdog+KYWW6D9BvnmezuvFyrFPq7gSFeHchRnHEydEen4EA6y9XkGU8RHv7b
         oOyw==
X-Gm-Message-State: AHQUAuby8d2eF7rg0K41xKsrL00jMfOERNTPCQp+GstmTX6ycwHGNwBe
        tpW+wEWyHcW4k97hCE765Wh1SA==
X-Google-Smtp-Source: AHgI3IYDrPOeLqUxzQ8QOyeMeo7YnqlTQG3vnyBzAw0nuakLdPOARcIplblBSbfpE2FnoLvxhIZn0g==
X-Received: by 2002:a63:2905:: with SMTP id p5mr4642644pgp.178.1550162612830;
        Thu, 14 Feb 2019 08:43:32 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l28sm6632634pfi.178.2019.02.14.08.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 08:43:32 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:43:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] exec: load_script: Allow interpreter argument truncation
Message-ID: <20190214164331.GA33450@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we want to make sure the kernel doesn't attempt to execute a
truncated interpreter path, we must allow the interpreter arguments to
be truncated. Perl, for example, will re-read the script itself to parse
arguments correctly.

This documents the parsing steps, and will fail to exec if the string was
truncated with neither an end-of-line nor any trailing whitespace.

Reported-and-Tested-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
Fixes: 8099b047ecc4 ("exec: load_script: don't blindly truncate shebang string")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - fix 1-byte-too-early-bail-out in truncation detection (Oleg)
 - add Samuel's "tested" tag
---
 fs/binfmt_script.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index d0078cbb718b..fedcbf3e1f1c 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -20,6 +20,7 @@ static int load_script(struct linux_binprm *bprm)
 	char *cp;
 	struct file *file;
 	int retval;
+	bool truncated = false, end_of_interp = false;
 
 	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!'))
 		return -ENOEXEC;
@@ -42,32 +43,56 @@ static int load_script(struct linux_binprm *bprm)
 	fput(bprm->file);
 	bprm->file = NULL;
 
+	/*
+	 * Truncating interpreter arguments is okay: the interpreter
+	 * can re-read the script to parse them on its own. Truncating
+	 * the interpreter path itself, though, is bad. Note truncation
+	 * here, and check for either newline or start of arguments
+	 * below.
+	 */
 	for (cp = bprm->buf+2;; cp++) {
-		if (cp >= bprm->buf + BINPRM_BUF_SIZE)
-			return -ENOEXEC;
-		if (!*cp || (*cp == '\n'))
+		if (!*cp || (*cp == '\n')) {
+			end_of_interp = true;
 			break;
+		}
+		if (cp == bprm->buf + BINPRM_BUF_SIZE - 1) {
+			truncated = true;
+			break;
+		}
 	}
 	*cp = '\0';
 
+	/* Truncate trailing whitespace */
 	while (cp > bprm->buf) {
 		cp--;
-		if ((*cp == ' ') || (*cp == '\t'))
+		if ((*cp == ' ') || (*cp == '\t')) {
+			end_of_interp = true;
 			*cp = '\0';
-		else
+		} else
 			break;
 	}
+	/* Skip leading whitespace */
 	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
 	if (*cp == '\0')
 		return -ENOEXEC; /* No interpreter name found */
 	i_name = cp;
 	i_arg = NULL;
+	/*
+	 * Skip until end of string or finding whitespace which
+	 * signals the start of interpreter arguments.
+	 */
 	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
 		/* nothing */ ;
-	while ((*cp == ' ') || (*cp == '\t'))
+	/* Truncate and skip any whitespace in front of arguments */
+	while ((*cp == ' ') || (*cp == '\t')) {
+		end_of_interp = true;
 		*cp++ = '\0';
+	}
 	if (*cp)
 		i_arg = cp;
+	/* Fail exec if the name of the interpreter was cut off. */
+	if (truncated && !end_of_interp)
+		return -ENOEXEC;
 	/*
 	 * OK, we've parsed out the interpreter name and
 	 * (optional) argument.
-- 
2.17.1


-- 
Kees Cook
