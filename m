Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72967C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B772070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfAGJ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:29:39 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:43344 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAGJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:29:39 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id MMVd1z00A3XaVaC01MVdy8; Mon, 07 Jan 2019 10:29:37 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggRE1-0003KH-7Y; Mon, 07 Jan 2019 10:29:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggRE1-0003oW-4f; Mon, 07 Jan 2019 10:29:37 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Avoid VLA use in mangle_kernel_stack()
Date:   Mon,  7 Jan 2019 10:29:35 +0100
Message-Id: <20190107092935.14617-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 7.3.0:

    arch/m68k/kernel/signal.c: In function ‘mangle_kernel_stack’:
    arch/m68k/kernel/signal.c:654:3: warning: ISO C90 forbids variable length array ‘buf’ [-Wvla]
       unsigned long buf[fsize / 2]; /* yes, twice as much */
       ^~~~~~~~

Replace the variable size by the upper limit, which is 168 bytes.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index e2a9421c57975034..87e7f3639839f559 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -651,7 +651,8 @@ static int mangle_kernel_stack(struct pt_regs *regs, int formatvec,
 		regs->vector = formatvec & 0xfff;
 	} else {
 		struct switch_stack *sw = (struct switch_stack *)regs - 1;
-		unsigned long buf[fsize / 2]; /* yes, twice as much */
+		/* yes, twice as much as max(sizeof(frame.un.fmt<x>)) */
+		unsigned long buf[sizeof(((struct frame *)0)->un) / 2];
 
 		/* that'll make sure that expansion won't crap over data */
 		if (copy_from_user(buf + fsize / 4, fp, fsize))
-- 
2.17.1

