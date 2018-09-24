Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40503ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F202A214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F202A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbeIXSAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:00:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbeIXSAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:00:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DEC3AD64;
        Mon, 24 Sep 2018 11:58:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 41/70] USB: serial: io_ti: fix array underflow in completion handler
Date:   Mon, 24 Sep 2018 13:52:40 +0200
Message-Id: <20180924113104.509745108@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit 691a03cfe8ca483f9c48153b869d354e4ae3abef upstream.

As reported by Dan Carpenter, a malicious USB device could set
port_number to a negative value and we would underflow the port array in
the interrupt completion handler.

As these devices only have one or two ports, fix this by making sure we
only consider the seventh bit when determining the port number (and
ignore bits 0xb0 which are typically set to 0x30).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/io_ti.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/io_ti.h
+++ b/drivers/usb/serial/io_ti.h
@@ -178,7 +178,7 @@ struct ump_interrupt {
 }  __attribute__((packed));
 
 
-#define TIUMP_GET_PORT_FROM_CODE(c)	(((c) >> 4) - 3)
+#define TIUMP_GET_PORT_FROM_CODE(c)	(((c) >> 6) & 0x01)
 #define TIUMP_GET_FUNC_FROM_CODE(c)	((c) & 0x0f)
 #define TIUMP_INTERRUPT_CODE_LSR	0x03
 #define TIUMP_INTERRUPT_CODE_MSR	0x04


