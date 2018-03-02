Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519980782-2-8811731881089199832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519980782; b=KdonZ2GeDhvCFupFWwznU0K0GUjuvjD1B+ErE97lnGo6sjf
    jIWG1wOlxm2G1K0q0wkmiJ57SyrvaCSWatufb/Cpez2CqUELIb7A7USJdsgg3Jus
    +yyKigeGAAaVov2ea0/FW9EtxqlE3NiawdNwOjxDtRlEJEnJhGT19Hzo5mKfSO3W
    unJXFWmyUiTu0j3/j/ZR8RPLf5oRUNMmS3voN0rL+0LeP603XnZIt3223Iz7ttRq
    cIs52t57YLNWxPbA6WRWyYJS+BHbGGUFE3pWr5SWxipHKuMHS0GHSpMZmRydCSj1
    tPaTU5lhO4BqyAdXcYuLc37HvnWqyi84pt3dvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519980782; bh=Vai/oaXiSzSU2IDBfvHaEAjSD+
    kZK84PRtuWU7hBhiY=; b=YAushRJYZSk6yzN7Gp9SGIy3LTeFmaONJ/wSkx2Zy/
    TeHNSvofBczIBoAnEMaaG+uRdLLgEP8VW8ioKQyv6/F+Bs90AhSN8Ow5UHPsrh9N
    lqsRZujyUh0ef12acSY2Fa6vjJe4QD6QonfaJXetmT7HBNVO/W5ZkE3ya+J4VYAp
    w7l38W4AMsdVKiHmB3VaIya2ZUYJ229IsWwmNkY3fVeBdqG43zN8EdUkdrnSrOiG
    SzV5fyL4FWg/diqqgCK9SLayvPIbBCdw2ChB+X8B69OlQAMrAvPnoRWy/UElv69v
    6qES/T68YnlMIL03G+EzCmX3X1E0479rpANNMwkfDfXQ==
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
        id S1423293AbeCBIwx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:52:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423240AbeCBIwF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:52:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 19/24] mdio-sun4i: Fix a memory leak
Date: Fri,  2 Mar 2018 09:51:16 +0100
Message-Id: <20180302084240.092972403@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 56c0290202ab94a2f2780c449395d4ae8495fab4 ]

If the probing of the regulator is deferred, the memory allocated by
'mdiobus_alloc_size()' will be leaking.
It should be freed before the next call to 'sun4i_mdio_probe()' which will
reallocate it.

Fixes: 4bdcb1dd9feb ("net: Add MDIO bus driver for the Allwinner EMAC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-sun4i.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -128,8 +128,10 @@ static int sun4i_mdio_probe(struct platf
 
 	data->regulator = devm_regulator_get(&pdev->dev, "phy");
 	if (IS_ERR(data->regulator)) {
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(data->regulator) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_out_free_mdiobus;
+		}
 
 		dev_info(&pdev->dev, "no regulator found\n");
 	} else {
