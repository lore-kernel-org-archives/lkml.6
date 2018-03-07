Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520452839-2-5851347285317819282
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
    t=1520452838; b=Ijl2RFWWNEmMUgP80ZNb2F3uaBQ9Ng0sbsVpHKxrMyQB+0g
    bUOZfN45Oi+VsxeRwkXUQ8wHSA4zVirfS8IojRbqoof7OJuruKYObpsNle6Se0Ql
    IrT77d7bKruhE77gfF7dSBp8/+z1zq5Rdo3JirE/4O25Luc1ijKZrpikfZ3Gu2UD
    N0OlD/u+Mk2P+Cz7JTUOS+isqUvGTsHyCgZB0d1N6koejnvoT/E2DPN3jGoqJ3/m
    C2Jm3nbsU8ED1aopp3gfJEDH6AWHW4u6/wHx9kHe1iXSl56PpdNGkCpEhkhkclkL
    KBeYrm8hHXDLtgR7MI5TCy0pRCulS0slouPsxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452838; bh=8bWBQvjfVONqXX4ePa2bWVcgzI
    vytBmLeG9dVxMkp3U=; b=XXoiDBhuQIqkNkZ5502kWjOLBQxmMukKv5Z9lEpZBu
    ktvEJhwmHh7nR9zqCp+EcmGONCi9mSy0SxaTXtfTTBK3n8fgdXFLyKwbWcdIf79z
    qoRKK3iwPVMa5gylM7RYaN4MUhQt3DHho0V3kgs4HJR85XMWrERCWjZn9B+Ir1VS
    5fiJeUCR0q8awDdgu/QpndiK3Ql3RCfgx/lYsqwvhp3u+ZkMhdxcvz1lgCZO8gtV
    foFHdnuJs25eLmHHcK7YV701xT0avkjs7lYfeDIarT5yqlX+6Pe/o+NJ9+tfiiUV
    VoH2XN/IyOlOBrnys60UGGwgLJWYRZhb4NSveh3pFfDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935045AbeCGT6j (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:58:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965667AbeCGTrG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:06 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 078/110] s390/qeth: fix IP removal on offline cards
Date: Wed,  7 Mar 2018 11:39:01 -0800
Message-Id: <20180307191049.719974800@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 98d823ab1fbdcb13abc25b420f9bb71bade42056 ]

If the HW is not reachable, then none of the IPs in qeth's internal
table has been registered with the HW yet. So when deleting such an IP,
there's no need to stage it for deregistration - just drop it from
the table.

This fixes the "add-delete-add" scenario on an offline card, where the
the second "add" merely increments the IP's use count. But as the IP is
still set to DISP_ADDR_DELETE from the previous "delete" step,
l3_recover_ip() won't register it with the HW when the card goes online.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -255,12 +255,8 @@ int qeth_l3_delete_ip(struct qeth_card *
 	if (addr->in_progress)
 		return -EINPROGRESS;
 
-	if (!qeth_card_hw_is_reachable(card)) {
-		addr->disp_flag = QETH_DISP_ADDR_DELETE;
-		return 0;
-	}
-
-	rc = qeth_l3_deregister_addr_entry(card, addr);
+	if (qeth_card_hw_is_reachable(card))
+		rc = qeth_l3_deregister_addr_entry(card, addr);
 
 	hash_del(&addr->hnode);
 	kfree(addr);
@@ -403,11 +399,7 @@ static void qeth_l3_recover_ip(struct qe
 	spin_lock_bh(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
-		if (addr->disp_flag == QETH_DISP_ADDR_DELETE) {
-			qeth_l3_deregister_addr_entry(card, addr);
-			hash_del(&addr->hnode);
-			kfree(addr);
-		} else if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
+		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			if (addr->proto == QETH_PROT_IPV4) {
 				addr->in_progress = 1;
 				spin_unlock_bh(&card->ip_lock);
