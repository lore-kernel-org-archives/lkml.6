Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D36C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273F520C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273F520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeIMSvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:51:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeIMSvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:51:24 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6B0EAD19;
        Thu, 13 Sep 2018 13:41:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Geoff Alexander <alexandg@cs.unm.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 002/115] ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and TIME-WAIT state
Date:   Thu, 13 Sep 2018 15:30:22 +0200
Message-Id: <20180913131823.486289563@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 431280eebed9f5079553daf003011097763e71fd ]

tcp uses per-cpu (and per namespace) sockets (net->ipv4.tcp_sk) internally
to send some control packets.

1) RST packets, through tcp_v4_send_reset()
2) ACK packets in SYN-RECV and TIME-WAIT state, through tcp_v4_send_ack()

These packets assert IP_DF, and also use the hashed IP ident generator
to provide an IPv4 ID number.

Geoff Alexander reported this could be used to build off-path attacks.

These packets should not be fragmented, since their size is smaller than
IPV4_MIN_MTU. Only some tunneled paths could eventually have to fragment,
regardless of inner IPID.

We really can use zero IPID, to address the flaw, and as a bonus,
avoid a couple of atomic operations in ip_idents_reserve()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Geoff Alexander <alexandg@cs.unm.edu>
Tested-by: Geoff Alexander <alexandg@cs.unm.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_ipv4.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2468,6 +2468,12 @@ static int __net_init tcp_sk_init(struct
 		if (res)
 			goto fail;
 		sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
+
+		/* Please enforce IP_DF and IPID==0 for RST and
+		 * ACK sent in SYN-RECV and TIME-WAIT state.
+		 */
+		inet_sk(sk)->pmtudisc = IP_PMTUDISC_DO;
+
 		*per_cpu_ptr(net->ipv4.tcp_sk, cpu) = sk;
 	}
 


