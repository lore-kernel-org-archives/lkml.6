Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1771605-1518708034-2-13000474774738410795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708034; b=HmDnwiuTAgPjzxBO3jkqsPrnLGJFu4UbDnKmcwSZdthNjeC
    lbdntJhGDT6NL/k2Fo8fqrrR2V++c5oeEDcIP5Ui5haxU6Z/ijuZXgz3saYoQV9Z
    vpXmsDCCEuZMhohrqsV7/EMZ2Vw77ZV1DQ3dDlbMwnTGr3VR52n3m7Lxrc+tjCq1
    4Vb5BYjQJsF4JAtDlZniD+0mihIcGVH9jqnoJ3sLlYIrtD/eT2uuyTy1yYHNZwz9
    J8ytfxY9JnWAxY3O/eBoCKgG3oCdY9BaGwAzHa/tGyzv0a0uOIEusRIXld/S31B1
    x2HC1TvrQPy1UmpeuHSnzsrBWpDMis9+spDL9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708034; bh=JIlB3Nmg79zaUckVekJm8ehOAf
    3yqqBwMDeNliVestY=; b=s+xPfHnIPL2/ICtMOaigTYy953b8UlwbRpdFsbzSQd
    kTYXO3eXOyo7NY7uG+/Amy77iswunrxTifcRnZg+AtCAUdFUvB79meGFuLJAC93h
    wOKp4Bz8+XN4Ki/6+Ec55YLfmoJQPetB/34IV/QhtsmQe51qP0WPIO2AKh/J39/8
    LqrKImVibKnNzLf+Z3Z2OJeY5Y5rDGUu0B0Gp9PndR0VwECDAo+m9DcCA+wGQd/C
    nonTAo80NWNwn6XlJmw1DoKbsLwEEvrTrp7MzhO1Pncz4HFZcu4IjaWHuIwcUpVG
    0QOcrzwDLPpiyq/c9+5ajxXwYvDDmdqD+N1VubO2WdrQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161624AbeBOPUb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:20:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161735AbeBOPU3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Jonathan Dieter <jdieter@lesbg.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 18/45] usbip: Fix potential format overflow in userspace tools
Date: Thu, 15 Feb 2018 16:17:09 +0100
Message-Id: <20180215144119.706452573@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Dieter <jdieter@lesbg.com>

commit e5dfa3f902b9a642ae8c6997d57d7c41e384a90b upstream.

The usbip userspace tools call sprintf()/snprintf() and don't check for
the return value which can lead the paths to overflow, truncating the
final file in the path.

More urgently, GCC 7 now warns that these aren't checked with
-Wformat-overflow, and with -Werror enabled in configure.ac, that makes
these tools unbuildable.

This patch fixes these problems by replacing sprintf() with snprintf() in
one place and adding checks for the return value of snprintf().

Reviewed-by: Peter Senna Tschudin <peter.senna@gmail.com>
Signed-off-by: Jonathan Dieter <jdieter@lesbg.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 tools/usb/usbip/libsrc/usbip_common.c      |    9 ++++++++-
 tools/usb/usbip/libsrc/usbip_host_driver.c |   27 ++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

--- a/tools/usb/usbip/libsrc/usbip_common.c
+++ b/tools/usb/usbip/libsrc/usbip_common.c
@@ -215,9 +215,16 @@ int read_usb_interface(struct usbip_usb_
 		       struct usbip_usb_interface *uinf)
 {
 	char busid[SYSFS_BUS_ID_SIZE];
+	int size;
 	struct udev_device *sif;
 
-	sprintf(busid, "%s:%d.%d", udev->busid, udev->bConfigurationValue, i);
+	size = snprintf(busid, sizeof(busid), "%s:%d.%d",
+			udev->busid, udev->bConfigurationValue, i);
+	if (size < 0 || (unsigned int)size >= sizeof(busid)) {
+		err("busid length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(busid));
+		return -1;
+	}
 
 	sif = udev_device_new_from_subsystem_sysname(udev_context, "usb", busid);
 	if (!sif) {
--- a/tools/usb/usbip/libsrc/usbip_host_driver.c
+++ b/tools/usb/usbip/libsrc/usbip_host_driver.c
@@ -39,13 +39,19 @@ struct udev *udev_context;
 static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
 {
 	char status_attr_path[SYSFS_PATH_MAX];
+	int size;
 	int fd;
 	int length;
 	char status;
 	int value = 0;
 
-	snprintf(status_attr_path, SYSFS_PATH_MAX, "%s/usbip_status",
-		 udev->path);
+	size = snprintf(status_attr_path, SYSFS_PATH_MAX, "%s/usbip_status",
+			udev->path);
+	if (size < 0 || (unsigned int)size >= sizeof(status_attr_path)) {
+		err("usbip_status path length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(status_attr_path));
+		return -1;
+	}
 
 	fd = open(status_attr_path, O_RDONLY);
 	if (fd < 0) {
@@ -225,6 +231,7 @@ int usbip_host_export_device(struct usbi
 {
 	char attr_name[] = "usbip_sockfd";
 	char sockfd_attr_path[SYSFS_PATH_MAX];
+	int size;
 	char sockfd_buff[30];
 	int ret;
 
@@ -244,10 +251,20 @@ int usbip_host_export_device(struct usbi
 	}
 
 	/* only the first interface is true */
-	snprintf(sockfd_attr_path, sizeof(sockfd_attr_path), "%s/%s",
-		 edev->udev.path, attr_name);
+	size = snprintf(sockfd_attr_path, sizeof(sockfd_attr_path), "%s/%s",
+			edev->udev.path, attr_name);
+	if (size < 0 || (unsigned int)size >= sizeof(sockfd_attr_path)) {
+		err("exported device path length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(sockfd_attr_path));
+		return -1;
+	}
 
-	snprintf(sockfd_buff, sizeof(sockfd_buff), "%d\n", sockfd);
+	size = snprintf(sockfd_buff, sizeof(sockfd_buff), "%d\n", sockfd);
+	if (size < 0 || (unsigned int)size >= sizeof(sockfd_buff)) {
+		err("socket length %i >= %lu or < 0", size,
+		    (unsigned long)sizeof(sockfd_buff));
+		return -1;
+	}
 
 	ret = write_sysfs_attribute(sockfd_attr_path, sockfd_buff,
 				    strlen(sockfd_buff));
