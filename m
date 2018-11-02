Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C6EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DA420847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2OX/aNFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DA420847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbeKCDya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:29 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4D020837;
        Fri,  2 Nov 2018 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184376;
        bh=3gQUE4GedYVbMOH4HqQ4ExhtCew3xFxG4zF9Zkf9DE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2OX/aNFGVMIZ2p3EmXpWwT5s0Jjw7xuugcJHmgartG1oCYr78N9KlfMZ+huSokqWV
         csByFT0mqiJKFL7f1y732INeGZjVun8Uk3QSoRv5GluqR91vlRiJBmtrVBZkAyVInG
         SHowEeTMSSriCAyh9jIreKjXEHwmW9MYHSHBCQMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 148/150] sparc: Fix syscall fallback bugs in VDSO.
Date:   Fri,  2 Nov 2018 19:35:10 +0100
Message-Id: <20181102182912.678968396@linuxfoundation.org>
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

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 776ca1543b5fe673aaf1beb244fcc2429d378083 ]

First, the trap number for 32-bit syscalls is 0x10.

Also, only negate the return value when syscall error is indicated by
the carry bit being set.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/vdso/vclock_gettime.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -33,9 +33,19 @@
 #define	TICK_PRIV_BIT	(1ULL << 63)
 #endif
 
+#ifdef	CONFIG_SPARC64
 #define SYSCALL_STRING							\
 	"ta	0x6d;"							\
-	"sub	%%g0, %%o0, %%o0;"					\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#else
+#define SYSCALL_STRING							\
+	"ta	0x10;"							\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#endif
 
 #define SYSCALL_CLOBBERS						\
 	"f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",			\


