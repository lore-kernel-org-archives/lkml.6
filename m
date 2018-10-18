Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B97C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B7720645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbY11R8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B7720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeJSCCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:02:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46125 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbeJSCCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:02:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id x3-v6so28534379lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JfQGwIrwrD1CvEnjr+HtowFFhShfNj5LOkGinrHbu/8=;
        b=VbY11R8swKAm1KTZ8V+5/NheT9ftarHsnwgt6h6G3YrDEYzP2z5VtbH9BZCRX9L7RA
         9LmyyDTs0ki0vNrnuhbZaA8n9A7izNXuHPQ7Y/XqZFBJwvSiWvEhJe6ptG/fWhSwfc+p
         I4K5oTEsa+ozkF/ljQBKvta6/n0tLmh7CoHDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JfQGwIrwrD1CvEnjr+HtowFFhShfNj5LOkGinrHbu/8=;
        b=jgEhnVwTJYm8ipsexwF3/yAzEDyEUmwhXvXVx0LZiSO2rIHcRCDOZyzEhdJYsss+zi
         CyWXFNWsVLZ4Bk5tPPPEZHNROeD11/mUV3Hd8/1t/tgOtIHb8YLj+ZLorLYBszT/YDUb
         b1rim4oNO/VdlVSgYY/gSVUykHCCDXFc3a0iEGEu6jLe6AiMg+jN+nTE5x1P3wbU6ras
         VmyuiT7Vfp0E3lH4HU7ZpRZysrI8WVvSwRgTlVgdgqMX58xLQ0pKIrO2o7F0WphuZIie
         +uk9ncGOWfz5iMDzPeWRP4Z+/p29Gow5LbRISu7MbCbL6XmhvPeVWchD0IwlAgUQOXv3
         Sbdw==
X-Gm-Message-State: ABuFfoj3wW2rNat+vPrTtzUrwbL+Di8wnv5ThgBv0DcXq5rlDbH5/Q7V
        BFyDbhMw40Gub5u+TsfhYdefqA==
X-Google-Smtp-Source: ACcGV62KRPrLWS14LB0TptIULZKWUZrgKrW0LNBKgm5ci8dx8fZSzinTQwdhdtkI1xTuJr1aynadYw==
X-Received: by 2002:a2e:5215:: with SMTP id g21-v6mr20429816ljb.144.1539885613356;
        Thu, 18 Oct 2018 11:00:13 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id o185-v6sm944988lfo.40.2018.10.18.11.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:00:12 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast entries while switch promisc mode
Date:   Thu, 18 Oct 2018 21:00:06 +0300
Message-Id: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need now to flush mcast entries in switch mode while toggling to
promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
and mcast/vlan ports = ALL_PORTS, the same happening for vlan
unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
mode routine by calling set allmulti. I suppose main reason to flush
them is to use unreg_mcast to receive all to host port. Thus, now, all
mcast packets are received anyway and no reason to flush mcast entries
unsafely, as they were synced with __dev_mc_sync() previously and are
not restored. Another way is to _dev_mc_unsync() them, but no need.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master
Tasted on am572x EVM and BBB

 drivers/net/ethernet/ti/cpsw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 226be2a56c1f..0e475020a674 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -638,9 +638,6 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 			} while (time_after(timeout, jiffies));
 			cpsw_ale_control_set(ale, 0, ALE_AGEOUT, 1);
 
-			/* Clear all mcast from ALE */
-			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
-
 			/* Flood All Unicast Packets to Host port */
 			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
 			dev_dbg(&ndev->dev, "promiscuity enabled\n");
-- 
2.17.1

