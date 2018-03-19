Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeCSL1Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:27:25 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30213 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755372AbeCSL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:27:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w2JBQHQt023258
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/7] kbuild: remove partial section mismatch detection for built-in.a
Date: Mon, 19 Mar 2018 20:26:11 +0900
Message-Id: <1521458773-14224-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When built-in.o was incrementally linked with 'ld -r', the section
mismatch analysis for the individual built-in.o was possible when
CONFIG_DEBUG_SECTION_MISMATCH was enabled.

With the migration to the thin archive, built-in.a (former, built-in.o)
is no longer an ELF file.  So, the modpost does nothing useful.
scripts/mod/modpost.c just checks the header to bail out, as follows:

        /* Is this a valid ELF file? */
        if ((hdr->e_ident[EI_MAG0] != ELFMAG0) ||
            (hdr->e_ident[EI_MAG1] != ELFMAG1) ||
            (hdr->e_ident[EI_MAG2] != ELFMAG2) ||
            (hdr->e_ident[EI_MAG3] != ELFMAG3)) {
                /* Not an ELF file - silently ignore it */
                return 0;
        }

We have the full analysis in the final link stage anyway, so we would
not miss the section mismatching.

I do not see a good reason to require extra linking only for the
purpose of the per-directory analysis.  Just get rid of this part.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 316cb95..66461e9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -456,8 +456,7 @@ quiet_cmd_link_o_target = AR      $@
 
 # If the list of objects to link is empty, just create an empty built-in.a
 cmd_link_o_target = $(if $(strip $(real-obj-y)),\
-		      $(cmd_make_builtin) $@ $(filter $(real-obj-y), $^) \
-		      $(cmd_secanalysis),\
+		      $(cmd_make_builtin) $@ $(filter $(real-obj-y), $^), \
 		      $(cmd_make_empty_builtin) $@)
 
 $(builtin-target): $(real-obj-y) FORCE
-- 
2.7.4
