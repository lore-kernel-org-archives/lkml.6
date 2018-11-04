Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED0AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196D320862
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuPl8KgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196D320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeKDXIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbeKDXIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3332085A;
        Sun,  4 Nov 2018 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339577;
        bh=tEJtpAqTMjlEQ/L67FZ9RIUlP5Om9vqXkw2axuGYhyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuPl8KgNhG3siUxuZzX7a2khqAQNxkQJ7uAZCOZ/jHLtGlCz663zfTKQcNLGtrAx3
         9nQHpgZ6nKEdH+hxLTphaPz+9+S17C2zpH9O0K/9hE0cQ4xXllTzvtEvT+wOYcUQv4
         Y9dEiCqg98kD7jMH49FLAKYxSMeo5uFNyIVI+/18=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 14/45] powerpc/Makefile: Fix PPC_BOOK3S_64 ASFLAGS
Date:   Sun,  4 Nov 2018 08:52:09 -0500
Message-Id: <20181104135240.88431-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit 960e30029863db95ec79a71009272d4661db5991 ]

Ever since commit 15a3204d24a3 ("powerpc/64s: Set assembler machine type
to POWER4") we force -mpower4 to be passed to the assembler
irrespective of the CFLAGS used (for Book3s 64).

When building a powerpc64 kernel with clang, clang will not add -many
to the assembler flags, so any instructions that the compiler has
generated that are not available on power4 will cause an error:

  /usr/bin/as -a64 -mppc64 -mlittle-endian -mpower8 \
   -I ./arch/powerpc/include -I ./arch/powerpc/include/generated \
   -I ./include -I ./arch/powerpc/include/uapi \
   -I ./arch/powerpc/include/generated/uapi -I ./include/uapi \
   -I ./include/generated/uapi -I arch/powerpc -I arch/powerpc \
   -maltivec -mpower4 -o init/do_mounts.o /tmp/do_mounts-3b0a3d.s
  /tmp/do_mounts-51ce54.s:748: Error: unrecognized opcode: `isel'

GCC does include -many, so the GCC driven gas call will succeed:

  as -v -I ./arch/powerpc/include -I ./arch/powerpc/include/generated -I
  ./include -I ./arch/powerpc/include/uapi
  -I ./arch/powerpc/include/generated/uapi -I ./include/uapi
  -I ./include/generated/uapi -I arch/powerpc -I arch/powerpc
   -a64 -mpower8 -many -mlittle -maltivec -mpower4 -o init/do_mounts.o

Note that isel is power7 and above for IBM CPUs. GCC only generates it
for Power9 and above, but the above test was run against the clang
generated assembly.

Peter Bergner explains:

  When using -many -mpower4, gas will first try and find a matching
  power4 mnemonic and failing that, it will then allow any valid
  mnemonic that gas knows about. GCC's use of -many predates me
  though.

  IIRC, Alan looked at trying to remove it, but I forget why he
  didn't. Could be either a gcc or gas issue at the time. I'm not sure
  whether issue still exists or not. He and I have modified how gas
  works internally a fair amount since he tried removing gcc use of
  -many.

  I will also note that when using -many, gas will choose the first
  mnemonic that matches in the mnemonic table and we have (mostly)
  sorted the table so that server mnemonics show up earlier in the
  table than other mnemonics, so they'll be seen/chosen first.

By explicitly setting -many we can build with Clang and GCC while
retaining the -mpower4 option.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index fb96206de317..2510ff9381d0 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -244,7 +244,11 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
-cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+
+# When using '-many -mpower4' gas will first try and find a matching power4
+# mnemonic and failing that it will allow any valid mnemonic that GAS knows
+# about. GCC will pass -many to GAS when assembling, clang does not.
+cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4 -Wa,-many
 cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
2.17.1

