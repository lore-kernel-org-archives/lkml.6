Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeBWNQA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:16:00 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:35797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWNP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:15:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Arkadi Sharshevsky <arkadis@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH 1/2] mlxsw: spectrum_kvdl: use div_u64() for 64-bit division
Date: Fri, 23 Feb 2018 14:15:31 +0100
Message-Id: <20180223131540.1065413-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:oQgd2ylLPcq/v1LKdIP9kk2CkWxRUpxc0Y2CL9ZKRRNDkcFwZJ7
 3bzxmI/3M13FjdJ+yE++nmRZD4lP5LYM2HkW9tFlhEwCe49n8zrDEL9IId9YgdfysHhqwX2
 2Xya5WwY+A0gs16h0maZ6U8AftDPQTy/sdD+MNjaNGLitnD2c+5RHIOaeYkTFxQlM9toGAm
 6npCfMeHYdpyCFkHI0FXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lMfKzRS7n5I=:3Ea98XO4r5qotC3VoaSrfg
 wbncFagmKnK8cmgjMmg4F+LxYe0KsUXh0ycwDqUhRxt9cGxQTw2iv8u5wA424q+jBMveWabca
 2/U2zufssuMRP0mma7gDNTGJYb1W7Cmo1NdAMGyKdJIeE9qTo6HqlmM/mUfGBJyxd2LXCL2nu
 z7iducm79AmFmIW6wRUYRubGhWLDlk+pVIZm/TkzjbfBXcnPny7q4nTZpBH7tdIiaq0Dkle4b
 kbEU4TtH8fNsrpytsNVZHij/9GbS4rhTRN39KEiXW7vWJJv2uXXkp8mXjpgbVZvYWUUUUWMgb
 P82JaPT9W/MxJCilyggEXfgH2sQTnEEOcCnLo0rVXATrJd9YRtNjqg6SkDoY+vKJ7Bkn4xhYI
 PnVPJ5pGSOfJyrAuPNu0/L2uVwZvpeDMeYGU0716hRU7hiqmJQq2NFLoNAp4g6EzUDm1n0DDQ
 WenxbQER72aNWpRQ8VUHscDMfBJURYAF9AWHxAFlhNhxdYjslQ3wgD2kSHqPuqZvxoXXTF+p8
 zG5xM8BRwXyETXiDQpsZ9GJVwsh1q/STZ1taayMjjLv1j3ogja+R0SSJlyuRPoZb1J2tK6LmY
 /Er6ZBFOng/TvJgBp8zrZDHQMEw08ZHR/0rPtprd2Rl65XwGOQf6FHvMUUEk52k3Y3BJEzLZ+
 Mco0s9BvNeM2nYp2aWXQlm+wh7bpl72ZnOZHBRbVmUTY2Sot3WB9iYuo8v8ZQ5BgX0tmu/2Ou
 rArcInFvHf6fFU9quBGaEjj3/XT4T6hk8EoGKw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculating the number of entries now uses 64-bit arithmetic that
causes a link error on 32-bit architectures:

drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.o: In function `mlxsw_sp_kvdl_init':
spectrum_kvdl.c:(.text+0x51c): undefined reference to `__aeabi_uldivmod'

We could probably use a 32-bit division here as before, but since this is
not in a performance critical path, div_u64() seems cleaner here.

Fixes: 887839e6960d ("mlxsw: spectrum_kvdl: Add support for dynamic partition set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
index d27fa57ad3c3..6fd701db90c9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c
@@ -278,7 +278,7 @@ static int mlxsw_sp_kvdl_part_init(struct mlxsw_sp *mlxsw_sp,
 		resource_size = info->end_index - info->start_index + 1;
 	}
 
-	nr_entries = resource_size / info->alloc_size;
+	nr_entries = div_u64(resource_size, info->alloc_size);
 	usage_size = BITS_TO_LONGS(nr_entries) * sizeof(unsigned long);
 	part = kzalloc(sizeof(*part) + usage_size, GFP_KERNEL);
 	if (!part)
-- 
2.9.0
