Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F094BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B3B21708
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="a1wejeYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B3B21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeJUGLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:11:04 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:41650 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeJUGLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:11:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id D4595946
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 21:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r0ixYTYMfFYc for <linux-kernel@vger.kernel.org>;
        Sat, 20 Oct 2018 16:59:08 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id A2DBB92B
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 16:59:08 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id x5-v6so34269093ioa.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UkLunLEUOK7TbR+F8VWnP5l9DQpRtbz969KsXUguX+A=;
        b=a1wejeYFFW46If0uKZewQ1BNdOr0NPD4uRXoSz61z0Jpy4HrC+/MiCJQL1CyOBaeWQ
         h3m/6hkBtS0d4vR1fnEBZ+/wwpTGGuPLGJNtyTPx8VU4SS4aZF0qOzgZ37OwqL3PxICl
         BwXGG5cYtqXhm2Hei0K1nBwiQ5WnQUwJbcMQTVsxcL8EDKlgP5qeq3Z3D5T2ABeL619q
         7qSYWwGv/b5A5/1nmc8CPI5ti8/ucb7yZXxpfNPdG1vtQ4i4o+T1qP6extRZc3UnmCMR
         1D9rkY8rCCgiiJtZkrYRMCvRzskQhXoSXoP0TDzDhxmbU8qnun+OyaaMCUVl/bkd6BGM
         mS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UkLunLEUOK7TbR+F8VWnP5l9DQpRtbz969KsXUguX+A=;
        b=iX8Sxe6ThxNVEL9FtSvr/hQkmCNablZouq484g5b3mjYBOWUu6VtvDvDOfbyrCD5+S
         MwC86l8ENhBmSuDQIT4V5evl3cfCrByOiWbK3XHrYAJIcUCcgrZh+9Av0P2vcBj1E298
         oHovq1GgS76XcJvnGtovpof9/X0MX3K0ttOqRTRx5CJVRD2+ntoEgB20cBo1jcPV/58Q
         8f3HAovr2E+32JRoHD4Xa3iitNXI6qNf235jewZ6jSBGmXGpNOwH/TV+jfs7hD4xd2iB
         3KCqgR58rH5FZpHEXdGwfcRDiafJZl6uugVCHH5Hqh2fi+vd+09Yk7Ff4tLUzUoAvD1O
         Fhvg==
X-Gm-Message-State: ABuFfoh87g/1hTL9lbXS14GYmTWrC02HVTjMqURQ7cVn8V+Qr00STig3
        GW8QKlorf6kYRfsxRBHFCch2mCI9ai3+GN7gzz8Znzma/wD+BYgEmepTtpRihOBP8AZ1xLloSex
        LADa/uznMBt3OQBENU1Sc1xB6Megl
X-Received: by 2002:a24:1ad0:: with SMTP id 199-v6mr5734341iti.18.1540072748321;
        Sat, 20 Oct 2018 14:59:08 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62l+NhYX+EkB/KOniwQxwCakdsy1FlMwAWaV0r7R55qqBYwQASMLytEJlGFn7ZiNQ1RfX/joQ==
X-Received: by 2002:a24:1ad0:: with SMTP id 199-v6mr5734338iti.18.1540072748129;
        Sat, 20 Oct 2018 14:59:08 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id p185-v6sm3001152itg.34.2018.10.20.14.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 14:59:07 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org (open list:CXGB4 IWARP RNIC DRIVER
        (IW_CXGB4)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iw_cxgb4: fix a missing-check bug
Date:   Sat, 20 Oct 2018 16:59:00 -0500
Message-Id: <1540072741-18856-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In c4iw_flush_hw_cq, the next CQE is acquired through t4_next_hw_cqe(). In
t4_next_hw_cqe(), the CQE, i.e., 'cq->queue[cq->cidx]', is checked to see
whether it is valid through t4_valid_cqe(). If it is valid, the address of
the CQE is then saved to 'hw_cqe'. Later on, the CQE is copied to the local
memory in create_read_req_cqe(). The problem here is that the CQE is
actually in a DMA region allocated by dma_alloc_coherent() in create_cq().
Given that the device also has the permission to access the DMA region, a
malicious device controlled by an attacker can modify the CQE in the DMA
region after the check in t4_next_hw_cqe() but before the copy in
create_read_req_cqe(). By doing so, the attacker can supply invalid CQE,
which can cause undefined behavior of the kernel and introduce potential
security risks.

This patch avoids the above issue by saving the CQE to a local variable if
it is verified to be a valid CQE in t4_next_hw_cqe(). Also, the local
variable will be used for the copy in create_read_req_ceq().

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/infiniband/hw/cxgb4/cq.c | 8 +++++---
 drivers/infiniband/hw/cxgb4/t4.h | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 6d30427..09918ca 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -335,13 +335,15 @@ static void advance_oldest_read(struct t4_wq *wq)
  */
 void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp)
 {
-	struct t4_cqe *hw_cqe, *swcqe, read_cqe;
+	struct t4_cqe hw_cqe_obj;
+	struct t4_cqe *hw_cqe = &hw_cqe_obj;
+	struct t4_cqe *swcqe, read_cqe;
 	struct c4iw_qp *qhp;
 	struct t4_swsqe *swsqe;
 	int ret;
 
 	pr_debug("cqid 0x%x\n", chp->cq.cqid);
-	ret = t4_next_hw_cqe(&chp->cq, &hw_cqe);
+	ret = t4_next_hw_cqe(&chp->cq, hw_cqe);
 
 	/*
 	 * This logic is similar to poll_cq(), but not quite the same
@@ -414,7 +416,7 @@ void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp)
 		}
 next_cqe:
 		t4_hwcq_consume(&chp->cq);
-		ret = t4_next_hw_cqe(&chp->cq, &hw_cqe);
+		ret = t4_next_hw_cqe(&chp->cq, hw_cqe);
 		if (qhp && flush_qhp != qhp)
 			spin_unlock(&qhp->lock);
 	}
diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4/t4.h
index e42021f..9a9eea5 100644
--- a/drivers/infiniband/hw/cxgb4/t4.h
+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -791,7 +791,7 @@ static inline int t4_cq_notempty(struct t4_cq *cq)
 	return cq->sw_in_use || t4_valid_cqe(cq, &cq->queue[cq->cidx]);
 }
 
-static inline int t4_next_hw_cqe(struct t4_cq *cq, struct t4_cqe **cqe)
+static inline int t4_next_hw_cqe(struct t4_cq *cq, struct t4_cqe *cqe)
 {
 	int ret;
 	u16 prev_cidx;
@@ -809,7 +809,7 @@ static inline int t4_next_hw_cqe(struct t4_cq *cq, struct t4_cqe **cqe)
 
 		/* Ensure CQE is flushed to memory */
 		rmb();
-		*cqe = &cq->queue[cq->cidx];
+		*cqe = cq->queue[cq->cidx];
 		ret = 0;
 	} else
 		ret = -ENODATA;
-- 
2.7.4

