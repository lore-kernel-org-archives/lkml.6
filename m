Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F091AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05F32177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297753;
	bh=ilR6EM3XGJ7D4GJVtJcl8sjQEHR0Yr9Lc9r9ljuLxbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YdQCe5CxekpoQ7f7JSlr4MKs/RvCT7goE6XcWc3OG7HbgO6b9cQuLfhVjwnyhe2+2
	 eCZ3hKGezoYnveHOrIZHGz/KUYdEOTK7oQJE7+imqGGCazA/KuCgA28xOs/vuaUofA
	 OubIiL4tzp/YZegEJZvIzF71h1ctBEFVHAHrHR4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeLTJWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731345AbeLTJW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A823B20656;
        Thu, 20 Dec 2018 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297747;
        bh=ilR6EM3XGJ7D4GJVtJcl8sjQEHR0Yr9Lc9r9ljuLxbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuvj3zPa33XkF7xJaTFrQL3YhhD5RY+Wqw59bu9Q55fjk12ctLFeNoz1dfI8yc6ZA
         ckjL9PB4A2lr/BfjRv0wZfp1vOcYPxysdCdV41EiHi74zeHVW3BljBekdzTn9wm9Ih
         ixNDawTeWUZMP8e51F2oqoOy6AswX7pn6GV5U7ms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 07/40] powerpc/boot: Fix random libfdt related build errors
Date:   Thu, 20 Dec 2018 10:18:19 +0100
Message-Id: <20181220085826.778033739@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 64c3f648c25d108f346fdc96c15180c6b7d250e9 ]

Once in a while I see build errors similar to the following
when building images from a clean tree.

  Building powerpc:virtex-ml507:44x/virtex5_defconfig ... failed
  ------------
  Error log:
  arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
  	libfdt.h: No such file or directory

  Building powerpc:bamboo:smpdev:44x/bamboo_defconfig ... failed
  ------------
  Error log:
  arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
  	libfdt.h: No such file or directory

  arch/powerpc/boot/treeboot-currituck.c:35:20: fatal error:
       libfdt.h: No such file or directory

Rebuilds will succeed.

Turns out that several source files in arch/powerpc/boot/ include
libfdt.h, but Makefile dependencies are incomplete. Let's fix that.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[groeck: Backport to v4.4.y]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 99e4487248ff..57003d1bd243 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -70,7 +70,8 @@ $(addprefix $(obj)/,$(zlib) cuboot-c2k.o gunzip_util.o main.o): \
 libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 libfdtheader := fdt.h libfdt.h libfdt_internal.h
 
-$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o): \
+$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o \
+	treeboot-akebono.o treeboot-currituck.o treeboot-iss4xx.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
 src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
-- 
2.19.1



