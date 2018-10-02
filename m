Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78530C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF052213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ibW48wkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF052213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJBIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:14:03 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:36683 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeJBIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:14:02 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w921WUCD008691;
        Tue, 2 Oct 2018 10:32:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w921WUCD008691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538443950;
        bh=JKofTgoDVAcOjK873FSEktMhmAvuO6+axKfzAr06A20=;
        h=From:To:Cc:Subject:Date:From;
        b=ibW48wkq7EXXshsU0W+PqB62F72aVYOqJqKaAhKKXZ6aXWPXzvmRvul0QFCvPg+8z
         8vo/gPxvLBMqzT+qaEhU1kWjvtNXbu9gA0Yx4RHbxaRC4HZMbrV/G3l+eC1V1HvLKr
         XEYLsoTS8Jwxw870Fw/rJAWxktHCE5sc07U6cwG6DxsnlQhBZl7L23dtULpCCDn3dc
         djQdL7YTSICeNgByHnsYll8ES9V64t/TZI9+SQLl9Fo2Jl+Brp7wKbQg8CQOz3hJIu
         wGHnrhXR2zv2IxxrPyqqf/OTRGHul8k26bxRwANvOWLCB8MVG8fy9qDQDH5CAw94lz
         0jvuOvbwDMZeQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: add -Wno-unused-but-set-variable flag unconditionally
Date:   Tue,  2 Oct 2018 10:32:23 +0900
Message-Id: <1538443943-29805-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have raised the compiler requirement from time to time.
With commit cafa0010cd51 ("Raise the minimum required gcc version
to 4.6"), the minimum for GCC is 4.6 now.

This flag was added by GCC 4.6, and it is recognized by ICC as well.

It is true that Clang does not support this flag but this commit is
just touching the else part of the "ifeq ($(cc-name),clang)" check.
Hence, Clang build is not affected.

Let's rip off the cc-disable-warning switch, and see if somebody
complains about it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix commit log

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

