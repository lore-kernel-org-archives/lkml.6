Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeCMMHJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:07:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933477AbeCMMHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:07:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 40iw: include linux/irq.h
Date: Tue, 13 Mar 2018 13:06:20 +0100
Message-Id: <20180313120644.2619889-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:v77/dRA2M93IdkgcSz0tV4WtOUDGO5yRvpeO1YeePIS3pNOWypu
 0vx0Q15AywkC9UcQ+cGKJ/CgixXY12FoWaTpQZz9jk9xZvSyVqrY+nlrUHFF3DyQvBwS0NK
 4D4UqSjIbI6YpUUPfF3bqEWohT/ipM6EwI0fI+KOVto5QXHVEiM19gzPeDvephAsUxQDea8
 Ksa0JeAKN6H1a4RGSfygQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eyexsJRGOyk=:9ONSJYhHm7ochn95UbwJnJ
 hyFXodccDcCkFJEHXIjWDrYc437sLPT5gFiuWivTszjSr9KeKGKR4LjttjqyEVwgvo8oNuSSs
 RPi564LLOGKuM3hrvIT20CX1qNelEKTVJB+SXZpeNpu5+24pXagywXozb7uJsj+ha31I62fm+
 9Jwf49Kg92oGJoJdUDdVKib/LEBkEQaI0aDtdBBnfa6YltwXX8TirROcPpKx6CqPL5devXNUo
 F2cL5njfkS4mal15jMjopF/zlLOzC3vrrqxe1xNO5snlNUHmZsrnOn44mEaU/YxHQ/EyS/O+X
 is9sJKYJ28TA6K3app1aLHquYVTLL0xCdeTlpQ6njfI/DRwXIt75kzyTriN5/zEJQQbB93dqB
 zjKhVmipvOp8FmBB9dkm2O31044svVt22OOsvrPr7SWNTDbmfZI/4xmsKCSx0BJb5909D/5we
 vMTUYQqAbC72nQSbQpMbtjMRJmu4IfHY56S8eKmQflcbympSGlEmU3pgc6R4MlfG187/96BOH
 rWiGwK/ruGywr2l+TwINJu+2EtiHEYZLAtLVgo8thwPuaggzj/lXKG35xXKWgSDEHv3WAxUuC
 MMBDKX1cuPPxVNFAEzQUXOwUJ+nbiCU5DzzwVoX6KYt8IXVabVerFL5BxDmfuuB5mONHv1Eym
 NglkGOd9cnPRSUtz7byqmbvWWN6LbazcBgSRUfaaFy78B32wygeDwMEreCSVWLKIinDEEFrc0
 xxzgJM/QZrZ7hB+5zxfckUXEJyLkBZdE6Uo7Sw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a build failure on ARM unless the header is included explicitly:

drivers/infiniband/hw/i40iw/i40iw_verbs.c: In function 'i40iw_get_vector_affinity':
drivers/infiniband/hw/i40iw/i40iw_verbs.c:2747:9: error: implicit declaration of function 'irq_get_affinity_mask'; did you mean 'irq_create_affinity_masks'? [-Werror=implicit-function-declaration]
  return irq_get_affinity_mask(msix_vec->irq);
         ^~~~~~~~~~~~~~~~~~~~~
         irq_create_affinity_masks
drivers/infiniband/hw/i40iw/i40iw_verbs.c:2747:9: error: returning 'int' from a function with return type 'const struct cpumask *' makes pointer from integer without a cast [-Werror=int-conversion]
  return irq_get_affinity_mask(msix_vec->irq);

Fixes: 7e952b19eb63 ("i40iw: Implement get_vector_affinity API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index a51798578f27..f3af952402e9 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -38,6 +38,7 @@
 #include <linux/highmem.h>
 #include <linux/time.h>
 #include <linux/hugetlb.h>
+#include <linux/irq.h>
 #include <asm/byteorder.h>
 #include <net/ip.h>
 #include <rdma/ib_verbs.h>
-- 
2.9.0
