Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B253214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkfpSCmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B253214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeKVFuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:50:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730924AbeKVFpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE66D2151B;
        Wed, 21 Nov 2018 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827421;
        bh=QbIqRMfcFd7cE9cd0S0g3JEkF1HRuB8ZNXi//dPwGJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkfpSCmrRYoWFbe65mZVdmy7F7uqNRhLsyrnSNuaXmyrabCLO4rFg/axAAxka5mRz
         daVtxjkdQdolPv3xjtMkrcrNjaTUrOphwEJikcUvprkzV7nGug/U1HjWfKa0Pb9Lch
         PS5YlIdC0nVv2DeF4SZ0/Q74M8kJgDlKG8F3L1y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 23/59] x86/build: Use __cc-option for boot code compiler options
Date:   Wed, 21 Nov 2018 20:06:38 +0100
Message-Id: <20181121183509.165565662@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 032a2c4f65a2f81c93e161a11197ba19bc14a909 upstream.

cc-option is used to enable compiler options for the boot code if they
are available. The macro uses KBUILD_CFLAGS and KBUILD_CPPFLAGS for the
check, however these flags aren't used to build the boot code, in
consequence cc-option can yield wrong results. For example
-mpreferred-stack-boundary=2 is never set with a 64-bit compiler,
since the setting is only valid for 16 and 32-bit binaries. This
is also the case for 32-bit kernel builds, because the option -m32 is
added to KBUILD_CFLAGS after the assignment of REALMODE_CFLAGS.

Use __cc-option instead of cc-option for the boot mode options.
The macro receives the compiler options as parameter instead of using
KBUILD_C*FLAGS, for the boot code we pass REALMODE_CFLAGS.

Also use separate statements for the __cc-option checks instead
of performing them in the initial assignment of REALMODE_CFLAGS since
the variable is an input of the macro.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Makefile |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -24,10 +24,11 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os
 		   -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
-		   -mno-mmx -mno-sse \
-		   $(call cc-option, -ffreestanding) \
-		   $(call cc-option, -fno-stack-protector) \
-		   $(call cc-option, -mpreferred-stack-boundary=2)
+		   -mno-mmx -mno-sse
+
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -mpreferred-stack-boundary=2)
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit


