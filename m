Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EBCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFFB20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083962;
	bh=UUgbRxNhkruB8W0cVw0zBQ+pkPhZkiU03TYeuMFHVtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yvstJ05SzlUH6qDpH01/gIbEkHaOHsr2IsrSCspBF6ka1EZrWr9VnHRyFuSjqJNBk
	 mO81O5ob6ApQDrbxZUhFy+1x4UrfiRbr6RPO30SMsALJScaal4ummuFbCWAEfAhq6G
	 vqTab14q/tweW0NN1J4tErM52QvCSBmMx/uqo6iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405827AbfBMSnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405808AbfBMSnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3005222D8;
        Wed, 13 Feb 2019 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083389;
        bh=UUgbRxNhkruB8W0cVw0zBQ+pkPhZkiU03TYeuMFHVtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhtqMmEhk3aLCIm6mATcdtjt76UyUY7zJLAvbtoJy3vuxgoMfjImAlkWc0wH6iWRM
         RiTs986VLpkhinvicG1JaxIDkFiZ4MM0n3YF4dJ82L5nusnfzs4empA5dUn9PS9TZA
         62C6hZdP7orJvcaM10SyLG38jYIFUSIfMEbiUAf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@vger.kernel.org
Subject: [PATCH 4.19 21/44] MIPS: VDSO: Use same -m%-float cflag as the kernel proper
Date:   Wed, 13 Feb 2019 19:38:22 +0100
Message-Id: <20190213183653.508709791@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 0648e50e548d881d025b9419a1a168753c8e2bf7 upstream.

The MIPS VDSO build currently doesn't provide the -msoft-float flag to
the compiler as the kernel proper does. This results in an attempt to
use the compiler's default floating point configuration, which can be
problematic in cases where this is incompatible with the target CPU's
-march= flag. For example decstation_defconfig fails to build using
toolchains in which gcc was configured --with-fp-32=xx with the
following error:

    LDS     arch/mips/vdso/vdso.lds
  cc1: error: '-march=r3000' requires '-mfp32'
  make[2]: *** [scripts/Makefile.build:379: arch/mips/vdso/vdso.lds] Error 1

The kernel proper avoids this error because we build with the
-msoft-float compiler flag, rather than using the compiler's default.
Pass this flag through to the VDSO build so that it too becomes agnostic
to the toolchain's floating point configuration.

Note that this is filtered out from KBUILD_CFLAGS rather than simply
always using -msoft-float such that if we switch the kernel to use
-mno-float in the future the VDSO will automatically inherit the change.

The VDSO doesn't actually include any floating point code, and its
.MIPS.abiflags section is already manually generated to specify that
it's compatible with any floating point ABI. As such this change should
have no effect on the resulting VDSO, apart from fixing the build
failure for affected toolchains.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Kevin Hilman <khilman@baylibre.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Kevin Hilman <khilman@baylibre.com>
References: https://lore.kernel.org/linux-mips/1477843551-21813-1-git-send-email-linux@roeck-us.net/
References: https://kernelci.org/build/id/5c4e4ae059b5142a249ad004/logs/
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/vdso/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -8,6 +8,7 @@ ccflags-vdso := \
 	$(filter -E%,$(KBUILD_CFLAGS)) \
 	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
 	$(filter -march=%,$(KBUILD_CFLAGS)) \
+	$(filter -m%-float,$(KBUILD_CFLAGS)) \
 	-D__VDSO__
 
 ifeq ($(cc-name),clang)


