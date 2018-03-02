Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981757-2-6074379045683012411
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
    t=1519981757; b=LkZoseHBhzS7LzXXcZ5wXgdd2GWCkN/Ei3486NH8SAnS/Ns
    DzIK7jKZaZT6Tx+1cHLg7Pw3wKlN1QOdm5HdVJhFFVFqmu/aWagBuDXRm50763mj
    oxKHd8PdL24cJbVN8ee8m+KhQFQ55qOeeZdTuqbk26a6zX8QzyijiOIjQcZ917Y0
    TxcFqY+i8vxcx5hFxjQ4dqylipFszF7ya710Nt7syuKkEl/6eqCNMLZkP5de+bNk
    dY2MRVhbMlaO9LPu6OQu1lh6O669+YMM19A8LHQcPrKz6zwvmG1pQc2+FyWHYNsw
    wEW174KXSCWUhvNT/S0l0a3CYCAp1t4caOa1ndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981757; bh=k5p7wT4gykC/Me9u2OzHkLVdAN
    7wMyXcBI/ZVNqUuVU=; b=nyPVc8WLCBCUpsBdt1vVwK9oH0FfprzR49Naa1Ync9
    SgG/SBReoxoVe5neXZOVh6jx1FJ5MGSKDk6Sy9HMhX3yb5/vl59Ng+9tUxhuGhpR
    ybMF3E/CFsO40xh2QqW5QM6IufgsFIvboEfF6w9AiMe0qm2A5QBdSxqHqEG4dkgz
    XfzpVG9gQZr8mbehxu4FJwPkHU8mAcLnyzyEVhLOf7faT+b9uuQ9skC+Cwh9DNl6
    nWiMq16kHCl4WmhfQw70nmMosO9gVSzU02L8JlwrIvWSg1VaakNfkXU9tKE6aHEK
    EMbcIV2aXTsXzLkE/tSKiG1QIcybhQ4/2D0bZKc+1WaQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425265AbeCBJFl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:05:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425263AbeCBJFf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:05:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 105/115] of_mdio: avoid MDIO bus removal when a PHY is missing
Date: Fri,  2 Mar 2018 09:51:48 +0100
Message-Id: <20180302084508.090695188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
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

From: Madalin Bucur <madalin.bucur@nxp.com>


[ Upstream commit 95f566de0269a0c59fd6a737a147731302136429 ]

If one of the child devices is missing the of_mdiobus_register_phy()
call will return -ENODEV. When a missing device is encountered the
registration of the remaining PHYs is stopped and the MDIO bus will
fail to register. Propagate all errors except ENODEV to avoid it.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/of_mdio.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -228,7 +228,12 @@ int of_mdiobus_register(struct mii_bus *
 			rc = of_mdiobus_register_phy(mdio, child, addr);
 		else
 			rc = of_mdiobus_register_device(mdio, child, addr);
-		if (rc)
+
+		if (rc == -ENODEV)
+			dev_err(&mdio->dev,
+				"MDIO device at address %d is missing.\n",
+				addr);
+		else if (rc)
 			goto unregister;
 	}
 
@@ -252,7 +257,7 @@ int of_mdiobus_register(struct mii_bus *
 
 			if (of_mdiobus_child_is_phy(child)) {
 				rc = of_mdiobus_register_phy(mdio, child, addr);
-				if (rc)
+				if (rc && rc != -ENODEV)
 					goto unregister;
 			}
 		}
