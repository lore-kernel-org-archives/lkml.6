Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226wdrxqfKfM04OAavf7J6NtGw8A7LGANyRkfk2Q+C3JIZeTc1qV7fW6y4B18jZAZVNZqrEs
ARC-Seal: i=1; a=rsa-sha256; t=1519676959; cv=none;
        d=google.com; s=arc-20160816;
        b=DYiJCc86g+jCn1Q+h/QEl2Nanb2vVEaChVPA7XLZavB438Z6QNKrz2cqstwro3zZaj
         EWdMuB1+aICG6bwW6RNElSqhgH4dF+bUR0C3Lw8qgDXL7vF60MHRcJ+rhrVJ839SK1UY
         tiKYdTN1fXKLVlcQsCgjmjzD4Gsm+kv66/q4eDhsN1HEI1d4D56mEmZElAyj7FFSj/py
         u2mGMYos/tgzlxhedQT/QCvXT4aLTnJXuFNFCj8kU/9b+GUz3C+0FFV5p4WU0wY1nSg3
         /LGRZrOjVQkjT1RFOH3xlRTfzVLabqoG6KvEhbha4wtp7izlRDUn/J4Qism5WpLD+0+s
         BJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Snua8oiQao0wbfTOGjx5ax24nVBhe2cEU1Z4JqBbiNk=;
        b=IR73kM11IPuLcplsBB4afMgXpm0Woyikpn7X0+5YsWNEs1LMdpDPTUexbRerdwAVmt
         9TH1lPCZM3/K7WVNgAZ8xtOYRUyJSX31VDt6XFovXSiy71fW9dgxfEzJoGyhZu3wRmM3
         GYFPR+2h0n+xbGTFYW96ZVGPlVdtjYDefG8gstIx/sepUdimdvQBQcTTLDilIAy1qUf7
         PTZOoBxdTreQoFNZtc6c14up7ngcO6LJL68VFNGmoUnREmwz6OXEJ4Ktudk1REMzf3QB
         JP2QO7fLb0gfsqLzUuRBPxJ3uWKUln9SI/HLQ7wEMKVFshAX5fJxnhspaXcAUJOYvmbg
         6fxA==
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
Subject: [PATCH 4.15 38/64] usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()
Date: Mon, 26 Feb 2018 21:22:15 +0100
Message-Id: <20180226202155.079238024@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495994383041854?=
X-GMAIL-MSGID: =?utf-8?q?1593496787933214790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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

diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
index b2ec8c399363..4ccb85a67bb3 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -1019,6 +1019,8 @@ static void finish_unlinks(struct ohci_hcd *ohci)
 		 * have modified this list.  normally it's just prepending
 		 * entries (which we'd ignore), but paranoia won't hurt.
 		 */
+		*last = ed->ed_next;
+		ed->ed_next = NULL;
 		modified = 0;
 
 		/* unlink urbs as requested, but rescan the list after
@@ -1077,21 +1079,22 @@ static void finish_unlinks(struct ohci_hcd *ohci)
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
