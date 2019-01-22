Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF42217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170286;
	bh=LaoHT6t+6I0t7Au4X+40xRIvevMG8hhY615BAZGLV2Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CHetT75+mP3cGPopsBFy2FciyghEhACxi9Kq9I/6achduPt/KwXL2p8sKgfRg90oi
	 onroIwODwXq8PPqN/0AP9U0NsqPOyYN1hZ4YzazHcsq8RFbrvITQeOgYBTurPYN6Rr
	 UA7qain4w6Gr8MWwnPFDOM5KmgIgbXhFj4ZyIGFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfAVPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfAVPSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BDF620879;
        Tue, 22 Jan 2019 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170283;
        bh=LaoHT6t+6I0t7Au4X+40xRIvevMG8hhY615BAZGLV2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=vGlcuhwOz8J2N9NOcBDXMbOVULui8WXB8761qdpWCHIKY2r3zYEwaTZn1nQaCTKXr
         f+MIVkApJFLQaMjoFfxajnVBgA384Altyknn7T1BRbfF/VAK/orW9NmpyuaOy0zAkx
         2yDjCVCNsTpE2TBZUr9lEYqwQmTTCklLJ3VuCZgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/8] IB: cleanup debugfs usage
Date:   Tue, 22 Jan 2019 16:17:52 +0100
Message-Id: <20190122151800.15092-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs code, there is no need to ever check the return
value of the call, as no logic should ever change if a call works
properly or not.  Fix up a bunch of infiniband-specific code to not care
about the results of debugfs.

Greg Kroah-Hartman (8):
  infiniband: cxgb4: no need to check return value of debugfs_create functions
  infiniband: hfi1: drop crazy DEBUGFS_SEQ_FILE_CREATE() macro
  infiniband: hfi1: no need to check return value of debugfs_create functions
  infiniband: qib: no need to check return value of debugfs_create functions
  infiniband: mlx5: no need to check return value of debugfs_create functions
  infiniband: ocrdma: no need to check return value of debugfs_create functions
  infiniband: usnic: no need to check return value of debugfs_create functions
  infiniband: ipoib: no need to check return value of debugfs_create functions

 drivers/infiniband/hw/cxgb4/device.c        |  8 +--
 drivers/infiniband/hw/hfi1/debugfs.c        | 52 +++++++---------
 drivers/infiniband/hw/hfi1/debugfs.h        | 12 ----
 drivers/infiniband/hw/hfi1/fault.c          | 53 ++++++----------
 drivers/infiniband/hw/mlx5/cong.c           | 15 ++---
 drivers/infiniband/hw/mlx5/main.c           |  8 +--
 drivers/infiniband/hw/mlx5/mlx5_ib.h        |  8 +--
 drivers/infiniband/hw/mlx5/mr.c             | 51 +++-------------
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 67 +++++++--------------
 drivers/infiniband/hw/qib/qib_debugfs.c     | 26 +++-----
 drivers/infiniband/hw/usnic/usnic_debugfs.c | 26 --------
 drivers/infiniband/ulp/ipoib/ipoib.h        |  4 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c     |  7 +--
 drivers/infiniband/ulp/ipoib/ipoib_main.c   |  4 +-
 14 files changed, 94 insertions(+), 247 deletions(-)

-- 
2.20.1

