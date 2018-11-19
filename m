Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFAB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfUazUBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFAB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeKTCzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbeKTCzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94B720870;
        Mon, 19 Nov 2018 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645070;
        bh=UvO7wWR+PxZ2jgc1Co//ZpdECtmuq/bcH0QEIIu6Huw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfUazUBWmkL34TUk5hsZS4kEFbR2Q3CSyjVIqk5g6Dq/Z3J+OIr6gdVASw7oPNhb7
         sL44z7bdM4N9wbOq0y1xZZfv9Q22TnDffcJCMTwR3KOKQhapQrkMULUwt4vvhKZMQB
         YuNiskZDwyuzv+KnifCLbIjKxR/NLnafqWjry7xE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/205] powerpc/Makefile: Fix PPC_BOOK3S_64 ASFLAGS
Date:   Mon, 19 Nov 2018 17:25:14 +0100
Message-Id: <20181119162618.354142843@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -238,7 +238,11 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
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


