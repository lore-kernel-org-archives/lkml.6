Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521807027-2-2699502622424440525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807026; b=BtjfanwZzq4baGRBVz94zDQepkQTHHNcIqyeaSZLloNrs2+
    S0c4acChnDceV4IQy+zs5vhPHS2FBD+70YAQsYxhQ1wNgncnSUBm32sYhuEwmrE7
    D+WrMgMXPPC6WTuoMPoX7QDZ+w7YYINf7Oqzdx7rzmdQidzXYhBRT+EvQYT4I+4F
    qroIW0lekiHETSfyeGkEw3Ulvn1kGwHotTyzRFPvlyz66cNkH8Th6G54qCJv4XHZ
    qz8BcumDXCGz1C6doxcLr+gF+6p+M4Clul/l4mcpKb0RvixhDV69/5l9GKd9i8gw
    s2fvkQhvwk4eeXTcQzG76faQEKAHVu4v3tMU9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807026; bh=t/SRSFMz4+wP8t9b5rEfDH5Zms
    u3vFAIN24D0g6BiFI=; b=ecGBLuJLpaKxOKAul553x66lUixf6KCCi04l29I64y
    nPtGpkUv74JHTOmO5xhcLhHp7/1Wd7ImX3JikcURAVO2Fc939l1ttv7IdeLZwQNA
    60PQikViDck/kZcJ/SDd7+v+Yga4F2jvyamd54jzVvQuUMhtMNaTpRCMebop09Sr
    fZmnicDB8QHSaSiYRbiA865xXnIr2lBwLqQjpbvO2vHNKkxY49xTDISxvfTRXnlm
    UR+f4k77c4uaHLRPQTPUUipLtLDvjfw56dipNRO9RnKdjtxfngm1nPD4+awWB+iF
    u86UH1/ZcJljWK01GESkNp+RI3E7Jrra339PKUrlWI8A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1753305AbeCWMKL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:10:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeCWJ6F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 36/84] sfp: fix non-detection of PHY
Date: Fri, 23 Mar 2018 10:53:50 +0100
Message-Id: <20180323095417.359956382@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -315,12 +315,12 @@ static void sfp_sm_probe_phy(struct sfp
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
 
