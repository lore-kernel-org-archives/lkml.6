Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803619-2-13616396547790700372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803619; b=m7SunhtLhicw9lJSmOIzQzkKSV9yAhBS5Op9GqZhtobRKxh
    O5xtdpnk2OQNe38ejb89EXN5Q84ZPljUyM0um6cCyQF92bBQ9URWolmSHHx8cLT9
    G58yFF5zlmOnMFr9/E1CC5UR4SUbDIqNCQ1FpMfvWnS8MH9PIISnQeBEgBr0qYKw
    cRs9+ea/9VBLYsjQ0dEFQ9WFylVD4H4egBynaxjQ5ne/9s4k1cFONr/gxCCZWcXp
    Ph0PwJY7/XXRxfmERQuvPSj7C4UZtfLoRtHrjmDwCY2vs7/98qDj7aYasZNM6C5T
    nxRmfc5tGtcIrFA+gAxLwaWl85mZaWIZZmupENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803619; bh=t6X9SejACOJv2vbXhjL8j95yFV
    rkrQiszfP7FPpOgbQ=; b=qla5ZKcWWu0l1T8P9dnUZpg8ApnQQevwsUzAtzmJmR
    HttL5a+ckphjp5dXjtgwEE1O4HtbMD+R4Mb/My+SXg+sKTkV4ULFK8RmqJjXabMK
    FTm9rB93npym1KtDPkQoYHIL7H2gX2U5qBjlx10X5ITu2RsGpE2l5Jbg+zjFJLlc
    2eg6kAgyZ/JwcMc272Bj1KKxPrsCEIKClLOfRneXK7dYsSMlC42PgV/J2zXqdgop
    iU2y5Jlqbfmff7/I3X6wL8vIZIL7a3hNiJicY8xP4b8em9VY6svI7SMerZuQ5dqT
    lpAdzj5q22B4BkN3lBpoQ8HYuvWh0mEjG6xkWbPvFgFQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S932720AbeCWKKc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932684AbeCWKKa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timmy Li <lixiaoping3@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 124/177] net: hns: fix ethtool_get_strings overflow in hns driver
Date: Fri, 23 Mar 2018 10:54:12 +0100
Message-Id: <20180323094210.711890833@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timmy Li <lixiaoping3@huawei.com>


[ Upstream commit 412b65d15a7f8a93794653968308fc100f2aa87c ]

hns_get_sset_count() returns HNS_NET_STATS_CNT and the data space allocated
is not enough for ethtool_get_strings(), which will cause random memory
corruption.

When SLAB and DEBUG_SLAB are both enabled, memory corruptions like the
the following can be observed without this patch:
[   43.115200] Slab corruption (Not tainted): Acpi-ParseExt start=ffff801fb0b69030, len=80
[   43.115206] Redzone: 0x9f911029d006462/0x5f78745f31657070.
[   43.115208] Last user: [<5f7272655f746b70>](0x5f7272655f746b70)
[   43.115214] 010: 70 70 65 31 5f 74 78 5f 70 6b 74 00 6b 6b 6b 6b  ppe1_tx_pkt.kkkk
[   43.115217] 030: 70 70 65 31 5f 74 78 5f 70 6b 74 5f 6f 6b 00 6b  ppe1_tx_pkt_ok.k
[   43.115218] Next obj: start=ffff801fb0b69098, len=80
[   43.115220] Redzone: 0x706d655f6f666966/0x9f911029d74e35b.
[   43.115229] Last user: [<ffff0000084b11b0>](acpi_os_release_object+0x28/0x38)
[   43.115231] 000: 74 79 00 6b 6b 6b 6b 6b 70 70 65 31 5f 74 78 5f  ty.kkkkkppe1_tx_
[   43.115232] 010: 70 6b 74 5f 65 72 72 5f 63 73 75 6d 5f 66 61 69  pkt_err_csum_fai

Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c   |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c   |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -671,7 +671,7 @@ static void hns_gmac_get_strings(u32 str
 
 static int hns_gmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return ARRAY_SIZE(g_gmac_stats_string);
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -422,7 +422,7 @@ void hns_ppe_update_stats(struct hns_ppe
 
 int hns_ppe_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return ETH_PPE_STATIC_NUM;
 	return 0;
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -798,7 +798,7 @@ void hns_rcb_get_stats(struct hnae_queue
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return HNS_RING_STATIC_REG_NUM;
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -776,7 +776,7 @@ static void hns_xgmac_get_strings(u32 st
  */
 static int hns_xgmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS)
+	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
 		return ARRAY_SIZE(g_xgmac_stats_string);
 
 	return 0;
