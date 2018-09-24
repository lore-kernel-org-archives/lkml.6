Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741B6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E432145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E432145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeIXRrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:47:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51298 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbeIXRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:47:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 340C81071;
        Mon, 24 Sep 2018 11:45:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 105/105] USB: serial: ti_usb_3410_5052: fix array underflow in completion handler
Date:   Mon, 24 Sep 2018 13:34:31 +0200
Message-Id: <20180924113123.070097220@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 5dfdd24eb3d39d815bc952ae98128e967c9bba49 upstream.

Similarly to a recently reported bug in io_ti, a malicious USB device
could set port_number to a negative value and we would underflow the
port array in the interrupt completion handler.

As these devices only have one or two ports, fix this by making sure we
only consider the seventh bit when determining the port number (and
ignore bits 0xb0 which are typically set to 0x30).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/usb/serial/ti_usb_3410_5052.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/ti_usb_3410_5052.h
+++ b/drivers/usb/serial/ti_usb_3410_5052.h
@@ -223,7 +223,7 @@ struct ti_interrupt {
 } __attribute__((packed));
 
 /* Interrupt codes */
-#define TI_GET_PORT_FROM_CODE(c)	(((c) >> 4) - 3)
+#define TI_GET_PORT_FROM_CODE(c)	(((c) >> 6) & 0x01)
 #define TI_GET_FUNC_FROM_CODE(c)	((c) & 0x0f)
 #define TI_CODE_HARDWARE_ERROR		0xFF
 #define TI_CODE_DATA_ERROR		0x03


