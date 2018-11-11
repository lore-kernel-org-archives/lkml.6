Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9535C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9802E20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9802E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbeKLFsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50134 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730260AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000l9-EX; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pM-6t; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.479128202@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 314/366] dccp: fix undefined behavior with 'cwnd'
 shift in ccid2_cwnd_restart()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>

commit 61ef4b07fcdc30535889990cf4229766502561cf upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/dccp/ccids/ccid2.c | 6 ++++--
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
 

