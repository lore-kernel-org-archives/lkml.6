Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDCC36 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:29:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeDCC34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:29:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7683F60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
To: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ac46b4e4-7e6c-c15f-06eb-01b1e4893d50@codeaurora.org>
Date: Mon, 2 Apr 2018 22:29:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2018 12:26 PM, Sinan Kaya wrote:
> @@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32 cons, u8 flags)
>  	wmb();
>  	cq->db.data.agg_flags = flags;
>  	cq->db.data.value = cpu_to_le32(cons);
> -	writeq(cq->db.raw, cq->db_addr);
> +	writeq_relaxed(cq->db.raw, cq->db_addr);

Given the direction to get rid of wmb() in front of writeX() functions, I have been
reviewing this code. Under normal circumstances, I can get rid of all wmb() as follows.

However, I started having my doubts now. Are these wmb() used as a SMP barrier too?
I can't find any smp_Xmb() in drivers/infiniband/hw/qedr directory.

static void doorbell_cq(struct qedr_cq *cq, u32 cons, u8 flags)
 {
-       /* Flush data before signalling doorbell */
-       wmb();
        cq->db.data.agg_flags = flags;
        cq->db.data.value = cpu_to_le32(cons);
        writeq(cq->db.raw, cq->db_addr);
@@ -1870,8 +1868,7 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
                         */

                        if (rdma_protocol_roce(&dev->ibdev, 1)) {
-                               wmb();
-                               writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
+                               writel(qp->rq.db_data.raw, qp->rq.db);
                                /* Make sure write takes effect */
                                mmiowb();
                        }
@@ -3275,8 +3272,7 @@ int qedr_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
         * unchanged). For performance reasons we avoid checking for this
         * redundant doorbell.
         */
-       wmb();
-       writel_relaxed(qp->sq.db_data.raw, qp->sq.db);
+       writel(qp->sq.db_data.raw, qp->sq.db);

        /* Make sure write sticks */
        mmiowb();
@@ -3362,9 +3358,6 @@ int qedr_post_recv(struct ib_qp *ibqp, struct ib_recv_wr *wr,

                qedr_inc_sw_prod(&qp->rq);

-               /* Flush all the writes before signalling doorbell */
-               wmb();





-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
