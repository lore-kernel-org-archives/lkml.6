Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669BBC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA93824E63
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="W6Y8i8Rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA93824E63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=horus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeGANHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 09:07:39 -0400
Received: from mail.horus.com ([78.46.148.228]:43817 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeGANHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 09:07:37 -0400
Received: from [192.168.1.20] (193-83-224-126.adsl.highway.telekom.at [193.83.224.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 2483E64099;
        Sun,  1 Jul 2018 15:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1530450455;
        bh=UAoUhdb+4fAgu/Yk68X4JW3vcqUHd4iOGeKtEpHcWcc=;
        h=From:To:Cc:Subject:Date:From;
        b=W6Y8i8RqTJWuRwoO4d0gbHK9N9ft5S8BxCBaRcgIa2vdqnicbF3Jgf4k9+J9Im8fX
         cfoJ4FjPq0rL6zi2F6ykRTSyzeml2WpP2ENejD9CJ1WJZzJmYl3FlIH1g7EbYB9R19
         uYcXHfJwxbkyoBmr2yFJR8DRrnTyYu0ZjJyBlsP0=
Received: by camel2.lan (Postfix, from userid 1000)
        id 025A81C78CA; Sun,  1 Jul 2018 15:07:33 +0200 (CEST)
From:   Matthias Reichl <hias@horus.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: honor HOSTCFLAGS and HOSTLDFLAGS in libelf test
Date:   Sun,  1 Jul 2018 15:07:33 +0200
Message-Id: <20180701130733.7781-1-hias@horus.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 596a9f6768af ("objtool: Support HOSTCFLAGS and HOSTLDFLAGS")
objtool can use a libelf installed in a non-standard location by
passing in appropriate HOST flags.

The libelf check in the main Makefile is done without these flags
and fails if no libelf is installed on the system.

Fix this by adding HOSTCFLAGS and HOSTLDFLAGS to the libelf check.

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c9132594860b..b0485fddc554 100644
--- a/Makefile
+++ b/Makefile
@@ -933,7 +933,7 @@ export mod_sign_cmd
 
 ifdef CONFIG_STACK_VALIDATION
   has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
+		echo "int main() {}" | $(HOSTCC) $(HOSTCFLAGS) -xc -o /dev/null -lelf $(HOSTLDFLAGS) -,1,0)
   ifeq ($(has_libelf),1)
     objtool_target := tools/objtool FORCE
   else
-- 
2.11.0

