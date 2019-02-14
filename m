Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BA4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF11218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMzxLnFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502534AbfBNQBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:01:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38773 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502516AbfBNQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:01:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so7053275wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zUe4gYvIJ3SIUSlEayAwGcrtL8B8lj0rJehN7KB6Chg=;
        b=tMzxLnFmoFSHm3ABRtVozMuosejR1qn5+on7j+FFyiI6AQdQAoH6AgNOqw1i2yT+E4
         48xa9+vWoXUpczDpeH3RqNpEMn7YbCVygp/5fIFaYEbwH3Eg7PmgWJ4wiBY0xq44h6+F
         snRSdix6ddBfjaNWdHAruDu25VzxZicQKEJkOjNgJScJ+4CrV63Q0qCXI2PYW1UMQ/oX
         B3HPEYI2PuHnZj4Bpqurd5hL0jK8UcXlfoOQy9jml91SLSYAImSXODwiplS0oaUP8boQ
         SSe9fjECkY7Go1np/ty7hnucardLWJsNorll3wLFYUAN8Dl0T7dLXDyfX1tJhwHL1rti
         AsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zUe4gYvIJ3SIUSlEayAwGcrtL8B8lj0rJehN7KB6Chg=;
        b=WQyncOqKfAT3as99+Z0yPKaZMuZJBIXc2EbBgXRDeu98k9pZBVFY/nAAbZGX0aGJRU
         yWSmnjs8Nr5NHMZ95VyV3JI91HMfqzFRbhHA2ARflA9kDx880MxUU5fWG8YM80ZB/4lu
         uYV6Z3/rotLPXqUQ0WR3kboenuaT8XP//3hsNBis63WQyEei4ZLkBDWX2+m04PgtegeW
         GsW4wkr8m5MotXFLxm7Qw9SxFJFs+ymBg1J1oOEXcj25G60J0JZhWa6vAzEePtyfUuD8
         8afybeYZqQxeNBXKkNPDxebA45+PUjLxCdMLCckhAD4Eeza5zkXWj5w8HSReZuixXCSX
         KB1g==
X-Gm-Message-State: AHQUAubvXNasuEItUco8LMTfA3Gxj374ZpBYbTbsj4cop/Qa+es4nR2G
        t+G9kptURHyLu3EtVQQGOFk=
X-Google-Smtp-Source: AHgI3IbNBUNtf9lFmHBhG06jnbYV2An9KK/b0h2MYAcUXCDKfvcMGCm6bCQ38PlifttlJbLT5UxSIQ==
X-Received: by 2002:adf:b648:: with SMTP id i8mr3325334wre.319.1550160091916;
        Thu, 14 Feb 2019 08:01:31 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u15sm5092855wmu.17.2019.02.14.08.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:01:31 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v5 08/15] habanalabs: add event queue and interrupts
Date:   Thu, 14 Feb 2019 18:01:07 +0200
Message-Id: <20190214160114.26314-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214160114.26314-1-oded.gabbay@gmail.com>
References: <20190214160114.26314-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for receiving events from Goya's control CPU and
for receiving MSI-X interrupts from Goya's DMA engines and CPU.

Goya's PCI controller supports up to 8 MSI-X interrupts, which only 6 of
them are currently used. The first 5 interrupts are dedicated for Goya's
DMA engine queues. The 6th interrupt is dedicated for Goya's control CPU.

The DMA queue will signal its MSI-X entry upon each completion of a command
buffer that was placed on its primary queue. The driver will then mark that
CB as completed and free the related resources. It will also update the
command submission object which that CB belongs to.

There is a dedicated event queue (EQ) between the driver and Goya's control
CPU. The EQ is located on the Host memory. The control CPU writes a new
entry to the EQ for various reasons, such as ECC error, MMU page fault, Hot
temperature. After writing the new entry to the EQ, the control CPU will
trigger its dedicated MSI-X entry to signal the driver that there is a new
entry in the EQ. The driver will then read the entry and act accordingly.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v5:
  - Fix pointer cast warnings by casting to uintptr_t
 
 drivers/misc/habanalabs/device.c           |  34 +-
 drivers/misc/habanalabs/goya/goya.c        | 461 ++++++++++++++++++++-
 drivers/misc/habanalabs/goya/goyaP.h       |   1 +
 drivers/misc/habanalabs/habanalabs.h       |  39 +-
 drivers/misc/habanalabs/include/armcp_if.h |  24 ++
 drivers/misc/habanalabs/irq.c              | 144 +++++++
 6 files changed, 691 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index a69c0e336cc4..a8f17ae9dfb3 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -182,6 +182,13 @@ static int device_early_init(struct hl_device *hdev)
 		goto asid_fini;
 	}
 
+	hdev->eq_wq = alloc_workqueue("hl-events", WQ_UNBOUND, 0);
+	if (hdev->eq_wq == NULL) {
+		dev_err(hdev->dev, "Failed to allocate EQ workqueue\n");
+		rc = -ENOMEM;
+		goto free_cq_wq;
+	}
+
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
 	mutex_init(&hdev->fd_open_cnt_lock);
@@ -190,6 +197,8 @@ static int device_early_init(struct hl_device *hdev)
 
 	return 0;
 
+free_cq_wq:
+	destroy_workqueue(hdev->cq_wq);
 asid_fini:
 	hl_asid_fini(hdev);
 early_fini:
@@ -211,6 +220,7 @@ static void device_early_fini(struct hl_device *hdev)
 
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 
+	destroy_workqueue(hdev->eq_wq);
 	destroy_workqueue(hdev->cq_wq);
 
 	hl_asid_fini(hdev);
@@ -349,11 +359,22 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		}
 	}
 
+	/*
+	 * Initialize the event queue. Must be done before hw_init,
+	 * because there the address of the event queue is being
+	 * passed as argument to request_irq
+	 */
+	rc = hl_eq_init(hdev, &hdev->event_queue);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize event queue\n");
+		goto cq_fini;
+	}
+
 	/* Allocate the kernel context */
 	hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx), GFP_KERNEL);
 	if (!hdev->kernel_ctx) {
 		rc = -ENOMEM;
-		goto cq_fini;
+		goto eq_fini;
 	}
 
 	hdev->user_ctx = NULL;
@@ -398,6 +419,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 			"kernel ctx is still alive on initialization failure\n");
 free_ctx:
 	kfree(hdev->kernel_ctx);
+eq_fini:
+	hl_eq_fini(hdev, &hdev->event_queue);
 cq_fini:
 	for (i = 0 ; i < cq_ready_cnt ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
@@ -439,6 +462,13 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
+	/*
+	 * Halt the engines and disable interrupts so we won't get any more
+	 * completions from H/W and we won't have any accesses from the
+	 * H/W to the host machine
+	 */
+	hdev->asic_funcs->halt_engines(hdev, true);
+
 	hl_cb_pool_fini(hdev);
 
 	/* Release kernel context */
@@ -448,6 +478,8 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Reset the H/W. It will be in idle state after this returns */
 	hdev->asic_funcs->hw_fini(hdev, true);
 
+	hl_eq_fini(hdev, &hdev->event_queue);
+
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_fini(hdev, &hdev->completion_queue[i]);
 	kfree(hdev->completion_queue);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 74b31faafd6c..e31fc6d1bd5f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -94,9 +94,41 @@
 
 #define GOYA_MAX_INITIATORS		20
 
+#define GOYA_MAX_STRING_LEN		20
+
 #define GOYA_CB_POOL_CB_CNT		512
 #define GOYA_CB_POOL_CB_SIZE		0x20000		/* 128KB */
 
+static const char goya_irq_name[GOYA_MSIX_ENTRIES][GOYA_MAX_STRING_LEN] = {
+		"goya cq 0", "goya cq 1", "goya cq 2", "goya cq 3",
+		"goya cq 4", "goya cpu eq"
+};
+
+static const char *goya_axi_name[GOYA_MAX_INITIATORS] = {
+	"MME0",
+	"MME1",
+	"MME2",
+	"MME3",
+	"MME4",
+	"MME5",
+	"TPC0",
+	"TPC1",
+	"TPC2",
+	"TPC3",
+	"TPC4",
+	"TPC5",
+	"TPC6",
+	"TPC7",
+	"PCI",
+	"DMA", /* HBW */
+	"DMA", /* LBW */
+	"PSOC",
+	"CPU",
+	"MMU"
+};
+
+#define GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE 121
+
 static void goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -141,6 +173,7 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->va_space_dram_end_address = VA_DDR_SPACE_END;
 	prop->cfg_size = CFG_SIZE;
 	prop->max_asid = MAX_ASID;
+	prop->num_of_events = GOYA_ASYNC_EVENT_ID_SIZE;
 	prop->cb_pool_cb_cnt = GOYA_CB_POOL_CB_CNT;
 	prop->cb_pool_cb_size = GOYA_CB_POOL_CB_SIZE;
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
@@ -679,15 +712,10 @@ static void goya_init_dma_qman(struct hl_device *hdev, int dma_id,
 	WREG32(mmDMA_QM_0_PQ_CFG1 + reg_off, 0x00020002);
 	WREG32(mmDMA_QM_0_CQ_CFG1 + reg_off, 0x00080008);
 
-	if (dma_id == 0)
-		WREG32(mmDMA_QM_0_GLBL_PROT + reg_off, QMAN_DMA_FULLY_TRUSTED);
+	if (goya->hw_cap_initialized & HW_CAP_MMU)
+		WREG32(mmDMA_QM_0_GLBL_PROT + reg_off, QMAN_DMA_PARTLY_TRUSTED);
 	else
-		if (goya->hw_cap_initialized & HW_CAP_MMU)
-			WREG32(mmDMA_QM_0_GLBL_PROT + reg_off,
-					QMAN_DMA_PARTLY_TRUSTED);
-		else
-			WREG32(mmDMA_QM_0_GLBL_PROT + reg_off,
-					QMAN_DMA_FULLY_TRUSTED);
+		WREG32(mmDMA_QM_0_GLBL_PROT + reg_off, QMAN_DMA_FULLY_TRUSTED);
 
 	WREG32(mmDMA_QM_0_GLBL_ERR_CFG + reg_off, QMAN_DMA_ERR_MSG_EN);
 	WREG32(mmDMA_QM_0_GLBL_CFG0 + reg_off, QMAN_DMA_ENABLE);
@@ -893,6 +921,7 @@ static void goya_resume_external_queues(struct hl_device *hdev)
 int goya_init_cpu_queues(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
+	struct hl_eq *eq;
 	dma_addr_t bus_address;
 	u32 status;
 	struct hl_hw_queue *cpu_pq = &hdev->kernel_queues[GOYA_QUEUE_ID_CPU_PQ];
@@ -904,17 +933,24 @@ int goya_init_cpu_queues(struct hl_device *hdev)
 	if (goya->hw_cap_initialized & HW_CAP_CPU_Q)
 		return 0;
 
+	eq = &hdev->event_queue;
+
 	bus_address = cpu_pq->bus_address +
 			hdev->asic_prop.host_phys_base_address;
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_0, lower_32_bits(bus_address));
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_1, upper_32_bits(bus_address));
 
+	bus_address = eq->bus_address + hdev->asic_prop.host_phys_base_address;
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_2, lower_32_bits(bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_3, upper_32_bits(bus_address));
+
 	bus_address = hdev->cpu_accessible_dma_address +
 			hdev->asic_prop.host_phys_base_address;
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_8, lower_32_bits(bus_address));
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_9, upper_32_bits(bus_address));
 
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_5, HL_QUEUE_SIZE_IN_BYTES);
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_4, HL_EQ_SIZE_IN_BYTES);
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_10, CPU_ACCESSIBLE_MEM_SIZE);
 
 	/* Used for EQ CI */
@@ -1872,6 +1908,165 @@ static void goya_resume_internal_queues(struct hl_device *hdev)
 	WREG32(mmTPC7_CMDQ_GLBL_CFG1, 0);
 }
 
+static void goya_dma_stall(struct hl_device *hdev)
+{
+	WREG32(mmDMA_QM_0_GLBL_CFG1, 1 << DMA_QM_0_GLBL_CFG1_DMA_STOP_SHIFT);
+	WREG32(mmDMA_QM_1_GLBL_CFG1, 1 << DMA_QM_1_GLBL_CFG1_DMA_STOP_SHIFT);
+	WREG32(mmDMA_QM_2_GLBL_CFG1, 1 << DMA_QM_2_GLBL_CFG1_DMA_STOP_SHIFT);
+	WREG32(mmDMA_QM_3_GLBL_CFG1, 1 << DMA_QM_3_GLBL_CFG1_DMA_STOP_SHIFT);
+	WREG32(mmDMA_QM_4_GLBL_CFG1, 1 << DMA_QM_4_GLBL_CFG1_DMA_STOP_SHIFT);
+}
+
+static void goya_tpc_stall(struct hl_device *hdev)
+{
+	WREG32(mmTPC0_CFG_TPC_STALL, 1 << TPC0_CFG_TPC_STALL_V_SHIFT);
+	WREG32(mmTPC1_CFG_TPC_STALL, 1 << TPC1_CFG_TPC_STALL_V_SHIFT);
+	WREG32(mmTPC2_CFG_TPC_STALL, 1 << TPC2_CFG_TPC_STALL_V_SHIFT);
+	WREG32(mmTPC3_CFG_TPC_STALL, 1 << TPC3_CFG_TPC_STALL_V_SHIFT);
+	WREG32(mmTPC4_CFG_TPC_STALL, 1 << TPC4_CFG_TPC_STALL_V_SHIFT);
+	WREG32(mmTPC5_CFG_TPC_STALL, 1 << TPC5_CFG_TPC_STALL_V_SHIFT);
+	WREG32(mmTPC6_CFG_TPC_STALL, 1 << TPC6_CFG_TPC_STALL_V_SHIFT);
+	WREG32(mmTPC7_CFG_TPC_STALL, 1 << TPC7_CFG_TPC_STALL_V_SHIFT);
+}
+
+static void goya_mme_stall(struct hl_device *hdev)
+{
+	WREG32(mmMME_STALL, 0xFFFFFFFF);
+}
+
+static int goya_enable_msix(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	int cq_cnt = hdev->asic_prop.completion_queues_count;
+	int rc, i, irq_cnt_init, irq;
+
+	if (goya->hw_cap_initialized & HW_CAP_MSIX)
+		return 0;
+
+	rc = pci_alloc_irq_vectors(hdev->pdev, GOYA_MSIX_ENTRIES,
+				GOYA_MSIX_ENTRIES, PCI_IRQ_MSIX);
+	if (rc < 0) {
+		dev_err(hdev->dev,
+			"MSI-X: Failed to enable support -- %d/%d\n",
+			GOYA_MSIX_ENTRIES, rc);
+		return rc;
+	}
+
+	for (i = 0, irq_cnt_init = 0 ; i < cq_cnt ; i++, irq_cnt_init++) {
+		irq = pci_irq_vector(hdev->pdev, i);
+		rc = request_irq(irq, hl_irq_handler_cq, 0, goya_irq_name[i],
+				&hdev->completion_queue[i]);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+			goto free_irqs;
+		}
+	}
+
+	irq = pci_irq_vector(hdev->pdev, EVENT_QUEUE_MSIX_IDX);
+
+	rc = request_irq(irq, hl_irq_handler_eq, 0,
+			goya_irq_name[EVENT_QUEUE_MSIX_IDX],
+			&hdev->event_queue);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+		goto free_irqs;
+	}
+
+	goya->hw_cap_initialized |= HW_CAP_MSIX;
+	return 0;
+
+free_irqs:
+	for (i = 0 ; i < irq_cnt_init ; i++)
+		free_irq(pci_irq_vector(hdev->pdev, i),
+			&hdev->completion_queue[i]);
+
+	pci_free_irq_vectors(hdev->pdev);
+	return rc;
+}
+
+static void goya_sync_irqs(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	int i;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MSIX))
+		return;
+
+	/* Wait for all pending IRQs to be finished */
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+		synchronize_irq(pci_irq_vector(hdev->pdev, i));
+
+	synchronize_irq(pci_irq_vector(hdev->pdev, EVENT_QUEUE_MSIX_IDX));
+}
+
+static void goya_disable_msix(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	int i, irq;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MSIX))
+		return;
+
+	goya_sync_irqs(hdev);
+
+	irq = pci_irq_vector(hdev->pdev, EVENT_QUEUE_MSIX_IDX);
+	free_irq(irq, &hdev->event_queue);
+
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
+		irq = pci_irq_vector(hdev->pdev, i);
+		free_irq(irq, &hdev->completion_queue[i]);
+	}
+
+	pci_free_irq_vectors(hdev->pdev);
+
+	goya->hw_cap_initialized &= ~HW_CAP_MSIX;
+}
+
+static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
+{
+	u32 wait_timeout_ms, cpu_timeout_ms;
+
+	dev_info(hdev->dev,
+		"Halting compute engines and disabling interrupts\n");
+
+	if (hdev->pldm) {
+		wait_timeout_ms = GOYA_PLDM_RESET_WAIT_MSEC;
+		cpu_timeout_ms = GOYA_PLDM_RESET_WAIT_MSEC;
+	} else {
+		wait_timeout_ms = GOYA_RESET_WAIT_MSEC;
+		cpu_timeout_ms = GOYA_CPU_RESET_WAIT_MSEC;
+	}
+
+	if (hard_reset) {
+		/*
+		 * I don't know what is the state of the CPU so make sure it is
+		 * stopped in any means necessary
+		 */
+		WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_GOTO_WFE);
+		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+			GOYA_ASYNC_EVENT_ID_HALT_MACHINE);
+		msleep(cpu_timeout_ms);
+	}
+
+	goya_stop_external_queues(hdev);
+	goya_stop_internal_queues(hdev);
+
+	msleep(wait_timeout_ms);
+
+	goya_dma_stall(hdev);
+	goya_tpc_stall(hdev);
+	goya_mme_stall(hdev);
+
+	msleep(wait_timeout_ms);
+
+	goya_disable_external_queues(hdev);
+	goya_disable_internal_queues(hdev);
+
+	if (hard_reset)
+		goya_disable_msix(hdev);
+	else
+		goya_sync_irqs(hdev);
+}
 
 /*
  * goya_push_fw_to_device - Push FW code to device
@@ -2199,11 +2394,16 @@ static int goya_hw_init(struct hl_device *hdev)
 
 	goya_init_tpc_qmans(hdev);
 
+	/* MSI-X must be enabled before CPU queues are initialized */
+	rc = goya_enable_msix(hdev);
+	if (rc)
+		goto disable_queues;
+
 	rc = goya_init_cpu_queues(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize CPU H/W queues %d\n",
 			rc);
-		goto disable_queues;
+		goto disable_msix;
 	}
 
 	/* CPU initialization is finished, we can now move to 48 bit DMA mask */
@@ -2237,6 +2437,8 @@ static int goya_hw_init(struct hl_device *hdev)
 
 disable_pci_access:
 	goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+disable_msix:
+	goya_disable_msix(hdev);
 disable_queues:
 	goya_disable_internal_queues(hdev);
 	goya_disable_external_queues(hdev);
@@ -2302,6 +2504,7 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 					HW_CAP_DMA | HW_CAP_MME |
 					HW_CAP_MMU | HW_CAP_TPC_MBIST |
 					HW_CAP_GOLDEN | HW_CAP_TPC);
+	memset(goya->events_stat, 0, sizeof(goya->events_stat));
 
 	if (!hdev->pldm) {
 		int rc;
@@ -2788,6 +2991,242 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 			size);
 }
 
+static void goya_update_eq_ci(struct hl_device *hdev, u32 val)
+{
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, val);
+}
+
+static void goya_get_axi_name(struct hl_device *hdev, u32 agent_id,
+		u16 event_type, char *axi_name, int len)
+{
+	if (!strcmp(goya_axi_name[agent_id], "DMA"))
+		if (event_type >= GOYA_ASYNC_EVENT_ID_DMA0_CH)
+			snprintf(axi_name, len, "DMA %d",
+				event_type - GOYA_ASYNC_EVENT_ID_DMA0_CH);
+		else
+			snprintf(axi_name, len, "DMA %d",
+				event_type - GOYA_ASYNC_EVENT_ID_DMA0_QM);
+	else
+		snprintf(axi_name, len, "%s", goya_axi_name[agent_id]);
+}
+
+static void goya_print_razwi_info(struct hl_device *hdev, u64 reg,
+		bool is_hbw, bool is_read, u16 event_type)
+{
+	u32 val, agent_id;
+	char axi_name[10] = {0};
+
+	val = RREG32(reg);
+
+	if (is_hbw)
+		agent_id = (val & GOYA_IRQ_HBW_AGENT_ID_MASK) >>
+				GOYA_IRQ_HBW_AGENT_ID_SHIFT;
+	else
+		agent_id = (val & GOYA_IRQ_LBW_AGENT_ID_MASK) >>
+				GOYA_IRQ_LBW_AGENT_ID_SHIFT;
+
+	if (agent_id >= GOYA_MAX_INITIATORS) {
+		dev_err(hdev->dev,
+			"Illegal %s %s with wrong initiator id %d, H/W IRQ %d\n",
+				is_read ? "read from" : "write to",
+				is_hbw ? "HBW" : "LBW",
+				agent_id,
+				event_type);
+	} else {
+		goya_get_axi_name(hdev, agent_id, event_type, axi_name,
+				sizeof(axi_name));
+		dev_err(hdev->dev, "Illegal %s by %s %s %s, H/W IRQ %d\n",
+				is_read ? "read" : "write",
+				axi_name,
+				is_read ? "from" : "to",
+				is_hbw ? "HBW" : "LBW",
+				event_type);
+	}
+}
+
+static void goya_print_irq_info(struct hl_device *hdev, u16 event_type)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	bool is_hbw = false, is_read = false, is_info = false;
+
+	if (RREG32(mmDMA_MACRO_RAZWI_LBW_WT_VLD)) {
+		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_LBW_WT_ID, is_hbw,
+				is_read, event_type);
+		WREG32(mmDMA_MACRO_RAZWI_LBW_WT_VLD, 0);
+		is_info = true;
+	}
+	if (RREG32(mmDMA_MACRO_RAZWI_LBW_RD_VLD)) {
+		is_read = true;
+		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_LBW_RD_ID, is_hbw,
+				is_read, event_type);
+		WREG32(mmDMA_MACRO_RAZWI_LBW_RD_VLD, 0);
+		is_info = true;
+	}
+	if (RREG32(mmDMA_MACRO_RAZWI_HBW_WT_VLD)) {
+		is_hbw = true;
+		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_HBW_WT_ID, is_hbw,
+				is_read, event_type);
+		WREG32(mmDMA_MACRO_RAZWI_HBW_WT_VLD, 0);
+		is_info = true;
+	}
+	if (RREG32(mmDMA_MACRO_RAZWI_HBW_RD_VLD)) {
+		is_hbw = true;
+		is_read = true;
+		goya_print_razwi_info(hdev, mmDMA_MACRO_RAZWI_HBW_RD_ID, is_hbw,
+				is_read, event_type);
+		WREG32(mmDMA_MACRO_RAZWI_HBW_RD_VLD, 0);
+		is_info = true;
+	}
+	if (!is_info) {
+		dev_err(hdev->dev,
+			"Received H/W interrupt %d, no additional info\n",
+			event_type);
+		return;
+	}
+
+	if (goya->hw_cap_initialized & HW_CAP_MMU) {
+		u32 val = RREG32(mmMMU_PAGE_ERROR_CAPTURE);
+		u64 addr;
+
+		if (val & MMU_PAGE_ERROR_CAPTURE_ENTRY_VALID_MASK) {
+			addr = val & MMU_PAGE_ERROR_CAPTURE_VA_49_32_MASK;
+			addr <<= 32;
+			addr |= RREG32(mmMMU_PAGE_ERROR_CAPTURE_VA);
+
+			dev_err(hdev->dev, "MMU page fault on va 0x%llx\n",
+					addr);
+
+			WREG32(mmMMU_PAGE_ERROR_CAPTURE, 0);
+		}
+	}
+}
+
+static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
+{
+	struct armcp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = ARMCP_PACKET_UNMASK_RAZWI_IRQ << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	pkt.value = event_type;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if (rc)
+		dev_err(hdev->dev, "failed to unmask RAZWI IRQ %d", event_type);
+
+	return rc;
+}
+
+void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
+{
+	u16 event_type = ((eq_entry->hdr.ctl & EQ_CTL_EVENT_TYPE_MASK)
+			>> EQ_CTL_EVENT_TYPE_SHIFT);
+	struct goya_device *goya = hdev->asic_specific;
+
+	goya->events_stat[event_type]++;
+
+	switch (event_type) {
+	case GOYA_ASYNC_EVENT_ID_PCIE_IF:
+	case GOYA_ASYNC_EVENT_ID_TPC0_ECC:
+	case GOYA_ASYNC_EVENT_ID_TPC1_ECC:
+	case GOYA_ASYNC_EVENT_ID_TPC2_ECC:
+	case GOYA_ASYNC_EVENT_ID_TPC3_ECC:
+	case GOYA_ASYNC_EVENT_ID_TPC4_ECC:
+	case GOYA_ASYNC_EVENT_ID_TPC5_ECC:
+	case GOYA_ASYNC_EVENT_ID_TPC6_ECC:
+	case GOYA_ASYNC_EVENT_ID_TPC7_ECC:
+	case GOYA_ASYNC_EVENT_ID_MME_ECC:
+	case GOYA_ASYNC_EVENT_ID_MME_ECC_EXT:
+	case GOYA_ASYNC_EVENT_ID_MMU_ECC:
+	case GOYA_ASYNC_EVENT_ID_DMA_MACRO:
+	case GOYA_ASYNC_EVENT_ID_DMA_ECC:
+	case GOYA_ASYNC_EVENT_ID_CPU_IF_ECC:
+	case GOYA_ASYNC_EVENT_ID_PSOC_MEM:
+	case GOYA_ASYNC_EVENT_ID_PSOC_CORESIGHT:
+	case GOYA_ASYNC_EVENT_ID_SRAM0 ... GOYA_ASYNC_EVENT_ID_SRAM29:
+	case GOYA_ASYNC_EVENT_ID_GIC500:
+	case GOYA_ASYNC_EVENT_ID_PLL0:
+	case GOYA_ASYNC_EVENT_ID_PLL1:
+	case GOYA_ASYNC_EVENT_ID_PLL3:
+	case GOYA_ASYNC_EVENT_ID_PLL4:
+	case GOYA_ASYNC_EVENT_ID_PLL5:
+	case GOYA_ASYNC_EVENT_ID_PLL6:
+	case GOYA_ASYNC_EVENT_ID_AXI_ECC:
+	case GOYA_ASYNC_EVENT_ID_L2_RAM_ECC:
+	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET:
+	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT:
+		dev_err(hdev->dev,
+			"Received H/W interrupt %d, reset the chip\n",
+			event_type);
+		break;
+
+	case GOYA_ASYNC_EVENT_ID_PCIE_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC0_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC1_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC2_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC3_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC4_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC5_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC6_DEC:
+	case GOYA_ASYNC_EVENT_ID_TPC7_DEC:
+	case GOYA_ASYNC_EVENT_ID_MME_WACS:
+	case GOYA_ASYNC_EVENT_ID_MME_WACSD:
+	case GOYA_ASYNC_EVENT_ID_CPU_AXI_SPLITTER:
+	case GOYA_ASYNC_EVENT_ID_PSOC_AXI_DEC:
+	case GOYA_ASYNC_EVENT_ID_PSOC:
+	case GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC1_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC2_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC3_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC4_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC5_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC6_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC7_KRN_ERR:
+	case GOYA_ASYNC_EVENT_ID_TPC0_CMDQ ... GOYA_ASYNC_EVENT_ID_TPC7_QM:
+	case GOYA_ASYNC_EVENT_ID_MME_QM:
+	case GOYA_ASYNC_EVENT_ID_MME_CMDQ:
+	case GOYA_ASYNC_EVENT_ID_DMA0_QM ... GOYA_ASYNC_EVENT_ID_DMA4_QM:
+	case GOYA_ASYNC_EVENT_ID_DMA0_CH ... GOYA_ASYNC_EVENT_ID_DMA4_CH:
+		goya_print_irq_info(hdev, event_type);
+		goya_unmask_irq(hdev, event_type);
+		break;
+
+	case GOYA_ASYNC_EVENT_ID_TPC0_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_TPC1_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_TPC2_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_TPC3_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_TPC4_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_TPC5_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_TPC6_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_TPC7_BMON_SPMU:
+	case GOYA_ASYNC_EVENT_ID_DMA_BM_CH0:
+	case GOYA_ASYNC_EVENT_ID_DMA_BM_CH1:
+	case GOYA_ASYNC_EVENT_ID_DMA_BM_CH2:
+	case GOYA_ASYNC_EVENT_ID_DMA_BM_CH3:
+	case GOYA_ASYNC_EVENT_ID_DMA_BM_CH4:
+		dev_info(hdev->dev, "Received H/W interrupt %d\n", event_type);
+		break;
+
+	default:
+		dev_err(hdev->dev, "Received invalid H/W interrupt %d\n",
+				event_type);
+		break;
+	}
+}
+
+void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	*size = (u32) sizeof(goya->events_stat);
+
+	return goya->events_stat;
+}
+
 
 static void goya_hw_queues_lock(struct hl_device *hdev)
 {
@@ -2810,6 +3249,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.sw_fini = goya_sw_fini,
 	.hw_init = goya_hw_init,
 	.hw_fini = goya_hw_fini,
+	.halt_engines = goya_halt_engines,
 	.suspend = goya_suspend,
 	.resume = goya_resume,
 	.mmap = goya_mmap,
@@ -2824,6 +3264,9 @@ static const struct hl_asic_funcs goya_funcs = {
 	.dma_pool_free = goya_dma_pool_free,
 	.cpu_accessible_dma_pool_alloc = goya_cpu_accessible_dma_pool_alloc,
 	.cpu_accessible_dma_pool_free = goya_cpu_accessible_dma_pool_free,
+	.update_eq_ci = goya_update_eq_ci,
+	.handle_eqe = goya_handle_eqe,
+	.get_events_stat = goya_get_events_stat,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
 	.send_cpu_message = goya_send_cpu_message
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 659bba374583..a474373a9057 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -152,6 +152,7 @@ struct goya_device {
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
 	u64		ddr_bar_cur_addr;
+	u32		events_stat[GOYA_ASYNC_EVENT_ID_SIZE];
 	u32		hw_cap_initialized;
 };
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 12e4ee6eb45e..5152b6d3bb4a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -86,6 +86,7 @@ struct hw_queue_properties {
  * @cfg_size: configuration space size on SRAM.
  * @sram_size: total size of SRAM.
  * @max_asid: maximum number of open contexts (ASIDs).
+ * @num_of_events: number of possible internal H/W IRQs.
  * @completion_queues_count: number of completion queues.
  * @high_pll: high PLL frequency used by the device.
  * @cb_pool_cb_cnt: number of CBs in the CB pool.
@@ -112,6 +113,7 @@ struct asic_fixed_properties {
 	u32			cfg_size;
 	u32			sram_size;
 	u32			max_asid;
+	u32			num_of_events;
 	u32			high_pll;
 	u32			cb_pool_cb_cnt;
 	u32			cb_pool_cb_size;
@@ -204,6 +206,9 @@ struct hl_cs_job;
 #define HL_CQ_LENGTH			HL_QUEUE_LENGTH
 #define HL_CQ_SIZE_IN_BYTES		(HL_CQ_LENGTH * HL_CQ_ENTRY_SIZE)
 
+/* Must be power of 2 (HL_PAGE_SIZE / HL_EQ_ENTRY_SIZE) */
+#define HL_EQ_LENGTH			64
+#define HL_EQ_SIZE_IN_BYTES		(HL_EQ_LENGTH * HL_EQ_ENTRY_SIZE)
 
 
 /**
@@ -251,6 +256,20 @@ struct hl_cq {
 	atomic_t		free_slots_cnt;
 };
 
+/**
+ * struct hl_eq - describes the event queue (single one per device)
+ * @hdev: pointer to the device structure
+ * @kernel_address: holds the queue's kernel virtual address
+ * @bus_address: holds the queue's DMA address
+ * @ci: ci inside the queue
+ */
+struct hl_eq {
+	struct hl_device	*hdev;
+	u64			kernel_address;
+	dma_addr_t		bus_address;
+	u32			ci;
+};
+
 
 /*
  * ASICs
@@ -277,6 +296,9 @@ enum hl_asic_type {
  * @sw_fini: tears down driver state, does not configure H/W.
  * @hw_init: sets up the H/W state.
  * @hw_fini: tears down the H/W state.
+ * @halt_engines: halt engines, needed for reset sequence. This also disables
+ *                interrupts from the device. Should be called before
+ *                hw_fini and before CS rollback.
  * @suspend: handles IP specific H/W or SW changes for suspend.
  * @resume: handles IP specific H/W or SW changes for resume.
  * @mmap: mmap function, does nothing.
@@ -298,6 +320,9 @@ enum hl_asic_type {
  * @dma_pool_free: free small DMA allocation from pool.
  * @cpu_accessible_dma_pool_alloc: allocate CPU PQ packet from DMA pool.
  * @cpu_accessible_dma_pool_free: free CPU PQ packet from DMA pool.
+ * @update_eq_ci: update event queue CI.
+ * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
+ * @get_events_stat: retrieve event queue entries histogram.
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
  * @send_cpu_message: send buffer to ArmCP.
@@ -309,6 +334,7 @@ struct hl_asic_funcs {
 	int (*sw_fini)(struct hl_device *hdev);
 	int (*hw_init)(struct hl_device *hdev);
 	void (*hw_fini)(struct hl_device *hdev, bool hard_reset);
+	void (*halt_engines)(struct hl_device *hdev, bool hard_reset);
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
 	int (*mmap)(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
@@ -331,6 +357,10 @@ struct hl_asic_funcs {
 				size_t size, dma_addr_t *dma_handle);
 	void (*cpu_accessible_dma_pool_free)(struct hl_device *hdev,
 				size_t size, void *vaddr);
+	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
+	void (*handle_eqe)(struct hl_device *hdev,
+				struct hl_eq_entry *eq_entry);
+	void* (*get_events_stat)(struct hl_device *hdev, u32 *size);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
@@ -370,8 +400,6 @@ struct hl_ctx_mgr {
 };
 
 
-
-
 /**
  * struct hl_cs_job - command submission job.
  * @finish_work: workqueue object to run when job is completed.
@@ -461,6 +489,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @kernel_ctx: KMD context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
+ * @event_queue: event queue for IRQ from ArmCP.
  * @dma_pool: DMA pool for small allocations.
  * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
  * @cpu_accessible_dma_address: KMD <-> ArmCP shared memory DMA address.
@@ -495,9 +524,11 @@ struct hl_device {
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
 	struct workqueue_struct		*cq_wq;
+	struct workqueue_struct		*eq_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
 	struct hl_cb_mgr		kernel_cb_mgr;
+	struct hl_eq			event_queue;
 	struct dma_pool			*dma_pool;
 	void				*cpu_accessible_dma_mem;
 	dma_addr_t			cpu_accessible_dma_address;
@@ -579,6 +610,10 @@ void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id);
 
 int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id);
 void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q);
+int hl_eq_init(struct hl_device *hdev, struct hl_eq *q);
+void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q);
+irqreturn_t hl_irq_handler_cq(int irq, void *arg);
+irqreturn_t hl_irq_handler_eq(int irq, void *arg);
 int hl_asid_init(struct hl_device *hdev);
 void hl_asid_fini(struct hl_device *hdev);
 unsigned long hl_asid_alloc(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index cc37003aa6b7..9dddb917e72c 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -10,6 +10,30 @@
 
 #include <linux/types.h>
 
+/*
+ * EVENT QUEUE
+ */
+
+struct hl_eq_header {
+	__le32 reserved;
+	__le32 ctl;
+};
+
+struct hl_eq_entry {
+	struct hl_eq_header hdr;
+	__le64 data[7];
+};
+
+#define HL_EQ_ENTRY_SIZE		sizeof(struct hl_eq_entry)
+
+#define EQ_CTL_READY_SHIFT		31
+#define EQ_CTL_READY_MASK		0x80000000
+
+#define EQ_CTL_EVENT_TYPE_SHIFT		16
+#define EQ_CTL_EVENT_TYPE_MASK		0x03FF0000
+
+#define EVENT_QUEUE_MSIX_IDX		5
+
 enum pq_init_status {
 	PQ_INIT_STATUS_NA = 0,
 	PQ_INIT_STATUS_READY_FOR_CP,
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 44e4bcd2f2d0..1addcbcee078 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -9,6 +9,18 @@
 
 #include <linux/dma-mapping.h>
 
+/**
+ * This structure is used to schedule work of EQ entry and armcp_reset event
+ *
+ * @eq_work          - workqueue object to run when EQ entry is received
+ * @hdev             - pointer to device structure
+ * @eq_entry         - copy of the EQ entry
+ */
+struct hl_eqe_work {
+	struct work_struct	eq_work;
+	struct hl_device	*hdev;
+	struct hl_eq_entry	eq_entry;
+};
 
 /*
  * hl_cq_inc_ptr - increment ci or pi of cq
@@ -26,6 +38,33 @@ inline u32 hl_cq_inc_ptr(u32 ptr)
 	return ptr;
 }
 
+/*
+ * hl_eq_inc_ptr - increment ci of eq
+ *
+ * @ptr: the current ci value of the event queue
+ *
+ * Increment ptr by 1. If it reaches the number of event queue
+ * entries, set it to 0
+ */
+inline u32 hl_eq_inc_ptr(u32 ptr)
+{
+	ptr++;
+	if (unlikely(ptr == HL_EQ_LENGTH))
+		ptr = 0;
+	return ptr;
+}
+
+static void irq_handle_eqe(struct work_struct *work)
+{
+	struct hl_eqe_work *eqe_work = container_of(work, struct hl_eqe_work,
+							eq_work);
+	struct hl_device *hdev = eqe_work->hdev;
+
+	hdev->asic_funcs->handle_eqe(hdev, &eqe_work->eq_entry);
+
+	kfree(eqe_work);
+}
+
 /*
  * hl_irq_handler_cq - irq handler for completion queue
  *
@@ -103,6 +142,68 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+/*
+ * hl_irq_handler_eq - irq handler for event queue
+ *
+ * @irq: irq number
+ * @arg: pointer to event queue structure
+ *
+ */
+irqreturn_t hl_irq_handler_eq(int irq, void *arg)
+{
+	struct hl_eq *eq = arg;
+	struct hl_device *hdev = eq->hdev;
+	struct hl_eq_entry *eq_entry;
+	struct hl_eq_entry *eq_base;
+	struct hl_eqe_work *handle_eqe_work;
+
+	eq_base = (struct hl_eq_entry *) (uintptr_t) eq->kernel_address;
+
+	while (1) {
+		bool entry_ready =
+				((eq_base[eq->ci].hdr.ctl & EQ_CTL_READY_MASK)
+						>> EQ_CTL_READY_SHIFT);
+
+		if (!entry_ready)
+			break;
+
+		eq_entry = &eq_base[eq->ci];
+
+		/*
+		 * Make sure we read EQ entry contents after we've
+		 * checked the ownership bit.
+		 */
+		dma_rmb();
+
+		if (hdev->disabled) {
+			dev_warn(hdev->dev,
+				"Device disabled but received IRQ %d for EQ\n",
+					irq);
+			goto skip_irq;
+		}
+
+		handle_eqe_work = kmalloc(sizeof(*handle_eqe_work), GFP_ATOMIC);
+		if (handle_eqe_work) {
+			INIT_WORK(&handle_eqe_work->eq_work, irq_handle_eqe);
+			handle_eqe_work->hdev = hdev;
+
+			memcpy(&handle_eqe_work->eq_entry, eq_entry,
+					sizeof(*eq_entry));
+
+			queue_work(hdev->eq_wq, &handle_eqe_work->eq_work);
+		}
+skip_irq:
+		/* Clear EQ entry ready bit */
+		eq_entry->hdr.ctl &= ~EQ_CTL_READY_MASK;
+
+		eq->ci = hl_eq_inc_ptr(eq->ci);
+
+		hdev->asic_funcs->update_eq_ci(hdev, eq->ci);
+	}
+
+	return IRQ_HANDLED;
+}
+
 /*
  * hl_cq_init - main initialization function for an cq object
  *
@@ -148,3 +249,46 @@ void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q)
 	hdev->asic_funcs->dma_free_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
 			(void *) (uintptr_t) q->kernel_address, q->bus_address);
 }
+
+/*
+ * hl_eq_init - main initialization function for an event queue object
+ *
+ * @hdev: pointer to device structure
+ * @q: pointer to eq structure
+ *
+ * Allocate dma-able memory for the event queue and initialize fields
+ * Returns 0 on success
+ */
+int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
+{
+	void *p;
+
+	BUILD_BUG_ON(HL_EQ_SIZE_IN_BYTES > HL_PAGE_SIZE);
+
+	p = hdev->asic_funcs->dma_alloc_coherent(hdev, HL_EQ_SIZE_IN_BYTES,
+				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
+	if (!p)
+		return -ENOMEM;
+
+	q->hdev = hdev;
+	q->kernel_address = (u64) (uintptr_t) p;
+	q->ci = 0;
+
+	return 0;
+}
+
+/*
+ * hl_eq_fini - destroy event queue
+ *
+ * @hdev: pointer to device structure
+ * @q: pointer to eq structure
+ *
+ * Free the event queue memory
+ */
+void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
+{
+	flush_workqueue(hdev->eq_wq);
+
+	hdev->asic_funcs->dma_free_coherent(hdev, HL_EQ_SIZE_IN_BYTES,
+			(void *) (uintptr_t) q->kernel_address, q->bus_address);
+}
-- 
2.17.1

