Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225x7ydbiGX+zBJ4LGYHCe4yJJ7M4rcqsSnrNTKBili9ievSFeOzU3hprt86MWhzm4TXMXyq
ARC-Seal: i=1; a=rsa-sha256; t=1519676485; cv=none;
        d=google.com; s=arc-20160816;
        b=mCAZVN9T17739UvD+td6coQ9Sdz3UxB29rFCGmWnb2NkoDpJRNFCG22xVSe7o9rmHO
         0HPtSeXCGkoSQunAOjI3tfJwL3ZyDC7BcxlwtIV6Zhg9kHFa9td20RiQ4iV76ooxoOF1
         F2qvTB+t1PBPqHwuhwz0tZEcDIJY4iW58luDv+89YMCqVS8FCyyia3OAfZ7Vaf9u1ooy
         ywiXTSL+qQreH2Sd1KHJ03swRA1LFoXY2foufxZa180121VYCL0PSF48flwFoV4ucuA/
         lprKmydv7Bp45G5GbC32JASVhuxug3aMaIx9h9q42J2LwRQ16PcV5aF3KpnqD9XzKGlA
         Ezag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=if9oOJ6fXovO1Tm8YiXbFAI0SQs3x9VXGdCe6S5r86Q=;
        b=BDNK37Bgf6GzrYJzBMOtIGV44J0GR7q5nS/EdTpesqPHbDK/smqGpnz1+XwXwyZWJV
         iTolfub0/xE9/xrSZhysp0wYpXnn3Vbcy2kg8tAGsYU8DyT3J0FoBzoAf1f33qXRRll3
         lYyajjT4ncWVm1y8a1rOw8cfsTmdPNIrsjBZG6uNjBmcXwcjHaklfIBd2iMeY8IAanqa
         KlCVU/i/t26l3Z5bgdqOwiP6jYW1ZPmGfx/3aYTJNMXfFX0Kcet4OuHwuwIyE2vttsXC
         +HCXzmR/71pDkLE1PSAprQxuPUSy6vnjIztE2IiRb6ONPjgQoXsyPB4I53iIDLi3GxNM
         XR9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Aman Deep <aman.deep@samsung.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 4.9 14/39] usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()
Date: Mon, 26 Feb 2018 21:20:35 +0100
Message-Id: <20180226201644.311208882@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495994383041854?=
X-GMAIL-MSGID: =?utf-8?q?1593496290916100925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
CC: <stable@vger.kernel.org>
Signed-off-by: Aman Deep <aman.deep@samsung.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ohci-q.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -1018,6 +1018,8 @@ skip_ed:
 		 * have modified this list.  normally it's just prepending
 		 * entries (which we'd ignore), but paranoia won't hurt.
 		 */
+		*last = ed->ed_next;
+		ed->ed_next = NULL;
 		modified = 0;
 
 		/* unlink urbs as requested, but rescan the list after
@@ -1076,21 +1078,22 @@ rescan_this:
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
 			list_del(&ed->in_use_list);
 		} else if (ohci->rh_state == OHCI_RH_RUNNING) {
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
