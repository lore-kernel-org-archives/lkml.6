Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805930-2-17977342582731923915
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805930; b=Ph22H41ukTfMx/3l0yZqQYGujIG5qgQZbQKG1okKwYYAbVW
    IPyS2Aa6l6ghTSSEqOYeFbBORF5SsSv74fieNxftTJGrOzLZqQSZ4q5V8AYEn9qj
    V5FyNIyLBAxL/p3QUOI9vL2ZRbZt8NMzONrLuf3mlT521moefpUuSKuH1kB10XXz
    MNAShjEZ5uYLMiCv9eY/RN1sTWRGrSWsfe55zphUA+V+eo6AV0kgF9a+Hr2FtCHv
    4eik/aB5yUc6PFQH8xe8LqAqkRRrbe0VJG0carE9K//B/H8FmrS6OfePR00QxtGs
    tPpyLDEWrSXv8bCqrml0+vMcWSXoihBJusid+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805930; bh=l1Va/VxAbI4+z8FKazkCG59quG
    qvJM4hFp3QmTcNxQo=; b=aR/rmifCcBLksgdy9q2ooFFO3RJUppln/+VfiJllsC
    tRCaFxhGTjqVfmOBdN+Bk5BACM4AYjdg7PmWCDy8gqStyDrJU8ajoNq9eBCc+7Qh
    Ba5ZGbeleq2dCEvUN9zKVeqM7aPiUcJDICnmAzI0/J6z54LcxtmZsFPDfJyNketG
    91mIOPo0wRwGNUQrh00X1xsTkPtHWGe/O/Ydk3MkyJMHXGwoYVAmyLVSbPSKt42I
    K63OflJ/vdrjhqZuKhNKCk7UsxmLfEWH0R/Duxv0ZlXxJ2zkBl0TXhZPmhTTuYIS
    JK/QECJXSnZ+CQ3HmsFavUKJigbpVoriZOb71mv2eXdg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1754263AbeCWLvc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:51:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbeCWKCJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 32/77] sfp: fix non-detection of PHY
Date: Fri, 23 Mar 2018 10:54:06 +0100
Message-Id: <20180323094144.396673896@linuxfoundation.org>
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

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit 20b56ed9f8adfb9a7fb1c878878c54aa4ed645c1 ]

The detection of a PHY changed in commit e98a3aabf85f ("mdio_bus: don't
return NULL from mdiobus_scan()") which now causes sfp to print an
error message.  Update for this change.

Fixes: 73970055450e ("sfp: add SFP module support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -318,12 +318,12 @@ static void sfp_sm_probe_phy(struct sfp
 	msleep(T_PHY_RESET_MS);
 
 	phy = mdiobus_scan(sfp->i2c_mii, SFP_PHY_ADDR);
-	if (IS_ERR(phy)) {
-		dev_err(sfp->dev, "mdiobus scan returned %ld\n", PTR_ERR(phy));
+	if (phy == ERR_PTR(-ENODEV)) {
+		dev_info(sfp->dev, "no PHY detected\n");
 		return;
 	}
-	if (!phy) {
-		dev_info(sfp->dev, "no PHY detected\n");
+	if (IS_ERR(phy)) {
+		dev_err(sfp->dev, "mdiobus scan returned %ld\n", PTR_ERR(phy));
 		return;
 	}
 
