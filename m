Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226fRYSt1Ch+LRtl922LlmQxRO770941y97ZIrAgtcumvxA5JXLPoBQDcIDoJXeMhUHhTt2C
ARC-Seal: i=1; a=rsa-sha256; t=1518323639; cv=none;
        d=google.com; s=arc-20160816;
        b=AmaiWI+DaREjx03RZ9iTpQ8hGSor69eLsiQttMixmocbthH6H9ogjS5bbqbabTn507
         OYIUGABL3kpazhJirrIARg04cEE+fVkZ5j99ljEM8WYb3t3a15K01+w6U1SmCvcEhTBi
         H0WH/KILkDax/Pv0t8xWD88+RDbvt49vHd2xqI5a1NDYgwgPI3LZd2DJIYn77T6pCaD4
         O0f5NzTwzz9mPjIJ3y3F5a4irhxbT2PzlcfcTfR9Oi3udk051Hgs3kX/UMqm6HYHQpPo
         KrasRkykfJeBDdFdwfeCL1YJNlReMuXEYKCgHCUAkSOZqswMxFPdV0QgXicUa93zuIcR
         rY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ZCFIZ3KTZqzGJ25yLmWhh8IzuBexN0ABD1SiMcOoWis=;
        b=VwWIv56etvIWRXKE1vlwmfE+KoqH2oMaRXAj00JdlbvLUybFpyacGDx8hgpNnfGUq7
         JIk7TXnCRZ4LN1M3hCZ29gKYVIT8xG86Rk0buqxiVvLUIcxfzTn9/41SBxDd9GnKkSQM
         exx5Krm9fLj+k9f3kj2wIgfS7iN+g9rg+AguHKDgZl0U7RZOGO4UcfBaursZclBfesqQ
         FOAGUmAV3mCFWoJX+hYlhkbsvckEsXMSmtY+AssF5F3uCHMrQ3e1WMx3IKKsT7ClTek4
         9m4b0+wiEyUvBWfjEjYFIJPz+U5CZWC5LxjikIeVh/3JNiUE8ZXHBt62YwVPDzXxICT3
         ST6w==
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
 "Minas Harutyunyan" <Minas.Harutyunyan@synopsys.com>,
 "Alan Stern" <stern@rowland.harvard.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.51721224@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 069/136] USB: usbfs: compute urb->actual_length for
 isochronous
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077714820363844?=
X-GMAIL-MSGID: =?utf-8?q?1592077729030275340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 2ef47001b3ee3ded579b7532ebdcf8680e4d8c54 upstream.

The USB kerneldoc says that the actual_length field "is read in
non-iso completion functions", but the usbfs driver uses it for all
URB types in processcompl().  Since not all of the host controller
drivers set actual_length for isochronous URBs, programs using usbfs
with some host controllers don't work properly.  For example, Minas
reports that a USB camera controlled by libusb doesn't work properly
with a dwc2 controller.

It doesn't seem worthwhile to change the HCDs and the documentation,
since the in-kernel USB class drivers evidently don't rely on
actual_length for isochronous transfers.  The easiest solution is for
usbfs to calculate the actual_length value for itself, by adding up
the lengths of the individual packets in an isochronous transfer.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Reported-and-tested-by: wlf <wulf@rock-chips.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/devio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1650,6 +1650,18 @@ static int proc_unlinkurb(struct usb_dev
 	return 0;
 }
 
+static void compute_isochronous_actual_length(struct urb *urb)
+{
+	unsigned int i;
+
+	if (urb->number_of_packets > 0) {
+		urb->actual_length = 0;
+		for (i = 0; i < urb->number_of_packets; i++)
+			urb->actual_length +=
+					urb->iso_frame_desc[i].actual_length;
+	}
+}
+
 static int processcompl(struct async *as, void __user * __user *arg)
 {
 	struct urb *urb = as->urb;
@@ -1657,6 +1669,7 @@ static int processcompl(struct async *as
 	void __user *addr = as->userurb;
 	unsigned int i;
 
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (copy_urb_data_to_user(as->userbuffer, urb))
 			goto err_out;
@@ -1826,6 +1839,7 @@ static int processcompl_compat(struct as
 	void __user *addr = as->userurb;
 	unsigned int i;
 
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (copy_urb_data_to_user(as->userbuffer, urb))
 			return -EFAULT;
