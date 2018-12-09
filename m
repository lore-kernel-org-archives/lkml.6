Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F32FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEE6208E7
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEE6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeLIWMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:12:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37764 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727647AbeLIWME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:12:04 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73R-0002ie-2W; Sun, 09 Dec 2018 21:56:01 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003FJ-Du; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Johan Hovold" <johan@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.519857667@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 040/328] tty: fix termios input-speed encoding when
 using BOTHER
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

From: Johan Hovold <johan@kernel.org>

commit 1cee38f0363a88db374e50b232ca17b9a4c12fa0 upstream.

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
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/tty_ioctl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -407,16 +407,20 @@ void tty_termios_encode_baud_rate(struct
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
 #ifdef IBSHIFT

