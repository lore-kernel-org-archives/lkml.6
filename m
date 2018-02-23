Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBWPhT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:37:19 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeBWPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:37:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
Date: Fri, 23 Feb 2018 16:36:49 +0100
Message-Id: <20180223153700.2186058-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:U+DKE4OFNzGgL+0oopMIfkMcM5EGoKBtxrYuzePhjF2V54yyjLT
 Ee6Y4ZGdO+pAuMTJnwGx+xHlHRQLAOLXWzQonW8qme4dKbOyoMEhX3XH0gP0772Pe6RLxpK
 8iMd+jtoyOTYlXdDOXXyskKwGE+cS/S8nfbDcFmtCXdocsCvUCcHJ2Plm5JhIogK+pNxntk
 jFCM9V4agYrO1tXdpe1Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Us+QsB6EKx8=:qNk4IGw3nR8S9pddcFONUp
 fO9IzLXVBfjnwUei/RR89i0RH1xogGutYtmTOANmp6kTc8QbjW3tSGlga0Z+WK823Tg2tgXO4
 pB/uhZFpDN3rd3Z9UF6FusgTFZI6jFyPFmvC0ipfKQFO77hLv6ncw6qipQ6as7DNvHzWGKrw1
 bf3lcWEBYIwMwOSbO+u5D4U/2wlVt7v/pYDVEr+Iu7bCXvHsokdzrH5HHJZ45KX8IQIL5lUmm
 BPYL0ys7s4MW18ckk4Z6pOQQU0Dh630ERL41hfnuhvZpkio7/UJ96j9TKMT8h+bqGiutbEMpa
 YOvu22PVlh+2Epy6z1gvn8i/w7hacDqVn4lJShejxgbX6zV9avKtMQKTSy/5j941pR9Sp9D1S
 dauA13qg1Nl5BuYbCprmE7dVamx5WxEIsiG8b2DsTHT+hMqXeQ3C4zCBqMbR/zZgvpW6pU9qi
 BR+ubbYlBbU/tzSYR2am9xxo//pjoSY7NfpxhQhA2znkokMIpcZcpiRx45nQNuu0kq9vERvgq
 tI6Ta1ZG9/Ir0hwS7RvKdpODmoGOWJJetJ1CsFEYGXhKURgvtsDVxcpHKvPuicTH3gFayY7eU
 UIRZ4OxS5XavwI2bgR6kF8U8yw+0So3/Mu8zTmM17qESi41mau4lERK7fdt/RcaMgCd0mLv1A
 OX2B4RG04rZtrBFEJWJhdJUDoITN5aWGMo2qp4EDXf4Cd3K0Mn50UYT1MehsmB486NjahtG+w
 PSw/zIifuuaMRRMalNDdOln+wutP51pTPHoXrA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit architectures generally cannot use writeq(), so we now get a build
failure for the lpfc driver:

drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_wq_put':
drivers/scsi/lpfc/lpfc_sli.c:145:4: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Werror=implicit-function-declaration]

Another problem here is that writing out actual data (unlike accessing
mmio registers) means we must write the data with the same endianess
that we have read from memory, but writeq() will perform byte swaps
and add barriers inbetween accesses as we do for registers.

Using memcpy_toio() should do the right thing here, using register
sized stores with correct endianess conversion and barriers (i.e. none),
but on some architectures might fall back to byte-size access.

Side note: shouldn't the driver use ioremap_wc() instead of ioremap()
to get a write-combining mapping on all architectures that support this?

Fixes: 1351e69fc6db ("scsi: lpfc: Add push-to-adapter support to sli4")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/lpfc/lpfc_sli.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 4ce3ca6f4b79..6749d41753b4 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -115,7 +115,6 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, union lpfc_wqe *wqe)
 	struct lpfc_register doorbell;
 	uint32_t host_index;
 	uint32_t idx;
-	uint32_t i = 0;
 	uint8_t *tmp;
 
 	/* sanity check on queue memory */
@@ -138,12 +137,10 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, union lpfc_wqe *wqe)
 	if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
 		bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
 	lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
-	if (q->dpp_enable && q->phba->cfg_enable_dpp) {
+	if (q->dpp_enable && q->phba->cfg_enable_dpp)
 		/* write to DPP aperture taking advatage of Combined Writes */
-		tmp = (uint8_t *)wqe;
-		for (i = 0; i < q->entry_size; i += sizeof(uint64_t))
-			writeq(*((uint64_t *)(tmp + i)), q->dpp_regaddr + i);
-	}
+		memcpy_toio(tmp, q->dpp_regaddr, q->entry_size);
+
 	/* ensure WQE bcopy and DPP flushed before doorbell write */
 	wmb();
 
-- 
2.9.0
