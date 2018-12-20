Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F01C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF7521852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298125;
	bh=ea7a+1jPYn3BjkFOMVRWdf30xDnhwi1ZDxJdVvqQhAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UI9/LAoGLvuqPoZ9LFcB917c0jf+a8/oZUG4WkbEcWyF6RW9Ki1coZOKkmg1PDurE
	 gqm5cBrJlUw2j6BAWQAq4B6vwumrmYDMiFoYXcggR1jjAgyCu75yzGChpaX87L8vW5
	 yDyMMl9h0wUd9B/vTQqyirUzV7kDIg2+Y9pcft1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbeLTJ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730924AbeLTJ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 483C520989;
        Thu, 20 Dec 2018 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298120;
        bh=ea7a+1jPYn3BjkFOMVRWdf30xDnhwi1ZDxJdVvqQhAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6qlQVHK0mSEwbBQtGFKHjzIhvgQNCg6BBt4XhJBbIl7asElXhGUco7m+Jhn566bL
         rLWjN0OP0j0xZSlIhYmLL7JGoQ4aTW+6PgYoQD3T/zitFKa3YlUIuci9+uWe1ySluO
         v4DuZhvftnd6dEwG9pwjHw+iUqoV3XS3MfhAGE58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Schichan <nschichan@freebox.fr>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 72/72] bpf, arm: fix emit_ldx_r and emit_mov_i using TMP_REG_1
Date:   Thu, 20 Dec 2018 10:19:11 +0100
Message-Id: <20181220085925.164928102@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

emit_ldx_r() and emit_a32_mov_i() were both using TMP_REG_1 and
clashing with each other. Using TMP_REG_2 in emit_ldx_r() fixes
the issue.

Fixes: ec19e02b343 ("ARM: net: bpf: fix LDX instructions")
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/net/bpf_jit_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index ece2d1d43724..dafeb5f81353 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -915,7 +915,7 @@ static inline void emit_str_r(const u8 dst, const u8 src, bool dstk,
 /* dst = *(size*)(src + off) */
 static inline void emit_ldx_r(const u8 dst[], const u8 src, bool dstk,
 			      s32 off, struct jit_ctx *ctx, const u8 sz){
-	const u8 *tmp = bpf2a32[TMP_REG_1];
+	const u8 *tmp = bpf2a32[TMP_REG_2];
 	const u8 *rd = dstk ? tmp : dst;
 	u8 rm = src;
 	s32 off_max;
-- 
2.19.1



