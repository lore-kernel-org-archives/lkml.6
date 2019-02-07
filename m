Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA37DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B734D21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjzqXAPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBGWCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:02:31 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:41080 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfBGWCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:02:30 -0500
Received: by mail-it1-f202.google.com with SMTP id 71so2301150ita.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MqLuibBHajEelET2gmxRQFU5+ervUm+M6PMMM0jIz+k=;
        b=NjzqXAPv2Gw8MbNmaKl8Irqy4dtdTyhJaKdWzaw4RP1C7HT2CI16fy8ualj7GapIKe
         xUFEeAmjG0112J8IFKsNdet7r3fKZ0/bKmkZJHuesmNFEmJbrRdmF5gK4Gn3ciG/rDEP
         ZWZ2JVO7WQqtuTlFrvinw01+LGNXX2gGOvPmc5TDylF1MGJNGuX8jVtQt9NbjtztdFGX
         uBhO1DP9kUuWcl7gGnTRZH9wV0K0p7K6Q2GgsBnlsS2NMW8P/+Wpk+PbF2ld1SxoojoB
         fX9y4ed58VzKk/6+uFwRM5nsRpzZAJ5V5vQB2Bs9C+nm8a//QWSJ+dqZRKHF4Wc3jB34
         yM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MqLuibBHajEelET2gmxRQFU5+ervUm+M6PMMM0jIz+k=;
        b=VqC6P0XE2H7WL2XaBV7BvOSdyXLuW1EuGJqJKjPJRGsVYad5YsWi2gZv5vNXnvI4Tl
         lN88DXSeI4q/9zPiy3DOh436DhjK/wRaw9mkc5iOUTFTJXPCKrLew85tHrqxFJbjJmS6
         rcFTVtHdjv5x5zMKyHCtxRCRoiYA/CTMzsyw8THuFKWVl/xAGbPfZtzNiuyRTmkoxaOq
         EjBS4kdZeR6ceB+Jz63PVAp7wjEpSuzMIuTiDIO/lFfK7NkDS1chUf4aQbARXec49IQx
         IoRhrO4y0dOEitBm8ukbEPk7hvVHSLYjgMJu5A4Gy9YqhdsCam3GCq6lpKXvTKDkiYjd
         wDRQ==
X-Gm-Message-State: AHQUAubhyl2WiKqakY1cG+sD74C6eHWB/21UeD2hTOynoNc0x21D7hxt
        wFxmAPjdt1EXQMm8iKNEvUIvDM/VRFTGJkVD6P0=
X-Google-Smtp-Source: AHgI3IbzAB08Nd8K+rw+XS37VTuAC7piX0ErADL9L1+p2KSX5VtiIPHG/x6FtX4a94kQGQFtcnBDnQq+Yp+9LGZ8bvg=
X-Received: by 2002:a24:5e90:: with SMTP id h138mr7648078itb.27.1549576950026;
 Thu, 07 Feb 2019 14:02:30 -0800 (PST)
Date:   Thu,  7 Feb 2019 14:01:49 -0800
Message-Id: <20190207220155.81351-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH 1/4] init/Kconfig: add config support for detecting linker
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-kernel@vger.kernel.org
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

Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
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

