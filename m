Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9492147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696701;
	bh=9k9h0oelVyaxezXSiUbgFVMHHDUCyd9ua27ytOD+lvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0OOjqS15zXI04xEv9h5SAi/PN5dgMM3QLvLJ/dWLufKxTX0bvAdCtsIsRRV7G8Sd6
	 AbVk8XcB+aUiu6XA+QNr7dkd9CucuQqnH1awG6cHuc2EKs1vxb4oLxRs0jlbaCmUVh
	 9uQikyjnJuvEbH/vyVkMWYMS47jq6vVsAPsi58fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfA1Rbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfA1P6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADFD821841;
        Mon, 28 Jan 2019 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691088;
        bh=9k9h0oelVyaxezXSiUbgFVMHHDUCyd9ua27ytOD+lvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtzQQ7NkzaP2fn9tOxkj2V3Gqv2OX307cAueQwhKy2X/E80mvWaBxUBwnrAfsV9h6
         FL6dcO8pS8eZYi0xFSS2wzmbS1EAlCOTR7y/8NwNBoi4OFYE54ijguCkL82F4yixWO
         gGxiUOquOXX2m0C0RrJBMPodMn/3K7OlPIbPgJP4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 283/304] isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()
Date:   Mon, 28 Jan 2019 10:43:20 -0500
Message-Id: <20190128154341.47195-283-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 7418e6520f22a2e35815122fa5a53d5bbfa2c10f ]

In drivers/isdn/hisax/hfc_pci.c, the functions hfcpci_interrupt() and
HFCPCI_l1hw() may be concurrently executed.

HFCPCI_l1hw()
  line 1173: if (!cs->tx_skb)

hfcpci_interrupt()
  line 942: spin_lock_irqsave();
  line 1066: dev_kfree_skb_irq(cs->tx_skb);

Thus, a possible concurrency use-after-free bug may occur
in HFCPCI_l1hw().

To fix these bugs, the calls to spin_lock_irqsave() and
spin_unlock_irqrestore() are added in HFCPCI_l1hw(), to protect the
access to cs->tx_skb.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hisax/hfc_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index ea0e4c6de3fb..0109e0e8bcb6 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -1170,11 +1170,13 @@ HFCPCI_l1hw(struct PStack *st, int pr, void *arg)
 		if (cs->debug & L1_DEB_LAPD)
 			debugl1(cs, "-> PH_REQUEST_PULL");
 #endif
+		spin_lock_irqsave(&cs->lock, flags);
 		if (!cs->tx_skb) {
 			test_and_clear_bit(FLG_L1_PULL_REQ, &st->l1.Flags);
 			st->l1.l1l2(st, PH_PULL | CONFIRM, NULL);
 		} else
 			test_and_set_bit(FLG_L1_PULL_REQ, &st->l1.Flags);
+		spin_unlock_irqrestore(&cs->lock, flags);
 		break;
 	case (HW_RESET | REQUEST):
 		spin_lock_irqsave(&cs->lock, flags);
-- 
2.19.1

