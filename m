Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B0CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FA5224E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTtesWSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FA5224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbeKLIVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389761AbeKLIVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:37 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05431224B3;
        Sun, 11 Nov 2018 22:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975500;
        bh=1ICxfcL/TFd/yyMU1GG4B99XEkJVRPOTwet093rOpZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTtesWSw6TqaN1U4ztuSkoCc5cWjGra7l4gafarnADjlxC4bj9HJj0Zku1ztapkOv
         a+O+rJs2Q8680PpITILAWC+QZMfoo6OHyNSMeB/d/wmpx5HDmwf+mw40ZAOQkJdHVg
         yEgiQWvWQ20fQGCpnIa5Ao92V/DZ+6NJOcOVFQao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will.deacon@arm.com>, Tri Vo <trong@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.18 307/350] arm64: lse: remove -fcall-used-x0 flag
Date:   Sun, 11 Nov 2018 14:22:51 -0800
Message-Id: <20181111221720.920755607@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Tri Vo <trong@android.com>

commit 2a6c7c367de82951c98a290a21156770f6f82c84 upstream.

x0 is not callee-saved in the PCS. So there is no need to specify
-fcall-used-x0.

Clang doesn't currently support -fcall-used flags. This patch will help
building the kernel with clang.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Tri Vo <trong@android.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/lib/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -12,7 +12,7 @@ lib-y		:= bitops.o clear_user.o delay.o
 # when supported by the CPU. Result and argument registers are handled
 # correctly, based on the function prototype.
 lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
-CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
+CFLAGS_atomic_ll_sc.o	:= -ffixed-x1 -ffixed-x2        		\
 		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
 		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\


