Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC08ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6CF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUH3YcOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6CF21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeJSCFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbeJSCFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:05:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4641321476;
        Thu, 18 Oct 2018 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885787;
        bh=ecbJt/NCz6RjiJQ1dgdwMWc3fCWJ/buw75pF1YmS9Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUH3YcOhL6KnmSiLGKeQoCIOjayImJX/jjEwDlTLWEkKQglyAi8AZr5QX7BP9K0dJ
         pSd/GcSbuvmyqj7Kic98Z9eqgCXaTeLh6K8Aqgqo74SOhvbphwSg2BatLbV5MYItsi
         sqMJEJzUaokW9U47DWAtYSsH48khbkv2mfpHpVfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Merker <merker@debian.org>,
        James Cowgill <jcowgill@debian.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 19/35] RISC-V: include linux/ftrace.h in asm-prototypes.h
Date:   Thu, 18 Oct 2018 19:54:48 +0200
Message-Id: <20181018175425.541240594@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
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

From: James Cowgill <jcowgill@debian.org>

[ Upstream commit 57a489786de9ec37d6e25ef1305dc337047f0236 ]

Building a riscv kernel with CONFIG_FUNCTION_TRACER and
CONFIG_MODVERSIONS enabled results in these two warnings:

  MODPOST vmlinux.o
WARNING: EXPORT symbol "return_to_handler" [vmlinux] version generation failed, symbol will not be versioned.
WARNING: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.

When exporting symbols from an assembly file, the MODVERSIONS code
requires their prototypes to be defined in asm-prototypes.h (see
scripts/Makefile.build). Since both of these symbols have prototypes
defined in linux/ftrace.h, include this header from RISC-V's
asm-prototypes.h.

Reported-by: Karsten Merker <merker@debian.org>
Signed-off-by: James Cowgill <jcowgill@debian.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/asm-prototypes.h |    7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/riscv/include/asm/asm-prototypes.h

--- /dev/null
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_PROTOTYPES_H
+
+#include <linux/ftrace.h>
+#include <asm-generic/asm-prototypes.h>
+
+#endif /* _ASM_RISCV_PROTOTYPES_H */


