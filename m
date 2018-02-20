Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBTU4w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:56:52 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBTU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:56:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Eddie Wai <eddie.wai@broadcom.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] infiniband: qplib_fp: fix pointer cast
Date: Tue, 20 Feb 2018 21:56:26 +0100
Message-Id: <20180220205638.1959033-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:UsVEUP5YRm5GTLXIFRv9PjJVrPSCuF++k8RY9xC1anBdbTXPHSp
 UVhCTxxko4ttVyPMYBUhU7uSTcgGhmt4dlX7IgdM+y39lGuUIMpTQq4mD9gnfY0jo8H+n0Y
 6rfIoRFcFLordE4PTIARNWWrSNhYSRWckAYKuAwAMNlHBYP2y9nHu0ZtMwXQGQHpuUq9oCG
 6D4Mci/9WUbDbjoVprvxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WrFKAHds2Jg=:wCMKKuiTelSrhn6UzCVvyz
 QeRJF/EwbV62W9whmdjStwScFzv9V9ZTxTMQESS/GaFqtBsj0GRHbo9qL2IULZWKi4pJQ6Esn
 HyiQcxVyVDUNk6ifWok/C50XinraJ40kls1UFJe4dJLamDsb0AoiYP5eUjsEhrgK425h64Wae
 4DY1sqpS/jCKa5LMUyIeDMCQrs/JW4u0zHSD6TnAk5Uq25yfCfTj2rjdfHuBRMm8jNopX2/tb
 AfE7YpXV95U6E8vW+TAMtAaYEXfoTFs4UTg3/jdI8bi0fdCqI6RvvB7uahXzQnqkTJfuh/sgz
 w9EH09qKf5QZCNxLdbekV5FZuwxME0zVFoY4ATCa9yHLDOZLfaClQgjMTU8aiiMIAqJvQ63x4
 VX0CU6v1DcQKUpgqWvOIZR0XeLU5p3t43BTNhxC10hg6bFw0Sljq0Xu5y9kNzSYTKjFzm32pB
 +2q9nM/yRBkj+ZQNbfzlS0z4n2iljJj98ocY1iFExuzkOhNtYCfhQlty0YBHAwQeIsZOzaD1a
 r5U9C19320aADPOMkMvdwaW7KyawghF4ovPYcx3Y6lDQv5NwVY8vrLW7MSeDgn763KALOHqqI
 yD1x41GeubbVjc9irCL2Scm5zBHK5MVXtKRfrICJt+p1EgGA9BreRf3ldn7Iss/8L9ZuF5kzo
 Za/Y71PcEZghId3bI1nrEOCjLXeL9/b/DrQnVaGhFqDG3W1YFgN1C/7B+US6qxMy6WEJIHvDu
 8a+8EdCGgt+IyD2PMUqdWXqnWZPvCroPCHsPLA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building for a 32-bit target results in a couple of warnings from casting between
a 32-bit pointer and a 64-bit integer:

drivers/infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_service_nq':
drivers/infiniband/hw/bnxt_re/qplib_fp.c:333:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
    bnxt_qplib_arm_srq((struct bnxt_qplib_srq *)q_handle,
                       ^
drivers/infiniband/hw/bnxt_re/qplib_fp.c:336:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
            (struct bnxt_qplib_srq *)q_handle,
            ^
In file included from include/linux/byteorder/little_endian.h:5,
                 from arch/arm/include/uapi/asm/byteorder.h:22,
                 from include/asm-generic/bitops/le.h:6,
                 from arch/arm/include/asm/bitops.h:342,
                 from include/linux/bitops.h:38,
                 from include/linux/kernel.h:11,
                 from include/linux/interrupt.h:6,
                 from drivers/infiniband/hw/bnxt_re/qplib_fp.c:39:
drivers/infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_create_srq':
include/uapi/linux/byteorder/little_endian.h:31:43: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
 #define __cpu_to_le64(x) ((__force __le64)(__u64)(x))
                                           ^
include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
 #define cpu_to_le64 __cpu_to_le64
                     ^~~~~~~~~~~~~
drivers/infiniband/hw/bnxt_re/qplib_fp.c:569:19: note: in expansion of macro 'cpu_to_le64'
  req.srq_handle = cpu_to_le64(srq);

Using a uintptr_t as an intermediate works on all architectures.

Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 1b0e94697fe3..9885d7d428e3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -283,7 +283,7 @@ static void bnxt_qplib_service_nq(unsigned long data)
 	u32 sw_cons, raw_cons;
 	u16 type;
 	int budget = nq->budget;
-	u64 q_handle;
+	uintptr_t q_handle;
 
 	/* Service the NQ until empty */
 	raw_cons = hwq->cons;
@@ -566,7 +566,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 
 	/* Configure the request */
 	req.dpi = cpu_to_le32(srq->dpi->dpi);
-	req.srq_handle = cpu_to_le64(srq);
+	req.srq_handle = cpu_to_le64((uintptr_t)srq);
 
 	req.srq_size = cpu_to_le16((u16)srq->hwq.max_elements);
 	pbl = &srq->hwq.pbl[PBL_LVL_0];
-- 
2.9.0
