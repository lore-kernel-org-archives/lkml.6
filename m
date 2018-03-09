Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629814; cv=none;
        d=google.com; s=arc-20160816;
        b=s56DYAF8IcqsMstGfVQueH/RkrCw8xHe+gQgyjpDWnOvVQ5iD+vSlm31z/AL7xj59v
         XwcOYwJ5f9/SQMwzoX3hZ828IXgZzySwc79k2qalDO1HKOloIpHgLJByM2iZ3Q6GaRaw
         J7Yp49BLZ2uKBtlyTPBUHV6aRX4odKG9lFji2hv1BJN7/By2GstkjM5hpvPn8O5NH+Kw
         sGrj0p8nExwEiamI3HEmf8wxKIOxUIuPs2p5WF3Jx/EFqqK0it324mOGcu9zDuQfgZUh
         BFHF1vUmBZQqyB5+2Cz2hak6B5dL9AoY5NmyQhnRW9CgOKQiqIIwKHppgNCTLYaYj3m3
         jXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=z8yo/sC6hCtYEyrW3KbVgjl+frUKZLozMT8XbUakTz4=;
        b=xX/fFX2KJNMV2YA4heeVlU42nLHt6FZvlak9ETTyeFaiQmMbrg/PVIeANsHqfUe3I1
         tvqJtZldFNyQwtKrGDPKwGl7C4BY+wrW3lGxStBmZA82LdPOJd2/lspM0xOjxo6h5wKY
         iS2LVwicVefakvLKQMT0P/yuUbNneaihuA3PQrhpTxj59HIygYhskuDRbJGB4I1e04UX
         IzGOBJ9Ycv9lUP2E5db4qvZAO+CbgjarWfWMYL9s521joEyb9Gi2P9txIYSdoichvtnc
         hn+RmjS3YnRD23j3n4tNRvkZHHKlCh6zeGoAIIPEj31jxIdEKS4Uys06jPFSfmA68zJX
         Qdiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e7GR0aYY;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e7GR0aYY;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsfKqE+4XB043vXB20MfQEM7dEpzwlibBxM4hyFrRQzAWOJgmJdY6HflUKtUZ9u5OfdtKjZ8Q==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net,
	robh+dt@kernel.org,
	mturquette@baylibre.com,
	khilman@baylibre.com,
	vincent.guittot@linaro.org,
	skannan@codeaurora.org,
	bjorn.andersson@linaro.org,
	amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com,
	davidai@quicinc.com,
	mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	georgi.djakov@linaro.org
Subject: [PATCH v4 5/7] interconnect: qcom: Add msm8916 interconnect provider driver
Date: Fri,  9 Mar 2018 23:09:56 +0200
Message-Id: <20180309210958.16672-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495928598793277?=
X-GMAIL-MSGID: =?utf-8?q?1594495928598793277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add driver for the Qualcomm interconnect buses found in msm8916 based
platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/Kconfig        |   5 +
 drivers/interconnect/Makefile       |   1 +
 drivers/interconnect/qcom/Kconfig   |  11 +
 drivers/interconnect/qcom/Makefile  |   2 +
 drivers/interconnect/qcom/msm8916.c | 482 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect/qcom.h   | 350 ++++++++++++++++++++++++++
 6 files changed, 851 insertions(+)
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/msm8916.c
 create mode 100644 include/linux/interconnect/qcom.h

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index a261c7d41deb..07a8276fa35a 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -8,3 +8,8 @@ menuconfig INTERCONNECT
 
 	  If unsure, say no.
 
+if INTERCONNECT
+
+source "drivers/interconnect/qcom/Kconfig"
+
+endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 5edf0ae80818..5971b811c2d7 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_INTERCONNECT)		+= core.o
+obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
new file mode 100644
index 000000000000..86465dc37bd4
--- /dev/null
+++ b/drivers/interconnect/qcom/Kconfig
@@ -0,0 +1,11 @@
+config INTERCONNECT_QCOM
+	bool "Qualcomm Network-on-Chip interconnect drivers"
+	depends on INTERCONNECT
+	depends on ARCH_QCOM || COMPILE_TEST
+	default y
+
+config INTERCONNECT_QCOM_MSM8916
+	tristate "Qualcomm MSM8916 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based platforms.
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 095bdef1ee6e..a0c13a25e8db 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -1 +1,3 @@
 obj-y += smd-rpm.o
+
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += msm8916.o
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
new file mode 100644
index 000000000000..d5b54f8261c8
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Linaro Ltd
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/interconnect-provider.h>
+#include <linux/interconnect/qcom.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "smd-rpm.h"
+
+#define RPM_MASTER_FIELD_BW	0x00007762
+#define RPM_BUS_MASTER_REQ      0x73616d62
+#define RPM_BUS_SLAVE_REQ       0x766c7362
+
+#define to_qcom_provider(_provider) \
+	container_of(_provider, struct qcom_icc_provider, provider)
+
+#define DEFINE_QNODE(_name, _id, _port, _buswidth, _ap_owned,		\
+			_mas_rpm_id, _slv_rpm_id, _qos_mode,		\
+			_numlinks, ...)					\
+		static struct qcom_icc_node _name = {			\
+		.id = _id,						\
+		.name = #_name,						\
+		.port = _port,						\
+		.buswidth = _buswidth,					\
+		.qos_mode = _qos_mode,					\
+		.ap_owned = _ap_owned,					\
+		.mas_rpm_id = _mas_rpm_id,				\
+		.slv_rpm_id = _slv_rpm_id,				\
+		.num_links = _numlinks,					\
+		.links = { __VA_ARGS__ },				\
+	}
+
+enum qcom_qos_mode {
+	QCOM_QOS_MODE_BYPASS = 0,
+	QCOM_QOS_MODE_FIXED,
+	QCOM_QOS_MODE_MAX,
+};
+
+struct qcom_icc_provider {
+	struct icc_provider	provider;
+	void __iomem		*base;
+	struct clk		*bus_clk;
+	struct clk		*bus_a_clk;
+};
+
+#define MSM8916_MAX_LINKS	8
+
+/**
+ * struct qcom_icc_node - Qualcomm specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @links: an array of nodes where we can go next while traversing
+ * @id: a unique node identifier
+ * @num_links: the total number of @links
+ * @port: the offset index into the masters QoS register space
+ * @buswidth: width of the interconnect between a node and the bus
+ * @ap_owned: the AP CPU does the writing to QoS registers
+ * @rpm: reference to the RPM SMD driver
+ * @qos_mode: QoS mode for ap_owned resources
+ * @mas_rpm_id:	RPM id for devices that are bus masters
+ * @slv_rpm_id:	RPM id for devices that are bus slaves
+ * @rate: current bus clock rate in Hz
+ */
+struct qcom_icc_node {
+	unsigned char *name;
+	u16 links[MSM8916_MAX_LINKS];
+	u16 id;
+	u16 num_links;
+	u16 port;
+	u16 buswidth;
+	bool ap_owned;
+	struct qcom_smd_rpm *rpm;
+	enum qcom_qos_mode qos_mode;
+	int mas_rpm_id;
+	int slv_rpm_id;
+	u64 rate;
+};
+
+struct qcom_icc_desc {
+	struct qcom_icc_node **nodes;
+	size_t num_nodes;
+};
+
+DEFINE_QNODE(mas_video, 63, 8, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10000, 10002);
+DEFINE_QNODE(mas_jpeg, 62, 6, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10000, 10002);
+DEFINE_QNODE(mas_vfe, 29, 9, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10001, 10002);
+DEFINE_QNODE(mas_mdp, 22, 7, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10000, 10002);
+DEFINE_QNODE(mas_qdss_bam, 53, 11, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10009);
+DEFINE_QNODE(mas_snoc_cfg, 54, 0, 16, 0, 20, -1, QCOM_QOS_MODE_BYPASS, 1, 10009);
+DEFINE_QNODE(mas_qdss_etr, 60, 10, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10009);
+DEFINE_QNODE(mm_int_0, 10000, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10003);
+DEFINE_QNODE(mm_int_1, 10001, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10003);
+DEFINE_QNODE(mm_int_2, 10002, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10004);
+DEFINE_QNODE(mm_int_bimc, 10003, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10008);
+DEFINE_QNODE(snoc_int_0, 10004, 0, 8, 0, 99, 130, QCOM_QOS_MODE_FIXED, 3, 588, 519, 10027);
+DEFINE_QNODE(snoc_int_1, 10005, 0, 8, 0, 100, 131, QCOM_QOS_MODE_FIXED, 3, 517, 663, 664);
+DEFINE_QNODE(snoc_int_bimc, 10006, 0, 8, 0, 101, 132, QCOM_QOS_MODE_FIXED, 1, 10007);
+DEFINE_QNODE(snoc_bimc_0_mas, 10007, 0, 8, 0, 3, -1, QCOM_QOS_MODE_FIXED, 1, 10025);
+DEFINE_QNODE(snoc_bimc_1_mas, 10008, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10026);
+DEFINE_QNODE(qdss_int, 10009, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, 10004, 10006);
+DEFINE_QNODE(bimc_snoc_slv, 10017, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, 10004, 10005);
+DEFINE_QNODE(snoc_pnoc_mas, 10027, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10028);
+DEFINE_QNODE(pnoc_snoc_slv, 10011, 0, 8, 0, -1, 45, QCOM_QOS_MODE_FIXED, 3, 10004, 10006, 10005);
+DEFINE_QNODE(slv_srvc_snoc, 587, 0, 8, 0, -1, 29, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_qdss_stm, 588, 0, 4, 0, -1, 30, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_imem, 519, 0, 8, 0, -1, 26, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_apss, 517, 0, 4, 0, -1, 20, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_cats_0, 663, 0, 16, 0, -1, 106, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_cats_1, 664, 0, 8, 0, -1, 107, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(mas_apss, 1, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
+DEFINE_QNODE(mas_tcu0, 104, 5, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
+DEFINE_QNODE(mas_tcu1, 105, 6, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
+DEFINE_QNODE(mas_gfx, 26, 2, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
+DEFINE_QNODE(bimc_snoc_mas, 10016, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10017);
+DEFINE_QNODE(snoc_bimc_0_slv, 10025, 0, 8, 0, -1, 24, QCOM_QOS_MODE_FIXED, 1, 512);
+DEFINE_QNODE(snoc_bimc_1_slv, 10026, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 512);
+DEFINE_QNODE(slv_ebi_ch0, 512, 0, 8, 0, -1, 0, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_apps_l2, 514, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(snoc_pnoc_slv, 10028, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10012);
+DEFINE_QNODE(pnoc_int_0, 10012, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 8, 10010, 10018, 10019, 10020, 10021, 10022, 10023, 10024);
+DEFINE_QNODE(pnoc_int_1, 10013, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10010);
+DEFINE_QNODE(pnoc_m_0, 10014, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10012);
+DEFINE_QNODE(pnoc_m_1, 10015, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10010);
+DEFINE_QNODE(pnoc_s_0, 10018, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 620, 624, 579, 622, 521);
+DEFINE_QNODE(pnoc_s_1, 10019, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 627, 625, 535, 577, 618);
+DEFINE_QNODE(pnoc_s_2, 10020, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 533, 630, 629, 641, 632);
+DEFINE_QNODE(pnoc_s_3, 10021, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 536, 647, 636, 635, 634);
+DEFINE_QNODE(pnoc_s_4, 10022, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, 596, 589, 590);
+DEFINE_QNODE(pnoc_s_8, 10023, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, 614, 606, 613);
+DEFINE_QNODE(pnoc_s_9, 10024, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, 609, 522, 598);
+DEFINE_QNODE(slv_imem_cfg, 627, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_crypto_0_cfg, 625, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_msg_ram, 535, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_pdm, 577, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_prng, 618, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_clk_ctl, 620, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_mss, 521, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_tlmm, 624, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_tcsr, 579, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_security, 622, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_spdm, 533, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_pnoc_cfg, 641, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_pmic_arb, 632, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_bimc_cfg, 629, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_boot_rom, 630, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_mpm, 536, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_qdss_cfg, 635, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_rbcpr_cfg, 636, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_snoc_cfg, 647, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_dehr_cfg, 634, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_venus_cfg, 596, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_display_cfg, 590, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_camera_cfg, 589, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_usb_hs, 614, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_sdcc_1, 606, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_blsp_1, 613, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_sdcc_2, 609, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_gfx_cfg, 598, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(slv_audio, 522, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
+DEFINE_QNODE(mas_blsp_1, 86, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10015);
+DEFINE_QNODE(mas_spdm, 36, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10014);
+DEFINE_QNODE(mas_dehr, 75, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10014);
+DEFINE_QNODE(mas_audio, 15, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10014);
+DEFINE_QNODE(mas_usb_hs, 87, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10015);
+DEFINE_QNODE(mas_pnoc_crypto_0, 55, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10013);
+DEFINE_QNODE(mas_pnoc_sdcc_1, 78, 7, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10013);
+DEFINE_QNODE(mas_pnoc_sdcc_2, 81, 8, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10013);
+DEFINE_QNODE(pnoc_snoc_mas, 10010, 0, 8, 0, 29, -1, QCOM_QOS_MODE_FIXED, 1, 10011);
+
+static struct qcom_icc_node *msm8916_snoc_nodes[] = {
+	&mas_video,
+	&mas_jpeg,
+	&mas_vfe,
+	&mas_mdp,
+	&mas_qdss_bam,
+	&mas_snoc_cfg,
+	&mas_qdss_etr,
+	&mm_int_0,
+	&mm_int_1,
+	&mm_int_2,
+	&mm_int_bimc,
+	&snoc_int_0,
+	&snoc_int_1,
+	&snoc_int_bimc,
+	&snoc_bimc_0_mas,
+	&snoc_bimc_1_mas,
+	&qdss_int,
+	&bimc_snoc_slv,
+	&snoc_pnoc_mas,
+	&pnoc_snoc_slv,
+	&slv_srvc_snoc,
+	&slv_qdss_stm,
+	&slv_imem,
+	&slv_apss,
+	&slv_cats_0,
+	&slv_cats_1,
+};
+
+static struct qcom_icc_desc msm8916_snoc = {
+	.nodes = msm8916_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+};
+
+static struct qcom_icc_node *msm8916_bimc_nodes[] = {
+	&mas_apss,
+	&mas_tcu0,
+	&mas_tcu1,
+	&mas_gfx,
+	&bimc_snoc_mas,
+	&snoc_bimc_0_slv,
+	&snoc_bimc_1_slv,
+	&slv_ebi_ch0,
+	&slv_apps_l2,
+};
+
+static struct qcom_icc_desc msm8916_bimc = {
+	.nodes = msm8916_bimc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+};
+
+static struct qcom_icc_node *msm8916_pnoc_nodes[] = {
+	&snoc_pnoc_slv,
+	&pnoc_int_0,
+	&pnoc_int_1,
+	&pnoc_m_0,
+	&pnoc_m_1,
+	&pnoc_s_0,
+	&pnoc_s_1,
+	&pnoc_s_2,
+	&pnoc_s_3,
+	&pnoc_s_4,
+	&pnoc_s_8,
+	&pnoc_s_9,
+	&slv_imem_cfg,
+	&slv_crypto_0_cfg,
+	&slv_msg_ram,
+	&slv_pdm,
+	&slv_prng,
+	&slv_clk_ctl,
+	&slv_mss,
+	&slv_tlmm,
+	&slv_tcsr,
+	&slv_security,
+	&slv_spdm,
+	&slv_pnoc_cfg,
+	&slv_pmic_arb,
+	&slv_bimc_cfg,
+	&slv_boot_rom,
+	&slv_mpm,
+	&slv_qdss_cfg,
+	&slv_rbcpr_cfg,
+	&slv_snoc_cfg,
+	&slv_dehr_cfg,
+	&slv_venus_cfg,
+	&slv_display_cfg,
+	&slv_camera_cfg,
+	&slv_usb_hs,
+	&slv_sdcc_1,
+	&slv_blsp_1,
+	&slv_sdcc_2,
+	&slv_gfx_cfg,
+	&slv_audio,
+	&mas_blsp_1,
+	&mas_spdm,
+	&mas_dehr,
+	&mas_audio,
+	&mas_usb_hs,
+	&mas_pnoc_crypto_0,
+	&mas_pnoc_sdcc_1,
+	&mas_pnoc_sdcc_2,
+	&pnoc_snoc_mas,
+};
+
+static struct qcom_icc_desc msm8916_pnoc = {
+	.nodes = msm8916_pnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_pnoc_nodes),
+};
+
+static int qcom_icc_init(struct icc_node *node)
+{
+	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
+	/* TODO: init qos and priority */
+
+	clk_prepare_enable(qp->bus_clk);
+	clk_prepare_enable(qp->bus_a_clk);
+
+	return 0;
+}
+
+static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
+			u32 avg, u32 peak)
+{
+	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
+	struct icc_node *node;
+	struct icc_provider *provider;
+	u64 avg_bw;
+	u64 peak_bw;
+	u64 rate = 0;
+	int ret = 0;
+
+	if (!src)
+		node = dst;
+	else
+		node = src;
+
+	qn = node->data;
+	provider = node->provider;
+	qp = to_qcom_provider(node->provider);
+
+	/* convert from kbps to bps */
+	avg_bw = avg * 1000ULL;
+	peak_bw = peak * 1000ULL;
+
+	/* set bandwidth */
+	if (qn->ap_owned) {
+		/* TODO: set QoS */
+	} else {
+		/* send message to the RPM processor */
+		if (qn->mas_rpm_id != -1) {
+			ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+						    RPM_BUS_MASTER_REQ,
+						    qn->mas_rpm_id,
+						    avg_bw);
+		}
+
+		if (qn->slv_rpm_id != -1) {
+			ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+						    RPM_BUS_SLAVE_REQ,
+						    qn->slv_rpm_id,
+						    avg_bw);
+		}
+	}
+
+	rate = max(avg_bw, peak_bw);
+
+	do_div(rate, qn->buswidth);
+
+	if (qn->rate != rate) {
+		ret = clk_set_rate(qp->bus_clk, rate);
+		if (ret) {
+			pr_err("set clk rate %lld error %d\n", rate, ret);
+			return ret;
+		}
+
+		ret = clk_set_rate(qp->bus_a_clk, rate);
+		if (ret) {
+			pr_err("set clk rate %lld error %d\n", rate, ret);
+			return ret;
+		}
+
+		qn->rate = rate;
+	}
+
+	return ret;
+}
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+	const struct qcom_icc_desc *desc;
+	struct qcom_icc_node **qnodes;
+	struct qcom_icc_provider *qp;
+	struct resource *res;
+	struct icc_provider *provider;
+	size_t num_nodes, i;
+	int ret;
+
+	/* wait for RPM */
+	if (!qcom_icc_rpm_smd_available())
+		return -EPROBE_DEFER;
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	qp->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(qp->base))
+		return PTR_ERR(qp->base);
+
+	qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
+	if (IS_ERR(qp->bus_clk))
+		return PTR_ERR(qp->bus_clk);
+
+	qp->bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
+	if (IS_ERR(qp->bus_a_clk))
+		return PTR_ERR(qp->bus_a_clk);
+
+	provider = &qp->provider;
+	provider->dev = &pdev->dev;
+	provider->set = &qcom_icc_set;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = qp;
+
+	ret = icc_add_provider(provider);
+	if (ret) {
+		dev_err(&pdev->dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	for (i = 0; i < num_nodes; i++) {
+		struct icc_node *node;
+		int ret;
+		size_t j;
+
+		node = icc_node_create(qnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = qnodes[i]->name;
+		node->data = qnodes[i];
+		icc_node_add(node, provider);
+
+		dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
+			qnodes[i]->name, node->id);
+
+		/* populate links */
+		for (j = 0; j < qnodes[i]->num_links; j++)
+			if (qnodes[i]->links[j])
+				icc_link_create(node, qnodes[i]->links[j]);
+
+		ret = qcom_icc_init(node);
+		if (ret)
+			dev_err(&pdev->dev, "%s init error (%d)\n", node->name,
+				ret);
+	}
+
+	platform_set_drvdata(pdev, provider);
+
+	return ret;
+err:
+	icc_del_provider(provider);
+	return ret;
+}
+
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+
+	icc_del_provider(provider);
+
+	return 0;
+}
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,msm8916-pnoc", .data = &msm8916_pnoc },
+	{ .compatible = "qcom,msm8916-snoc", .data = &msm8916_snoc },
+	{ .compatible = "qcom,msm8916-bimc", .data = &msm8916_bimc },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
+	.driver = {
+		.name = "qnoc-msm8916",
+		.of_match_table = qnoc_of_match,
+	},
+};
+module_platform_driver(qnoc_driver);
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm msm8916 NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/interconnect/qcom.h b/include/linux/interconnect/qcom.h
new file mode 100644
index 000000000000..2cd378d2f575
--- /dev/null
+++ b/include/linux/interconnect/qcom.h
@@ -0,0 +1,350 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __QCOM_INTERCONNECT_IDS_H
+#define __QCOM_INTERCONNECT_IDS_H
+
+#define FAB_BIMC 0
+#define FAB_SYS_NOC 1024
+#define FAB_MMSS_NOC 2048
+#define FAB_OCMEM_NOC 3072
+#define FAB_PERIPH_NOC 4096
+#define FAB_CONFIG_NOC 5120
+#define FAB_OCMEM_VNOC 6144
+
+#define MASTER_AMPSS_M0 1
+#define MASTER_AMPSS_M1 2
+#define APPSS_MASTER_FAB_MMSS 3
+#define APPSS_MASTER_FAB_SYSTEM 4
+#define SYSTEM_MASTER_FAB_APPSS 5
+#define MASTER_SPS 6
+#define MASTER_ADM_PORT0 7
+#define MASTER_ADM_PORT1 8
+#define SYSTEM_MASTER_ADM1_PORT0 9
+#define MASTER_ADM1_PORT1 10
+#define MASTER_LPASS_PROC 11
+#define MASTER_MSS_PROCI 12
+#define MASTER_MSS_PROCD 13
+#define MASTER_MSS_MDM_PORT0 14
+#define MASTER_LPASS 15
+#define SYSTEM_MASTER_CPSS_FPB 16
+#define SYSTEM_MASTER_SYSTEM_FPB 17
+#define SYSTEM_MASTER_MMSS_FPB 18
+#define MASTER_ADM1_CI 19
+#define MASTER_ADM0_CI 20
+#define MASTER_MSS_MDM_PORT1 21
+#define MASTER_MDP_PORT0 22
+#define MASTER_MDP_PORT1 23
+#define MMSS_MASTER_ADM1_PORT0 24
+#define MASTER_ROTATOR 25
+#define MASTER_GRAPHICS_3D 26
+#define MASTER_JPEG_DEC 27
+#define MASTER_GRAPHICS_2D_CORE0 28
+#define MASTER_VFE 29
+#define MASTER_VPE 30
+#define MASTER_JPEG_ENC 31
+#define MASTER_GRAPHICS_2D_CORE1 32
+#define MMSS_MASTER_APPS_FAB 33
+#define MASTER_HD_CODEC_PORT0 34
+#define MASTER_HD_CODEC_PORT1 35
+#define MASTER_SPDM 36
+#define MASTER_RPM 37
+#define MASTER_MSS 38
+#define MASTER_RIVA 39
+#define SYSTEM_MASTER_UNUSED_6 40
+#define MASTER_MSS_SW_PROC 41
+#define MASTER_MSS_FW_PROC 42
+#define MMSS_MASTER_UNUSED_2 43
+#define MASTER_GSS_NAV 44
+#define MASTER_PCIE 45
+#define MASTER_SATA 46
+#define MASTER_CRYPTO 47
+#define MASTER_VIDEO_CAP 48
+#define MASTER_GRAPHICS_3D_PORT1 49
+#define MASTER_VIDEO_ENC 50
+#define MASTER_VIDEO_DEC 51
+#define MASTER_LPASS_AHB 52
+#define MASTER_QDSS_BAM 53
+#define MASTER_SNOC_CFG 54
+#define MASTER_CRYPTO_CORE0 55
+#define MASTER_CRYPTO_CORE1 56
+#define MASTER_MSS_NAV 57
+#define MASTER_OCMEM_DMA 58
+#define MASTER_WCSS 59
+#define MASTER_QDSS_ETR 60
+#define MASTER_USB3 61
+#define MASTER_JPEG 62
+#define MASTER_VIDEO_P0 63
+#define MASTER_VIDEO_P1 64
+#define MASTER_MSS_PROC 65
+#define MASTER_JPEG_OCMEM 66
+#define MASTER_MDP_OCMEM 67
+#define MASTER_VIDEO_P0_OCMEM 68
+#define MASTER_VIDEO_P1_OCMEM 69
+#define MASTER_VFE_OCMEM 70
+#define MASTER_CNOC_ONOC_CFG 71
+#define MASTER_RPM_INST 72
+#define MASTER_RPM_DATA 73
+#define MASTER_RPM_SYS 74
+#define MASTER_DEHR 75
+#define MASTER_QDSS_DAP 76
+#define MASTER_TIC 77
+#define MASTER_SDCC_1 78
+#define MASTER_SDCC_3 79
+#define MASTER_SDCC_4 80
+#define MASTER_SDCC_2 81
+#define MASTER_TSIF 82
+#define MASTER_BAM_DMA 83
+#define MASTER_BLSP_2 84
+#define MASTER_USB_HSIC 85
+#define MASTER_BLSP_1 86
+#define MASTER_USB_HS 87
+#define MASTER_PNOC_CFG 88
+#define MASTER_V_OCMEM_GFX3D 89
+#define MASTER_IPA 90
+#define MASTER_QPIC 91
+#define MASTER_MDPE 92
+#define MASTER_USB_HS2 93
+#define MASTER_VPU 94
+#define MASTER_UFS 95
+#define MASTER_BCAST 96
+#define MASTER_CRYPTO_CORE2 97
+#define MASTER_EMAC 98
+#define MASTER_VPU_1 99
+#define MASTER_PCIE_1 100
+#define MASTER_USB3_1 101
+#define MASTER_CNOC_MNOC_MMSS_CFG 102
+#define MASTER_CNOC_MNOC_CFG 103
+#define MASTER_TCU_0 104
+#define MASTER_TCU_1 105
+#define MASTER_CPP 106
+#define MASTER_AUDIO 107
+
+#define SNOC_MM_INT_0 10000
+#define SNOC_MM_INT_1 10001
+#define SNOC_MM_INT_2 10002
+#define SNOC_MM_INT_BIMC 10003
+#define SNOC_INT_0 10004
+#define SNOC_INT_1 10005
+#define SNOC_INT_BIMC 10006
+#define SNOC_BIMC_0_MAS 10007
+#define SNOC_BIMC_1_MAS 10008
+#define SNOC_QDSS_INT 10009
+#define PNOC_SNOC_MAS 10010
+#define PNOC_SNOC_SLV 10011
+#define PNOC_INT_0 10012
+#define PNOC_INT_1 10013
+#define PNOC_M_0 10014
+#define PNOC_M_1 10015
+#define BIMC_SNOC_MAS 10016
+#define BIMC_SNOC_SLV 10017
+#define PNOC_SLV_0 10018
+#define PNOC_SLV_1 10019
+#define PNOC_SLV_2 10020
+#define PNOC_SLV_3 10021
+#define PNOC_SLV_4 10022
+#define PNOC_SLV_8 10023
+#define PNOC_SLV_9 10024
+#define SNOC_BIMC_0_SLV 10025
+#define SNOC_BIMC_1_SLV 10026
+#define MNOC_BIMC_MAS 10027
+#define MNOC_BIMC_SLV 10028
+#define BIMC_MNOC_MAS 10029
+#define BIMC_MNOC_SLV 10030
+#define SNOC_BIMC_MAS 10031
+#define SNOC_BIMC_SLV 10032
+#define CNOC_SNOC_MAS 10033
+#define CNOC_SNOC_SLV 10034
+#define SNOC_CNOC_MAS 10035
+#define SNOC_CNOC_SLV 10036
+#define OVNOC_SNOC_MAS 10037
+#define OVNOC_SNOC_SLV 10038
+#define SNOC_OVNOC_MAS 10039
+#define SNOC_OVNOC_SLV 10040
+#define SNOC_PNOC_MAS 10041
+#define SNOC_PNOC_SLV 10042
+#define BIMC_INT_APPS_EBI 10043
+#define BIMC_INT_APPS_SNOC 10044
+#define SNOC_BIMC_2_MAS 10045
+#define SNOC_BIMC_2_SLV 10046
+#define PNOC_SLV_5 10047
+#define PNOC_SLV_7 10048
+#define PNOC_INT_2 10049
+#define PNOC_INT_3 10050
+#define PNOC_INT_4 10051
+#define PNOC_INT_5 10052
+#define PNOC_INT_6 10053
+#define PNOC_INT_7 10054
+
+#define SLAVE_EBI_CH0 512
+#define SLAVE_EBI_CH1 513
+#define SLAVE_AMPSS_L2 514
+#define APPSS_SLAVE_FAB_MMSS 515
+#define APPSS_SLAVE_FAB_SYSTEM 516
+#define SYSTEM_SLAVE_FAB_APPS 517
+#define SLAVE_SPS 518
+#define SLAVE_SYSTEM_IMEM 519
+#define SLAVE_AMPSS 520
+#define SLAVE_MSS 521
+#define SLAVE_LPASS 522
+#define SYSTEM_SLAVE_CPSS_FPB 523
+#define SYSTEM_SLAVE_SYSTEM_FPB 524
+#define SYSTEM_SLAVE_MMSS_FPB 525
+#define SLAVE_CORESIGHT 526
+#define SLAVE_RIVA 527
+#define SLAVE_SMI 528
+#define MMSS_SLAVE_FAB_APPS 529
+#define MMSS_SLAVE_FAB_APPS_1 530
+#define SLAVE_MM_IMEM 531
+#define SLAVE_CRYPTO 532
+#define SLAVE_SPDM 533
+#define SLAVE_RPM 534
+#define SLAVE_RPM_MSG_RAM 535
+#define SLAVE_MPM 536
+#define SLAVE_PMIC1_SSBI1_A 537
+#define SLAVE_PMIC1_SSBI1_B 538
+#define SLAVE_PMIC1_SSBI1_C 539
+#define SLAVE_PMIC2_SSBI2_A 540
+#define SLAVE_PMIC2_SSBI2_B 541
+#define SLAVE_GSBI1_UART 542
+#define SLAVE_GSBI2_UART 543
+#define SLAVE_GSBI3_UART 544
+#define SLAVE_GSBI4_UART 545
+#define SLAVE_GSBI5_UART 546
+#define SLAVE_GSBI6_UART 547
+#define SLAVE_GSBI7_UART 548
+#define SLAVE_GSBI8_UART 549
+#define SLAVE_GSBI9_UART 550
+#define SLAVE_GSBI10_UART 551
+#define SLAVE_GSBI11_UART 552
+#define SLAVE_GSBI12_UART 553
+#define SLAVE_GSBI1_QUP 554
+#define SLAVE_GSBI2_QUP 555
+#define SLAVE_GSBI3_QUP 556
+#define SLAVE_GSBI4_QUP 557
+#define SLAVE_GSBI5_QUP 558
+#define SLAVE_GSBI6_QUP 559
+#define SLAVE_GSBI7_QUP 560
+#define SLAVE_GSBI8_QUP 561
+#define SLAVE_GSBI9_QUP 562
+#define SLAVE_GSBI10_QUP 563
+#define SLAVE_GSBI11_QUP 564
+#define SLAVE_GSBI12_QUP 565
+#define SLAVE_EBI2_NAND 566
+#define SLAVE_EBI2_CS0 567
+#define SLAVE_EBI2_CS1 568
+#define SLAVE_EBI2_CS2 569
+#define SLAVE_EBI2_CS3 570
+#define SLAVE_EBI2_CS4 571
+#define SLAVE_EBI2_CS5 572
+#define SLAVE_USB_FS1 573
+#define SLAVE_USB_FS2 574
+#define SLAVE_TSIF 575
+#define SLAVE_MSM_TSSC 576
+#define SLAVE_MSM_PDM 577
+#define SLAVE_MSM_DIMEM 578
+#define SLAVE_MSM_TCSR 579
+#define SLAVE_MSM_PRNG 580
+#define SLAVE_GSS 581
+#define SLAVE_SATA 582
+#define SLAVE_USB3 583
+#define SLAVE_WCSS 584
+#define SLAVE_OCIMEM 585
+#define SLAVE_SNOC_OCMEM 586
+#define SLAVE_SERVICE_SNOC 587
+#define SLAVE_QDSS_STM 588
+#define SLAVE_CAMERA_CFG 589
+#define SLAVE_DISPLAY_CFG 590
+#define SLAVE_OCMEM_CFG 591
+#define SLAVE_CPR_CFG 592
+#define SLAVE_CPR_XPU_CFG 593
+#define SLAVE_MISC_CFG 594
+#define SLAVE_MISC_XPU_CFG 595
+#define SLAVE_VENUS_CFG 596
+#define SLAVE_MISC_VENUS_CFG 597
+#define SLAVE_GRAPHICS_3D_CFG 598
+#define SLAVE_MMSS_CLK_CFG 599
+#define SLAVE_MMSS_CLK_XPU_CFG 600
+#define SLAVE_MNOC_MPU_CFG 601
+#define SLAVE_ONOC_MPU_CFG 602
+#define SLAVE_SERVICE_MNOC 603
+#define SLAVE_OCMEM 604
+#define SLAVE_SERVICE_ONOC 605
+#define SLAVE_SDCC_1 606
+#define SLAVE_SDCC_3 607
+#define SLAVE_SDCC_2 608
+#define SLAVE_SDCC_4 609
+#define SLAVE_BAM_DMA 610
+#define SLAVE_BLSP_2 611
+#define SLAVE_USB_HSIC 612
+#define SLAVE_BLSP_1 613
+#define SLAVE_USB_HS 614
+#define SLAVE_PDM 615
+#define SLAVE_PERIPH_APU_CFG 616
+#define SLAVE_PNOC_MPU_CFG 617
+#define SLAVE_PRNG 618
+#define SLAVE_SERVICE_PNOC 619
+#define SLAVE_CLK_CTL 620
+#define SLAVE_CNOC_MSS 621
+#define SLAVE_SECURITY 622
+#define SLAVE_TCSR 623
+#define SLAVE_TLMM 624
+#define SLAVE_CRYPTO_0_CFG 625
+#define SLAVE_CRYPTO_1_CFG 626
+#define SLAVE_IMEM_CFG 627
+#define SLAVE_MESSAGE_RAM 628
+#define SLAVE_BIMC_CFG 629
+#define SLAVE_BOOT_ROM 630
+#define SLAVE_CNOC_MNOC_MMSS_CFG 631
+#define SLAVE_PMIC_ARB 632
+#define SLAVE_SPDM_WRAPPER 633
+#define SLAVE_DEHR_CFG 634
+#define SLAVE_QDSS_CFG 635
+#define SLAVE_RBCPR_CFG 636
+#define SLAVE_RBCPR_QDSS_APU_CFG 637
+#define SLAVE_SNOC_MPU_CFG 638
+#define SLAVE_CNOC_ONOC_CFG 639
+#define SLAVE_CNOC_MNOC_CFG 640
+#define SLAVE_PNOC_CFG 641
+#define SLAVE_SNOC_CFG 642
+#define SLAVE_EBI1_DLL_CFG 643
+#define SLAVE_PHY_APU_CFG 644
+#define SLAVE_EBI1_PHY_CFG 645
+#define SLAVE_SERVICE_CNOC 646
+#define SLAVE_IPS_CFG 647
+#define SLAVE_QPIC 648
+#define SLAVE_DSI_CFG 649
+#define SLAVE_UFS_CFG 650
+#define SLAVE_RBCPR_CX_CFG 651
+#define SLAVE_RBCPR_MX_CFG 652
+#define SLAVE_PCIE_CFG 653
+#define SLAVE_USB_PHYS_CFG 654
+#define SLAVE_VIDEO_CAP_CFG 655
+#define SLAVE_AVSYNC_CFG 656
+#define SLAVE_CRYPTO_2_CFG 657
+#define SLAVE_VPU_CFG 658
+#define SLAVE_BCAST_CFG 659
+#define SLAVE_KLM_CFG 660
+#define SLAVE_GENI_IR_CFG 661
+#define SLAVE_OCMEM_GFX 662
+#define SLAVE_CATS_128 663
+#define SLAVE_OCMEM_64 664
+#define SLAVE_PCIE_0 665
+#define SLAVE_PCIE_1 666
+#define SLAVE_PCIE_0_CFG 667
+#define SLAVE_PCIE_1_CFG 668
+#define SLAVE_SRVC_MNOC 669
+#define SLAVE_USB_HS2 670
+#define SLAVE_AUDIO 671
+#define SLAVE_TCU 672
+#define SLAVE_APPSS 673
+#define SLAVE_PCIE_PARF 674
+#define SLAVE_USB3_PHY_CFG 675
+#define SLAVE_IPA_CFG 676
+
+#endif
