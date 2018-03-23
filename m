Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802195-2-7424566202695650631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802195; b=gIXEtvgW1ES6Bm2wYPrkn9RqygKbQ9eUFdnDikazvqZDF6e
    1QHWhVPT3zvvh8D4kchGtBmNC7wfK0pB2k3zb3X+B1GgjZiv4lU88Kind0+cRrEa
    Ai2zVwb66dnigrorkkWt06SCltChGVMfrFYkz8hvO/Fk9va2s6po0ht+16iFjNFX
    DpCwTdNQy/3zpoApkN7dWShTA5rC5cNUyVlkKF7C25XyXzyh4wkxeMCu5eLI3PyG
    bHQEVxjy3tkcCwd6sYBTlCpx+1REnZ4x4Udia/S+4/Udy9JHvR1QwWmw+m/HPhwh
    krRlX9+T4CQw0CauNcM5enrdrg18BtIbUwGBH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802195; bh=ouMnyY8R/R/fjhXL9qWFkyToPs
    N9RePpfoOeguZ0VUw=; b=CcTEcCjsNbW6qFYt+u3K9kKIgJHzzEH/X6XwScSQi/
    uQk5jHrvsT+hKYOspKeUUcKuNoJiIg7djx4miD4ZK6E+QVgmG73dACkrlZzc7nBq
    WEyLVd/2KjaU0HiHcm6yQR8fQH74evrRXq5y0oCffoWzP6iWMG0WmSeXibcp285N
    MalA1bZgEoZxFTVjgKE8W4faYGLfNhizRNOYJr1CTXpZEShBz7eKByHQOW+zmTHS
    PUcBMufCrPhtvwgXoUXdAnHCe1IPQcM4aiKa2hW0y0vzMivCRsjb9O0mNWV5MulC
    cDULDp2wjPyQc2V0RFRtyPLbMEd2z2UjqkVKmSgmrWSg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933363AbeCWKOo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933345AbeCWKOn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 43/97] scsi: mac_esp: Replace bogus memory barrier with spinlock
Date: Fri, 23 Mar 2018 10:54:30 +0100
Message-Id: <20180323094200.059244813@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>


[ Upstream commit 4da2b1eb230ba4ad19b58984dc52e05b1073df5f ]

Commit da244654c66e ("[SCSI] mac_esp: fix for quadras with two esp
chips") added mac_scsi_esp_intr() to handle the IRQ lines from a pair of
on-board ESP chips (a normal shared IRQ did not work).

Proper mutual exclusion was missing from that patch. This patch fixes
race conditions between comparison and assignment of esp_chips[]
pointers.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mac_esp.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -55,6 +55,7 @@ struct mac_esp_priv {
 	int error;
 };
 static struct esp *esp_chips[2];
+static DEFINE_SPINLOCK(esp_chips_lock);
 
 #define MAC_ESP_GET_PRIV(esp) ((struct mac_esp_priv *) \
 			       platform_get_drvdata((struct platform_device *) \
@@ -562,15 +563,18 @@ static int esp_mac_probe(struct platform
 	}
 
 	host->irq = IRQ_MAC_SCSI;
-	esp_chips[dev->id] = esp;
-	mb();
-	if (esp_chips[!dev->id] == NULL) {
-		err = request_irq(host->irq, mac_scsi_esp_intr, 0, "ESP", NULL);
-		if (err < 0) {
-			esp_chips[dev->id] = NULL;
-			goto fail_free_priv;
-		}
+
+	/* The request_irq() call is intended to succeed for the first device
+	 * and fail for the second device.
+	 */
+	err = request_irq(host->irq, mac_scsi_esp_intr, 0, "ESP", NULL);
+	spin_lock(&esp_chips_lock);
+	if (err < 0 && esp_chips[!dev->id] == NULL) {
+		spin_unlock(&esp_chips_lock);
+		goto fail_free_priv;
 	}
+	esp_chips[dev->id] = esp;
+	spin_unlock(&esp_chips_lock);
 
 	err = scsi_esp_register(esp, &dev->dev);
 	if (err)
@@ -579,8 +583,13 @@ static int esp_mac_probe(struct platform
 	return 0;
 
 fail_free_irq:
-	if (esp_chips[!dev->id] == NULL)
+	spin_lock(&esp_chips_lock);
+	esp_chips[dev->id] = NULL;
+	if (esp_chips[!dev->id] == NULL) {
+		spin_unlock(&esp_chips_lock);
 		free_irq(host->irq, esp);
+	} else
+		spin_unlock(&esp_chips_lock);
 fail_free_priv:
 	kfree(mep);
 fail_free_command_block:
@@ -599,9 +608,13 @@ static int esp_mac_remove(struct platfor
 
 	scsi_esp_unregister(esp);
 
+	spin_lock(&esp_chips_lock);
 	esp_chips[dev->id] = NULL;
-	if (!(esp_chips[0] || esp_chips[1]))
+	if (esp_chips[!dev->id] == NULL) {
+		spin_unlock(&esp_chips_lock);
 		free_irq(irq, NULL);
+	} else
+		spin_unlock(&esp_chips_lock);
 
 	kfree(mep);
 
