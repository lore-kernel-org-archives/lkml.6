Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807015-2-16144356932971065259
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
    t=1521807014; b=ILL5KC5+ZdHHDkEVxwaujp6sPWphPQlGcJ2wYqJly4B3dWo
    G0kfqoy+TS/EgTjuRo6oRacvocrpGuLRFPHvo6D0IIqmIc2mVWkSMuO5FYdNk+tc
    lWvebmvrJuFJ8UveldRxoUbRVXaeE/snTiDM3yV7KeUnAYily6kM2ckIq/6bbWfs
    ZSuWoDS8AMh1IZtrijEGAfS7bKXS856vo6kQIVk1VtGoC700XUZbsB9nPupijp9o
    l45tJXgKM60IzhT6IBFGRDXjUBr+sd+z2c1YwjV2cfvN0Tcferw0nxx/+RcRll9v
    +ZfPYyuQQiU+pEhwZMautWywjZPBVyka24mU/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807014; bh=s+QBAJ+T3/gzmPFlUBsKwINQoG
    cd/yLVmj4FZdlAw80=; b=hcP6ZvgiXvQe4HYbeGQOPXJ9uSda5EHDnLnKlj9Bxc
    Ymo+u5v1ZlTQz6M4D0EY+2jNjB+uhPPqcCtLLnwdcnbwMIEkbCNVRauytSjrgDAY
    g7hBXSDkrZDMUEQSlJlVtn7ZcGT7YRJhi36VyI7lXf6sDGPZ3JuYX31cGs/K/gJW
    R7PsCliBRgI41UAgOKwp6r6j5xu5hCtpmH87gwTGUCb1AqnpTBulhev52fM6eIoQ
    0TBfh3TgiraPTuxFpDHX+y6Z8zasWyw2a0V+PU2xDmtv5vfv5zz3Ybb/W73+GBcR
    CXPBnAxsaU3/CNQZgUnQ4OMzx99J0V7Yzzcgf5lMGq+Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1753005AbeCWJ6F (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbeCWJ6B (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 35/84] sfp: fix EEPROM reading in the case of non-SFF8472 SFPs
Date: Fri, 23 Mar 2018 10:53:49 +0100
Message-Id: <20180323095417.193331557@linuxfoundation.org>
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


[ Upstream commit 2794ffc441dde3109804085dc745e8014a4de224 ]

The EEPROM reading was trying to read from the second EEPROM address
if we requested the last byte from the SFF8079 EEPROM, which caused a
failure when the second EEPROM is not present.  Discovered with a
S-RJ01 SFP module.  Fix this.

Fixes: 73970055450e ("sfp: add SFP module support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -683,20 +683,19 @@ static int sfp_module_eeprom(struct sfp
 		len = min_t(unsigned int, last, ETH_MODULE_SFF_8079_LEN);
 		len -= first;
 
-		ret = sfp->read(sfp, false, first, data, len);
+		ret = sfp_read(sfp, false, first, data, len);
 		if (ret < 0)
 			return ret;
 
 		first += len;
 		data += len;
 	}
-	if (first >= ETH_MODULE_SFF_8079_LEN &&
-	    first < ETH_MODULE_SFF_8472_LEN) {
+	if (first < ETH_MODULE_SFF_8472_LEN && last > ETH_MODULE_SFF_8079_LEN) {
 		len = min_t(unsigned int, last, ETH_MODULE_SFF_8472_LEN);
 		len -= first;
 		first -= ETH_MODULE_SFF_8079_LEN;
 
-		ret = sfp->read(sfp, true, first, data, len);
+		ret = sfp_read(sfp, true, first, data, len);
 		if (ret < 0)
 			return ret;
 	}
