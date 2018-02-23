Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519414207-2-7114110057156061900
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
    t=1519414206; b=bxnDwJuhHLVeHYXqCp4Yhdn6a8uI1Ci7viXMuomU3owYAzu
    mhe6/hw4Z4WxuTgAB1RHTkDEddNmVkAifagAaJKLavQvoujit9aEa4RU0+KFD3/U
    VMnIJ0/YZCgiznqFurqrS9aSmTXqX/5z/pWAZ6VAWDLuBAbvoNeL7JZ52hKmf3jp
    /TZseA0iJLOedWaHtbMucHQ1HpNm7lAYY3gEFVn/o1EPJjvaY3zkSlUi2moQJ9Oz
    NWWmch7VnyG66zFfkMNhXR4bkS+hdLSmzFnclfnAPDatJ287oRPFcDMTKNoOaBps
    LaAgSDivlXj01rVwbUbYDS36vVBK5F43/RzaH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414206; bh=2xpoRsIo/KQI5Lk90iDCutMBzO
    DhNSk5Q6Q3UKokA5w=; b=unAZ5h6IvKy3lIRdBUhc4uPmYzOJnXtHzPXtWrA9cj
    gm3slx2bYI0fQUBIdm/3CzSMnX62SwHFrlAkCh132xkPaY7myRMyTUvsiAEsVTPi
    hgb+a3HJWG7+fDyAR91bTvg+MYQ6iMckPki5x+7dyPUODiG5kQ0qoy9rEZ6GGexY
    pTzkvlUWja5sTrq+KWZTXm1mJjOGkOCrK/HBMUTzGXNGylN+fr5RCsBDu1UYGbJH
    f+4d6sftT+KGASCJt3QfvIWAjV6SkTmVQtNrNc19vudtgfUhafK5SVx7CXC+opLx
    o8DqiqwGToK0+SOyBOGXHFgVJxuNzSMgGg0EMdEUW3mg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935027AbeBWSvv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934465AbeBWSvt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 058/159] usbip: keep usbip_device sockfd state in sync with tcp_socket
Date: Fri, 23 Feb 2018 19:26:06 +0100
Message-Id: <20180223170750.635565694@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -998,6 +998,7 @@ static void vhci_shutdown_connection(str
 	if (vdev->ud.tcp_socket) {
 		sockfd_put(vdev->ud.tcp_socket);
 		vdev->ud.tcp_socket = NULL;
+		vdev->ud.sockfd = -1;
 	}
 	pr_info("release socket\n");
 
@@ -1044,6 +1045,7 @@ static void vhci_device_reset(struct usb
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 	ud->status = VDEV_ST_NULL;
 
