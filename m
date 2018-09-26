Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46798C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4F2173A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F4F2173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeI0BwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:52:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeI0BwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:52:01 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKbc2-1gLfTj32M8-00KyOQ; Wed, 26 Sep 2018 21:37:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Shaobo Xu <xushaobo2@huawei.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA: fix dependencies for rdma_user_mmap_io
Date:   Wed, 26 Sep 2018 21:36:52 +0200
Message-Id: <20180926193706.2447532-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:+vRyNR1nIKmd26OTzp2PhY+zAVub2P5w/v0nK8D5aalyoPp0GMe
 0HhYVPRbs8RMWMYegoAJ+p2Fk9wGUqwTKTFO9cz6Dc7pxbEAB+Vp9gim7l3ZN/Rimw/2clD
 QIhSLZy7MRoGxfavDD2G0xCvMIS9G0L7KEAgXVLwdlCuI95+iDnpx6c9AlK87/6+LIpxUdW
 Y62gROiE9kytXUv05SiiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4XvGftH8zU8=:VWRaC7XUo4RLRKWYyPcWAB
 Jhfzu0CaAvaDWXnRm+Sk3O4wtZZVS/+BP21ltKY25Ym9lBlHOMadGPjaeH6UgEVD9a9bcnJYK
 NulcqRhYng4tYIQU1OedLZLpCRm7ZG5vUdmhiQdkjHt8qCNloIk46H9FgOJcnFoHYszc2WkGb
 zB+4jb2tf/Wyfxwn9F+JfpaPHtTIv4WXeViWCw5NMDlqRxexcDNODbgpKR0u/c51Y++uvGUJd
 VS7YdrPk2MdluE/MbL1rfq5CyI6gjKPbHANIM3TsPBiyZMyjxdT5dSp4tyqv5zHQ56juIisBW
 Pgp2bk13/PkaLY7mSy50Ps4wyP8gy7KGzSvYCVK3Nva8tfQHKkFHSmLNnDE3td1H8MEQwNTFi
 beHv8vntcDlB+2YW5KPVVPFZr0wrHIyPRtiB+Tf3XcArmzkf8iG4O6ZiEz3J/TwpNWmhBcEuw
 y09r01uhyNSGyHNAyBnjXbtURPqanRQZUjmN3eD8qSEzMaTeUDplmgpwOHxT2Jp9jnz8JlvTx
 DGJ5oyNza+YAElTMIU85ePcQBpfIRf8YU5s/c8w0l7/STpmDj59RW8o5/7/V/Khdt2pQaHOQj
 /VnzVW/JviRn+Lj7z0DrgcEEhNp28r5ejmwl/3e16H3hOOpK43QKI1gfQW1Go7GerdJsmov/M
 c+1eLsrvav5sFJzVmx8eURkOyYqAfwpdNYmhBlwXNspWx89HLsKgSuBowUqPkv6SK734=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mlx4 driver produces a link error when it is configured
as built-in while CONFIG_INFINIBAND_USER_ACCESS is set to =m:

drivers/infiniband/hw/mlx4/main.o: In function `mlx4_ib_mmap':
main.c:(.text+0x1af4): undefined reference to `rdma_user_mmap_io'

The same function is called from mlx5, which already has a
dependency to ensure we can call it, and from hns, which
appears to suffer from the same problem.

This adds the same dependency that mlx5 uses to the other two.

Fixes: 6745d356ab39 ("RDMA/hns: Use rdma_user_mmap_io")
Fixes: c282da4109e4 ("RDMA/mlx4: Use rdma_user_mmap_io")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/hns/Kconfig  | 1 +
 drivers/infiniband/hw/mlx4/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index fddb5fdf92de..21c2100b2ea9 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -1,6 +1,7 @@
 config INFINIBAND_HNS
 	tristate "HNS RoCE Driver"
 	depends on NET_VENDOR_HISILICON
+	depends on INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	---help---
 	  This is a RoCE/RDMA driver for the Hisilicon RoCE engine. The engine
diff --git a/drivers/infiniband/hw/mlx4/Kconfig b/drivers/infiniband/hw/mlx4/Kconfig
index db4aa13ebae0..d1de3285fd88 100644
--- a/drivers/infiniband/hw/mlx4/Kconfig
+++ b/drivers/infiniband/hw/mlx4/Kconfig
@@ -1,6 +1,7 @@
 config MLX4_INFINIBAND
 	tristate "Mellanox ConnectX HCA support"
 	depends on NETDEVICES && ETHERNET && PCI && INET
+	depends on INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 	depends on MAY_USE_DEVLINK
 	select NET_VENDOR_MELLANOX
 	select MLX4_CORE
-- 
2.18.0

