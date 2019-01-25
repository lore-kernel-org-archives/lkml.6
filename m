Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A97EC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618CF218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Df6cDEx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfAYElN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:41:13 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53530 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfAYElM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:41:12 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0P4dtwY005225;
        Fri, 25 Jan 2019 13:39:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0P4dtwY005225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548391199;
        bh=sYPXqy9zti+00fd+MuJO2yCy2ff9Xfu+cf+PJFW+VJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Df6cDEx4L2fWprRCY5Pl3W5YMiFirN+Ge1+/1AgtoqpmALIVs7HROKA3f8Fd73rT/
         sxGSvPCBU6MlHDM1yok9XDSZi3WbVOdZrvk0J56HQ4e97MwJsfQfInCjHoXcf94xKF
         +orzFDd/OSpgN9KfKM4jVY95dABg7dGnk9DvImwdEQDmLyA54jrfadxltiFxpvAOUV
         FQooZj79ZokGjiliefIN7dWwn19+8A943fAcXd2GCjUbCNqAhwfi3+6tHH90asziIH
         3zMKvYdkHCnKfXxLXw0TlSH6agSDpD+Zj0Du0iEPEeBRbg01tDf6XCfwkvccqLCGOK
         HULoLSo+7nb5g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        Steve Wise <swise@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH 2/2] infiniband: prefix header search paths with $(srctree)/
Date:   Fri, 25 Jan 2019 13:39:31 +0900
Message-Id: <1548391171-6407-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/infiniband/hw/bnxt_re/Makefile | 2 +-
 drivers/infiniband/hw/cxgb3/Makefile   | 2 +-
 drivers/infiniband/hw/cxgb4/Makefile   | 4 ++--
 drivers/infiniband/hw/hns/Makefile     | 2 +-
 drivers/infiniband/hw/i40iw/Makefile   | 2 +-
 drivers/infiniband/hw/ocrdma/Makefile  | 2 +-
 drivers/infiniband/hw/usnic/Makefile   | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/Makefile b/drivers/infiniband/hw/bnxt_re/Makefile
index 6e3bc25..ee9bb1b 100644
--- a/drivers/infiniband/hw/bnxt_re/Makefile
+++ b/drivers/infiniband/hw/bnxt_re/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-ccflags-y := -Idrivers/net/ethernet/broadcom/bnxt
+ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnxt
 obj-$(CONFIG_INFINIBAND_BNXT_RE) += bnxt_re.o
 bnxt_re-y := main.o ib_verbs.o \
 	     qplib_res.o qplib_rcfw.o	\
diff --git a/drivers/infiniband/hw/cxgb3/Makefile b/drivers/infiniband/hw/cxgb3/Makefile
index 66fe091..34bb86a 100644
--- a/drivers/infiniband/hw/cxgb3/Makefile
+++ b/drivers/infiniband/hw/cxgb3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -Idrivers/net/ethernet/chelsio/cxgb3
+ccflags-y := -I $(srctree)/drivers/net/ethernet/chelsio/cxgb3
 
 obj-$(CONFIG_INFINIBAND_CXGB3) += iw_cxgb3.o
 
diff --git a/drivers/infiniband/hw/cxgb4/Makefile b/drivers/infiniband/hw/cxgb4/Makefile
index 9edd920..31a87d9 100644
--- a/drivers/infiniband/hw/cxgb4/Makefile
+++ b/drivers/infiniband/hw/cxgb4/Makefile
@@ -1,5 +1,5 @@
-ccflags-y := -Idrivers/net/ethernet/chelsio/cxgb4
-ccflags-y += -Idrivers/net/ethernet/chelsio/libcxgb
+ccflags-y := -I $(srctree)/drivers/net/ethernet/chelsio/cxgb4
+ccflags-y += -I $(srctree)/drivers/net/ethernet/chelsio/libcxgb
 
 obj-$(CONFIG_INFINIBAND_CXGB4) += iw_cxgb4.o
 
diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index 004c88b..e2a7f14 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the Hisilicon RoCE drivers.
 #
 
-ccflags-y :=  -Idrivers/net/ethernet/hisilicon/hns3
+ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
 obj-$(CONFIG_INFINIBAND_HNS) += hns-roce.o
 hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
diff --git a/drivers/infiniband/hw/i40iw/Makefile b/drivers/infiniband/hw/i40iw/Makefile
index 5a8a7a3..8942f82 100644
--- a/drivers/infiniband/hw/i40iw/Makefile
+++ b/drivers/infiniband/hw/i40iw/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y :=  -Idrivers/net/ethernet/intel/i40e
+ccflags-y :=  -I $(srctree)/drivers/net/ethernet/intel/i40e
 
 obj-$(CONFIG_INFINIBAND_I40IW) += i40iw.o
 
diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infiniband/hw/ocrdma/Makefile
index d1bfd4f..e3f20ca 100644
--- a/drivers/infiniband/hw/ocrdma/Makefile
+++ b/drivers/infiniband/hw/ocrdma/Makefile
@@ -1,4 +1,4 @@
-ccflags-y := -Idrivers/net/ethernet/emulex/benet
+ccflags-y := -I $(srctree)/drivers/net/ethernet/emulex/benet
 
 obj-$(CONFIG_INFINIBAND_OCRDMA)	+= ocrdma.o
 
diff --git a/drivers/infiniband/hw/usnic/Makefile b/drivers/infiniband/hw/usnic/Makefile
index 94ae7a1..f12a493 100644
--- a/drivers/infiniband/hw/usnic/Makefile
+++ b/drivers/infiniband/hw/usnic/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -Idrivers/net/ethernet/cisco/enic
+ccflags-y := -I $(srctree)/drivers/net/ethernet/cisco/enic
 
 obj-$(CONFIG_INFINIBAND_USNIC)+= usnic_verbs.o
 
-- 
2.7.4

