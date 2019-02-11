Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E20C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382BA218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgD0EQVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfBKTaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:30:35 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:44277 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbfBKTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:30:34 -0500
Received: by mail-vs1-f73.google.com with SMTP id o132so24536vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yTmTM4lUWy38wNpJAAj82b5/JRtPQPUWiVhvkLc+GmU=;
        b=IgD0EQVvZuRTW8V34xCcsd5j+kuukE2iC4AfflnsyCWMauneJH9QQAwi3n3dFkIVl1
         yQswrFqCX01hxOU9LOZO0jzflZSDdobLsqRH5CHZZS9fyZhRZN6ud1RvJO39OL8fdmbt
         yLJy++glVR3+LvhqrpbOMBvg79T3MIgcnDdm7OK9ePSvhksVKeSMnZwAsu1RJPhY8pVF
         UAUdVqmig6Bg1NRh1FsbaVldgBDaN9hsdr5ZXzn4pVerj9lk7g8t8xyKGo6LarW5hRMs
         Q3HUQFQaraxBEnLMlaCLxHCQs0YFbjOCOpL7Jt8ePKT/VScKQENAsWNu/THSYgipbRiR
         /zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yTmTM4lUWy38wNpJAAj82b5/JRtPQPUWiVhvkLc+GmU=;
        b=Hij+j741/9dG4TJXNJ+M5xl/pORQm7UTUanNurKoqGLyE/5e7hAEsLVPaRvPql9OnW
         R2z8tkDgNdHfRG2FdJiAi003yiGjp5jtGQgMj1N+FNZ8sSBFCIzw/L1Ff3esRUsUtJma
         xsYyNhyVmnHZN4PcT2MiGnyvG3KIp6CRbTdexBAOL8YYtRaBlXH+yoxxXzb3ZHuhLbhS
         azg7LzrdeBX8wUsn3M4/qGwcva2/8Xbt8AZmlkOhu0+hZ87r9J7ZbjMB5duyjIRQhO/V
         bRAqRKEdC2Tu08rm42QA0h2LI5Xu9a6J6o4FJrI1zOV3ZE8FKutgU0tzJolvUywg6VbT
         coUw==
X-Gm-Message-State: AHQUAubimfz/4whBWKOaxyDBCCNLDRESPpkWCxcjJM6hIEwgeuXhnEsI
        W6LGOzG4+vVoQXIbdfH3ftEPQ7oh+PlbtWEm8g4=
X-Google-Smtp-Source: AHgI3IYWVYrxBcjc7ylnGQXBCE4Ft/swEAMJWDf3/5UvXBH/BklzcuSloD6V+Nqifugd/XtXLW3Gdz3KUFbiE1Nntpo=
X-Received: by 2002:ab0:4e23:: with SMTP id g35mr23818918uah.0.1549913433804;
 Mon, 11 Feb 2019 11:30:33 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:30:03 -0800
Message-Id: <20190211193008.24101-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v2 1/4] init/Kconfig: add config support for detecting linker
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     natechancellor@gmail.com, sedat.dilek@gmail.com,
        keescook@chromium.org, samitolvanen@google.com,
        michal.lkml@markovi.net, akpm@linux-foundation.org,
        hannes@cmpxchg.org, peterz@infradead.org,
        linux@dominikbrodowski.net, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, gor@linux.ibm.com, adrian@lisas.de,
        rgb@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how we differentiate between CONFIG_CC_IS_GCC and
CONFIG_CC_IS_CLANG, add CONFIG_LD_IS_BFD, CONFIG_LD_IS_GOLD, and
CONFIG_LD_IS_LLD.

This simiplifies patches to Makefiles that need to do different things
for different linkers.

Cc: Sami Tolvanen <samitolvanen@google.com>
Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1->V2:
* Add suggested, reviewed, and tested by tags.

 init/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index c9386a365eea..b6046dcf7794 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -26,6 +26,15 @@ config CLANG_VERSION
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
 
+config LD_IS_BFD
+	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU ld')
+
+config LD_IS_GOLD
+	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU gold')
+
+config LD_IS_LLD
+	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'LLD')
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.20.1.791.gb4d0f1c61a-goog

