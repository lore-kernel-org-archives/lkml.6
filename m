Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+VARpUT0woivenUjHZ9Jo/IoGcrlNK9AZbx8EdAlu9xYOZJMfTcPtD5t5oDcgdMDdyu+i6
ARC-Seal: i=1; a=rsa-sha256; t=1523399305; cv=none;
        d=google.com; s=arc-20160816;
        b=LolL7m7BsrFuUpGRvKwNbSG1B8zRV25oxcduSHxVvygMzQ2EACEd4QFYDPykQt1TO/
         Q1sHtmINMszauGG6WkWBWuQEM4504g50PqZGqTYbS9N5a1coFXSlcL/WK831gCrHUsY6
         up1u1t+NTqoXFP0Wg6hFYc+9FOK65c2wAnD2pM9fyyAOsj4OMLYacVqBxcpT+ELj1UL5
         c62FPzRNQqVbKCHa/JOoQ8SJuxruIaxQ6HM1MkVGXglT+xlTDZilLrArovy3vD8msiZp
         rsGmrCB2jQJJxyEMybyOoDetjpxFRpWGuD+XB2dE9jRlMmE95YRynP+O3ESsX7JG+zAv
         ffew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SCCEChsNrRSBiLYczgKdoUMY6cUdf1Y77rVnFREiXvw=;
        b=Bj0R9JZLl3VcNX618wfqlTf10qkJM1qcNPmZvxBQabWc2oWmm/tw86rXSPOYOQ6RoD
         BzgT4H+6Eb82nVY8gpEQaJbVuQhRt3Ldu9/2LcgJebTgozBTna0JyLCZzGEknLe5B+g5
         FeNo1kAaoJLsqc4lLljoNRjiAy7t9cqjcw2accNsVO+XZocSD/u+Z5nBB0gxvU+ngLqW
         qAWLfA2MG7n2IhO2IKKk4OxJ+KBXMkHPnqj6a81H0CBnvj5In5+x4JtwtaNPQkbEDRPe
         yV6eX5UK3kJgzEPuHqDkLjIBads01U+nxdKbjssdmqi4xI9HUmHhRgDS9gIQjM+oaE5W
         pgXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lijun Ou <oulijun@huawei.com>,
	Yixian Liu <liuyixian@huawei.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 039/168] RDMA/hns: Update the usage of sr_max and rr_max field
Date: Wed, 11 Apr 2018 00:23:01 +0200
Message-Id: <20180410212801.854640922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399950157696347?=
X-GMAIL-MSGID: =?utf-8?q?1597399950157696347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: oulijun <oulijun@huawei.com>


[ Upstream commit 4f3f7a704b3bff9e4eb322ab3c989b505f7562eb ]

This patch fixes the usage with sr_max filed and rr_max of qp
context when modify qp. Its modifications include:
1. Adjust location of filling sr_max filed of qpc
2. Only assign the number of responder resource if
   IB_QP_MAX_DEST_RD_ATOMIC bit is set
3. Only assign the number of outstanding resource if
   IB_QP_MAX_QP_RD_ATOMIC
4. Fix the assgin algorithms for the field of sr_max
   and rr_max of qp context

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2463,11 +2463,14 @@ static int modify_qp_init_to_rtr(struct
 		roce_set_bit(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_LBI_S, 0);
 	}
 
-	roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
-		       V2_QPC_BYTE_140_RR_MAX_S,
-		       ilog2((unsigned int)attr->max_dest_rd_atomic));
-	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
-		       V2_QPC_BYTE_140_RR_MAX_S, 0);
+	if ((attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) &&
+	     attr->max_dest_rd_atomic) {
+		roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
+			       V2_QPC_BYTE_140_RR_MAX_S,
+			       fls(attr->max_dest_rd_atomic - 1));
+		roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
+			       V2_QPC_BYTE_140_RR_MAX_S, 0);
+	}
 
 	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_DQPN_M,
 		       V2_QPC_BYTE_56_DQPN_S, attr->dest_qp_num);
@@ -2557,12 +2560,6 @@ static int modify_qp_init_to_rtr(struct
 		       V2_QPC_BYTE_168_LP_SGEN_INI_M,
 		       V2_QPC_BYTE_168_LP_SGEN_INI_S, 0);
 
-	roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_SR_MAX_M,
-		       V2_QPC_BYTE_208_SR_MAX_S,
-		       ilog2((unsigned int)attr->max_rd_atomic));
-	roce_set_field(qpc_mask->byte_208_irrl, V2_QPC_BYTE_208_SR_MAX_M,
-		       V2_QPC_BYTE_208_SR_MAX_S, 0);
-
 	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
 		       V2_QPC_BYTE_28_SL_S, rdma_ah_get_sl(&attr->ah_attr));
 	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
@@ -2766,6 +2763,14 @@ static int modify_qp_rtr_to_rts(struct i
 	roce_set_field(qpc_mask->byte_196_sq_psn, V2_QPC_BYTE_196_SQ_MAX_PSN_M,
 		       V2_QPC_BYTE_196_SQ_MAX_PSN_S, 0);
 
+	if ((attr_mask & IB_QP_MAX_QP_RD_ATOMIC) && attr->max_rd_atomic) {
+		roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_SR_MAX_M,
+			       V2_QPC_BYTE_208_SR_MAX_S,
+			       fls(attr->max_rd_atomic - 1));
+		roce_set_field(qpc_mask->byte_208_irrl,
+			       V2_QPC_BYTE_208_SR_MAX_M,
+			       V2_QPC_BYTE_208_SR_MAX_S, 0);
+	}
 	return 0;
 }
 
