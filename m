Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D20208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D20208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966244AbeFRJgz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:36:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935942AbeFRIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6452FC5C;
        Mon, 18 Jun 2018 08:23:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 185/279] gcc-plugins: fix build condition of SANCOV plugin
Date:   Mon, 18 Jun 2018 10:12:50 +0200
Message-Id: <20180618080616.594507233@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 642ef99be932c4071274b28eaf3d3d85bbb6e78c ]

Since commit d677a4d60193 ("Makefile: support flag
-fsanitizer-coverage=trace-cmp"), you miss to build the SANCOV
plugin under some circumstances.

  CONFIG_KCOV=y
  CONFIG_KCOV_ENABLE_COMPARISONS=y
  Your compiler does not support -fsanitize-coverage=trace-pc
  Your compiler does not support -fsanitize-coverage=trace-cmp

Under this condition, $(CFLAGS_KCOV) is not empty but contains a
space, so the following ifeq-conditional is false.

    ifeq ($(CFLAGS_KCOV),)

Then, scripts/Makefile.gcc-plugins misses to add sancov_plugin.so to
gcc-plugin-y while the SANCOV plugin is necessary as an alternative
means.

Fixes: d677a4d60193 ("Makefile: support flag -fsanitizer-coverage=trace-cmp")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.gcc-plugins |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -14,7 +14,7 @@ ifdef CONFIG_GCC_PLUGINS
   endif
 
   ifdef CONFIG_GCC_PLUGIN_SANCOV
-    ifeq ($(CFLAGS_KCOV),)
+    ifeq ($(strip $(CFLAGS_KCOV)),)
       # It is needed because of the gcc-plugin.sh and gcc version checks.
       gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
 


