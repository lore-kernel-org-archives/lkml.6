Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeDDKYd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:24:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeDDKYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:24:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@chromium.org>,
        Simon Xue <xxm@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: rockchip: fix building without CONFIG_OF
Date: Wed,  4 Apr 2018 12:23:53 +0200
Message-Id: <20180404102401.3634085-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:7CmUPavO3w1gNayRTTinbvsD5Hwunayj36eLBmr1zHhRH1ejn4w
 obFJth4IhGTL7uSaBD8/qipw+71XqPckzNnJdpNvqi15Zr0Dg+xXAnh/7GzOvAvkaryWnho
 FCWG/f6FReptov5LiQVDo9bW3+KDhQZMu8KKdrYfTx17dhRQ53rPoU+XpZ/54b6Oou9TVLS
 k8yDjPTxB4W1nsStolNdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZWoxCgApfZk=:aRqQG8UVibrgDW9/KcBJUZ
 i4ROiA1cWmNvCgui6/RDAtsi1ULIBOY5Y8ueW8qgGmDw8UueSE+MgAxfWgZAS42LJtSQAwVJT
 SwqnL1GBYlh6XyCNdFC38wKQxXoBaflhDSewJgYl9bv+Jzew0xase0aK3uzHLrBOwYdOP9R00
 liVNcIUVRPvNWd5uTrBAzfG2gxqANqG5TTkqRmi0dg263260ytuntVFfEJGK7FcRuCxdNsizu
 hBVZBY3KE+Iy+690qR1bgvIROTcV+3B95Ja76017fFBye8M3474fBFzT5uvVmCwcjQWw/BWSf
 DEpBVKdGZS7ChXbfDKXPuEsbLh+MZyT1r7OkwrCPgMpRp4tYSupXd1dYQgxqSw8aoJN/hNJTX
 Dx0O+FeyGoswyt5wJ9zU96tiFJrB/b23ncQdE/o5yZt9/wG2ynACov5meyPU2dFf6JDHCXvmG
 M9Pduu0LraX1GTSXRxwcRlx1P6uPURlQY6ddOMzSojofNrkJe4BC4ZhhZ3Xp42NxeShovJlgl
 y/jH5YzQfeEmFB5wfHtpmO4shjZucvNOF/zNYJf231W9XGrTrdfrGwEb4WJ4cZjp16JheHwRX
 tfgiSx14nz9+WZxT4CovQNEruhtGL5BzzpWkx01QLgyXeb+QwUwpjWorc47700+S/CWYG4nuF
 fvcYA3GxJsa5Ee89VZmuqIrhk7twsRRLJuFy2RNO/5koIXWWAvNTwiN0Chq/yNiWCrsxT/kaw
 AkPrcxiuoFLp68xPDiEhOkKT+Bi+NB1q2r+EXA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a build error when compiling the iommu driver without CONFIG_OF:

drivers/iommu/rockchip-iommu.c: In function 'rk_iommu_of_xlate':
drivers/iommu/rockchip-iommu.c:1101:2: error: implicit declaration of function 'of_dev_put'; did you mean 'of_node_put'? [-Werror=implicit-function-declaration]

This replaces the of_dev_put() with the equivalent platform_device_put(),
and adds an error check for of_find_device_by_node() returning NULL,
which seems to be appropriate here given that we pass the device into
platform_get_drvdata() next, and that of_find_device_by_node() might
theoretically return a NULL pointer.

Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This warning appears to only have been introduced in linux-next after
the merge window opened.
---
 drivers/iommu/rockchip-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 5fc8656c60f9..fe9c9cc1a9d4 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1094,11 +1094,15 @@ static int rk_iommu_of_xlate(struct device *dev,
 		return -ENOMEM;
 
 	iommu_dev = of_find_device_by_node(args->np);
+	if (!iommu_dev) {
+		kfree(data);
+		return -ENODEV;
+	}
 
 	data->iommu = platform_get_drvdata(iommu_dev);
 	dev->archdata.iommu = data;
 
-	of_dev_put(iommu_dev);
+	platform_device_put(iommu_dev);
 
 	return 0;
 }
-- 
2.9.0
