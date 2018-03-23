Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806242-2-7039898872652061610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806241; b=raKCaPlm9rqM7Ag7jd1V/GqQXNAwE39tKoBjpmXNs7m6o8i
    LWwOodFwRYd0z6iV2bEmp4IMBKbFAH54ywYWkPUztfxrLwN49JrATeAluupaFdnZ
    i/txotzZUzz7WX5gCtmghkgf24WoeAbkZwJmftSO7hvVJ0KJfdmQTeKpjq4MiML+
    NRBGLhp5Od5nQIn2P38Gc1BA1QwpwtVtZQwhin98Q/i2PWnWqcstaWulXtKQtA54
    EQCdTMOjSoq2OkFPI8DRdBEsMccskL2/4/9178Nu7tWDj2gDOpAOJpP2x+7GcaBe
    IAVc/ShD7RUk08clPvqrKd/E961RPv5im3UM9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806241; bh=1SuhNRKqlzpKnUoot/+Dthdj3x
    8wCokJ1J+alk+6tUw=; b=YyVFMnieVEICIHtDhShODQOW5Ui63l5I2htKYPAaRG
    cTJ7+BYa120ToZCOMi0pLPaY9g7x4+N0lvszQUPjS+g8SOTkhkcHiSj3lAe8xOgT
    14jAEm75RDM6x25mstnOMH8dRECpsQ1K5eUPjkKMTvYEW87ibXZzXu3yG2pFhaSQ
    WUs0BJvIC7wblXzc4tFTAeVlHlcevLRvue5xB4aH5Ri8ik9xRkEuh26wTBSQr6Ty
    T4UAvM4yjXbTkmjkkk1aC9SmurRKEz34jV748T2qoQdvpDzHOMhQZjvUPJ6ABFt2
    OFOQubVr8UmGPsSaRMSkrrO3DtqdsB0hVR1Kr8yCzxwQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1753674AbeCWKAi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753606AbeCWKAh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 04/77] Bluetooth: btqcomsmd: Fix skb double free corruption
Date: Fri, 23 Mar 2018 10:53:38 +0100
Message-Id: <20180323094142.487465476@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Loic Poulain <loic.poulain@linaro.org>


[ Upstream commit 67b8fbead4685b36d290a0ef91c6ddffc4920ec9 ]

In case of hci send frame failure, skb is still owned
by the caller (hci_core) and then should not be freed.

This fixes crash on dragonboard-410c when sending SCO
packet. skb is freed by both btqcomsmd and hci_core.

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btqcomsmd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -86,7 +86,8 @@ static int btqcomsmd_send(struct hci_dev
 		break;
 	}
 
-	kfree_skb(skb);
+	if (!ret)
+		kfree_skb(skb);
 
 	return ret;
 }
