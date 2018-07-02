Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D067FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A31425C38
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saczxlD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A31425C38
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeGBVDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:03:01 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:32772 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeGBVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:03:00 -0400
Received: by mail-qk0-f201.google.com with SMTP id j189-v6so18075958qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=BehkCuOEOmmlpKtkCglP7vVPMQq/4eUyR2IGQHQpdsQ=;
        b=saczxlD7LczlogxB8lqT2XYDb1MIBCcg2XM1LFpPiU3PAcbCgatmkuWK4bIZkiBclj
         rxzDa7+3j29wayhr87ioPZN2hze+9FZGPpfrhaFnbGwuI/BYSqJQwC7ZdrgDZ+XENr6T
         cJek0UdzGH33A/q67vikiWgam4Yn5ZDsWsA0AYzFJz6jfkLImHTjTu4VgoHd+eks6M+M
         AkouUhVylLWxyKDCGo4mIxMHdSBH+tfYPooQHuvBLGCMBSUmY2pmKdps6NEDfAbDnWZN
         3CEn1er9wNOMNHzsPGHIoNcjWZFwz0+OGMw44d1ueLZnPFI2ncbE/Usrv/uVev8waAc8
         jKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=BehkCuOEOmmlpKtkCglP7vVPMQq/4eUyR2IGQHQpdsQ=;
        b=TBUX01czQ/yB5XrfMH+CBlD2xB069OXafIqYlLOsfDsLYBcB6520AMp/+PkxQhQleL
         B0BmDdcEEkx3rIUI58oBKU7Oa9EHQArUkOKwW9TbqEHWJyCg1gnvWDDa6STwop2bws4r
         q/8zK+5yhmEPorHihQSU7ABOhQuelBS2vzQSsDEi5LYNc2ZznGwlZH4nt5sIysP3qgDn
         QYKlslLNqlzoKdBYQq46i9q+GmDvaWXlZa6EoeYlsUr+PAtJMO1sZXfVsJ2j7OGb5PB+
         wAD7unllspMbdCC6V27E41+3uJE8s8N5XYyYrxH7UC40w0KvsDnD8LqDFpEO0hN8AQ9J
         AUzA==
X-Gm-Message-State: APt69E0ks0ex4f+JCceHA00XTj99urc3FF7NAF+6mrrc4D7HukoX95pF
        Y0FcLcucwM+mzVkWHmDPNaFuQxlMFA==
X-Google-Smtp-Source: AAOMgpcoETQckKUwWjuGWRAeqR5ncB7ZZmSN3WsdkXPuUuIWh8v0KNWKQjYRVEkPphpEA9/kBFmELu5yQCM=
MIME-Version: 1.0
X-Received: by 2002:ac8:c85:: with SMTP id n5-v6mr14595604qti.60.1530565379282;
 Mon, 02 Jul 2018 14:02:59 -0700 (PDT)
Date:   Mon,  2 Jul 2018 14:02:34 -0700
Message-Id: <20180702210234.107361-1-tarick@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] IB/mlx4: Test port number before querying type.
From:   Tarick Bedeir <tarick@google.com>
To:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     edumazet@google.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tarick Bedeir <tarick@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdma_ah_find_type() can reach into ib_device->port_immutable with a
potentially out-of-bounds port number, so check that the port number is
valid first.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Tarick Bedeir <tarick@google.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index f045491f2c14..4f1dabecf9a5 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4034,9 +4034,9 @@ static void to_rdma_ah_attr(struct mlx4_ib_dev *ibdev,
 	u8 port_num = path->sched_queue & 0x40 ? 2 : 1;
 
 	memset(ah_attr, 0, sizeof(*ah_attr));
-	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
 	if (port_num == 0 || port_num > dev->caps.num_ports)
 		return;
+	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE)
 		rdma_ah_set_sl(ah_attr, ((path->sched_queue >> 3) & 0x7) |
-- 
2.18.0.399.gad0ab374a1-goog

