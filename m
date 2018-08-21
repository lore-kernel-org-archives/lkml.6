Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8205C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8ED20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8ED20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeHUJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:52:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeHUJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:52:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BEA8BC1;
        Tue, 21 Aug 2018 06:33:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 01/22] dccp: fix undefined behavior with cwnd shift in ccid2_cwnd_restart()
Date:   Tue, 21 Aug 2018 08:21:27 +0200
Message-Id: <20180821055139.530485227@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055139.462620042@linuxfoundation.org>
References: <20180821055139.462620042@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>

[ Upstream commit 61ef4b07fcdc30535889990cf4229766502561cf ]

The shift of 'cwnd' with '(now - hc->tx_lsndtime) / hc->tx_rto' value
can lead to undefined behavior [1].

In order to fix this use a gradual shift of the window with a 'while'
loop, similar to what tcp_cwnd_restart() is doing.

When comparing delta and RTO there is a minor difference between TCP
and DCCP, the last one also invokes dccp_cwnd_restart() and reduces
'cwnd' if delta equals RTO. That case is preserved in this change.

[1]:
[40850.963623] UBSAN: Undefined behaviour in net/dccp/ccids/ccid2.c:237:7
[40851.043858] shift exponent 67 is too large for 32-bit type 'unsigned int'
[40851.127163] CPU: 3 PID: 15940 Comm: netstress Tainted: G        W   E     4.18.0-rc7.x86_64 #1
...
[40851.377176] Call Trace:
[40851.408503]  dump_stack+0xf1/0x17b
[40851.451331]  ? show_regs_print_info+0x5/0x5
[40851.503555]  ubsan_epilogue+0x9/0x7c
[40851.548363]  __ubsan_handle_shift_out_of_bounds+0x25b/0x2b4
[40851.617109]  ? __ubsan_handle_load_invalid_value+0x18f/0x18f
[40851.686796]  ? xfrm4_output_finish+0x80/0x80
[40851.739827]  ? lock_downgrade+0x6d0/0x6d0
[40851.789744]  ? xfrm4_prepare_output+0x160/0x160
[40851.845912]  ? ip_queue_xmit+0x810/0x1db0
[40851.895845]  ? ccid2_hc_tx_packet_sent+0xd36/0x10a0 [dccp]
[40851.963530]  ccid2_hc_tx_packet_sent+0xd36/0x10a0 [dccp]
[40852.029063]  dccp_xmit_packet+0x1d3/0x720 [dccp]
[40852.086254]  dccp_write_xmit+0x116/0x1d0 [dccp]
[40852.142412]  dccp_sendmsg+0x428/0xb20 [dccp]
[40852.195454]  ? inet_dccp_listen+0x200/0x200 [dccp]
[40852.254833]  ? sched_clock+0x5/0x10
[40852.298508]  ? sched_clock+0x5/0x10
[40852.342194]  ? inet_create+0xdf0/0xdf0
[40852.388988]  sock_sendmsg+0xd9/0x160
...

Fixes: 113ced1f52e5 ("dccp ccid-2: Perform congestion-window validation")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ccids/ccid2.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/dccp/ccids/ccid2.c
+++ b/net/dccp/ccids/ccid2.c
@@ -228,14 +228,16 @@ static void ccid2_cwnd_restart(struct so
 	struct ccid2_hc_tx_sock *hc = ccid2_hc_tx_sk(sk);
 	u32 cwnd = hc->tx_cwnd, restart_cwnd,
 	    iwnd = rfc3390_bytes_to_packets(dccp_sk(sk)->dccps_mss_cache);
+	s32 delta = now - hc->tx_lsndtime;
 
 	hc->tx_ssthresh = max(hc->tx_ssthresh, (cwnd >> 1) + (cwnd >> 2));
 
 	/* don't reduce cwnd below the initial window (IW) */
 	restart_cwnd = min(cwnd, iwnd);
-	cwnd >>= (now - hc->tx_lsndtime) / hc->tx_rto;
-	hc->tx_cwnd = max(cwnd, restart_cwnd);
 
+	while ((delta -= hc->tx_rto) >= 0 && cwnd > restart_cwnd)
+		cwnd >>= 1;
+	hc->tx_cwnd = max(cwnd, restart_cwnd);
 	hc->tx_cwnd_stamp = now;
 	hc->tx_cwnd_used  = 0;
 


