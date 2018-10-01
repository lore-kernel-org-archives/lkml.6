Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3ED2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1i+0bhjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3ED2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeJAQWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:22:24 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64049 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeJAQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:22:24 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w919iipK005108;
        Mon, 1 Oct 2018 18:44:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w919iipK005108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538387086;
        bh=4lVB2aFznZ03R0jO3ZE1lpLOFkM4t8EYXVBngQ9ssaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1i+0bhjYXKFw4qk3zw+9tpdVx9sqsT2gcGC+SMY5e9xVWNjs23T0pQ1Rp7NAPPurG
         lnSsSerOLxy3ASjXShB691YYT02M3Lnyuur0NvzkBQWNQqgNjTVfXNu/nQ+L1PdOyX
         4v0iVTSaa55oZvJL14Khf5JGxLV5IY/iFdCz7te8kNIJn9axJuewHz375Vcmc91vUH
         1DvMFExtIsmizZ780FC7ivFQnfj3luLznovMykFKTb3ckX8zZr5m0D9AzP8APk64XW
         ksOw/5VcpYEaBsyZkZRG6pwLJGLxf/AkH0/bQNULzY5oQ6jNZpssorWMsxazv5qDzw
         S8O/RhrR6FvNw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: add -Wno-unused-but-set-variable compiler flag unconditionally
Date:   Mon,  1 Oct 2018 18:44:38 +0900
Message-Id: <1538387078-21892-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have raised the compiler requirement from time to time.
With commit cafa0010cd51 ("Raise the minimum required gcc version
to 4.6"), the minimum for GCC is 4.6 now.

This flag was added by GCC 4.6, and it is recognized by Clang and
ICC as well.

Let's rip off the cc-disable-warning switch, and see if somebody
complains about it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8a23fee..2627266 100644
--- a/Makefile
+++ b/Makefile
@@ -716,7 +716,7 @@ else
 
 # These warnings generated too much noise in a regular build.
 # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
+KBUILD_CFLAGS += -Wno-unused-but-set-variable
 endif
 
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-- 
2.7.4

