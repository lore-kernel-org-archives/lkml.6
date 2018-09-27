Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C154C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A59A2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV7ljj6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A59A2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeI1DRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:17:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38621 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:17:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so166475wmi.3;
        Thu, 27 Sep 2018 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/MCnOWG9uwP6deUpl1LXHp074WRmvmwLGHPGftzWtNw=;
        b=mV7ljj6/D04ms6W4K8VcQy3W+16/jbN17Sz0e+JLLu4PUdw0yfHz0Ktl94dgML9ePt
         VYa01DK/NwZBHWeyRDVsFhDZCH6FwwYpPBAvMVhJwczL18mxRVUs7XC5R3YwZJU28kJt
         4DfdPZEwTKWcuov/8HTJae8qtRI/6bjdjSecTQUJfcEtQ3RPevQBgxRHhnxulYJHfEee
         HMtFWbHKmlL8m4T1/ozxLFLJlHs6u15HfRL3/jMm0tRZ3nRSe2cCPu3FyhdHZo8zH8su
         HjLqFK+j++Z2ELfowCXdA2I+qUgKd3Dr2f9gMzPnoNh3fhXV1MX1WhI2KnicLtGYpE+g
         zUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/MCnOWG9uwP6deUpl1LXHp074WRmvmwLGHPGftzWtNw=;
        b=KSjKsZz5OQAUG48JOUzmEu7AcpSKNoY0iGCorD+YNLcrkhpJMiorAuMsiyvUCb1/LP
         U5I259reXPxej54J5iEsXddisC7P0XiO3RRcnJQc1t9e1pPoggylITPjWxtjD0mhPjd3
         YaNLuYTjLlO6UPkQLEAM0dPzSkV+m+U1GH7rQ9hWH8CA4El9IdyU3InDx6ksG3jDARrL
         JaqGn21jGdlDk6H/wz5tP0taftL+uRaue23GO0PgHVczGmNrGctMYcu2URFwWlMS8CP0
         kQPvmdIxBRgM7BzenBOsWX+0sfBnrHJlwxUINpoJT49+Gb1NbiIn3G5ZfEofGiBHlWh3
         atUg==
X-Gm-Message-State: ABuFfoiivoeM5NKvNwlV7aRl9DblbIw9YiapXo3ANGX/3SCaZMdAdvwr
        UAlwW3O3eDIDLWi/62qkgkE=
X-Google-Smtp-Source: ACcGV623lFMF7xzQXNsRPIByIr0YBivwPVM4LgY9tCEkcZuqp47qmXSV2LAIyXwsm2dPtpK8oIyLwQ==
X-Received: by 2002:a1c:dac7:: with SMTP id r190-v6mr198351wmg.137.1538081826076;
        Thu, 27 Sep 2018 13:57:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u23-v6sm4215886wrc.42.2018.09.27.13.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:57:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] RDMA/qedr: Remove enumerated type qed_roce_ll2_tx_dest
Date:   Thu, 27 Sep 2018 13:55:58 -0700
Message-Id: <20180927205557.32026-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927011820.13608-1-natechancellor@gmail.com>
References: <20180927011820.13608-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is explicitly converted to another.

drivers/infiniband/hw/qedr/qedr_roce_cm.c:198:28: warning: implicit
conversion from enumeration type 'enum qed_roce_ll2_tx_dest' to
different enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
        ll2_tx_pkt.tx_dest = pkt->tx_dest;
                           ~ ~~~~~^~~~~~~
1 warning generated.

Turns out that QED_ROCE_LL2_TX_DEST_NW and QED_ROCE_LL2_TX_DEST_LB are
only used once in the whole tree and QED_ROCE_LL2_TX_DEST_MAX is used
nowhere. Remove them and use the equivalent values from qed_ll2_tx_dest
in their place.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Rather than using an explicit cast, just convert the uses to the
  appropriate values and delete the duplicated enum.

 drivers/infiniband/hw/qedr/qedr_roce_cm.c |  4 ++--
 include/linux/qed/qed_rdma_if.h           | 11 +----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
index 85578887421b..e1ac2fd60bb1 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -519,9 +519,9 @@ static inline int qedr_gsi_build_packet(struct qedr_dev *dev,
 	}
 
 	if (ether_addr_equal(udh.eth.smac_h, udh.eth.dmac_h))
-		packet->tx_dest = QED_ROCE_LL2_TX_DEST_LB;
+		packet->tx_dest = QED_LL2_TX_DEST_LB;
 	else
-		packet->tx_dest = QED_ROCE_LL2_TX_DEST_NW;
+		packet->tx_dest = QED_LL2_TX_DEST_NW;
 
 	packet->roce_mode = roce_mode;
 	memcpy(packet->header.vaddr, ud_header_buffer, header_size);
diff --git a/include/linux/qed/qed_rdma_if.h b/include/linux/qed/qed_rdma_if.h
index df4d13f7e191..d15f8e4815e3 100644
--- a/include/linux/qed/qed_rdma_if.h
+++ b/include/linux/qed/qed_rdma_if.h
@@ -39,15 +39,6 @@
 #include <linux/qed/qed_ll2_if.h>
 #include <linux/qed/rdma_common.h>
 
-enum qed_roce_ll2_tx_dest {
-	/* Light L2 TX Destination to the Network */
-	QED_ROCE_LL2_TX_DEST_NW,
-
-	/* Light L2 TX Destination to the Loopback */
-	QED_ROCE_LL2_TX_DEST_LB,
-	QED_ROCE_LL2_TX_DEST_MAX
-};
-
 #define QED_RDMA_MAX_CNQ_SIZE               (0xFFFF)
 
 /* rdma interface */
@@ -581,7 +572,7 @@ struct qed_roce_ll2_packet {
 	int n_seg;
 	struct qed_roce_ll2_buffer payload[RDMA_MAX_SGE_PER_SQ_WQE];
 	int roce_mode;
-	enum qed_roce_ll2_tx_dest tx_dest;
+	enum qed_ll2_tx_dest tx_dest;
 };
 
 enum qed_rdma_type {
-- 
2.19.0

