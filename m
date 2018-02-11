Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226ixUcIU0XqlwnqJfM9oedfLH8GwSyZKoXzHWTs45frTvZzlLUI/EVpPqnlqw/FMx48NJx/
ARC-Seal: i=1; a=rsa-sha256; t=1518323624; cv=none;
        d=google.com; s=arc-20160816;
        b=JoB7Repw/S4M4eSkQ0OSXCtbhYDWtHLXPGJLH124C4/7FWJmyiSpkKPbSTl5NXS7hf
         wxlgMSPiJ7tYdeyVh/O6bknMVjG5aX+hnnYMIrgffu/Y8L69ytdA5xqx/4shdF5FR8CL
         Elh+HODG24WOK+6Hti+QgKPyceTDapmoX14xb2bzEB9Z2C270DwougaEQ88tk9K62MCk
         PZq1alde1IixWXOJjf+xy/W7fWpHhKTSg7BwZtqiBfZBaswUGktT+MQjmRS0h3HfpGfQ
         8qLRm4pXIro6rFh3n4vzIASjST2MHQ4WfefPLGGdHUgJ063G8IlAmSr7BHI1SsyFLQRy
         an4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=BcMvjtfxidHho9ikrOlsXR4gg4QouDoo0serhxfGnhE=;
        b=lUbqzs1B079BhBNs4G0siQIfrDffhEG6ND7MffbBDPnFCWbLqrd8VNeywujrAE0Xv2
         NmoqdPwqkka9FXTqovHlqX0lBlMeIb2qLTb8gCYBE2fvgd0OGha6nDFqMlZbTiThg1/X
         nYFGU+ooW33OHq3umbEiWWJ6ZubM/GP5zBNnTyNLteJhp4USGYoXQ+W/iFv6Dzp2DpMX
         nY83Y0DtsPbJTnU+GrXtWxa7ua/Zl9WGHI2ilBZUl1lOIs65wLZjDKlehUz/0qJISqG9
         18fY++oFOkM7zbLM57hVrh3wbjZVMkFnIE+9GliNO2wZJDG8JEbz4SgTQwUP8RGh7kwt
         pQ3g==
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
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Secunia Research" <vuln@secunia.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.536756096@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 75/79] usbip: prevent vhci_hcd driver from leaking a
 socket pointer address
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077713034495995?=
X-GMAIL-MSGID: =?utf-8?q?1592077713034495995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
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
@@ -276,6 +276,7 @@ struct usbip_device {
 	/* lock for status */
 	spinlock_t lock;
 
+	int sockfd;
 	struct socket *tcp_socket;
 
 	struct task_struct *tcp_rx;
--- a/drivers/staging/usbip/vhci_sysfs.c
+++ b/drivers/staging/usbip/vhci_sysfs.c
@@ -38,13 +38,18 @@ static ssize_t show_status(struct device
 
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
 	out += sprintf(out, "prt sta spd bus dev socket           "
 		       "local_busid\n");
@@ -58,7 +63,7 @@ static ssize_t show_status(struct device
 		if (vdev->ud.status == VDEV_ST_USED) {
 			out += sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
+			out += sprintf(out, "%u", vdev->ud.sockfd);
 			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));
 
 		} else {
@@ -215,6 +220,7 @@ static ssize_t store_attach(struct devic
 
 	vdev->devid         = devid;
 	vdev->speed         = speed;
+	vdev->ud.sockfd     = sockfd;
 	vdev->ud.tcp_socket = socket;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
 
--- a/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
+++ b/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
@@ -63,12 +63,12 @@ static int parse_status(char *value)
 
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
@@ -77,7 +77,7 @@ static int parse_status(char *value)
 
 		dbg("port %d status %d speed %d devid %x",
 				port, status, speed, devid);
-		dbg("socket %lx lbusid %s", socket, lbusid);
+		dbg("sockfd %u lbusid %s", sockfd, lbusid);
 
 
 		/* if a device is connected, look at it */
