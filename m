Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804457-2-7448455865584460674
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
    t=1521804456; b=Wy1DJNB41bv7SL1SQQ+Gv09JmnE8+87WN3WfIcF+2lp3uAI
    I6bTl16204k4KGqJ5Z9CJXl9oFe4sgadJ1cO4luD498sx7QJQ17zIV4LvglrH/Nm
    NQg/YcEkJryDXOujgpHsHAfI5B5rLmbzRrDKDqGHOvZNiOdhe0WQOg7JDbFrxhrx
    o5L9TMAT8h5uOpuLAiWm+n3UP7BsEtWPnl9MZYXYMqGNPfJrHgXQrvLpQwPWzgRi
    oKZ0sSB36FPcjds12xJornuMvZq71Kh97qy/wedGMhmnm+g4gA9/zANK/GGJO3jz
    8QtYQS9FegCOv3Vu+6PNwlQCdywM4qu8KwvB7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804456; bh=8/tfImPPqnb7k5Pwsu3h0oiT1W
    EkejlHWo7zpN3lkPg=; b=o3TmV7sk64AVE67DyT5js+iUE6JThs8JKELu2dMDCK
    dJLHj9mlMXeOkokTRiTxVDflBdltAawUfMgLc4Cgzt2BSz2xgw9JrlhxQWTyn0xC
    8jXp6Os00dCJdIKIGGp5Ru+zC/RVtJgXr6ErS9JdH2tNs1uLRtTsPxFl0zGSnvs9
    5pl+Iaq3UWInmor2muQs6KrMO13NXFPxnTy5VaPIyEz4uvbu9DQxlDWw9D6bL9wn
    DGPj2zYGr1lBqgMshNMkTFRYDeTVu4rI6r1zbxVeSEIrykCjuJzzG8RUUkZEYvSi
    bmFer64u1AEe/1o2mSvKhiPe0Y/lkH15Q46h9raYVQPw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S932326AbeCWKHE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbeCWKHA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 067/177] scsi: mac_esp: Replace bogus memory barrier with spinlock
Date: Fri, 23 Mar 2018 10:53:15 +0100
Message-Id: <20180323094208.286238281@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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
 
