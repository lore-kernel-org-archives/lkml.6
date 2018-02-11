Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224NhEjQbHJ6FXNEWJFAeUqnQ6OOjYZlaaiaa7xSpm6iJyD9WgLmkdegACypKWNyUQG7ld6I
ARC-Seal: i=1; a=rsa-sha256; t=1518323640; cv=none;
        d=google.com; s=arc-20160816;
        b=G2YUV92otWnZbgXlGuXF5MY8gtMKQ1l/Vihct05b2MLOtqWeVpQ4fJ7WO569XFyZ23
         NCRf22foBmr0uV44GF7XPOQqfWp7myqRHUHfvYDn0kn4YIsXQKpzSq27/ebEISL6zlGk
         qW35PlqRm3SBhB/JwKBpPmCf5Wk7MERQVzwUc6JVY8yYtJJ6nJyETmV0wOcZC9hpaisW
         AWDbClqk5203YQrLev5CDtwRR2yu4SHmYzc+Pxtw4WBjnGGy9fMa+rRNTuV//w6HnVwg
         Y1B2ji80D97Ycr0OqAiJytx7htaTMB1ipHyC1rLUku0n1kk6CO/Mr1BA3cB8pRfYcHlM
         Z0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=FaHfQdLBdsEvRQWYUHYtsPs8f2WO9RKoMZsOEWHUjcs=;
        b=Roz5joA1wEBRvMrkdR/D0BljDy9KaDVYBRrMUFADp3NRK24FJWKdg0KvtDGVaQFLhW
         4vtfj01cE3GT3DlZZvsSQCpSzUHoUUYKyX+NkfnazK+43ch3w2WEU+sbuCP1lXYddyOK
         SjuI3wcdqkyTyy7QU1spc1BGmE3EW+mxIuZ1aqqwNVIHOAZ7rGp8MFgVCAbHF3Ycm/Nn
         hOKFXAHWP+T7IVlASbpECtblMuGCZx3Jetl54qaohdD0Z7NU8r6sv75f8XMbAphdNqBR
         ERuWUXR6UxNfOdYgqJ4DzrhReB1imweEAfWC2WMlo53q+jKjzUE3h0Erheqtp7dfAv4h
         sVog==
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
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Secunia Research" <vuln@secunia.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.311662782@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 125/136] usbip: prevent vhci_hcd driver from leaking
 a socket pointer address
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077713034495995?=
X-GMAIL-MSGID: =?utf-8?q?1592077729143982692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 2f2d0088eb93db5c649d2a5e34a3800a8a935fc5 upstream.

When a client has a USB device attached over IP, the vhci_hcd driver is
locally leaking a socket pointer address via the

/sys/devices/platform/vhci_hcd/status file (world-readable) and in debug
output when "usbip --debug port" is run.

Fix it to not leak. The socket pointer address is not used at the moment
and it was made visible as a convenient way to find IP address from socket
pointer address by looking up /proc/net/{tcp,tcp6}.

As this opens a security hole, the fix replaces socket pointer address with
sockfd.

Reported-by: Secunia Research <vuln@secunia.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - usbip port status does not include hub type
 - Adjust filenames, context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/usbip_common.h                 |  1 +
 drivers/staging/usbip/vhci_sysfs.c                   | 25 ++++++++++++++++---------
 drivers/staging/usbip/userspace/libsrc/vhci_driver.c |  8 ++++----
 3 files changed, 21 insertions(+), 13 deletions(-)

--- a/drivers/staging/usbip/usbip_common.h
+++ b/drivers/staging/usbip/usbip_common.h
@@ -261,6 +261,7 @@ struct usbip_device {
 	/* lock for status */
 	spinlock_t lock;
 
+	int sockfd;
 	struct socket *tcp_socket;
 
 	struct task_struct *tcp_rx;
--- a/drivers/staging/usbip/vhci_sysfs.c
+++ b/drivers/staging/usbip/vhci_sysfs.c
@@ -39,13 +39,18 @@ static ssize_t status_show(struct device
 
 	/*
 	 * output example:
-	 * prt sta spd dev socket           local_busid
-	 * 000 004 000 000         c5a7bb80 1-2.3
-	 * 001 004 000 000         d8cee980 2-3.4
+	 * prt sta spd dev sockfd    local_busid
+	 * 000 004 000 000 3         1-2.3
+	 * 001 004 000 000 4         2-3.4
+	 *
+	 * Output includes socket fd instead of socket pointer address to avoid
+	 * leaking kernel memory address in:
+	 *	/sys/devices/platform/vhci_hcd.0/status and in debug output.
+	 * The socket pointer address is not used at the moment and it was made
+	 * visible as a convenient way to find IP address from socket pointer
+	 * address by looking up /proc/net/{tcp,tcp6}. As this opens a security
+	 * hole, the change is made to use sockfd instead.
 	 *
-	 * IP address can be retrieved from a socket pointer address by looking
-	 * up /proc/net/{tcp,tcp6}. Also, a userland program may remember a
-	 * port number and its peer IP address.
 	 */
 	out += sprintf(out,
 		       "prt sta spd bus dev socket           local_busid\n");
@@ -59,7 +64,7 @@ static ssize_t status_show(struct device
 		if (vdev->ud.status == VDEV_ST_USED) {
 			out += sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
+			out += sprintf(out, "%u", vdev->ud.sockfd);
 			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));
 
 		} else {
@@ -223,6 +228,7 @@ static ssize_t store_attach(struct devic
 
 	vdev->devid         = devid;
 	vdev->speed         = speed;
+	vdev->ud.sockfd     = sockfd;
 	vdev->ud.tcp_socket = socket;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
 
--- a/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
+++ b/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
@@ -55,12 +55,12 @@ static int parse_status(const char *valu
 
 	while (*c != '\0') {
 		int port, status, speed, devid;
-		unsigned long socket;
+		int sockfd;
 		char lbusid[SYSFS_BUS_ID_SIZE];
 
-		ret = sscanf(c, "%d %d %d %x %lx %31s\n",
+		ret = sscanf(c, "%d %d %d %x %u %31s\n",
 				&port, &status, &speed,
-				&devid, &socket, lbusid);
+				&devid, &sockfd, lbusid);
 
 		if (ret < 5) {
 			dbg("sscanf failed: %d", ret);
@@ -69,7 +69,7 @@ static int parse_status(const char *valu
 
 		dbg("port %d status %d speed %d devid %x",
 				port, status, speed, devid);
-		dbg("socket %lx lbusid %s", socket, lbusid);
+		dbg("sockfd %u lbusid %s", sockfd, lbusid);
 
 
 		/* if a device is connected, look at it */
