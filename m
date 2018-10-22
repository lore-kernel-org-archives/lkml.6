Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA0FECDE49
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86892088F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHfzBRkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86892088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeJVSiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbeJVSiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1E720890;
        Mon, 22 Oct 2018 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203613;
        bh=NRimIiSNjP5AwnX94Z59lY2o2MkPlkwBMk2vgEdCQlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHfzBRkp2jIUEI0gsaZNbdqD5jjwOcE18OsLhQkkdXIp3c+h7wHNwytXmWWKt8QyZ
         DOx1WhWERFUiZQ5JyZvZe/KJUl4RUkPGDKl+goxq0DVho5NYxXe1KBLdTjXJMPu5Pg
         qFfD5xs1qHHHoa/g5ocTVlAFwZl+9PIzs7nQfXa4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 24/27] vmlinux.lds.h: Fix incomplete .text.exit discards
Date:   Mon, 22 Oct 2018 06:19:21 -0400
Message-Id: <20181022101924.40531-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <oberpar@linux.ibm.com>

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

