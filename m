Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415421-2-8775604711236115714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415420; b=RBT2t6UOH2XKInwv+UxxaIaEF8bqg48QoKgQsPsSURqJZ9/
    4gPsGsaPtosKiMkYfSeOC2nyZR1Y+chCbqFbjoKTmxdX51Oq/7+xwlcE7R9Lcckx
    pXWdIvtBs/Hf/9p9TbqsDHBqQzGKVrxPnolJtqsRmOSelIa14NRH3ZmN4n+YGsUn
    z29W3/IdKpTfouMmgbGekp2NBlVyt0FMXNxD3uCGPDG+JBvH0kxMQAywDOVbjbnH
    SA2JWLctToD0qygU50ljCCHhmg/DQAN3u5cGnMDMnGshtUWlxRV31eS18v72vMuf
    +AndrGOledFdfgtUwMTOuwoBYjkgu/jciOx9vkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415420; bh=UpNuIGV2mdVHYklz7xPlXVMKaW
    nBODRoTR7iq76jqKo=; b=Kt5xSrNNJMsB4j5hFmd08bTwh0nJ++OWQzPkecfra3
    eY+IKMjGs1F7yhk61B/WltokgeqnT+mg7zks0NGgGgJ9lqbgSltGhZK3dHJosMAY
    UpPtni6qR0x3WInAZsaLU4uTv7khqhVrYW7OqXXd2Q2SiTskXpbptlkYpWXmrsa8
    Rjti6PGkIY0fUl1F+w4Yht70LJLy/WPrpH/ElvGcY+XaFhK7hOWQUCDvmygLFZTm
    3VKSt/lg24/Gl+DvM0GvFusENk4Fz7Tula6eVOCf+bmiiGElQKBwLtTBIg6rKry9
    yx48pTYZE2zViWfvrxTGQ/fslBSdTLFgTyWuqhgEyufQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeBWSqO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:46:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933962AbeBWSqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 041/145] usbip: keep usbip_device sockfd state in sync with tcp_socket
Date: Fri, 23 Feb 2018 19:25:47 +0100
Message-Id: <20180223170730.211970857@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 009f41aed4b3e11e6dc1e3c07377a10c20f1a5ed upstream.

Keep usbip_device sockfd state in sync with tcp_socket. When tcp_socket
is reset to null, reset sockfd to -1 to keep it in sync.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c |    3 +++
 drivers/usb/usbip/vhci_hcd.c |    2 ++
 2 files changed, 5 insertions(+)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -87,6 +87,7 @@ static ssize_t store_sockfd(struct devic
 			goto err;
 
 		sdev->ud.tcp_socket = socket;
+		sdev->ud.sockfd = sockfd;
 
 		spin_unlock_irq(&sdev->ud.lock);
 
@@ -186,6 +187,7 @@ static void stub_shutdown_connection(str
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 
 	/* 3. free used data */
@@ -280,6 +282,7 @@ static struct stub_device *stub_device_a
 	sdev->ud.status		= SDEV_ST_AVAILABLE;
 	spin_lock_init(&sdev->ud.lock);
 	sdev->ud.tcp_socket	= NULL;
+	sdev->ud.sockfd		= -1;
 
 	INIT_LIST_HEAD(&sdev->priv_init);
 	INIT_LIST_HEAD(&sdev->priv_tx);
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -832,6 +832,7 @@ static void vhci_shutdown_connection(str
 	if (vdev->ud.tcp_socket) {
 		sockfd_put(vdev->ud.tcp_socket);
 		vdev->ud.tcp_socket = NULL;
+		vdev->ud.sockfd = -1;
 	}
 	pr_info("release socket\n");
 
@@ -879,6 +880,7 @@ static void vhci_device_reset(struct usb
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 	ud->status = VDEV_ST_NULL;
 
