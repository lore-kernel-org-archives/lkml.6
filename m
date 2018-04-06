Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeDFO2s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:28:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34987 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756065AbeDFO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:28:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hexagon: add memset_io() helper
Date: Fri,  6 Apr 2018 16:28:22 +0200
Message-Id: <20180406142832.2243021-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180406142832.2243021-1-arnd@arndb.de>
References: <20180406142832.2243021-1-arnd@arndb.de>
X-Provags-ID: V03:K1:s1MefovsIdd8pWGjCa6TN43HkaEmmf4A3xJeRZ3+U2oRPUtdGqp
 gESTipH8oYfBi4fzMLaOtRToqtPFHleZPi69+2u6X8oVKd1b0WnEqeRvHsm51gymVzVIvpq
 jtsAMH5Xo6Y9WQRyo6W0gNSi5f0OEe0VbjbtpAXMW1jD1Gil5FT8VTPcBdX9BzF+zN4cssG
 iW9gQ5xM0gyws7KmvVXxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5feViq3UTVY=:34EvZdnkSpNOrndEH9Pd2A
 HXEziwzQjISEsAC7MsqZYvA8nhJ3oo3F7HPwlwQT8hH/We+JkV0Se3c2Jd0Ci/VXdZe+qveU0
 rMG+LDW6+oImBaOZtzsRqVPylhdippkEYL04T4QSbEhHFPhrrndwaUJyq4xfiW+5BZt8TMdxd
 SVdw12EHgUNXOryuy/WKipKquA/LfqOJZY85grA9bdSJyx8F5JVR3LwKwAqsTm923Eo67zh2C
 QPFauevFksZxWa9qloz0czEXPGZO9oipFp6CWqTyehd+K6CDHuAAjwAeiKrip4jdUlRQuiJGm
 +Y6dnxRm+dvj88jRTP4k2r+Mu4TqOK/NBvCqYifgMlzGJkB0xZi/W//e9LvSc0i8jAaBMqh47
 wOTRclgK1I0DQ909vFQf7tEu+zTsgIGXgBpqzCf0z6CO/826zOUAh3fIWVNSdpfl0bKpc7r0P
 hgmFFpgZV1Sh82U2NT3BWltrsf4PjjV1biha5KYUkUqfpDdOZsAljh6X/eSr95PpaYAw+/Mxz
 5l22iDTObURXQ54D4PrzA3VRBLWlwdePTUndt7/yBM1dGqa2/be5NoXeLV2Tsn9eF2+wDoP+X
 t7j50HT6WWyGh+KTtjG7BUTKWjVxdNtjXfyDUTmqA57mrSkAy5KuVGYjcdzCa5Xs1j34RIuvQ
 cmvRdSURvx3vzk8M4vkknvqlub4umV3fCOSZLOP5V0vqBxvxWkLCNsN05LtZO/MLC//ZHNgG5
 uTZ93ky68RAfgGpkPUwZRsQz4i6L97uJQkGuOQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have memcpy_toio(), but not memset_io(), so let's
add the obvious version to allow building an allmodconfig kernel
without errors like

drivers/gpu/drm/ttm/ttm_bo_util.c: In function 'ttm_bo_move_memcpy':
drivers/gpu/drm/ttm/ttm_bo_util.c:390:3: error: implicit declaration of function 'memset_io' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/hexagon/include/asm/io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 9e8621d94ee9..e17262ad125e 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -216,6 +216,12 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
 	memcpy((void *) dst, src, count);
 }
 
+static inline void memset_io(volatile void __iomem *addr, int value,
+			     size_t size)
+{
+	memset((void __force *)addr, value, size);
+}
+
 #define PCI_IO_ADDR	(volatile void __iomem *)
 
 /*
-- 
2.9.0
