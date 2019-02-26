Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08721C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAB821850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfBZTQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:16:17 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.61]:45924 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfBZTQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:16:16 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id C7A811D8A4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 13:16:15 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yiD9gV2XF90onyiD9gpmBc; Tue, 26 Feb 2019 13:16:15 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=33964 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gyiD8-003vjy-MQ; Tue, 26 Feb 2019 13:16:14 -0600
Date:   Tue, 26 Feb 2019 13:16:14 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] gdbstub: mark expected switch fall-throughs
Message-ID: <20190226191614.GA21908@embeddedor>
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
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gyiD8-003vjy-MQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:33964
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

kernel/debug/gdbstub.c: In function ‘gdb_serial_stub’:
kernel/debug/gdbstub.c:1031:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (remcom_in_buffer[1] == '\0') {
       ^
kernel/debug/gdbstub.c:1036:3: note: here
   case 'C': /* Exception passing */
   ^~~~
kernel/debug/gdbstub.c:1040:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (tmp == 0)
       ^
kernel/debug/gdbstub.c:1043:3: note: here
   case 'c': /* Continue packet */
   ^~~~
kernel/debug/gdbstub.c:1050:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    dbg_activate_sw_breakpoints();
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/debug/gdbstub.c:1052:3: note: here
   default:
   ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/debug/gdbstub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 7510dc687c0d..9f267b8905b4 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -1033,13 +1033,14 @@ int gdb_serial_stub(struct kgdb_state *ks)
 				return DBG_PASS_EVENT;
 			}
 #endif
+			/* Fall through */
 		case 'C': /* Exception passing */
 			tmp = gdb_cmd_exception_pass(ks);
 			if (tmp > 0)
 				goto default_handle;
 			if (tmp == 0)
 				break;
-			/* Fall through on tmp < 0 */
+			/* Fall through - on tmp < 0 */
 		case 'c': /* Continue packet */
 		case 's': /* Single step packet */
 			if (kgdb_contthread && kgdb_contthread != current) {
@@ -1048,7 +1049,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
 				break;
 			}
 			dbg_activate_sw_breakpoints();
-			/* Fall through to default processing */
+			/* Fall through - to default processing */
 		default:
 default_handle:
 			error = kgdb_arch_handle_exception(ks->ex_vector,
-- 
2.21.0

