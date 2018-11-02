Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B04C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFD42084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjuFagtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFD42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbeKCDur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1B62084A;
        Fri,  2 Nov 2018 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184154;
        bh=y3wHrv4IMw0y6Oq0BPXJpNz3471o2swGlCqqM7ha41k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjuFagtuxUTz6IH/XPpnv0K98FZkNm2Fe4AP/BozrBNoZ7rWFc89AI9lBvRUNNsQ/
         JkKDNnCNRHXGu9OI6biFOrz0MIHLn4cCaodI261t8IB41X42HaUqUFbfu3TyeNOLyD
         dVMHFQRYo4m8DoC5BqzXpUBVYJQtVd0O9CCnfzAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greentime Hu <green.hu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 096/150] vmlinux.lds.h: Fix incomplete .text.exit discards
Date:   Fri,  2 Nov 2018 19:34:18 +0100
Message-Id: <20181102182910.115039624@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8dcf86caa1e3daf4a6ccf38e97f4f752b411f829 ]

Enabling CONFIG_GCOV_PROFILE_ALL=y causes linker errors on ARM:

  `.text.exit' referenced in section `.ARM.exidx.text.exit':
  defined in discarded section `.text.exit'

  `.text.exit' referenced in section `.fini_array.00100':
  defined in discarded section `.text.exit'

And related errors on NDS32:

  `.text.exit' referenced in section `.dtors.65435':
  defined in discarded section `.text.exit'

The gcov compiler flags cause certain compiler versions to generate
additional destructor-related sections that are not yet handled by the
linker script, resulting in references between discarded and
non-discarded sections.

Since destructors are not used in the Linux kernel, fix this by
discarding these additional sections.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Greentime Hu <green.hu@gmail.com>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/vmlinux.lds.h     | 2 ++
 include/asm-generic/vmlinux.lds.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index ae5fdff18406..8247bc15addc 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -49,6 +49,8 @@
 #define ARM_DISCARD							\
 		*(.ARM.exidx.exit.text)					\
 		*(.ARM.extab.exit.text)					\
+		*(.ARM.exidx.text.exit)					\
+		*(.ARM.extab.text.exit)					\
 		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))		\
 		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))		\
 		ARM_EXIT_DISCARD(EXIT_TEXT)				\
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e10f6a..a11f86014352 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -617,8 +617,8 @@
 
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
-	*(.fini_array)							\
-	*(.dtors)							\
+	*(.fini_array .fini_array.*)					\
+	*(.dtors .dtors.*)						\
 	MEM_DISCARD(exit.data*)						\
 	MEM_DISCARD(exit.rodata*)
 
-- 
2.17.1



