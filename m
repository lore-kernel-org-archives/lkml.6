Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CDD224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMthWeah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CDD224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeKMBPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:15:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46513 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:15:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so1538958ply.13;
        Mon, 12 Nov 2018 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=EP970EtUPPmxMSocrXllAaTbi8u+T/xBMhYPnG+pMuY=;
        b=VMthWeahRdNi6bG33YW4SCPHVS/ge8U0oIa0ibzf9peagXeuzlGhATJMfRdPbaclXQ
         BWkDQ8tg0sZC6YbOSRKevflg0k1yA6W6K6TgUslJ5FwRn4UzkRpeSwJW9dAftX2oeZP2
         vZMXk2DOAYwHu7xl92LDlbDVQI8t2jxfqsGaP8tRR4mOAVElEXGKhUV+CK3chsrXbpRW
         y40Mf6cZmgFUoWwAsB/oN/okm1AfBwy9dPrUbGibtrqlR59wRaaD5ZwfwCdal0Os2mdj
         xGVzFkdUUIxgo3r7nb0Pfd5yCBmYzrBv3M4T3FiOCx63Yj0AfMVMN7FLO4/4nEA13d9u
         zTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=EP970EtUPPmxMSocrXllAaTbi8u+T/xBMhYPnG+pMuY=;
        b=dh9VbnIIZqFgJPMQ4z0LeA+ScnE633fbGpkog+LCyz5tiXeKw7E0+ilxhZ5eQNhUSn
         RQOqx3c2zI6qPi5b3m8oYdFjQpLdSK1K1+4yGeVo3TxfHNWROaVk8T5h6LOF3nFq6LUR
         2GPWWM4WXtnnJkDvdb6P2asPfH98PRmjw7riKmCmXEWXYO+qDxlxJQ8G1kWgYYXOEYBc
         URIkUiEfFRP9FVhRbFN2L+McAfg/p0H5YwRflRFSbICb4ngYJ5BSE0e72hawx5DBpvyU
         GlMTDCXtjsvXy+dnTinRrf+F8Iq8/R3C9buMZUOYfypeNBfus1f+cSm//kN80gWrYua5
         vVCw==
X-Gm-Message-State: AGRZ1gK/qmjqGEgeKN+BHsw4M9YKxyJSznXl6QvUnfeXiisqWb+BlUKq
        uy2kbUsByjz05+aAs5Hca4U=
X-Google-Smtp-Source: AJdET5fNk7r69o9WWy3iKN4f6No1xd/kjVykQcvQrQ1zluZzK3C8yI6D5oAJIBui1h60BEwAUUaiBA==
X-Received: by 2002:a17:902:f208:: with SMTP id gn8mr1304772plb.6.1542036126872;
        Mon, 12 Nov 2018 07:22:06 -0800 (PST)
Received: from sabyasachi ([2405:205:6189:c1f1:2151:b4c2:f56b:842])
        by smtp.gmail.com with ESMTPSA id r81-v6sm34685576pfa.110.2018.11.12.07.22.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 07:22:06 -0800 (PST)
Message-ID: <5be99a9e.1c69fb81.87c65.4ec2@mx.google.com>
X-Google-Original-Message-ID: <20181112152159.GA3155@sabyasachi.linux@gmail.com>
Date:   Mon, 12 Nov 2018 20:51:59 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     swise@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     jrdr.linux@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] infiniband/hw/cxgb4/qp.c: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/infiniband/hw/cxgb4/qp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 13478f3..5a8030b 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2564,13 +2564,12 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
 	wq->rqt_abs_idx = (wq->rqt_hwaddr - rdev->lldi.vr->rq.start) >>
 		T4_RQT_ENTRY_SHIFT;
 
-	wq->queue = dma_alloc_coherent(&rdev->lldi.pdev->dev,
+	wq->queue = dma_zalloc_coherent(&rdev->lldi.pdev->dev,
 				       wq->memsize, &wq->dma_addr,
 			GFP_KERNEL);
 	if (!wq->queue)
 		goto err_free_rqtpool;
 
-	memset(wq->queue, 0, wq->memsize);
 	dma_unmap_addr_set(wq, mapping, wq->dma_addr);
 
 	wq->bar2_va = c4iw_bar2_addrs(rdev, wq->qid, CXGB4_BAR2_QTYPE_EGRESS,
-- 
2.7.4

