Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B100DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8040520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8040520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLIVzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35278 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbeLIVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:23 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0002ir-4y; Sun, 09 Dec 2018 21:55:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72i-0003a0-9Q; Sun, 09 Dec 2018 21:55:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Jason Wessel" <jason.wessel@windriver.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Christophe Leroy" <christophe.leroy@c-s.fr>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.965559385@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 245/328] serial: cpm_uart: return immediately from
 console poll
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit be28c1e3ca29887e207f0cbcd294cefe5074bab6 upstream.

kgdb expects poll function to return immediately and
returning NO_POLL_CHAR when no character is available.

Fixes: f5316b4aea024 ("kgdb,8250,pl011: Return immediately from console poll")
Cc: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1062,8 +1062,8 @@ static int poll_wait_key(char *obuf, str
 	/* Get the address of the host memory buffer.
 	 */
 	bdp = pinfo->rx_cur;
-	while (bdp->cbd_sc & BD_SC_EMPTY)
-		;
+	if (bdp->cbd_sc & BD_SC_EMPTY)
+		return NO_POLL_CHAR;
 
 	/* If the buffer address is in the CPM DPRAM, don't
 	 * convert it.
@@ -1097,7 +1097,11 @@ static int cpm_get_poll_char(struct uart
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

