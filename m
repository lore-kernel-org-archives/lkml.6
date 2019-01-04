Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474DBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081552070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIoftdq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfADGpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:45:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40504 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfADGpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:45:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so17000920plq.7;
        Thu, 03 Jan 2019 22:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LMUV/4YjWMvaS8Ac79zbRsjMFRoDchIM77+L6GMHAPo=;
        b=UIoftdq2t2r//NFdUy9J8kOrncKjZ0CiqmXSiPAkz8+FR7vLVoZN4OFkdFvtf0f2GT
         G5D3tZ6z55z1M88OFcG1bZdGYNcG9SpnyWAKPUpk/lyvW7qHp23jncXpI8KoL5XSyqRH
         yvXS7OPfdWbWgjXC7EbOlsY7l974pE8aa0Gm0BFZWCJDjqwYaDxnyAveW4FRYH3WaOkU
         XrlpCyYhKvy1dy0aGpyt23C9nxHA6sKsYlMgSUGotL1BKBmJ1tCZvCimIt4OAVNOnTbn
         lUfPVI37qmkhZxospPGjNUdyPH2xMQScQFthUGrZ6QK/BzvLwQiMcz8gUyxXMA7hIT/0
         q++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LMUV/4YjWMvaS8Ac79zbRsjMFRoDchIM77+L6GMHAPo=;
        b=Winj5+XnaysnC21lxCDK7ZF5WWoVSkQjDCEnrMjPTuABLUdLu7PWb4ec1yiQoeOH3K
         R1/xlm9NtGJk/pLWnOWOU23YsiiYKASwdDmsWOJ6cD6XHDlZgODSs8qoicwFS70BQRzM
         fJBD6ExgZWPbe4YF6gv+U1u5/ncneTyRbnLYOfpAX1nSsqH3Jonu8oCK1oZNCIhZ7MpE
         sGqI2qvqhCmPWddVJEoa5OnYBB9FGNvtRdi85iA/EFQx52fTrpGCDx7OsPD7Chpk3LJg
         GOoPAp+uxlYyU1F0SpTASic+8uhGBOj5ZaMJ0cblHB3J+jaGANqf/WRG71oD4O3awP/7
         /qtw==
X-Gm-Message-State: AJcUuke3+4MtEy2FCDjyj3oxxU06RZ7V5RSrbPEkYDy9qF74E/fqyR+Z
        NTdh5GM4lMuRZWqaBP+D1Rc=
X-Google-Smtp-Source: ALg8bN7VmqOdxc+nUIqaHT/gfKv5+mZ6BERJ8yJ2661KlSTUFQh7+JanSdUcX/LcGMLaWRfqOSb/Cw==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr48152325pla.144.1546584343551;
        Thu, 03 Jan 2019 22:45:43 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id x19sm98142138pfk.14.2019.01.03.22.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 22:45:43 -0800 (PST)
Date:   Thu, 3 Jan 2019 22:45:40 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/cma: Rollback source IP address if failing to acquire
 device
Message-ID: <20190104064537.GA352@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cma_acquire_dev_by_src_ip() returns error in addr_handler(), the
device state changes back to RDMA_CM_ADDR_BOUND but the resolved source
IP address is still left. After that, if rdma_destroy_id() is called
after rdma_listen(), the device is freed without removed from
listen_any_list in cma_cancel_operation(). Revert to the previous IP
address if acquiring device fails.

Reported-by: syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/infiniband/core/cma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 63a7cc00bae0..d27c3b154e71 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2963,13 +2963,17 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 {
 	struct rdma_id_private *id_priv = context;
 	struct rdma_cm_event event = {};
+	struct sockaddr *addr;
+	struct sockaddr_storage old_addr;
 
 	mutex_lock(&id_priv->handler_mutex);
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY,
 			   RDMA_CM_ADDR_RESOLVED))
 		goto out;
 
-	memcpy(cma_src_addr(id_priv), src_addr, rdma_addr_size(src_addr));
+	addr = cma_src_addr(id_priv);
+	memcpy(&old_addr, addr, rdma_addr_size(addr));
+	memcpy(addr, src_addr, rdma_addr_size(src_addr));
 	if (!status && !id_priv->cma_dev) {
 		status = cma_acquire_dev_by_src_ip(id_priv);
 		if (status)
@@ -2980,6 +2984,8 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 	}
 
 	if (status) {
+		memcpy(addr, &old_addr,
+		       rdma_addr_size((struct sockaddr *)&old_addr));
 		if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED,
 				   RDMA_CM_ADDR_BOUND))
 			goto out;
-- 
2.17.1

