Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0495BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D01208E7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D01208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeJBURQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbeJBURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:15 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11C40B2F;
        Tue,  2 Oct 2018 13:33:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.14 086/137] serial: cpm_uart: return immediately from console poll
Date:   Tue,  2 Oct 2018 06:24:47 -0700
Message-Id: <20181002132504.539420549@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit be28c1e3ca29887e207f0cbcd294cefe5074bab6 upstream.

kgdb expects poll function to return immediately and
returning NO_POLL_CHAR when no character is available.

Fixes: f5316b4aea024 ("kgdb,8250,pl011: Return immediately from console poll")
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1068,8 +1068,8 @@ static int poll_wait_key(char *obuf, str
 	/* Get the address of the host memory buffer.
 	 */
 	bdp = pinfo->rx_cur;
-	while (bdp->cbd_sc & BD_SC_EMPTY)
-		;
+	if (bdp->cbd_sc & BD_SC_EMPTY)
+		return NO_POLL_CHAR;
 
 	/* If the buffer address is in the CPM DPRAM, don't
 	 * convert it.
@@ -1104,7 +1104,11 @@ static int cpm_get_poll_char(struct uart
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


