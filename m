Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3533C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB39213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqN+xhbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfBYLZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:25:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42506 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfBYLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 06:25:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so4361043pfi.9;
        Mon, 25 Feb 2019 03:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+x9NY/g/oFDY/DpQbYmhnQBjuw/unnswRPtci/btBgA=;
        b=eqN+xhbo41A2PWT/69Hpsm3XMVOW1xTuUfdUzk+tBVhXdMANTESTJ2ikuxKidQYtaY
         bwRt1Lq1CpATWrW864L5/mlXTY7XqR2ZQ8nQcI0WdQBrEXaEY5TTLQGiOX1abNO36REc
         aDsQq+WBaoNzGD7LM6rIGoUZe8EkBuwrbADk/KClMgodn4sn3x0sqgSbQ6FjBSgfIY6Y
         bXLTNvD8g2hrBXXMK6HVnusH8+BlF8b/RAkfz9YKl1tQ3PbH8ggEST3nNWZEX34xSm+s
         inSS5AsD+wYQSkv6Zi2IefEPLYiAoW4f3+2Hnc0PWIMQLbFy7tAc6loP+eLMoMZ87564
         aOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+x9NY/g/oFDY/DpQbYmhnQBjuw/unnswRPtci/btBgA=;
        b=H/8UdigpsClpE64RrEz8FdGzUKDFditJM22lm+nA57pM1SAT6YkddIzPQwLxOrqXQs
         gIt5VJfJ1GVS44MthtP3cJ1oHZ62TmcJzGf+cYaaFvGCJ+wu/gfCrmX2DsN7F8QRLpNf
         V9DJkW7ObP7HkKVffSPjON+ZkZ9kyWOBGVie5qUfcaptu8VX+0NCpJ962KdliGLZXFnS
         HUFKgLSO9jXlN1AMwyfVuVbIv4k0/gQhVbQ0QJZzQEFg1YvcJEHx1QjJZ1797VG3oqj8
         HSsAREkgKTOyNbBb5wXdHHuSWMAOJiPHe5CMzzJnoEe+ZRalM6/B5q+gpaT79Lc3qbUH
         huLg==
X-Gm-Message-State: AHQUAub/NPHiLQ7R463frtn6fBARY+wmj+FHTwWmUnqB5nurpR48F7iY
        VB9Z29BOyXTW0x1p45PHkCBQDNc+
X-Google-Smtp-Source: AHgI3IaRm4DCHuDGAWaQ5cVa6OdfzMCQ5DbZyZfQYIiC1ghj4rR6d+fH7GvQ3DiaszKIwfHWugx+0g==
X-Received: by 2002:a63:cd06:: with SMTP id i6mr6305638pgg.267.1551093945562;
        Mon, 25 Feb 2019 03:25:45 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u26sm11221518pfn.166.2019.02.25.03.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 03:25:44 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: get sctphdr by offset in sctp_compute_cksum
Date:   Mon, 25 Feb 2019 19:25:37 +0800
Message-Id: <2aee76766861ac9e46b7acf123d5d6e8f2adf8e0.1551093937.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sctp_hdr(skb) only works when skb->transport_header is set properly.

But in the path of nf_conntrack_in: sctp_packet() -> sctp_error()

skb->transport_header is not guaranteed to be right value for sctp.
It will cause to fail to check the checksum for sctp packets.

So fix it by using offset, which is always right in all places.

Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/sctp/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
index 32ee65a..1c6e6c0 100644
--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -61,7 +61,7 @@ static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
-	struct sctphdr *sh = sctp_hdr(skb);
+	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
 	const struct skb_checksum_ops ops = {
 		.update  = sctp_csum_update,
 		.combine = sctp_csum_combine,
-- 
2.1.0

