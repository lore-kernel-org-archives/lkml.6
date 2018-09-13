Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26998C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D820620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D820620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeIMSpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:45:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:45:34 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB2F3D19;
        Thu, 13 Sep 2018 13:36:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Geoff Alexander <alexandg@cs.unm.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/78] ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and TIME-WAIT state
Date:   Thu, 13 Sep 2018 15:30:50 +0200
Message-Id: <20180913131805.927841842@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2440,6 +2440,12 @@ static int __net_init tcp_sk_init(struct
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
 


