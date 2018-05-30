Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeE3LHh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:07:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60703 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752062AbeE3LG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:58 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "James Holderness" <j4_james@hotmail.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.502313133@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 144/153] tty: vt: fix up tabstops properly
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -1676,7 +1676,7 @@ static void reset_terminal(struct vc_dat
 	default_attr(vc);
 	update_attr(vc);
 
-	vc->vc_tab_stop[0]	= 0x01010100;
+	vc->vc_tab_stop[0]	=
 	vc->vc_tab_stop[1]	=
 	vc->vc_tab_stop[2]	=
 	vc->vc_tab_stop[3]	=
@@ -1715,7 +1715,7 @@ static void do_con_trol(struct tty_struc
 		vc->vc_pos -= (vc->vc_x << 1);
 		while (vc->vc_x < vc->vc_cols - 1) {
 			vc->vc_x++;
-			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
+			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
 				break;
 		}
 		vc->vc_pos += (vc->vc_x << 1);
@@ -1775,7 +1775,7 @@ static void do_con_trol(struct tty_struc
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[vc->vc_x >> 5] |= (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |= (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -1968,7 +1968,7 @@ static void do_con_trol(struct tty_struc
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[vc->vc_x >> 5] &= ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &= ~(1 << (vc->vc_x & 31));
 			else if (vc->vc_par[0] == 3) {
 				vc->vc_tab_stop[0] =
 					vc->vc_tab_stop[1] =
