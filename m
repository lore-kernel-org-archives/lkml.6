Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELs3f5XaQ60PzsxTx4NhYQv/VUIivwLYo7LSmJbpgI04NPyTyUEEYUV26xLQpbfme9H/yzjM
ARC-Seal: i=1; a=rsa-sha256; t=1519832882; cv=none;
        d=google.com; s=arc-20160816;
        b=V8tGOLjaf2QkY6IWcYhTxrFJpCD1bNDgqRrW2fbxbXLceaP8CgG/ub1LUh/EK6iip5
         o7ELmRN7rtDuoD3mllhFLJ5EIqCEn7oGV2zojclN9uvKxlghYW3Ecf0oRplokj2LoCLI
         4/8lWyn4CDmGJLfh3p0pEK7ygBAVT7f+GiZZxUExdpajU6RZJ5fB6/AD6/Q+lx0aplcY
         B17fr7fov0NebvnAqhWnHbzoSbvwO1ILg8KgQ3pxWNXxODCCZIt8JQWCb5h21XEk4s8/
         cuTxgqFUo/Xx9C5n8EayL/tAK9f4gexeT6evYhJOb15Kx1Zqssy2gfNj+ueNzu2eKkj2
         z9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=H7pW8UmNprvpR0H2AluQMNbTENn2Jna3SC7ssjU+Lto=;
        b=Kd6oZbGokyyZP2YPD7yjUUthUNCgATSdtxVt8A5btX0aJVuu5PCQxIunuirWa+dkvt
         ENqJJ9ZLFgFRdkEv+b3a4/XdjhyNL3hiT2ZwqoSuZaiPXjx4uDXNL2JWwlXkiDBWmnpT
         RGZX3+0sjNYlpd8kyZs70PCwqs8oD0pLbQjGTnxrW0ShoW6PcNxm8pgCPw+y7g768CI0
         bdKe/CVMM19qqsBr+kRy7tyETQl/v/+aB2HWBJXWBL6AzoCMbM7eFKXVJfdRHKT7YnTz
         ggOdnuKl80S/TMZjjJYa6NQ2qB7aHVqWK6wAzewjOl56LVTCKdVP/c7vb4dYQ6XUSpL3
         LwhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Mathias Nyman" <mathias.nyman@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.924105652@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 024/140] xhci: Don't show incorrect WARN message about
 events for empty rings
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593660283837449924?=
X-GMAIL-MSGID: =?utf-8?q?1593660283837449924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit e4ec40ec4b260efcca15089de4285a0a3411259b upstream.

xHC can generate two events for a short transfer if the short TRB and
last TRB in the TD are not the same TRB.

The driver will handle the TD after the first short event, and remove
it from its internal list. Driver then incorrectly prints a warning
for the second event:

"WARN Event TRB for slot x ep y with no TDs queued"

Fix this by not printing a warning if we get a event on a empty list
if the previous event was a short event.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci-ring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2396,12 +2396,16 @@ static int handle_tx_event(struct xhci_h
 		 */
 		if (list_empty(&ep_ring->td_list)) {
 			/*
-			 * A stopped endpoint may generate an extra completion
-			 * event if the device was suspended.  Don't print
-			 * warnings.
+			 * Don't print wanings if it's due to a stopped endpoint
+			 * generating an extra completion event if the device
+			 * was suspended. Or, a event for the last TRB of a
+			 * short TD we already got a short event for.
+			 * The short TD is already removed from the TD list.
 			 */
+
 			if (!(trb_comp_code == COMP_STOP ||
-						trb_comp_code == COMP_STOP_INVAL)) {
+			      trb_comp_code == COMP_STOP_INVAL ||
+			      ep_ring->last_td_was_short)) {
 				xhci_warn(xhci, "WARN Event TRB for slot %d ep %d with no TDs queued?\n",
 						TRB_TO_SLOT_ID(le32_to_cpu(event->flags)),
 						ep_index);
