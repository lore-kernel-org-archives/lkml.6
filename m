Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13CCC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1B5217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1B5217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbeHDLGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:06:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeHDLF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:05:59 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8783C89C;
        Sat,  4 Aug 2018 09:06:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 07/32] tcp_bbr: fix bw probing to raise in-flight data for very small BDPs
Date:   Sat,  4 Aug 2018 11:00:57 +0200
Message-Id: <20180804082650.284138337@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit 383d470936c05554219094a4d364d964cb324827 ]

For some very small BDPs (with just a few packets) there was a
quantization effect where the target number of packets in flight
during the super-unity-gain (1.25x) phase of gain cycling was
implicitly truncated to a number of packets no larger than the normal
unity-gain (1.0x) phase of gain cycling. This meant that in multi-flow
scenarios some flows could get stuck with a lower bandwidth, because
they did not push enough packets inflight to discover that there was
more bandwidth available. This was really only an issue in multi-flow
LAN scenarios, where RTTs and BDPs are low enough for this to be an
issue.

This fix ensures that gain cycling can raise inflight for small BDPs
by ensuring that in PROBE_BW mode target inflight values with a
super-unity gain are always greater than inflight values with a gain
<= 1. Importantly, this applies whether the inflight value is
calculated for use as a cwnd value, or as a target inflight value for
the end of the super-unity phase in bbr_is_next_cycle_phase() (both
need to be bigger to ensure we can probe with more packets in flight
reliably).

This is a candidate fix for stable releases.

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Priyaranjan Jha <priyarjha@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_bbr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -324,6 +324,10 @@ static u32 bbr_target_cwnd(struct sock *
 	/* Reduce delayed ACKs by rounding up cwnd to the next even number. */
 	cwnd = (cwnd + 1) & ~1U;
 
+	/* Ensure gain cycling gets inflight above BDP even for small BDPs. */
+	if (bbr->mode == BBR_PROBE_BW && gain > BBR_UNIT)
+		cwnd += 2;
+
 	return cwnd;
 }
 


