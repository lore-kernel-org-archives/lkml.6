Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeE3L3P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:29:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60909 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750816AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Heiko Przybyl" <lil_tux@web.de>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.433483012@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 094/153] USB: OHCI: Fix race between ED unlink and URB
 submission
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 7d8021c967648accd1b78e5e1ddaad655cd2c61f upstream.

This patch fixes a bug introduced by commit 977dcfdc6031 ("USB: OHCI:
don't lose track of EDs when a controller dies").  The commit changed
ed_state from ED_UNLINK to ED_IDLE too early, before finish_urb() had
been called.  The user-visible consequence is that the driver
occasionally crashes or locks up when an URB is submitted while
another URB for the same endpoint is being unlinked.

This patch moves the ED state change later, to the right place.  The
drawback is that now we may unnecessarily execute some instructions
multiple times when a controller dies.  Since controllers dying is an
exceptional occurrence, a little wasted time won't matter.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Heiko Przybyl <lil_tux@web.de>
Tested-by: Heiko Przybyl <lil_tux@web.de>
Fixes: 977dcfdc60311e7aa571cabf6f39c36dde13339e
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/ohci-q.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -908,10 +908,6 @@ rescan_all:
 		int			completed, modified;
 		__hc32			*prev;
 
-		/* Is this ED already invisible to the hardware? */
-		if (ed->state == ED_IDLE)
-			goto ed_idle;
-
 		/* only take off EDs that the HC isn't using, accounting for
 		 * frame counter wraps and EDs with partially retired TDs
 		 */
@@ -942,14 +938,12 @@ skip_ed:
 		}
 
 		/* ED's now officially unlinked, hc doesn't see */
-		ed->state = ED_IDLE;
 		if (quirk_zfmicro(ohci) && ed->type == PIPE_INTERRUPT)
 			ohci->eds_scheduled--;
 		ed->hwHeadP &= ~cpu_to_hc32(ohci, ED_H);
 		ed->hwNextED = 0;
 		wmb();
 		ed->hwINFO &= ~cpu_to_hc32(ohci, ED_SKIP | ED_DEQUEUE);
-ed_idle:
 
 		/* reentrancy:  if we drop the schedule lock, someone might
 		 * have modified this list.  normally it's just prepending
@@ -1020,6 +1014,7 @@ rescan_this:
 		if (list_empty(&ed->td_list)) {
 			*last = ed->ed_next;
 			ed->ed_next = NULL;
+			ed->state = ED_IDLE;
 		} else if (HC_IS_RUNNING(ohci_to_hcd(ohci)->state)) {
 			*last = ed->ed_next;
 			ed->ed_next = NULL;
