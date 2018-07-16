Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546B0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1997E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1997E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbeGPIHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DB6CCA1;
        Mon, 16 Jul 2018 07:41:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.14 40/54] tools build: fix # escaping in .cmd files for future Make
Date:   Mon, 16 Jul 2018 09:35:37 +0200
Message-Id: <20180716073458.430005227@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Menzel <pmenzel@molgen.mpg.de>

commit 9feeb638cde083c737e295c0547f1b4f28e99583 upstream.

In 2016 GNU Make made a backwards incompatible change to the way '#'
characters were handled in Makefiles when used inside functions or
macros:

http://git.savannah.gnu.org/cgit/make.git/commit/?id=c6966b323811c37acedff05b57

Due to this change, when attempting to run `make prepare' I get a
spurious make syntax error:

    /home/earnest/linux/tools/objtool/.fixdep.o.cmd:1: *** missing separator.  Stop.

When inspecting `.fixdep.o.cmd' it includes two lines which use
unescaped comment characters at the top:

    \# cannot find fixdep (/home/earnest/linux/tools/objtool//fixdep)
    \# using basic dep data

This is because `tools/build/Build.include' prints these '\#'
characters:

    printf '\# cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
    printf '\# using basic dep data\n\n' >> $(dot-target).cmd;           \

This completes commit 9564a8cf422d ("Kbuild: fix # escaping in .cmd files
for future Make").

Link: https://bugzilla.kernel.org/show_bug.cgi?id=197847
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: stable@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/build/Build.include |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -63,8 +63,8 @@ dep-cmd = $(if $(wildcard $(fixdep)),
            $(fixdep) $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;           \
            rm -f $(depfile);                                                    \
            mv -f $(dot-target).tmp $(dot-target).cmd,                           \
-           printf '\# cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
-           printf '\# using basic dep data\n\n' >> $(dot-target).cmd;           \
+           printf '$(pound) cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
+           printf '$(pound) using basic dep data\n\n' >> $(dot-target).cmd;           \
            cat $(depfile) >> $(dot-target).cmd;                                 \
            printf '\n%s\n' 'cmd_$@ := $(make-cmd)' >> $(dot-target).cmd)
 


