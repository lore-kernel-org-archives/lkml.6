Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413ADECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D8D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D8D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbeGTNaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:30:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbeGTNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:30:12 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 079FAC8A;
        Fri, 20 Jul 2018 12:38:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 057/101] s390/qeth: avoid using is_multicast_ether_addr_64bits on (u8 *)[6]
Date:   Fri, 20 Jul 2018 14:14:03 +0200
Message-Id: <20180720121425.547783082@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 9d0a58fb9747afd27d490c02a97889a1b59f6be4 ]

*ether_addr*_64bits functions have been introduced to optimize
performance critical paths, which access 6-byte ethernet address as u64
value to get "nice" assembly. A harmless hack works nicely on ethernet
addresses shoved into a structure or a larger buffer, until busted by
Kasan on smth like plain (u8 *)[6].

qeth_l2_set_mac_address calls qeth_l2_remove_mac passing
u8 old_addr[ETH_ALEN] as an argument.

Adding/removing macs for an ethernet adapter is not that performance
critical. Moreover is_multicast_ether_addr_64bits itself on s390 is not
faster than is_multicast_ether_addr:

is_multicast_ether_addr(%r2) -> %r2
llc	%r2,0(%r2)
risbg	%r2,%r2,63,191,0

is_multicast_ether_addr_64bits(%r2) -> %r2
llgc	%r2,0(%r2)
risbg	%r2,%r2,63,191,0

So, let's just use is_multicast_ether_addr instead of
is_multicast_ether_addr_64bits.

Fixes: bcacfcbc82b4 ("s390/qeth: fix MAC address update sequence")
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l2_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -141,7 +141,7 @@ static int qeth_l2_send_setmac(struct qe
 
 static int qeth_l2_write_mac(struct qeth_card *card, u8 *mac)
 {
-	enum qeth_ipa_cmds cmd = is_multicast_ether_addr_64bits(mac) ?
+	enum qeth_ipa_cmds cmd = is_multicast_ether_addr(mac) ?
 					IPA_CMD_SETGMAC : IPA_CMD_SETVMAC;
 	int rc;
 
@@ -158,7 +158,7 @@ static int qeth_l2_write_mac(struct qeth
 
 static int qeth_l2_remove_mac(struct qeth_card *card, u8 *mac)
 {
-	enum qeth_ipa_cmds cmd = is_multicast_ether_addr_64bits(mac) ?
+	enum qeth_ipa_cmds cmd = is_multicast_ether_addr(mac) ?
 					IPA_CMD_DELGMAC : IPA_CMD_DELVMAC;
 	int rc;
 


