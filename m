Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806907-2-11167160849843839920
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
    t=1521806906; b=XzqWleqYRWcJ2lcdDt2/fJZ+v7A5/+UKgLRm/ZFlNBHypBP
    hlwuEMLjKaBeZXU/kLTb+qqVPUsaXfueEUYVl8IAg5SS5oer87riPL0zqHMAyCpV
    ZLa3QmMFyhUmuNBgItIjb5ocJxNmaRQh08DQkI5XO82EfblsI6O9yV3JkIjzAIM1
    2CEDLODkj7T3W0x88YR66ttYRKCB3bGUHBFBLQNNY4hghGkIlBWme/Gu4FRYh0VA
    CqCiGMgJ0R9ODmWpaggyed4K3gaNPgAb1JVIVQ1Dhab9FQIrghfjDj6F1G6w/AX3
    1HIKUCygxvH8FIS5wjYQ0DTIolP9oBl5dqaTn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806906; bh=NSt4stAloi4mr7MLLoOPGPcm9I
    etEZTnPtuTxzeW1AA=; b=jWbDtbFUenFbEfF91MQwQuXQyQfgokRCHkZUYTZGSm
    oyk3s2PRoRciSrWIOahCGuhaUPWPOabNFauJ4fxdRAs7cBC9quFoiIaOs1XiVU4Y
    +nxS8kj9L2DCVJnoTggBIGJOQbx4OUhGTc/wuVsL8woFQKshzbFSf818uBpedBMk
    mMdoTFx6S32qO6TyPpQkK8Bt9HMzS3lFj8gu3HU+uLfRD1uKCapSVJFC79dX+RLk
    NPHmJgqFiOmMIdqMUqiI6iGUUw21AuH+MdimYdsbRG1FvbDJXc40LpjolxmsjoDt
    5r/RvecMjpOp+eNapZ6UjOmT2yrXA2MlL7XxylNeUfng==
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
        id S1751963AbeCWMIF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:08:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbeCWJ6i (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Tu <u9012063@gmail.com>,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 62/84] ip_gre: fix error path when erspan_rcv failed
Date: Fri, 23 Mar 2018 10:54:16 +0100
Message-Id: <20180323095421.356666250@linuxfoundation.org>
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

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>


[ Upstream commit dd8d5b8c5b22e31079b259b8bfb686f1fac1080a ]

When erspan_rcv call return PACKET_REJECT, we shoudn't call ipgre_rcv to
process packets again, instead send icmp unreachable message in error
path.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Acked-by: William Tu <u9012063@gmail.com>
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -408,11 +408,13 @@ static int gre_rcv(struct sk_buff *skb)
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN))) {
 		if (erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
 			return 0;
+		goto out;
 	}
 
 	if (ipgre_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
 		return 0;
 
+out:
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 drop:
 	kfree_skb(skb);
