Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E151C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5305208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glRMnOFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5305208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeGaNTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:19:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EKFNYWTAAbsEgQKEfQZQ3Mj+neeluXFNp57AUV9sKik=; b=glRMnOFRgKYDE4M+KF65W8GrL
        tJQfhLucTirqEIN3oZTGynXNetMqv394eAZquuJ9738cAhNTrEKDdipLL9GKovxWWEMim8FHKWxUN
        VVm6l7zI1wuEHra5nMGoMfde11jFHIPOSiZ9TKsaTX0RLD6gVdLCVCcXBhhSflL2/6HIiLqr9fMRf
        Nb4d7sg4/RlnDYFE1d01VbVMSBorvcSHLQ++hIp53jFkF3dKYpMo9mK51HE2Ah5T70ff2P1tkMztE
        0Ma4HZbPMqKQwFGcN+zFq6h0YUjuMeuzA3b/cXQFwyrnUhWSNkxv2AGrqhguDoHdd/PmjHVX0/M+M
        tbLkgeCGA==;
Received: from 089144201224.atnat0010.highway.a1.net ([89.144.201.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkT0J-0001LG-Cy; Tue, 31 Jul 2018 11:39:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] kconfig: remove duplicate SWAP symbol defintions
Date:   Tue, 31 Jul 2018 13:39:29 +0200
Message-Id: <20180731113935.6105-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

microblaze and nios2 define their own always n SWAP symbols.  Remove those
and let the generic defintion do the right thing by adding a new symbol
to disable swap entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/Kconfig | 4 +---
 arch/nios2/Kconfig      | 4 +---
 init/Kconfig            | 9 ++++++++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d14782100088..cc139d1b1284 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_NO_SWAP
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
@@ -52,9 +53,6 @@ config CPU_LITTLE_ENDIAN
 
 endchoice
 
-config SWAP
-	def_bool n
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..3f9d4ef8b20f 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config NIOS2
 	def_bool y
+	select ARCH_NO_SWAP
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
@@ -38,9 +39,6 @@ config HAS_DMA
 config FPU
 	def_bool n
 
-config SWAP
-	def_bool n
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
diff --git a/init/Kconfig b/init/Kconfig
index 041f3a022122..1e69f93b809e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -218,9 +218,16 @@ config DEFAULT_HOSTNAME
 	  but you may wish to use a different default here to make a minimal
 	  system more usable with less configuration.
 
+#
+# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
+# add proper SWAP support to them, in which case this can be remove.
+#
+config ARCH_NO_SWAP
+	bool
+
 config SWAP
 	bool "Support for paging of anonymous memory (swap)"
-	depends on MMU && BLOCK
+	depends on MMU && BLOCK && !ARCH_NO_SWAP
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-- 
2.18.0

