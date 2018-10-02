Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9855DC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3E02089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3E02089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbeJBUN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbeJBUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:57 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF4C6C52;
        Tue,  2 Oct 2018 13:30:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Yang <yyd@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 191/228] tcp_bbr: in restart from idle, see if we should exit PROBE_RTT
Date:   Tue,  2 Oct 2018 06:24:48 -0700
Message-Id: <20181002132511.040897325@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Yang <yyd@google.com>

[ Upstream commit 5490b32dce6932ea7ee8e3b2f76db2957c92af6e ]

This patch fix the case where BBR does not exit PROBE_RTT mode when
it restarts from idle. When BBR restarts from idle and if BBR is in
PROBE_RTT mode, BBR should check if it's time to exit PROBE_RTT. If
yes, then BBR should exit PROBE_RTT mode and restore the cwnd to its
full value.

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Kevin Yang <yyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_bbr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -174,6 +174,8 @@ static const u32 bbr_lt_bw_diff = 4000 /
 /* If we estimate we're policed, use lt_bw for this many round trips: */
 static const u32 bbr_lt_bw_max_rtts = 48;
 
+static void bbr_check_probe_rtt_done(struct sock *sk);
+
 /* Do we estimate that STARTUP filled the pipe? */
 static bool bbr_full_bw_reached(const struct sock *sk)
 {
@@ -304,6 +306,8 @@ static void bbr_cwnd_event(struct sock *
 		 */
 		if (bbr->mode == BBR_PROBE_BW)
 			bbr_set_pacing_rate(sk, bbr_bw(sk), BBR_UNIT);
+		else if (bbr->mode == BBR_PROBE_RTT)
+			bbr_check_probe_rtt_done(sk);
 	}
 }
 


