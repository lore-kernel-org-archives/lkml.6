Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225RQs6CxJVKXUV3euK2PJqcXklXfOLQ0GOPVO9ywgUPQ/Z2P+Gi9uS7UokXCvwTqXZhSoIg
ARC-Seal: i=1; a=rsa-sha256; t=1518708028; cv=none;
        d=google.com; s=arc-20160816;
        b=gXxy+6WaOzvP/Q6eXqrG+3u521X3WgPYfvTOa0wV2DUCIA/nyJARrvlZgEwT4KfamJ
         jR36O2ENo7EpYZU5hn7mtVukcMRi6xyr5z6xVzbrs8T+HefQlQY6UND7FKA9NpPv9YjP
         FYcwNc85WL6U6FPt0Ni6y1mDGEyvhlfScGRJtTF4tJvc/M6q01lDwGlRyG2wccPo5lBd
         uQmEx3OwahEjZ5T5qP2N8j/wYxm3uRpfdVXFi4UBNCMvSt9qeGfS0X/IYwfbG5oUxfdI
         0gf/IlTs7VLRXTIjsKxg3nh+s+dR0PGEEcS7vXKq6n1RoNDX1udhzQABwCZ/HPDvsotX
         OEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XSpM+paUvjnjp4eTiBHqIgT5249eFsrIhyalsJnHV68=;
        b=af55pJ1hpDTffAiHluZP5hThXGzAn2C9H3Oe2zKoTyQ2pXxyQSqgpQkt4FG1dUD38h
         NXB1JeKgM67VYhbt0/70i3gzKwhGsY9XNy81CG5WT/QuRR8B7Lw7QEVvJgkvMAq1UYoS
         SSaExdcrW506NhR52Uv7VFcqjrcl4CGVgLGTXX5Kn8CXgvbd4iZEBErHBz50NkeFtI8Y
         pbUfjidHuOu3YBFsCV8f+Ss5aeuA2Q/3t2GKQL5EBsldqiq1gOq+zL4Y6krOEEathpaj
         /e4wCcWNa39x6NQpVPcPpAHbNGLNaiL9k/tc3YFt5fAhW0Ps5pUFljJntWwMCaBU5Pfb
         maCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Secunia Research <vuln@secunia.com>,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 17/45] usbip: prevent vhci_hcd driver from leaking a socket pointer address
Date: Thu, 15 Feb 2018 16:17:08 +0100
Message-Id: <20180215144119.482963599@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480789297541099?=
X-GMAIL-MSGID: =?utf-8?q?1592480789297541099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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


---
 drivers/usb/usbip/usbip_common.h     |    1 +
 drivers/usb/usbip/vhci_sysfs.c       |   26 +++++++++++++++-----------
 tools/usb/usbip/libsrc/vhci_driver.c |    8 ++++----
 3 files changed, 20 insertions(+), 15 deletions(-)

--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -261,6 +261,7 @@ struct usbip_device {
 	/* lock for status */
 	spinlock_t lock;
 
+	int sockfd;
 	struct socket *tcp_socket;
 
 	struct task_struct *tcp_rx;
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -39,16 +39,20 @@ static ssize_t status_show(struct device
 
 	/*
 	 * output example:
-	 * prt sta spd dev socket           local_busid
-	 * 000 004 000 000         c5a7bb80 1-2.3
-	 * 001 004 000 000         d8cee980 2-3.4
+	 * prt  sta spd dev      sockfd local_busid
+	 * 0000 004 000 00000000 000003 1-2.3
+	 * 0001 004 000 00000000 000004 2-3.4
 	 *
-	 * IP address can be retrieved from a socket pointer address by looking
-	 * up /proc/net/{tcp,tcp6}. Also, a userland program may remember a
-	 * port number and its peer IP address.
+	 * Output includes socket fd instead of socket pointer address to
+	 * avoid leaking kernel memory address in:
+	 *	/sys/devices/platform/vhci_hcd.0/status and in debug output.
+	 * The socket pointer address is not used at the moment and it was
+	 * made visible as a convenient way to find IP address from socket
+	 * pointer address by looking up /proc/net/{tcp,tcp6}. As this opens
+	 * a security hole, the change is made to use sockfd instead.
 	 */
 	out += sprintf(out,
-		       "prt sta spd bus dev socket           local_busid\n");
+		       "prt sta spd dev      sockfd local_busid\n");
 
 	for (i = 0; i < VHCI_NPORTS; i++) {
 		struct vhci_device *vdev = port_to_vdev(i);
@@ -59,12 +63,11 @@ static ssize_t status_show(struct device
 		if (vdev->ud.status == VDEV_ST_USED) {
 			out += sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
+			out += sprintf(out, "%06u ", vdev->ud.sockfd);
 			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));
 
-		} else {
-			out += sprintf(out, "000 000 000 0000000000000000 0-0");
-		}
+		} else
+			out += sprintf(out, "000 00000000 000000 0-0");
 
 		out += sprintf(out, "\n");
 		spin_unlock(&vdev->ud.lock);
@@ -223,6 +226,7 @@ static ssize_t store_attach(struct devic
 
 	vdev->devid         = devid;
 	vdev->speed         = speed;
+	vdev->ud.sockfd     = sockfd;
 	vdev->ud.tcp_socket = socket;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
 
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
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
