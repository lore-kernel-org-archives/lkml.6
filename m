Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeE3L3F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:29:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60933 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751670AbeE3LHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:05 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jeffy Chen" <jeffy.chen@rock-chips.com>,
        "AMAN DEEP" <aman.deep@samsung.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.149836472@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 095/153] usb: ohci: Proper handling of ed_rm_list to
 handle race condition between usb_kill_urb() and finish_unlinks()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: AMAN DEEP <aman.deep@samsung.com>

commit 46408ea558df13b110e0866b99624384a33bdeba upstream.

There is a race condition between finish_unlinks->finish_urb() function
and usb_kill_urb() in ohci controller case. The finish_urb calls
spin_unlock(&ohci->lock) before usb_hcd_giveback_urb() function call,
then if during this time, usb_kill_urb is called for another endpoint,
then new ed will be added to ed_rm_list at beginning for unlink, and
ed_rm_list will point to newly added.

When finish_urb() is completed in finish_unlinks() and ed->td_list
becomes empty as in below code (in finish_unlinks() function):

        if (list_empty(&ed->td_list)) {
                *last = ed->ed_next;
                ed->ed_next = NULL;
        } else if (ohci->rh_state == OHCI_RH_RUNNING) {
                *last = ed->ed_next;
                ed->ed_next = NULL;
                ed_schedule(ohci, ed);
        }

The *last = ed->ed_next will make ed_rm_list to point to ed->ed_next
and previously added ed by usb_kill_urb will be left unreferenced by
ed_rm_list. This causes usb_kill_urb() hang forever waiting for
finish_unlink to remove added ed from ed_rm_list.

The main reason for hang in this race condtion is addition and removal
of ed from ed_rm_list in the beginning during usb_kill_urb and later
last* is modified in finish_unlinks().

As suggested by Alan Stern, the solution for proper handling of
ohci->ed_rm_list is to remove ed from the ed_rm_list before finishing
any URBs. Then at the end, we can add ed back to the list if necessary.

This properly handle the updated ohci->ed_rm_list in usb_kill_urb().

Fixes: 977dcfdc6031 ("USB: OHCI: don't lose track of EDs when a controller dies")
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Aman Deep <aman.deep@samsung.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/ohci-q.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -949,6 +949,8 @@ skip_ed:
 		 * have modified this list.  normally it's just prepending
 		 * entries (which we'd ignore), but paranoia won't hurt.
 		 */
+		*last = ed->ed_next;
+		ed->ed_next = NULL;
 		modified = 0;
 
 		/* unlink urbs as requested, but rescan the list after
@@ -1007,20 +1009,21 @@ rescan_this:
 			goto rescan_this;
 
 		/*
-		 * If no TDs are queued, take ED off the ed_rm_list.
+		 * If no TDs are queued, ED is now idle.
 		 * Otherwise, if the HC is running, reschedule.
-		 * If not, leave it on the list for further dequeues.
+		 * If the HC isn't running, add ED back to the
+		 * start of the list for later processing.
 		 */
 		if (list_empty(&ed->td_list)) {
-			*last = ed->ed_next;
-			ed->ed_next = NULL;
 			ed->state = ED_IDLE;
 		} else if (HC_IS_RUNNING(ohci_to_hcd(ohci)->state)) {
-			*last = ed->ed_next;
-			ed->ed_next = NULL;
 			ed_schedule(ohci, ed);
 		} else {
-			last = &ed->ed_next;
+			ed->ed_next = ohci->ed_rm_list;
+			ohci->ed_rm_list = ed;
+			/* Don't loop on the same ED */
+			if (last == &ohci->ed_rm_list)
+				last = &ed->ed_next;
 		}
 
 		if (modified)
