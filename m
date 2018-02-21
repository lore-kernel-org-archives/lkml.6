Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218764-2-7227244416548312763
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218763; b=t5zMY069/dHHu/EZZq/7xOeAYdDxAki+kYdU3Wwc8ojWcsa
    t7NlzpYFOt5PPbzr3GIQ669pkT2RzN5VQvuI287i2glJG73KxyDxFSmanvIkge1N
    /6k+5o+dHEUuEqoEG+bX+wCNOxGHwV4ppg14KRx9SVGiEF3+WRcDg4qc3uHHnOtJ
    7Foy+0iIDG7mP79v41eI62mng9DKelR3W11ohgwObQt3ewb5DenES7J0qlGhj5Wz
    b95P7LhLHHpC+UogSQ4qOlPbVN/DYffZgEYc/IB52vZOyDWHIK3qJDpSUXheEbZM
    6PdxJqT11jmscljikr6oaUJCEpzVyfDMvWNBU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218763; bh=ak6so3SLMJtp98VgF/G4OVtPUE
    49Oicpl2zh8QO+icM=; b=ZzJGab6qePtD4fNp9ml0DihXz/ndTSca1jfwV92CUA
    UbJaM1b8gwSIt7YMLXuCcj8XAyTA8FzVcyAejT8gWyB3tryIQrrmCDXO2HudZ3VH
    9JgRvRjJuVavZyJ5gSLKy8Y2eAIrVZpUpf1PZfXHDITZbvTVkfvaqsET+B6QiSSv
    rFZT/+nv84zqAR0U1P/gbIKUA/ZHIwqc78/UXGM6gJ5FNs60dH8qCatYyOoIoVkm
    8gy8ImM7sijlvHbCpVQpkbrQ3/rVMC++PzxhfAYCHTtjzRytV2uDNgin3TMVw+N4
    2lBiZQLakXkREkOMcHK0Ptw8zh3weV5aFWe/49ErGrjg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeBUNMc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:12:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965605AbeBUNMb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 151/163] mvpp2: fix multicast address filter
Date: Wed, 21 Feb 2018 13:49:40 +0100
Message-Id: <20180221124538.356378054@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit 7ac8ff95f48cbfa609a060fd6a1e361dd62feeb3 upstream.

IPv6 doesn't work on the MacchiatoBIN board. It is caused by broken
multicast address filter in the mvpp2 driver.

The driver loads doesn't load any multicast entries if "allmulti" is not
set. This condition should be reversed.

The condition !netdev_mc_empty(dev) is useless (because
netdev_for_each_mc_addr is nop if the list is empty).

This patch also fixes a possible overflow of the multicast list - if
mvpp2_prs_mac_da_accept fails, we set the allmulti flag and retry.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/marvell/mvpp2.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7127,6 +7127,7 @@ static void mvpp2_set_rx_mode(struct net
 	int id = port->id;
 	bool allmulti = dev->flags & IFF_ALLMULTI;
 
+retry:
 	mvpp2_prs_mac_promisc_set(priv, id, dev->flags & IFF_PROMISC);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_ALL, allmulti);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_IP6, allmulti);
@@ -7134,9 +7135,13 @@ static void mvpp2_set_rx_mode(struct net
 	/* Remove all port->id's mcast enries */
 	mvpp2_prs_mcast_del_all(priv, id);
 
-	if (allmulti && !netdev_mc_empty(dev)) {
-		netdev_for_each_mc_addr(ha, dev)
-			mvpp2_prs_mac_da_accept(priv, id, ha->addr, true);
+	if (!allmulti) {
+		netdev_for_each_mc_addr(ha, dev) {
+			if (mvpp2_prs_mac_da_accept(priv, id, ha->addr, true)) {
+				allmulti = true;
+				goto retry;
+			}
+		}
 	}
 }
 
