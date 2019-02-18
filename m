Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDB521901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499079;
	bh=M+ZiYPG4aBvx2y6CXLgVvQXiokYrDM1RcH+HtWDSFt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SqhKH523kdnSHWZqHhdrNrBL9ggnRPr1pvBCszpICy8rg6NMBg8mfvnKWaJ54kgF8
	 OsdAkehurU5ihqMwdyVv13gBajX66IA9iskXSCYE0YSfu0/hSnFN65O49zYYhR+hmT
	 Ddt5TD/4qZxFydLaJxgldpNA/LllORDWFkGcjOmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391688AbfBROLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391665AbfBROLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D13F217D9;
        Mon, 18 Feb 2019 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499071;
        bh=M+ZiYPG4aBvx2y6CXLgVvQXiokYrDM1RcH+HtWDSFt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzxAmdYvIg4zvQjPCrS1ipBF4v55V0HDwD1fqF0MObhg8ROehJmNbYQkAC9xI12E7
         4JY2D7eikt3eer0UXI8R9RSwxvKvujzqugABQrPNnwbhwuZ3aqsaRXFTMjoHXApgjL
         jexHnm9MmDeKqpfjZ7vsf3Fr+aZh373xtrDe1wRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 050/108] isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()
Date:   Mon, 18 Feb 2019 14:43:46 +0100
Message-Id: <20190218133521.836429874@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 4a4825528188..3d58437638c8 100644
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



