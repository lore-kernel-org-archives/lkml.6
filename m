Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15286ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C128721476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C128721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeINPqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:46:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3756 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeINPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:46:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42BX0G5z02z9ttgD;
        Fri, 14 Sep 2018 12:32:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id utc2cr_4KTjH; Fri, 14 Sep 2018 12:32:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42BX0G5Sckz9ttg2;
        Fri, 14 Sep 2018 12:32:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9D0C8B8BA;
        Fri, 14 Sep 2018 12:32:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jU7EBzOrf-oq; Fri, 14 Sep 2018 12:32:50 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 895D28B8B4;
        Fri, 14 Sep 2018 12:32:50 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 461C671925; Fri, 14 Sep 2018 10:32:50 +0000 (UTC)
Message-Id: <379467c33068e86235272401edfe60a57f2130bb.1536883882.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] serial: cpm_uart: return immediately from console poll
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>
Date:   Fri, 14 Sep 2018 10:32:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kgdb expects poll function to return immediately and
returning NO_POLL_CHAR when no character is available.

Fixes: f5316b4aea024 ("kgdb,8250,pl011: Return immediately from console poll")
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index cd3f3fc4e0a5..280acc4dfa90 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1093,8 +1093,8 @@ static int poll_wait_key(char *obuf, struct uart_cpm_port *pinfo)
 	/* Get the address of the host memory buffer.
 	 */
 	bdp = pinfo->rx_cur;
-	while (bdp->cbd_sc & BD_SC_EMPTY)
-		;
+	if (bdp->cbd_sc & BD_SC_EMPTY)
+		return NO_POLL_CHAR;
 
 	/* If the buffer address is in the CPM DPRAM, don't
 	 * convert it.
@@ -1129,7 +1129,11 @@ static int cpm_get_poll_char(struct uart_port *port)
 		poll_chars = 0;
 	}
 	if (poll_chars <= 0) {
-		poll_chars = poll_wait_key(poll_buf, pinfo);
+		int ret = poll_wait_key(poll_buf, pinfo);
+
+		if (ret == NO_POLL_CHAR)
+			return ret;
+		poll_chars = ret;
 		pollp = poll_buf;
 	}
 	poll_chars--;
-- 
2.13.3

