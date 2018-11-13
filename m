Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391FAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71FC223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M15aUcWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71FC223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbeKMPxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbeKMPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:43 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146542251F;
        Tue, 13 Nov 2018 05:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088336;
        bh=Xjx91Y/N9vX2IoiRxzERn0vSbClzJP6WibOoCGQdd60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M15aUcWZVK22CFHYvOWkLwcqklH6LHakMGVJKOZPi4uawGvaRsEtdAJ8akBVELF5l
         2E78RwUAvCCmf5bkkAT60u49EE5qVvNplQwcSAcaeiOtQHfYpJWV2Ygs9LFNq2Prax
         vFSqd84lToOm+UKU40KFig67dY1cSHyP4TfBLoic=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 22/26] arm64: percpu: Initialize ret in the default case
Date:   Tue, 13 Nov 2018 00:51:46 -0500
Message-Id: <20181113055150.78773-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit b5bb425871186303e6936fa2581521bdd1964a58 ]

Clang warns that if the default case is taken, ret will be
uninitialized.

./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]
        default:
        ^~~~~~~
./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
here
        return ret;
               ^~~
./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
'ret' to silence this warning
        unsigned long ret, loop;
                         ^
                          = 0

This warning appears several times while building the erofs filesystem.
While it's not strictly wrong, the BUILD_BUG will prevent this from
becoming a true problem. Initialize ret to 0 in the default case right
before the BUILD_BUG to silence all of these warnings.

Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/percpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 43393208229e..d79eaa816f29 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -93,6 +93,7 @@ static inline unsigned long __percpu_##op(void *ptr,			\
 		: [val] "Ir" (val));					\
 		break;							\
 	default:							\
+		ret = 0;						\
 		BUILD_BUG();						\
 	}								\
 									\
@@ -122,6 +123,7 @@ static inline unsigned long __percpu_read(void *ptr, int size)
 		ret = READ_ONCE(*(u64 *)ptr);
 		break;
 	default:
+		ret = 0;
 		BUILD_BUG();
 	}
 
@@ -191,6 +193,7 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 		: [val] "r" (val));
 		break;
 	default:
+		ret = 0;
 		BUILD_BUG();
 	}
 
-- 
2.17.1

