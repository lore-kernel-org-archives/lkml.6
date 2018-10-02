Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFFDC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF77204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF77204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbeJBUQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:16:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbeJBUQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:16:50 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BFF2B2F;
        Tue,  2 Oct 2018 13:33:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Manish Rangankar <Manish.Rangankar@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 070/137] scsi: bnx2i: add error handling for ioremap_nocache
Date:   Tue,  2 Oct 2018 06:24:31 -0700
Message-Id: <20181002132503.478169502@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit aa154ea885eb0c2407457ce9c1538d78c95456fa ]

When ioremap_nocache fails, the lack of error-handling code may cause
unexpected results.

This patch adds error-handling code after calling ioremap_nocache.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Manish Rangankar <Manish.Rangankar@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/bnx2i/bnx2i_hwi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -2742,6 +2742,8 @@ int bnx2i_map_ep_dbell_regs(struct bnx2i
 					      BNX2X_DOORBELL_PCI_BAR);
 		reg_off = (1 << BNX2X_DB_SHIFT) * (cid_num & 0x1FFFF);
 		ep->qp.ctx_base = ioremap_nocache(reg_base + reg_off, 4);
+		if (!ep->qp.ctx_base)
+			return -ENOMEM;
 		goto arm_cq;
 	}
 


