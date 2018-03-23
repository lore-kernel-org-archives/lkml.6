Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521806017-2-11305990623929133239
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
    t=1521806017; b=oNXPlAmtPeZ93C8pYh5wfQngwtHiDUp7GNA57G9LioIK5Xu
    oQKN92LKQrr374ceW2e+pzgR46Kek/sDtr1n7OyAK660Rr8mPqMZfojgQyCxxkiO
    IVwwL+H52CtLKadi6UIVFXzlxNZd0w0P25cz5uhQ002U0r9eXBBvIkPJIn7cmhhs
    LVcR0g7zjk9yB2Xyo/ihfNFJQY4sN66jw8IJpdQWuyFyZDPj6PV3kvNU8HyB1VGc
    EcmIytw0WYLCxeiCh5S7bfpFREwjPDMt0XTt9YItYwBMVe+j6+nezc751eijJ7Ja
    4poveUpvV7jgx2NRg1P0RVgN4zJYZFSek29X4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806017; bh=wdSVI99SQCVY6XYxc4KJHdSy0z
    kr2UqXIgDeSN6wl5o=; b=D0cZxaMBVPOte7t8GV0e0Qj1ZrODWxHflNobFSFSg9
    ZxswApFQakKunAJ7MJWkZ0HBGpMVKDD4up15T11BS5+zO+SYPJWvsndx1e4D+H8O
    j3uVNigi+gyb7RiIV+/Rzpr0z2ek+Ol9T5EhwVlqErCvlypyL4SZJqM6q8pheW5z
    Gw2kYfCMY5MgvolYnZY6qdiZw2+LRKsJmAvzqrYTzGeYl/Ya3GSL7PHtCYIApQUi
    ei79k3fL5a8aZ0czPH2FRfwx8AuWMinM4kQur8c2IKW/06FKqxTIkjCyCYt2e2E+
    WV9vgxuftijVMknw+gZahdyi/ZgZHyozdTAFTpMT7nXg==
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
        id S1753346AbeCWLxU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:53:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeCWKBt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 31/77] sfp: fix EEPROM reading in the case of non-SFF8472 SFPs
Date: Fri, 23 Mar 2018 10:54:05 +0100
Message-Id: <20180323094144.321463737@linuxfoundation.org>
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
@@ -667,20 +667,19 @@ static int sfp_module_eeprom(struct sfp
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
