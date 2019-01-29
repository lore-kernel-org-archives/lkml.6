Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DFBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A922082E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfA3ASE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:18:04 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.164]:39666 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727148AbfA3ASE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:18:04 -0500
X-Greylist: delayed 1226 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 19:18:03 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 3738BC315F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:57:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id odG5gFnS62qH7odG5gqayy; Tue, 29 Jan 2019 17:57:37 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=55932 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <garsilva@embeddedor.com>)
        id 1godFU-003MH7-EL; Tue, 29 Jan 2019 17:57:36 -0600
Date:   Tue, 29 Jan 2019 17:56:59 -0600
From:   "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190129235659.GA8556@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1godFU-003MH7-EL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:55932
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough by default, mark
switch-case statements where fall-through is intentional, explicitly in
order to fix a bunch of -Wimplicit-fallthrough warnings.

Warning level 3 was used: -Wimplicit-fallthrough=3.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 arch/x86/include/asm/syscall.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index d653139857af..04fc5c120558 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -125,23 +125,30 @@ static inline void syscall_get_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			*args++ = regs->bx;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			*args++ = regs->cx;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			*args++ = regs->dx;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			*args++ = regs->si;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			*args++ = regs->di;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			*args++ = regs->bp;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
@@ -152,23 +159,30 @@ static inline void syscall_get_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			*args++ = regs->di;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			*args++ = regs->si;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			*args++ = regs->dx;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			*args++ = regs->r10;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			*args++ = regs->r8;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			*args++ = regs->r9;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
@@ -186,23 +200,30 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			regs->bx = *args++;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			regs->cx = *args++;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			regs->dx = *args++;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			regs->si = *args++;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			regs->di = *args++;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			regs->bp = *args++;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
@@ -213,23 +234,30 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			regs->di = *args++;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			regs->si = *args++;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			regs->dx = *args++;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			regs->r10 = *args++;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			regs->r8 = *args++;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			regs->r9 = *args++;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
-- 
2.20.1

