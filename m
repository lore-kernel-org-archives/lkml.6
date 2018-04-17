Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeDQBw4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 21:52:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeDQBwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 21:52:55 -0400
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Matan Barak <matanb@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] infiniband: mlx5: fix build errors when
 INFINIBAND_USER_ACCESS=m
Message-ID: <aa0dd9f7-3475-c2b3-8d5c-032a7ad72fe9@infradead.org>
Date: Mon, 16 Apr 2018 18:51:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when INFINIBAND_USER_ACCESS=m and MLX5_INFINIBAND=y.
The build error occurs when the mlx5 driver code attempts to use
USER_ACCESS interfaces, which are built as a loadable module.

Fixes these build errors:

drivers/infiniband/hw/mlx5/main.o: In function `populate_specs_root':
../drivers/infiniband/hw/mlx5/main.c:4982: undefined reference to `uverbs_default_get_objects'
../drivers/infiniband/hw/mlx5/main.c:4994: undefined reference to `uverbs_alloc_spec_tree'
drivers/infiniband/hw/mlx5/main.o: In function `depopulate_specs_root':
../drivers/infiniband/hw/mlx5/main.c:5001: undefined reference to `uverbs_free_spec_tree'

Build-tested with multiple config combinations.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matan Barak <matanb@mellanox.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org # reported against 4.16
---
v2: allow building mxl5 even when INFINIBAND_USER_ACCESS is disabled.

 drivers/infiniband/hw/mlx5/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-417-rc1.orig/drivers/infiniband/hw/mlx5/Kconfig
+++ lnx-417-rc1/drivers/infiniband/hw/mlx5/Kconfig
@@ -1,6 +1,7 @@
 config MLX5_INFINIBAND
 	tristate "Mellanox Connect-IB HCA support"
 	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE
+	depends on INFINIBAND_USER_ACCESS || INFINIBAND_USER_ACCESS=n
 	---help---
 	  This driver provides low-level InfiniBand support for
 	  Mellanox Connect-IB PCI Express host channel adapters (HCAs).
