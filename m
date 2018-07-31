Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C62C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BC2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BC2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeGaP2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:28:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732378AbeGaP2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:28:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25B20AE1B;
        Tue, 31 Jul 2018 13:48:12 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        ard <ard@kwaak.net>, Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/3] fcoe: fix use-after-free in fcoe_ctlr_els_send
Date:   Tue, 31 Jul 2018 15:46:01 +0200
Message-Id: <20180731134603.20089-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180731134603.20089-1-jthumshirn@suse.de>
References: <20180731134603.20089-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reports a use-after-free in fcoe_ctlr_els_send() when we're
sending a LOGO and have FIP debugging enabled. This is because we're
first freeing the skb and then printing the frame's DID. But the DID
is a member of the FC frame header which in turn is the skb's payload.

Exchange the debug print and kfree_skb() calls so we're not touching
the freed data.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index ea23c8dffc25..ceb35ebbeb8f 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -799,9 +799,9 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 	fip->send(fip, skb);
 	return -EINPROGRESS;
 drop:
-	kfree_skb(skb);
 	LIBFCOE_FIP_DBG(fip, "drop els_send op %u d_id %x\n",
 			op, ntoh24(fh->fh_d_id));
+	kfree_skb(skb);
 	return -EINVAL;
 }
 EXPORT_SYMBOL(fcoe_ctlr_els_send);
-- 
2.16.4

