Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Mnx+MlJIGVtPRwAAmS7hNA
	; Thu, 07 Jun 2018 14:59:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3680608C1; Thu,  7 Jun 2018 14:59:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DCCCC607E7;
	Thu,  7 Jun 2018 14:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCCCC607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935673AbeFGO7Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:59:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41263 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935647AbeFGO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:18 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbd-0005a0-HL; Thu, 07 Jun 2018 15:09:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00033w-Ou; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Shuah Khan" <shuahkh@osg.samsung.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.332455465@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 241/410] usbip: keep usbip_device sockfd state in
 sync with tcp_socket
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 009f41aed4b3e11e6dc1e3c07377a10c20f1a5ed upstream.

Keep usbip_device sockfd state in sync with tcp_socket. When tcp_socket
is reset to null, reset sockfd to -1 to keep it in sync.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_dev.c | 3 +++
 drivers/staging/usbip/vhci_hcd.c | 2 ++
 2 files changed, 5 insertions(+)

--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -114,6 +114,7 @@ static ssize_t store_sockfd(struct devic
 			goto err;
 
 		sdev->ud.tcp_socket = socket;
+		sdev->ud.sockfd = sockfd;
 
 		spin_unlock_irq(&sdev->ud.lock);
 
@@ -213,6 +214,7 @@ static void stub_shutdown_connection(str
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 
 	/* 3. free used data */
@@ -307,6 +309,7 @@ static struct stub_device *stub_device_a
 	sdev->ud.status		= SDEV_ST_AVAILABLE;
 	spin_lock_init(&sdev->ud.lock);
 	sdev->ud.tcp_socket	= NULL;
+	sdev->ud.sockfd		= -1;
 
 	INIT_LIST_HEAD(&sdev->priv_init);
 	INIT_LIST_HEAD(&sdev->priv_tx);
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -786,6 +786,7 @@ static void vhci_shutdown_connection(str
 	if (vdev->ud.tcp_socket) {
 		sockfd_put(vdev->ud.tcp_socket);
 		vdev->ud.tcp_socket = NULL;
+		vdev->ud.sockfd = -1;
 	}
 	pr_info("release socket\n");
 
@@ -833,6 +834,7 @@ static void vhci_device_reset(struct usb
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 	ud->status = VDEV_ST_NULL;
 
