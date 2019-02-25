Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9F3217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129503;
	bh=/qTjuVrgjdrUQH2F4AOZ8+aOb+zjBGxG+iYCfGHJKD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yoTLXHbKMncDFDE45rFtM+SrzL9ROC05Wj6Yecl0a9OMcn5JWaKCF1QCmxVU8jMV+
	 hWQjDPjbEsvaZEGZDddLhbHx3Lt6BidGWOSRuYq/MBFEmaIdO6+kM8oOeNeNr66MwS
	 dRwj6cYmXemlUwmZpZZxFSgPI+z6ERuB7EsjHYxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfBYVSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730079AbfBYVSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A612147C;
        Mon, 25 Feb 2019 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129495;
        bh=/qTjuVrgjdrUQH2F4AOZ8+aOb+zjBGxG+iYCfGHJKD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nk2UYnI5MDayRjNeUdVvTPQb48kn3T+XnMYTURzsDqsLJPHqbBqT+6uoHVcr8kGZe
         ZWKi0iBvp+maf5G5QF/RHICZkh+ZSI8mLX/JgJdxALyBqwuyzhM8w9XRa2HNwBnofM
         DWu+r+dVlGTI1Etnpjn1C4J2EvHBPbmB/RDbpRQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 50/71] sctp: call gso_reset_checksum when computing checksum in sctp_gso_segment
Date:   Mon, 25 Feb 2019 22:11:52 +0100
Message-Id: <20190225195038.396583153@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit fc228abc2347e106a44c0e9b29ab70b712c4ca51 ]

Jianlin reported a panic when running sctp gso over gre over vlan device:

  [   84.772930] RIP: 0010:do_csum+0x6d/0x170
  [   84.790605] Call Trace:
  [   84.791054]  csum_partial+0xd/0x20
  [   84.791657]  gre_gso_segment+0x2c3/0x390
  [   84.792364]  inet_gso_segment+0x161/0x3e0
  [   84.793071]  skb_mac_gso_segment+0xb8/0x120
  [   84.793846]  __skb_gso_segment+0x7e/0x180
  [   84.794581]  validate_xmit_skb+0x141/0x2e0
  [   84.795297]  __dev_queue_xmit+0x258/0x8f0
  [   84.795949]  ? eth_header+0x26/0xc0
  [   84.796581]  ip_finish_output2+0x196/0x430
  [   84.797295]  ? skb_gso_validate_network_len+0x11/0x80
  [   84.798183]  ? ip_finish_output+0x169/0x270
  [   84.798875]  ip_output+0x6c/0xe0
  [   84.799413]  ? ip_append_data.part.50+0xc0/0xc0
  [   84.800145]  iptunnel_xmit+0x144/0x1c0
  [   84.800814]  ip_tunnel_xmit+0x62d/0x930 [ip_tunnel]
  [   84.801699]  gre_tap_xmit+0xac/0xf0 [ip_gre]
  [   84.802395]  dev_hard_start_xmit+0xa5/0x210
  [   84.803086]  sch_direct_xmit+0x14f/0x340
  [   84.803733]  __dev_queue_xmit+0x799/0x8f0
  [   84.804472]  ip_finish_output2+0x2e0/0x430
  [   84.805255]  ? skb_gso_validate_network_len+0x11/0x80
  [   84.806154]  ip_output+0x6c/0xe0
  [   84.806721]  ? ip_append_data.part.50+0xc0/0xc0
  [   84.807516]  sctp_packet_transmit+0x716/0xa10 [sctp]
  [   84.808337]  sctp_outq_flush+0xd7/0x880 [sctp]

It was caused by SKB_GSO_CB(skb)->csum_start not set in sctp_gso_segment.
sctp_gso_segment() calls skb_segment() with 'feature | NETIF_F_HW_CSUM',
which causes SKB_GSO_CB(skb)->csum_start not to be set in skb_segment().

For TCP/UDP, when feature supports HW_CSUM, CHECKSUM_PARTIAL will be set
and gso_reset_checksum will be called to set SKB_GSO_CB(skb)->csum_start.

So SCTP should do the same as TCP/UDP, to call gso_reset_checksum() when
computing checksum in sctp_gso_segment.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/offload.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -36,6 +36,7 @@ static __le32 sctp_gso_make_checksum(str
 {
 	skb->ip_summed = CHECKSUM_NONE;
 	skb->csum_not_inet = 0;
+	gso_reset_checksum(skb, ~0);
 	return sctp_compute_cksum(skb, skb_transport_offset(skb));
 }
 


