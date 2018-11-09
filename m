Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19228C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D067B2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVVFNhwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D067B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeKJATl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:19:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36905 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeKJATl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:19:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so1018282pfm.4;
        Fri, 09 Nov 2018 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=HMLsy4/vK/5MJMLcMVhQHXzcrLC9IJReryfnlPGh7Mo=;
        b=iVVFNhwK/e//xMcrK1l6NIHc+vI2ZuumZW9Suy8epJo/JEZjcVZ72mcGoEWN8kNm5r
         mVqzwozkuJRGaMgq8Z6bc0PKI4Cg4/YdU8LbAQuQzkTzRZE9varNMAlX7Zix0NSFn/0j
         V2IMyf0kOdd5/aiFUVYfCbv1LgrDRXpNdjgkrAGb4ZZXoxhAc3Rve5USEN9y8/SHCgbm
         TqJjyFIgruM0q+Xp3DWprzwyQdwFHTtH3cnZxUIIoH5PI7h8t6s9VOBUeG0VpMF9q62T
         LoQsE6qKjmvmEahAhbetn2o5LHcZbXbiWMaJhripUXARx14mAR7EgBBt/mHIEmaMolZj
         oj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=HMLsy4/vK/5MJMLcMVhQHXzcrLC9IJReryfnlPGh7Mo=;
        b=p67HKR+jImLWFMFHAOnoxVKbIo/KbMoRLJREmNva2FE7d9BUHNPBbgrMzkutaxAOOD
         gClA15FE5CHg+kQNh69sDoVKG+pRD6ewwGRxgaijCfBrGIdB2R8wXrXpe8ptbh85ccTu
         AZpr8yYpwQCes/itQ5e7L3egM0sSHwuiK355Oxefm1jw451Wb1XOPpFvmYIvQ4BHHYkR
         yDZQjsinRNY+xIQnOhDEKvFuemgmzOYDYA0RmU6kwhoCk3M+NNN36vTYDmRzhjJRUeQW
         Sdu6xkB0PGqwp1kbSkURKWX+TBfDB62X8wy09RHinTEMRpKuwTE4MEORoki8xXpL2kno
         5iKQ==
X-Gm-Message-State: AGRZ1gIS1+wLmpjYyKcxka16aFvo0eBnICb6dRpEjv5ync2HVXnRmhBM
        2RouKHhA7smeEcZOqIMSj9o=
X-Google-Smtp-Source: AJdET5cv2xWzcQEJuBJFQYws194pL6GgGAvd1OrCJhzRmI1FyJpxwNN/2dWUpXLn+MBQ7EcAxByorg==
X-Received: by 2002:a62:9702:: with SMTP id n2-v6mr9177581pfe.222.1541774329226;
        Fri, 09 Nov 2018 06:38:49 -0800 (PST)
Received: from sabyasachi ([45.116.191.194])
        by smtp.gmail.com with ESMTPSA id o27-v6sm16906667pfk.85.2018.11.09.06.38.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 06:38:48 -0800 (PST)
Message-ID: <5be59bf8.1c69fb81.a231.dcd6@mx.google.com>
X-Google-Original-Message-ID: <20181109143837.GA4023@sabyasachi.linux@gmail.com>
Date:   Fri, 9 Nov 2018 20:08:37 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     jrdr.linux@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] infiniband/hw/hns/hns_roce_hw_v2.c: Use dma_zalloc_coherent
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
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a4c62ae..c9966ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4972,13 +4972,12 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 				eqe_alloc = i * (buf_chk_sz / eq->eqe_size);
 				size = (eq->entries - eqe_alloc) * eq->eqe_size;
 			}
-			eq->buf[i] = dma_alloc_coherent(dev, size,
+			eq->buf[i] = dma_zalloc_coherent(dev, size,
 							&(eq->buf_dma[i]),
 							GFP_KERNEL);
 			if (!eq->buf[i])
 				goto err_dma_alloc_buf;
 
-			memset(eq->buf[i], 0, size);
 			*(eq->bt_l0 + i) = eq->buf_dma[i];
 
 			eq_buf_cnt++;
-- 
2.7.4

