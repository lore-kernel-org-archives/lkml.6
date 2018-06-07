Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pQAnMDFJGVshTgAAmS7hNA
	; Thu, 07 Jun 2018 15:03:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0C29B608C1; Thu,  7 Jun 2018 15:03:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77267601C3;
	Thu,  7 Jun 2018 15:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77267601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935957AbeFGPDo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:03:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935924AbeFGPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:38 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbJ-0005a0-9I; Thu, 07 Jun 2018 15:09:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003Im-4q; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "James Holderness" <j4_james@hotmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.181972819@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 396/410] tty: vt: fix up tabstops properly
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f1869a890cdedb92a3fab969db5d0fd982850273 upstream.

Tabs on a console with long lines do not wrap properly, so correctly
account for the line length when computing the tab placement location.

Reported-by: James Holderness <j4_james@hotmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/vt/vt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1705,7 +1705,7 @@ static void reset_terminal(struct vc_dat
 	default_attr(vc);
 	update_attr(vc);
 
-	vc->vc_tab_stop[0]	= 0x01010100;
+	vc->vc_tab_stop[0]	=
 	vc->vc_tab_stop[1]	=
 	vc->vc_tab_stop[2]	=
 	vc->vc_tab_stop[3]	=
@@ -1748,7 +1748,7 @@ static void do_con_trol(struct tty_struc
 		vc->vc_pos -= (vc->vc_x << 1);
 		while (vc->vc_x < vc->vc_cols - 1) {
 			vc->vc_x++;
-			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
+			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
 				break;
 		}
 		vc->vc_pos += (vc->vc_x << 1);
@@ -1808,7 +1808,7 @@ static void do_con_trol(struct tty_struc
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[vc->vc_x >> 5] |= (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |= (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -2001,7 +2001,7 @@ static void do_con_trol(struct tty_struc
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[vc->vc_x >> 5] &= ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &= ~(1 << (vc->vc_x & 31));
 			else if (vc->vc_par[0] == 3) {
 				vc->vc_tab_stop[0] =
 					vc->vc_tab_stop[1] =
