Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030553AbeEYVgr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:36:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44415 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030258AbeEYVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:36:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Boris Pismenny <borisp@mellanox.com>,
        Ilan Tayari <ilant@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>, Feras Daoud <ferasda@mellanox.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH, net-next] net/mlx5e: fix TLS dependency
Date: Fri, 25 May 2018 23:36:06 +0200
Message-Id: <20180525213630.2119214-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Lg23YVSiH5DynRgOZGcQZPo7NNswXk2zMKvKfSTkPYY4IdhZifE
 MtzChJTe5j28eHdA9OvY/GbwzSmy+1WfeuFPc+j+wcGpHwQiWnBzw9iVV0WyIShjOwAkLlg
 9zLFx1yPPWBKsHadf8W9vnPUr8rlXY/Km9eGoVPXpgCzyREHeuW5t+FnzAeUqJ6enNZUx7p
 vZAkfHkEPtVP6uFSYP4Ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ntgrmome74g=:j+FtjzKP6sHWJK3Qlw0jGQ
 mch1LVs2sjXurZcYRSbDYc2RQbhKO1DtKw7cPx7nhmTuWlmzNXPnDeyqdMewbi1epGXvdwafR
 O2UidtAnXCNe7Gn3a+6l2TOZY6vev1A++Ixp7Aa6JXiRKPw5VMJVm3Jz1FdFMo145noWStwM/
 WopxSbeSyfvTVuJNwgU+wUt0CX1YWv4rMiPSnb+wL/fnVOqsTMM2JVoEqTl1yuOxOxeuqtxkA
 MzNUwAjlAUPuKuPniyluuxkOHfN5EAnI0hJXEphS3E6aMbSVZSPjXor52/AL0u+KJos/vNRTC
 Zw3zW4aK2KCWGUudxo39HU7Pi9ow2MaQdB1EJss8dtTrLQ89sHspxnA8WKqpCAGmOPxdqc1IM
 90sJJQ+OV2SU69BRR/1EsFUxjrDF11oSUUche2rPwmZK8FvsFV3w2xvLRrovPkuZk5FJn9l/2
 McR1hT/eR47ZL4fArOE0AxwmX4i3UqDqnDb0ogtX4zJ9Nt+8R5Aqxdc4Ft2uR0gLldK4p9Pi4
 q+5lXiEBjiB2LiZQVR3kD4eXR7E+Rs4mcGgF4F2jlUuNwPLSBkWt0gSdeqzJhUan5U7xmbxPB
 X1YvB2aMjemOm7w+DLJ4ubyV0HrEQ2aibPdgl2xNG/sqSx6xrZY+JRqM0mbYxyKkQbS/iveYf
 taWeAdLI/F9vQ2CCDfeYGN6X1z2PlMVwt3eyZLMfKKvHeUMbEYLGo56BkQ01oOUtpGp0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_TLS=m and MLX5_CORE_EN=y, we get a link failure:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In function `mlx5e_tls_handle_ooo':
tls_rxtx.c:(.text+0x24c): undefined reference to `tls_get_record'
drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls_rxtx.o: In function `mlx5e_tls_handle_tx_skb':
tls_rxtx.c:(.text+0x9a8): undefined reference to `tls_device_sk_destruct'

This narrows down the dependency to only allow the configurations
that will actually work. The existing dependency on TLS_DEVICE is
not sufficient here since MLX5_EN_TLS is a 'bool' symbol.

Fixes: c83294b9efa5 ("net/mlx5e: TLS, Add Innova TLS TX support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index ee6684779d11..2545296a0c08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -91,6 +91,7 @@ config MLX5_EN_TLS
 	bool "TLS cryptography-offload accelaration"
 	depends on MLX5_CORE_EN
 	depends on TLS_DEVICE
+	depends on TLS=y || MLX5_CORE=m
 	depends on MLX5_ACCEL
 	default n
 	---help---
-- 
2.9.0
