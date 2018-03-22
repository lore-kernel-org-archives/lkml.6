Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCVVFm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:05:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35166 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCVVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:05:30 -0400
X-Google-Smtp-Source: AG47ELupWl466AHD+hMa82ihjnJbWSHo4TP2xrj8VxUNQoIO3Y6ZbXpDCpy+IpjZ4Jlx1NCj+mS20g==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC resend 2/2] modpost: sumversions: try to fix "same dir" logic
Date: Thu, 22 Mar 2018 22:05:24 +0100
Message-Id: <20180322210525.25361-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180322210525.25361-1-linux@rasmusvillemoes.dk>
References: <20180322150005.15061-2-linux@rasmusvillemoes.dk>
 <20180322210525.25361-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic for deciding whether to parse a file listed in the
.o.cmd file matches neither "is in same dir" (implied by the comment
here), nor the "/* Sum all files in the same dir or subdirs. */" a
little higher up. For example, for an object file in the top-level
crypto/ directory, we end up also parsing anything it includes from
include/crypto/ (though not subdirectories of that) and
arch/x86/include/asm/crypto/. On the other hand, we never parse anything
included from subdirectories of the object file's directory, contrary to
at least one of the comments.

This tries to fix things so that we actually implement "parse stuff
found in $(dirname $objfile) and below" by simply checking whether line
begins with dir. It doesn't quite work, though, because there are some

#include "../blabla"

directives, e.g. in drivers/scsi/libsas/ we have #include
"../scsi_sas_internal.h", and gcc doesn't normalize the path before
printing it, so we have

drivers/scsi/libsas/../scsi_sas_internal.h

in the .o.cmd file. But perhaps that's actually a good thing - then the
logic would be something like "if gcc found the included file using . as
starting point, we include it - otherwise it was found via some -I path,
so do not include it".

In any case, this is mostly just something I stumbled on because I'm
about to change the .o.cmd layout slightly, so I'd like to know what the
rules are really supposed to be.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Resending because I didn't reach any current kbuild maintainers nor
the kbuild mailing list.

 scripts/mod/sumversion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 0f6dcb4011a8..e4f83fb9da2f 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -368,7 +368,7 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 		}
 
 		/* Check if this file is in same dir as objfile */
-		if ((strstr(line, dir)+strlen(dir)-1) == strrchr(line, '/')) {
+		if (strncmp(line, dir, dirlen) == 0) {
 			if (!parse_file(line, md)) {
 				warn("could not open %s: %s\n",
 				     line, strerror(errno));
-- 
2.15.1
