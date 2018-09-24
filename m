Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E208FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E5821486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E5821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbeIXSni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:43:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeIXSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:43:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF1AC109E;
        Mon, 24 Sep 2018 12:41:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 179/235] tty: fix termios input-speed encoding when using BOTHER
Date:   Mon, 24 Sep 2018 13:52:45 +0200
Message-Id: <20180924113122.583646928@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

[ Upstream commit 1cee38f0363a88db374e50b232ca17b9a4c12fa0 ]

When the termios CIBAUD bits are left unset (i.e. B0), we use the same
output and input speed and should leave CIBAUD unchanged.

When the user requests a rate using BOTHER and c_ospeed which the driver
cannot set exactly, the driver can report back the actual baud rate
using tty_termios_encode_baud_rate(). If this rate is close enough to a
standard rate however, we could end up setting CIBAUD to a Bfoo value
despite the user having left it unset.

This in turn could lead to an unexpected input rate being set on
subsequent termios updates.

Fix this by using a zero tolerance value also for the input rate when
CIBAUD is clear so that the matching logic works as expected.

Fixes: 78137e3b34e1 ("[PATCH] tty: improve encode_baud_rate logic")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_baudrate.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -157,16 +157,20 @@ void tty_termios_encode_baud_rate(struct
 	termios->c_ospeed = obaud;
 
 #ifdef BOTHER
+	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
+		ibinput = 1;	/* An input speed was specified */
+
 	/* If the user asked for a precise weird speed give a precise weird
 	   answer. If they asked for a Bfoo speed they may have problems
 	   digesting non-exact replies so fuzz a bit */
 
-	if ((termios->c_cflag & CBAUD) == BOTHER)
+	if ((termios->c_cflag & CBAUD) == BOTHER) {
 		oclose = 0;
+		if (!ibinput)
+			iclose = 0;
+	}
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) == BOTHER)
 		iclose = 0;
-	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
-		ibinput = 1;	/* An input speed was specified */
 #endif
 	termios->c_cflag &= ~CBAUD;
 


