Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A64C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F8D20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="asLfp1LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfAVNzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:55:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:26006 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbfAVNy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:54:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43kVKX2LFPz9txr4;
        Tue, 22 Jan 2019 14:54:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=asLfp1LO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id S-NgA6mPdKls; Tue, 22 Jan 2019 14:54:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43kVKX1FVRz9txqy;
        Tue, 22 Jan 2019 14:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548165296; bh=qVmLAPcWj0aJo9RZPKDwGJ8WnXHlm3mfMSp+6z+2odc=;
        h=From:Subject:To:Cc:Date:From;
        b=asLfp1LO8iMgy8STPyioer3GSSKJ0Lf/5MCw9Jl4JP3l2hCSedjcdIYCrSPOYSAQ1
         i70iTR6uv7Vyh4iQisD+WfHgKhJSur9RgGjme7YhFXy/nZzl4wtAejctQTtV8n43X+
         7wxqIM9rhTd29Vv2mRkjsvX+JkoTFrMuKDyaW7dA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A81B8B7E5;
        Tue, 22 Jan 2019 14:54:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qkRma9sxqvZM; Tue, 22 Jan 2019 14:54:57 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D2CC8B7CE;
        Tue, 22 Jan 2019 14:54:57 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 38F14717D8; Tue, 22 Jan 2019 13:54:57 +0000 (UTC)
Message-Id: <3c3638c1ece313ad3fa0a850f9a98a635ebe688a.1548165236.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/selftest: fix type of mftb() in null_syscall
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Date:   Tue, 22 Jan 2019 13:54:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of mftb() expect 'unsigned long', and the function itself
only returns lower part of the TB so it really is 'unsigned long'
not 'unsigned long long'

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 tools/testing/selftests/powerpc/benchmarks/null_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/null_syscall.c b/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
index ecc14d68e101..908de689a902 100644
--- a/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
+++ b/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
@@ -25,7 +25,7 @@ unsigned long long clock_frequency;
 unsigned long long timebase_frequency;
 double timebase_multiplier;
 
-static inline unsigned long long mftb(void)
+static inline unsigned long mftb(void)
 {
 	unsigned long low;
 
-- 
2.13.3

