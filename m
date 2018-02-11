Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225N3VCnT2IsnxtEAvC1G1p7lPd0/m5+Mlo7i9mK0/bMOXtoiDL4noOdpMp+om82Cs6O8ZTo
ARC-Seal: i=1; a=rsa-sha256; t=1518323626; cv=none;
        d=google.com; s=arc-20160816;
        b=Kx0dSPOecuFHAoDeTpsuwWrQvegm/OSTjn2mRMDIopJ21aq66dmyYbbqU0wsaEHeyc
         loL3tGQ1xJXwIyNinYGRDbLHt9A7rHUrc+XKUgYNpniBEiK3NGYXmw1ciyZJbzHiP8Mf
         z/+3faD/nJfAJv11+CFqleQPrRw5BDvozep1vsnzF/xdUc7a6ivnSTAxSuHe9mBGeX7R
         3VFKpbFRQL/vVP6K9uDNUvdtp4CXXZvePAxA5nAoXOw1QZArZ5f8vJ9G8joKFb8b7K5A
         lu88zKgjzvG5r0V4q2ABUeuULkycc5iHcWKoOfrxwiwNVt0lPhO2yrghPcfUdIMBGk25
         S9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=DT6ooxkMTwKbWX/4TkBweaVGV6QdgRh1PjrMNyombc4=;
        b=YgJyOPCEFModMFfIuXk3eC/oWRTPY8LoZ0+dk+MMjnvmf7H5pxAqD+JQ8q8LqTmoX/
         Wvqrqz4NRz+zW/vh6lnSA31c8Ks0d79xcfvUtVpAReN/9KVjBxJzTack2O3H3CGBedpl
         /JODMEzmIsS2gXvmNjxigp8ouja9a4TQ1yITL0aRr6k8P+T3vaIzI/7/FLuNhsy/CUhy
         HVfXhqnLA6208+RH2PMoT4gLW9iyFTW9NKgQs+Fijwwez+1XJ1QpNyvc1d3HCht1nf4R
         Krn2DxTYe7qftMGPw5liZa6WhYNxHeIjicv4JoFnaGZuKp2zMQ114s9bcO8MsGSYVPxz
         vwfg==
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
 "Alan Stern" <stern@rowland.harvard.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Minas Harutyunyan" <Minas.Harutyunyan@synopsys.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.643433046@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 31/79] USB: usbfs: compute urb->actual_length for
 isochronous
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077714820363844?=
X-GMAIL-MSGID: =?utf-8?q?1592077714820363844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -1402,6 +1402,18 @@ static int proc_unlinkurb(struct dev_sta
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
@@ -1409,6 +1421,7 @@ static int processcompl(struct async *as
 	void __user *addr = as->userurb;
 	unsigned int i;
 
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (urb->number_of_packets > 0)		/* Isochronous */
 			i = urb->transfer_buffer_length;
@@ -1581,6 +1594,7 @@ static int processcompl_compat(struct as
 	void __user *addr = as->userurb;
 	unsigned int i;
 
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (urb->number_of_packets > 0)		/* Isochronous */
 			i = urb->transfer_buffer_length;
