Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A80C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA452087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlDVG/gK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA452087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJIBrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeJIBrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:47:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B7D2087D;
        Mon,  8 Oct 2018 18:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023673;
        bh=kcndAOFQp1uzuylPVkh24vusVWzAQ4R8E24MLeOrH9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlDVG/gKDabndkCTO5DfZ3qx0GBIGR2DeQmgTf3KFrMKuIjeBpl2A3Zr+jkEZQrSH
         BZ5NhRgsgdhV9xszMEoQdSNeykWbzza+D8AayOxaVoK4sWWQVEhPxD3xtFL7IuSFxy
         PCXXVARW7X7f3ns5RqKREqbkdLuj4GtQDvuMZKNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.4 044/113] serial: cpm_uart: return immediately from console poll
Date:   Mon,  8 Oct 2018 20:30:45 +0200
Message-Id: <20181008175533.058054239@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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


