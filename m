Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7FCC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215222081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TAjETD4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215222081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeKBQ7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:59:12 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:56757 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKBQ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:59:11 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wA27qdTT019534;
        Fri, 2 Nov 2018 16:52:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wA27qdTT019534
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541145160;
        bh=gWWzwPrnLaTVWNF8GlqDpCX3YpifmN/Gi8o7HznrAK4=;
        h=From:To:Cc:Subject:Date:From;
        b=TAjETD4acqACzqz8BXAIWAl/H8ZZ45E62HrpSIXm40Nx14txWsljqyjqP829xYzZ6
         +NXQaMWRCsh5xoH299PscGeCJEb3egHlFQRqJSfx7C2Vnyvf+2Y3HpYhjSsUUChjAY
         e4z+EIsCVXfDHgO5o1WY+bCtMwnH6AAk83UiLNqFvHNiuzmWFi4ShK9zjETa1MJMko
         dVQif6IumAAdw4mx3P94fz8zpQHSlqs1oIxyW6ZMi9KppzDELy+YJXlRGMbdOj34f+
         nxoDeBAQw7xRdDPr0lHA6x0+UPXlA46Z1B0H+gM4LfdvXwk5QP9yV3LPtJWrGbOHxZ
         4yAlpO6aN5ycQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Nasser <afshin.nasser@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: merge_config: avoid false positive matches from comment lines
Date:   Fri,  2 Nov 2018 16:52:31 +0900
Message-Id: <1541145151-7319-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current SED_CONFIG_EXP could match to comment lines in config
fragment files, especially when CONFIG_PREFIX_ is empty. For example,
Buildroot uses empty prefixing; starting symbols with BR2_ is just
convention.

Make the sed expression more robust against false positives from
comment lines. The new sed expression matches to config options
followed by '=' or ' is not set'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/merge_config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 7067a9f..180b523 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -103,7 +103,7 @@ if [ ! -r "$INITFILE" ]; then
 fi
 
 MERGE_LIST=$*
-SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
+SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)\(=.*\| is not set$\)/\2/p"
 
 TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
 
-- 
2.7.4

