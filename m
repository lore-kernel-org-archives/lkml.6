Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F82C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC33206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC33206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbeJBURl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbeJBURk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:40 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E6B5B2F;
        Tue,  2 Oct 2018 13:34:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 105/137] IB/hfi1: Fix SL array bounds check
Date:   Tue,  2 Oct 2018 06:25:06 -0700
Message-Id: <20181002132505.839767214@linuxfoundation.org>
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

From: Ira Weiny <ira.weiny@intel.com>

commit 0dbfaa9f2813787679e296eb5476e40938ab48c8 upstream.

The SL specified by a user needs to be a valid SL.

Add a range check to the user specified SL value which protects from
running off the end of the SL to SC table.

CC: stable@vger.kernel.org
Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/verbs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1573,6 +1573,7 @@ static int hfi1_check_ah(struct ib_devic
 	struct hfi1_pportdata *ppd;
 	struct hfi1_devdata *dd;
 	u8 sc5;
+	u8 sl;
 
 	if (hfi1_check_mcast(rdma_ah_get_dlid(ah_attr)) &&
 	    !(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH))
@@ -1581,8 +1582,13 @@ static int hfi1_check_ah(struct ib_devic
 	/* test the mapping for validity */
 	ibp = to_iport(ibdev, rdma_ah_get_port_num(ah_attr));
 	ppd = ppd_from_ibp(ibp);
-	sc5 = ibp->sl_to_sc[rdma_ah_get_sl(ah_attr)];
 	dd = dd_from_ppd(ppd);
+
+	sl = rdma_ah_get_sl(ah_attr);
+	if (sl >= ARRAY_SIZE(ibp->sl_to_sc))
+		return -EINVAL;
+
+	sc5 = ibp->sl_to_sc[sl];
 	if (sc_to_vlt(dd, sc5) > num_vls && sc_to_vlt(dd, sc5) != 0xf)
 		return -EINVAL;
 	return 0;


