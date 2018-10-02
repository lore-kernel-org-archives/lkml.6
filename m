Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440FCC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A0C2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A0C2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJBUKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeJBUJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:09:59 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68ADBB2F;
        Tue,  2 Oct 2018 13:26:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 020/228] USB: serial: kobil_sct: fix modem-status error handling
Date:   Tue,  2 Oct 2018 06:21:57 -0700
Message-Id: <20181002132500.431463254@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

[ Upstream commit a420b5d939ee58f1d950f0ea782834056520aeaa ]

Make sure to return -EIO in case of a short modem-status read request.

While at it, split the debug message to not include the (zeroed)
transfer-buffer content in case of errors.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/kobil_sct.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -393,12 +393,20 @@ static int kobil_tiocmget(struct tty_str
 			  transfer_buffer_length,
 			  KOBIL_TIMEOUT);
 
-	dev_dbg(&port->dev, "%s - Send get_status_line_state URB returns: %i. Statusline: %02x\n",
-		__func__, result, transfer_buffer[0]);
+	dev_dbg(&port->dev, "Send get_status_line_state URB returns: %i\n",
+			result);
+	if (result < 1) {
+		if (result >= 0)
+			result = -EIO;
+		goto out_free;
+	}
+
+	dev_dbg(&port->dev, "Statusline: %02x\n", transfer_buffer[0]);
 
 	result = 0;
 	if ((transfer_buffer[0] & SUSBCR_GSL_DSR) != 0)
 		result = TIOCM_DSR;
+out_free:
 	kfree(transfer_buffer);
 	return result;
 }


