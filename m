Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35128C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E333220892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhTJUmRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E333220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbeKIHob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbeKIHo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907CF208A3;
        Thu,  8 Nov 2018 22:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714817;
        bh=BGRUwpaTkapS3aSGnMbAVZ0HBX23gH4RTryQC02F0Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhTJUmRtqTNr0e4RnLko3+bpaTxX7JTHXoI6qYP5Iymd7/3qs6Y+hJkhBb4vm9fIq
         7hN+jQwe+Yj2bwyQuWfL5ibznwOkjD4wF3HMNvP6abczXBy7WlEUU4lt4dqh+WuVJj
         aPd2fcfUCAdem7JGGJOBioMfzXtr4SU0pVl9Wirw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Kumar <samanthakumar@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Sean Tranchetti <stranche@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 143/171] net: udp: fix handling of CHECKSUM_COMPLETE packets
Date:   Thu,  8 Nov 2018 13:51:53 -0800
Message-Id: <20181108215137.317545751@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

From: Sean Tranchetti <stranche@codeaurora.org>

[ Upstream commit db4f1be3ca9b0ef7330763d07bf4ace83ad6f913 ]

Current handling of CHECKSUM_COMPLETE packets by the UDP stack is
incorrect for any packet that has an incorrect checksum value.

udp4/6_csum_init() will both make a call to
__skb_checksum_validate_complete() to initialize/validate the csum
field when receiving a CHECKSUM_COMPLETE packet. When this packet
fails validation, skb->csum will be overwritten with the pseudoheader
checksum so the packet can be fully validated by software, but the
skb->ip_summed value will be left as CHECKSUM_COMPLETE so that way
the stack can later warn the user about their hardware spewing bad
checksums. Unfortunately, leaving the SKB in this state can cause
problems later on in the checksum calculation.

Since the the packet is still marked as CHECKSUM_COMPLETE,
udp_csum_pull_header() will SUBTRACT the checksum of the UDP header
from skb->csum instead of adding it, leaving us with a garbage value
in that field. Once we try to copy the packet to userspace in the
udp4/6_recvmsg(), we'll make a call to skb_copy_and_csum_datagram_msg()
to checksum the packet data and add it in the garbage skb->csum value
to perform our final validation check.

Since the value we're validating is not the proper checksum, it's possible
that the folded value could come out to 0, causing us not to drop the
packet. Instead, we believe that the packet was checksummed incorrectly
by hardware since skb->ip_summed is still CHECKSUM_COMPLETE, and we attempt
to warn the user with netdev_rx_csum_fault(skb->dev);

Unfortunately, since this is the UDP path, skb->dev has been overwritten
by skb->dev_scratch and is no longer a valid pointer, so we end up
reading invalid memory.

This patch addresses this problem in two ways:
	1) Do not use the dev pointer when calling netdev_rx_csum_fault()
	   from skb_copy_and_csum_datagram_msg(). Since this gets called
	   from the UDP path where skb->dev has been overwritten, we have
	   no way of knowing if the pointer is still valid. Also for the
	   sake of consistency with the other uses of
	   netdev_rx_csum_fault(), don't attempt to call it if the
	   packet was checksummed by software.

	2) Add better CHECKSUM_COMPLETE handling to udp4/6_csum_init().
	   If we receive a packet that's CHECKSUM_COMPLETE that fails
	   verification (i.e. skb->csum_valid == 0), check who performed
	   the calculation. It's possible that the checksum was done in
	   software by the network stack earlier (such as Netfilter's
	   CONNTRACK module), and if that says the checksum is bad,
	   we can drop the packet immediately instead of waiting until
	   we try and copy it to userspace. Otherwise, we need to
	   mark the SKB as CHECKSUM_NONE, since the skb->csum field
	   no longer contains the full packet checksum after the
	   call to __skb_checksum_validate_complete().

Fixes: e6afc8ace6dd ("udp: remove headers from UDP packets before queueing")
Fixes: c84d949057ca ("udp: copy skb->truesize in the first cache line")
Cc: Sam Kumar <samanthakumar@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/datagram.c     |    5 +++--
 net/ipv4/udp.c          |   20 ++++++++++++++++++--
 net/ipv6/ip6_checksum.c |   20 ++++++++++++++++++--
 3 files changed, 39 insertions(+), 6 deletions(-)

--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -754,8 +754,9 @@ int skb_copy_and_csum_datagram_msg(struc
 			return -EINVAL;
 		}
 
-		if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE))
-			netdev_rx_csum_fault(skb->dev);
+		if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE) &&
+		    !skb->csum_complete_sw)
+			netdev_rx_csum_fault(NULL);
 	}
 	return 0;
 fault:
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1726,8 +1726,24 @@ static inline int udp4_csum_init(struct
 	/* Note, we are only interested in != 0 or == 0, thus the
 	 * force to int.
 	 */
-	return (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
-							 inet_compute_pseudo);
+	err = (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
+							inet_compute_pseudo);
+	if (err)
+		return err;
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE && !skb->csum_valid) {
+		/* If SW calculated the value, we know it's bad */
+		if (skb->csum_complete_sw)
+			return 1;
+
+		/* HW says the value is bad. Let's validate that.
+		 * skb->csum is no longer the full packet checksum,
+		 * so don't treat it as such.
+		 */
+		skb_checksum_complete_unset(skb);
+	}
+
+	return 0;
 }
 
 /* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
--- a/net/ipv6/ip6_checksum.c
+++ b/net/ipv6/ip6_checksum.c
@@ -87,8 +87,24 @@ int udp6_csum_init(struct sk_buff *skb,
 	 * Note, we are only interested in != 0 or == 0, thus the
 	 * force to int.
 	 */
-	return (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
-							 ip6_compute_pseudo);
+	err = (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
+							ip6_compute_pseudo);
+	if (err)
+		return err;
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE && !skb->csum_valid) {
+		/* If SW calculated the value, we know it's bad */
+		if (skb->csum_complete_sw)
+			return 1;
+
+		/* HW says the value is bad. Let's validate that.
+		 * skb->csum is no longer the full packet checksum,
+		 * so don't treat is as such.
+		 */
+		skb_checksum_complete_unset(skb);
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(udp6_csum_init);
 


