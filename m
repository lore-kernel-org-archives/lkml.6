Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB37BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D66241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uxE+PwbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D66241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeGEClq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:46 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:44119 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbeGECln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:43 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZd028145;
        Thu, 5 Jul 2018 11:40:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZd028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758402;
        bh=PeVnUtgNC8gbPFeql5sex6hHkYn8Hq42VaeMvYoJ94Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxE+PwbTMNq/fcoT4cHNahcP2vjXwhW5fG1p5QfCWBdzwFuY9Wf4u3A822hAZmAuF
         Lh8eqCKCmH4vlmcQDDxW2H8xJsCTm7x4TcFlWR8KXTsH55cx0pB0fLx5sja0u1xdlF
         a0pJXzE7Z8EB50snqw2jx6kPdCoxYJhRAwtHSLGN9UVOSWYL8kBvRxXep6xiNnsbIY
         Ct0KRi9Qo2NuD0kvDYunNJxYJoxgsJL06eOXRk/PX9crBJ/rqyjK8gmtNRtBB2w63H
         3rme4QOti3cuZd/PMfvzobCbf5mCST+0AiTLD/WNNYWIl4mzCTh4yXcaJSmlq16AZB
         leAOS+b1bHZ7Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/12] kbuild: use 'include' directive to load auto.conf from top Makefile
Date:   Thu,  5 Jul 2018 11:39:44 +0900
Message-Id: <1530758389-30862-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you build targets that require the kernel configuration, dot-config
is set to 1, then the top-level Makefile includes auto.conf.  However,
Make considers its inclusion is optional because the '-include' directive
is used here.

If a necessary configuration file is missing for the external module
building, the following error message is displayed:

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are missing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.

However, Make still continues building; /bin/false let the creation of
'include/config/auto.config' fail, but Make can ignore the error since
it is included by the '-include' directive.

I guess the reason of using '-include' directive was to suppress
the warning when you build the kernel from a pristine source tree:

  Makefile:605: include/config/auto.conf: No such file or directory

The previous commit made sure include/config/auto.conf exists after
the 'make *config' stage.  Now, we can use the 'include' directive
without showing the warning.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d15ac32..ef24068 100644
--- a/Makefile
+++ b/Makefile
@@ -584,7 +584,7 @@ virt-y		:= virt/
 endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
--include include/config/auto.conf
+include include/config/auto.conf
 endif
 
 # The all: target is the default when no target is given on the
-- 
2.7.4

