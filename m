Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591486-2-1980821110496954491
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
    t=1517591485; b=Qlz3UbFvrBUGuPI0IzbbSps07pvgO5DR/nqVVI0f24vor4l
    MHUSAoWG/kRePI6hgJtfQPfidY+MvnK1YXQYNvCaooVJhE5Ufb2ge/JnfpXFWLds
    TCz0JNNNGVuH2hn/5GuPshmOhFd4+/CdAm5j2QK+vsK7ECYmkBTDQSeeeng0mXuz
    aNiTVjAMXgdRsHTw7x9QPgZ1lWSV5q3IoFvO60jPh1e3Dr9EUSkGKjYkCRzUAjPQ
    AkXztK5DXhg+tWXW/GPJ0TsYAlTXr7pNvn31tnYH6RBxhS9mUitHv7iWO20b2KOi
    eoD74g5h0hp9kLxcXk7w9PMFxPJon0MaKqbhe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591485; bh=dhJFYtmH6/I4Jk/zCeYN8tfcvE
    16CnwOBnGFatDMINk=; b=TrrX9ozz7fmhQxpC/FjSS7f5zANx2hHGHkeVL1jPp4
    jV++0JvBHSjHkz6+6tHOC0FSZv7WI8CaIrJPZHbpRFhmgzTjMV2xfs9DIjGVmZfc
    rDmptAOdc0jC8PXowm0mYgScXLjdOaSuZTy0lC0XTHF6bU5f+vIIUmBGxLz7Ikq+
    8I03pkOUYtnXEKv72noh+dBiph2y1jH37pQ7C71Moi4XyXnUc8AMDF1bH89NtdD0
    V9+fr6afMNddyhWGwXdpEpgaWeSDUk1HWMTozbuQtwBhGjFBMLKUs6Yke7NBGQWz
    orF+51xkpXhCgECJntbNbw1Q2ZYDgDxfEV/4aaPL6sKg==
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
        id S1753383AbeBBRLU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38580 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeBBRLS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 093/156] net: mvpp2: fix the txq_init error path
Date: Fri,  2 Feb 2018 17:57:54 +0100
Message-Id: <20180202140844.448045058@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@free-electrons.com>


[ Upstream commit ba2d8d887d962c2f790e6dc01b2fd25b4608720b ]

When an allocation in the txq_init path fails, the allocated buffers
end-up being freed twice: in the txq_init error path, and in txq_deinit.
This lead to issues as txq_deinit would work on already freed memory
regions:

    kernel BUG at mm/slub.c:3915!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP

This patch fixes this by removing the txq_init own error path, as the
txq_deinit function is always called on errors. This was introduced by
TSO as way more buffers are allocated.

Fixes: 186cd4d4e414 ("net: mvpp2: software tso support")
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2.c |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -5597,7 +5597,7 @@ static int mvpp2_txq_init(struct mvpp2_p
 						sizeof(*txq_pcpu->buffs),
 						GFP_KERNEL);
 		if (!txq_pcpu->buffs)
-			goto cleanup;
+			return -ENOMEM;
 
 		txq_pcpu->count = 0;
 		txq_pcpu->reserved_num = 0;
@@ -5610,26 +5610,10 @@ static int mvpp2_txq_init(struct mvpp2_p
 					   &txq_pcpu->tso_headers_dma,
 					   GFP_KERNEL);
 		if (!txq_pcpu->tso_headers)
-			goto cleanup;
+			return -ENOMEM;
 	}
 
 	return 0;
-cleanup:
-	for_each_present_cpu(cpu) {
-		txq_pcpu = per_cpu_ptr(txq->pcpu, cpu);
-		kfree(txq_pcpu->buffs);
-
-		dma_free_coherent(port->dev->dev.parent,
-				  txq_pcpu->size * TSO_HEADER_SIZE,
-				  txq_pcpu->tso_headers,
-				  txq_pcpu->tso_headers_dma);
-	}
-
-	dma_free_coherent(port->dev->dev.parent,
-			  txq->size * MVPP2_DESC_ALIGNED_SIZE,
-			  txq->descs, txq->descs_dma);
-
-	return -ENOMEM;
 }
 
 /* Free allocated TXQ resources */
