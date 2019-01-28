Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23579C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95B320879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693745;
	bh=coPPtY93kHQgqoCp5iWSNXYKSkTXmBl115yEVy2kBaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TXpCCov0tmmU3XsWLQrhMlcCqjHH1ZcoB1LjvvR11Tnco5Pd+JvmrPERi9dAzENtR
	 9cbn0FrdQk9a1Zc9oktKaX8Wrq1RC3OLHj1eycTykxcCJT251pC/MFOytSmjM37m59
	 JeoPvBkUYCxzFKbHXWblnLYJnnaXMPeXke7TuMLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390447AbfA1QmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:42:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389494AbfA1QXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0332084A;
        Mon, 28 Jan 2019 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692621;
        bh=coPPtY93kHQgqoCp5iWSNXYKSkTXmBl115yEVy2kBaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pw+wVrGsEyCA5qxzwT4iIkE2Yzj01bmAwdZzSQ1+ZA0tZ2r6cL8KPAEf5N51nkE27
         TUZaZ3Jo8wP8ywD/MxGbGtZoExbve+XF+CnzexzGngIrr8dlbCqlnpIDgk2JBVYUOZ
         QuvIkWIW/YVVVe/j6qRh6Bd9582QctVSKHFCWnV0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 097/107] isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()
Date:   Mon, 28 Jan 2019 11:19:37 -0500
Message-Id: <20190128161947.57405-97-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
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
index 90449e1e91e5..1b1453d62fed 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -1169,11 +1169,13 @@ HFCPCI_l1hw(struct PStack *st, int pr, void *arg)
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

