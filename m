Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591187-2-4594413038003356701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591186; b=RBxshsgH2gD7cSQYQImlRsRj6p9qwi81t/BLqMM4m/qjPH5
    w3gWwogawMDufhSWhzhNpTWxCga5/JS1SPlFurvz7NjPulkgFNXzqlfbBZV8JqGt
    AHOZZkyX8I/De1UubjdU6dA0IThuTq9QPSlZM9P0QPKkdctjiTltyKEI7D+dC5aC
    0ok2AnjqnZAIRyN+k7QsV31o2PBwhD6fJvPTGwMBoyDCFln+48IWE22AkHug9wwS
    lmTfC2FaHTUGnXTMg5JoNcjVhW+/xPg13dJf2uYQKNuLlvjk8TqjVb1CZc4FxENd
    QNUUTMubADHZB+QTEZX7ZgmqzWijg/0srnsa/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591186; bh=c32QVSOvxW7fDK7u+z6PLTYyqC
    X65cfyhb3WG0MZvzY=; b=iJe9TDIY7RZ6xKUZoMUs5smCE2J6B8YFR7U+H/DPOD
    gbBX6i5DBdFuMLKk30E7cgfLqDRoA0kRDsdpsSvyMGWPkut96ENgsszsrWm/mi/8
    06RJwYFyxQu8IqUrLTgoG5B8A+AEpwz2o9xpxHuZbhI43FNoiwdkYDRBlo7Wcd/9
    nmvI4Zx6HJPkVLBlpdCn+s2E6z2jSnTs5d6n2NJbu3Si82rcIM7IlyIAiMnRK5Xt
    zWu3tllNF+RjuED+MyhHcidLBLlN9tepOKsupt0g5v0BitUYLlv+eD5YBFKh/A3o
    D8SYfnR0sDeqE3bSUSAYuBAQ/PHTMWZJSzCEzVn9FwsQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeBBRGY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:06:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbeBBRGV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:06:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 78/86] usbip: prevent bind loops on devices attached to vhci_hcd
Date: Fri,  2 Feb 2018 17:58:38 +0100
Message-Id: <20180202140829.853191066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
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

commit ef54cf0c600fb8f5737fb001a9e357edda1a1de8 upstream.

usbip host binds to devices attached to vhci_hcd on the same server
when user does attach over localhost or specifies the server as the
remote.

usbip attach -r localhost -b busid
or
usbip attach -r servername (or server IP)

Unbind followed by bind works, however device is left in a bad state with
accesses via the attached busid result in errors and system hangs during
shutdown.

Fix it to check and bail out if the device is already attached to vhci_hcd.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/usb/usbip/src/usbip_bind.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/tools/usb/usbip/src/usbip_bind.c
+++ b/tools/usb/usbip/src/usbip_bind.c
@@ -144,6 +144,7 @@ static int bind_device(char *busid)
 	int rc;
 	struct udev *udev;
 	struct udev_device *dev;
+	const char *devpath;
 
 	/* Check whether the device with this bus ID exists. */
 	udev = udev_new();
@@ -152,8 +153,16 @@ static int bind_device(char *busid)
 		err("device with the specified bus ID does not exist");
 		return -1;
 	}
+	devpath = udev_device_get_devpath(dev);
 	udev_unref(udev);
 
+	/* If the device is already attached to vhci_hcd - bail out */
+	if (strstr(devpath, USBIP_VHCI_DRV_NAME)) {
+		err("bind loop detected: device: %s is attached to %s\n",
+		    devpath, USBIP_VHCI_DRV_NAME);
+		return -1;
+	}
+
 	rc = unbind_other(busid);
 	if (rc == UNBIND_ST_FAILED) {
 		err("could not unbind driver from device on busid %s", busid);
