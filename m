Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7D5C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D49C217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAYUzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:55:23 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:19061 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfAYUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:55:22 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 0F7D22A4000
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:55:22 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id n8VVg2Y2790onn8VVgTQG8; Fri, 25 Jan 2019 14:55:22 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=44192 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gn8VV-002krO-9k; Fri, 25 Jan 2019 14:55:21 -0600
Date:   Fri, 25 Jan 2019 14:55:20 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/insn-eval: Mark expected switch fall-through
Message-ID: <20190125205520.GA9602@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gn8VV-002krO-9k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:44192
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

arch/x86/lib/insn-eval.c: In function ‘resolve_default_seg’:
arch/x86/lib/insn-eval.c:179:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (insn->addr_bytes == 2)
      ^
arch/x86/lib/insn-eval.c:182:2: note: here
  case -EDOM:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/lib/insn-eval.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 9119d8e41f1f..8f1b2d8db4e2 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -178,6 +178,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 		/* Need insn to verify address size. */
 		if (insn->addr_bytes == 2)
 			return -EINVAL;
+		/* fall through */
 
 	case -EDOM:
 	case offsetof(struct pt_regs, bx):
-- 
2.20.1

