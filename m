Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E03ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D38820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D38820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbeGWN26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbeGWN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3210BBDB;
        Mon, 23 Jul 2018 12:27:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 58/63] ipv6: make DAD fail with enhanced DAD when nonce length differs
Date:   Mon, 23 Jul 2018 14:25:04 +0200
Message-Id: <20180723122448.548655519@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit e66515999b627368892ccc9b3a13a506f2ea1357 ]

Commit adc176c54722 ("ipv6 addrconf: Implemented enhanced DAD (RFC7527)")
added enhanced DAD with a nonce length of 6 bytes. However, RFC7527
doesn't specify the length of the nonce, other than being 6 + 8*k bytes,
with integer k >= 0 (RFC3971 5.3.2). The current implementation simply
assumes that the nonce will always be 6 bytes, but others systems are
free to choose different sizes.

If another system sends a nonce of different length but with the same 6
bytes prefix, it shouldn't be considered as the same nonce. Thus, check
that the length of the received nonce is the same as the length we sent.

Ugly scapy test script running on veth0:

def loop():
    pkt=sniff(iface="veth0", filter="icmp6", count=1)
    pkt = pkt[0]
    b = bytearray(pkt[Raw].load)
    b[1] += 1
    b += b'\xde\xad\xbe\xef\xde\xad\xbe\xef'
    pkt[Raw].load = bytes(b)
    pkt[IPv6].plen += 8
    # fixup checksum after modifying the payload
    pkt[IPv6].payload.cksum -= 0x3b44
    if pkt[IPv6].payload.cksum < 0:
        pkt[IPv6].payload.cksum += 0xffff
    sendp(pkt, iface="veth0")

This should result in DAD failure for any address added to veth0's peer,
but is currently ignored.

Fixes: adc176c54722 ("ipv6 addrconf: Implemented enhanced DAD (RFC7527)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ndisc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -811,7 +811,7 @@ static void ndisc_recv_ns(struct sk_buff
 			return;
 		}
 	}
-	if (ndopts.nd_opts_nonce)
+	if (ndopts.nd_opts_nonce && ndopts.nd_opts_nonce->nd_opt_len == 1)
 		memcpy(&nonce, (u8 *)(ndopts.nd_opts_nonce + 1), 6);
 
 	inc = ipv6_addr_is_multicast(daddr);


