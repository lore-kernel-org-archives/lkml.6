Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025EA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSz5wpvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfBLKrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:47:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45696 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfBLKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:47:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so1057270pgc.12;
        Tue, 12 Feb 2019 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uCkoQxTQgX3+6oFC+eCuPndPCUjblPAgc6eKUAYUiPQ=;
        b=hSz5wpvBnMoEwY4Wi2giwMD34IYRIn5NiViMdUZCXWOjBC7MGejP/RJEWDCBZhSanh
         OlJkSXzv0pgrfDHm9YNE349IzUDnaGtd88lqRIWv3rUrmMbvs8BxIGi8NM0/l1va+6nO
         5ybP0c+bvMJOx/wBWCYzgA4Ush0IfkV4ugyDn5rq8Hn5nOnqcS5duOvRdGJAaf1YOVu6
         A+n6x/qwbXeBikn/RCFt2gmIj6NEOOnWWQgiut6ZAO66JtMvaRu30YCFcvwYAunjvmXo
         oJnPkOT+Ust1X4T9aKKHgC9sA5T+SmUwfIJbpnibu87RzJsgRr8kAPy0A71q9Py6Zml1
         CoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uCkoQxTQgX3+6oFC+eCuPndPCUjblPAgc6eKUAYUiPQ=;
        b=BZDEjBhqvPYv0zsVvlhI4aZX6LivuvuMWS/no6RTBo3IUse23fYmeDSGCluPThaqUW
         AE2DxcEOc2AzjLz3bMzzwW8/kujtUJVGnLQlVvRY3+Co20Ump6wfAQQeAKxqk0594d4q
         XOGn37Ytok3p6yWQf6sr0cBUt4Lx+MXBcfWvKeNYfLFWlg5S2ZQCH5GZKcof48AhijyF
         60skFFYPzgKDKAkYL8EmrrvIQq1v5fcOk495M0pBltmZCcy8dGZ12RROY8Plh/9ov6hL
         h7/koP1znp5oF6/PVFqdADbjy0rvPHN2U+gpyceu0S3acyqjzxmQX3Otq93Okc0c8Api
         iQRA==
X-Gm-Message-State: AHQUAuYNK0RUEp5DKmzVgXQ9wpdYscJW34JkmDqvGTHqWmSa+BcZw7H5
        vnC4OjWbTF+xTn8/2ccSoThf0dHm
X-Google-Smtp-Source: AHgI3Ib3XF7pUaSy9bnSb1IBea2mQwuNLMkZCcJyHpLfvbI/84ydD2tB34wuvjUT1I2w0d9C1mzMbg==
X-Received: by 2002:a63:2f47:: with SMTP id v68mr92065pgv.144.1549968457985;
        Tue, 12 Feb 2019 02:47:37 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g20sm23426286pfg.85.2019.02.12.02.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:47:37 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: call gso_reset_checksum when computing checksum in sctp_gso_segment
Date:   Tue, 12 Feb 2019 18:47:30 +0800
Message-Id: <5b8187d1eabd52e4db7d3e4506d98c33571c1c83.1549968450.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 net/sctp/offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/offload.c b/net/sctp/offload.c
index 123e9f2..edfcf16 100644
--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -36,6 +36,7 @@ static __le32 sctp_gso_make_checksum(struct sk_buff *skb)
 {
 	skb->ip_summed = CHECKSUM_NONE;
 	skb->csum_not_inet = 0;
+	gso_reset_checksum(skb, ~0);
 	return sctp_compute_cksum(skb, skb_transport_offset(skb));
 }
 
-- 
2.1.0

