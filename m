Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAC9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F22206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F22206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbeGPIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:09:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388675AbeGPIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:09:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED252C03;
        Mon, 16 Jul 2018 07:43:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 31/32] RDMA/ucm: Mark UCM interface as BROKEN
Date:   Mon, 16 Jul 2018 09:36:39 +0200
Message-Id: <20180716073508.329161069@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 7a8690ed6f5346f6738971892205e91d39b6b901 upstream.

In commit 357d23c811a7 ("Remove the obsolete libibcm library")
in rdma-core [1], we removed obsolete library which used the
/dev/infiniband/ucmX interface.

Following multiple syzkaller reports about non-sanitized
user input in the UCMA module, the short audit reveals the same
issues in UCM module too.

It is better to disable this interface in the kernel,
before syzkaller team invests time and energy to harden
this unused interface.

[1] https://github.com/linux-rdma/rdma-core/pull/279

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/Kconfig       |   12 ++++++++++++
 drivers/infiniband/core/Makefile |    4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -34,6 +34,18 @@ config INFINIBAND_USER_ACCESS
 	  libibverbs, libibcm and a hardware driver library from
 	  <http://www.openfabrics.org/git/>.
 
+config INFINIBAND_USER_ACCESS_UCM
+	bool "Userspace CM (UCM, DEPRECATED)"
+	depends on BROKEN
+	depends on INFINIBAND_USER_ACCESS
+	help
+	  The UCM module has known security flaws, which no one is
+	  interested to fix. The user-space part of this code was
+	  dropped from the upstream a long time ago.
+
+	  This option is DEPRECATED and planned to be removed.
+
+
 config INFINIBAND_USER_MEM
 	bool
 	depends on INFINIBAND_USER_ACCESS != n
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -4,8 +4,8 @@ user_access-$(CONFIG_INFINIBAND_ADDR_TRA
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_cm.o iw_cm.o \
 					$(infiniband-y)
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
-obj-$(CONFIG_INFINIBAND_USER_ACCESS) +=	ib_uverbs.o ib_ucm.o \
-					$(user_access-y)
+obj-$(CONFIG_INFINIBAND_USER_ACCESS) += ib_uverbs.o $(user_access-y)
+obj-$(CONFIG_INFINIBAND_USER_ACCESS_UCM) += ib_ucm.o $(user_access-y)
 
 ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o fmr_pool.o cache.o netlink.o \


