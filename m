Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeBWNQD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:16:03 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52811 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeBWNQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:16:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Arkadi Sharshevsky <arkadis@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH 2/2] mlxsw: spectrum_kvdl: avoid uninitialized variable warning
Date: Fri, 23 Feb 2018 14:15:32 +0100
Message-Id: <20180223131540.1065413-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180223131540.1065413-1-arnd@arndb.de>
References: <20180223131540.1065413-1-arnd@arndb.de>
X-Provags-ID: V03:K0:5tE+at3L2r/OxIBtc2gUVbMk3eZuqPOmENWlSIq+RaWHUaPWjDL
 7XrH3l5XdM6hWRy0uwDiv49YO3NCvD7qXit+wjf/0hYudbzfcKyEjvua94rvFIRbblfPc/8
 kL12JXWxew7RX7qTwFJ0mPh5CxdZ6ffkPW6CeX8jwyJEh+tEe+rngLzThzAAPzf0z7zouUP
 76AztMtD/H0axLF2sg1KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LOGF/6oN0UE=:bbpFSrnGP08TqsrgSkibes
 li66B1ijPwexIl6KKjTJ0xeHe7JeGW5fOncNUdHCMcQj1IZN6DlQW4yxDndCPhfOt4OT8GltO
 muV4V5nX8ljgE2aZJJixpkQJ/3bLX1VCWhRpOs4EUgaMH87L5emKN09amA/1EaeKW4zz+KH25
 uorr6mpBk82SxgGwl6URgZdb2ZnrAinMw9FeopWCzUT2AiyhrN/roQvU/xxf5nSdk/tJZk22z
 RlrI7Db5Os7oe3flzrY9djQvfa47gmjiWqOYUiWNUY0ZW89WoSNz6eKd5NAmtMlbd4V+YOq0x
 781qanyKEFhG3/P6tdTLOYb9POeJvc3NbFrFPD+eClwgIqomLrBd0EE4/zcX0PW6II3iEvqFj
 z++khdTxwgXspkL77mHamuksRMLTsKN6gAW/SeSNGbDsFZhHa1X5hYR4fqP4AJjSR1Q04r1dS
 xaTKYqgOlip7XOfzq0LqwviK/Pngx0AfH/lIjMGLiEuvkpQMr1a1VeokfyJolx4MDq0/cM+63
 lfvp9TFHtRvzh2693QzpuWzMYI1xNuSBwRF3GQRJ+GjnCTGhWhy1fsXE46xIkGSjzE8k5KUM8
 S5vLLX8J/9vjowGw5XMDgycPcEOCsIyBu39FoLgENxD6+eIzRkDPqQtRTFhbFkFAd/ct6OamT
 4MWRKtCdF7CSaMCd2G40XTr039eODgaUgb3CJie+FVgajE/fyDF8JxTGvJJwTcgwHOl6sRN8i
 JKrQdlM4psS6AH1t8nkYVUjPbyuy0lRBB0ElxQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns that 'resource_id' is not initialized if we don't come though
any of the three 'case' statements before:

drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c: In function 'mlxsw_sp_kvdl_part_init':
drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c:275:8: error: 'resource_id' may be used uninitialized in this function [-Werror=maybe-uninitialized]

In the current code, that won't happen, but it's more robust to explicitly
handle this by returning a failure from mlxsw_sp_kvdl_part_init.

Fixes: 887839e6960d ("mlxsw: spectrum_kvdl: Add support for dynamic partition set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
index 6fd701db90c9..059eb3214328 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
@@ -270,6 +270,8 @@ static int mlxsw_sp_kvdl_part_init(struct mlxsw_sp *mlxsw_sp,
 	case MLXSW_SP_KVDL_PART_LARGE_CHUNKS:
 		resource_id = MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	err = devlink_resource_size_get(devlink, resource_id, &resource_size);
-- 
2.9.0
