Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965449AbeBMRB3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:01:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55487 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965419AbeBMRBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:20 -0500
X-Google-Smtp-Source: AH8x2249jcBSU3miTlwngTAj/w1h8n0Hah8iRtrNLJTKO9ykgy3g/XQS0iCsRv6QDEr+HADJUNGzBA==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
        spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 03/25] ASoC: qcom: qdsp6: Add common qdsp6 helper functions
Date: Tue, 13 Feb 2018 16:58:15 +0000
Message-Id: <20180213165837.1620-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds some common helper functions like translating dsp error
to linux error codes and channel mappings etc.

These functions are used in all the following qdsp6 drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig              | 14 ++++++
 sound/soc/qcom/qdsp6/Makefile       |  1 +
 sound/soc/qcom/qdsp6/q6dsp-common.c | 67 +++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6dsp-common.h | 24 +++++++++
 sound/soc/qcom/qdsp6/q6dsp-errno.h  | 97 +++++++++++++++++++++++++++++++++++++
 5 files changed, 203 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/Makefile
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8ec9a074b38b..b01f347b427d 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -43,3 +43,17 @@ config SND_SOC_APQ8016_SBC
           Support for Qualcomm Technologies LPASS audio block in
           APQ8016 SOC-based systems.
           Say Y if you want to use audio devices on MI2S.
+
+config SND_SOC_QDSP6_COMMON
+	tristate
+	default n
+
+config SND_SOC_QDSP6
+	tristate "SoC ALSA audio driver for QDSP6"
+	depends on QCOM_APR && HAS_DMA
+	select SND_SOC_QDSP6_COMMON
+	help
+	 To add support for MSM QDSP6 Soc Audio.
+	 This will enable sound soc platform specific
+	 audio drivers. This includes q6asm, q6adm,
+	 q6afe interfaces to DSP using apr.
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
new file mode 100644
index 000000000000..accebdb49306
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
diff --git a/sound/soc/qcom/qdsp6/q6dsp-common.c b/sound/soc/qcom/qdsp6/q6dsp-common.c
new file mode 100644
index 000000000000..3fe5b7942c4c
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2017, The Linux Foundation
+ * Copyright (c) 2018, Linaro Limited
+ */
+#include "q6dsp-common.h"
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+
+int q6dsp_map_channels(u8 ch_map[PCM_FORMAT_MAX_NUM_CHANNEL], int ch)
+{
+	memset(ch_map, 0, PCM_FORMAT_MAX_NUM_CHANNEL);
+
+	switch (ch) {
+	case 1:
+			ch_map[0] = PCM_CHANNEL_FC;
+		break;
+	case 2:
+			ch_map[0] = PCM_CHANNEL_FL;
+			ch_map[1] = PCM_CHANNEL_FR;
+		break;
+	case 3:
+			ch_map[0] = PCM_CHANNEL_FL;
+			ch_map[1] = PCM_CHANNEL_FR;
+			ch_map[2] = PCM_CHANNEL_FC;
+		break;
+	case 4:
+			ch_map[0] = PCM_CHANNEL_FL;
+			ch_map[1] = PCM_CHANNEL_FR;
+			ch_map[2] = PCM_CHANNEL_LS;
+			ch_map[3] = PCM_CHANNEL_RS;
+		break;
+	case 5:
+			ch_map[0] = PCM_CHANNEL_FL;
+			ch_map[1] = PCM_CHANNEL_FR;
+			ch_map[2] = PCM_CHANNEL_FC;
+			ch_map[3] = PCM_CHANNEL_LS;
+			ch_map[4] = PCM_CHANNEL_RS;
+		break;
+	case 6:
+			ch_map[0] = PCM_CHANNEL_FL;
+			ch_map[1] = PCM_CHANNEL_FR;
+			ch_map[2] = PCM_CHANNEL_LFE;
+			ch_map[3] = PCM_CHANNEL_FC;
+			ch_map[4] = PCM_CHANNEL_LS;
+			ch_map[5] = PCM_CHANNEL_RS;
+		break;
+	case 8:
+			ch_map[0] = PCM_CHANNEL_FL;
+			ch_map[1] = PCM_CHANNEL_FR;
+			ch_map[2] = PCM_CHANNEL_LFE;
+			ch_map[3] = PCM_CHANNEL_FC;
+			ch_map[4] = PCM_CHANNEL_LS;
+			ch_map[5] = PCM_CHANNEL_RS;
+			ch_map[6] = PCM_CHANNEL_LB;
+			ch_map[7] = PCM_CHANNEL_RB;
+		break;
+	default:
+			return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6dsp_map_channels);
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6dsp-common.h b/sound/soc/qcom/qdsp6/q6dsp-common.h
new file mode 100644
index 000000000000..32386f4a6432
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __Q6DSP_COMMON_H__
+#define __Q6DSP_COMMON_H__
+
+#include <linux/kernel.h>
+
+#define PCM_FORMAT_MAX_NUM_CHANNEL  8
+#define PCM_CHANNEL_NULL 0
+
+#define PCM_CHANNEL_FL    1	/* Front left channel. */
+#define PCM_CHANNEL_FR    2	/* Front right channel. */
+#define PCM_CHANNEL_FC    3	/* Front center channel. */
+#define PCM_CHANNEL_LS   4	/* Left surround channel. */
+#define PCM_CHANNEL_RS   5	/* Right surround channel. */
+#define PCM_CHANNEL_LFE  6	/* Low frequency effect channel. */
+#define PCM_CHANNEL_CS   7	/* Center surround channel; Rear center ch */
+#define PCM_CHANNEL_LB   8	/* Left back channel; Rear left channel. */
+#define PCM_CHANNEL_RB   9	/* Right back channel; Rear right channel. */
+#define PCM_CHANNELS   10	/* Top surround channel. */
+
+int q6dsp_map_channels(u8 ch_map[PCM_FORMAT_MAX_NUM_CHANNEL], int ch);
+
+#endif /* __Q6DSP_COMMON_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6dsp-errno.h b/sound/soc/qcom/qdsp6/q6dsp-errno.h
new file mode 100644
index 000000000000..763c19bb4a13
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6dsp-errno.h
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __Q6DSP_ERR_NO_H__
+#define __Q6DSP_ERR_NO_H__
+#include <linux/kernel.h>
+
+/* Success. The operation completed with no errors. */
+#define ADSP_EOK          0x00000000
+/* General failure. */
+#define ADSP_EFAILED      0x00000001
+/* Bad operation parameter. */
+#define ADSP_EBADPARAM    0x00000002
+/* Unsupported routine or operation. */
+#define ADSP_EUNSUPPORTED 0x00000003
+/* Unsupported version. */
+#define ADSP_EVERSION     0x00000004
+/* Unexpected problem encountered. */
+#define ADSP_EUNEXPECTED  0x00000005
+/* Unhandled problem occurred. */
+#define ADSP_EPANIC       0x00000006
+/* Unable to allocate resource. */
+#define ADSP_ENORESOURCE  0x00000007
+/* Invalid handle. */
+#define ADSP_EHANDLE      0x00000008
+/* Operation is already processed. */
+#define ADSP_EALREADY     0x00000009
+/* Operation is not ready to be processed. */
+#define ADSP_ENOTREADY    0x0000000A
+/* Operation is pending completion. */
+#define ADSP_EPENDING     0x0000000B
+/* Operation could not be accepted or processed. */
+#define ADSP_EBUSY        0x0000000C
+/* Operation aborted due to an error. */
+#define ADSP_EABORTED     0x0000000D
+/* Operation preempted by a higher priority. */
+#define ADSP_EPREEMPTED   0x0000000E
+/* Operation requests intervention to complete. */
+#define ADSP_ECONTINUE    0x0000000F
+/* Operation requests immediate intervention to complete. */
+#define ADSP_EIMMEDIATE   0x00000010
+/* Operation is not implemented. */
+#define ADSP_ENOTIMPL     0x00000011
+/* Operation needs more data or resources. */
+#define ADSP_ENEEDMORE    0x00000012
+/* Operation does not have memory. */
+#define ADSP_ENOMEMORY    0x00000014
+/* Item does not exist. */
+#define ADSP_ENOTEXIST    0x00000015
+/* Max count for adsp error code sent to HLOS*/
+
+struct q6dsp_err_code {
+	int	lnx_err_code;
+	char	*adsp_err_str;
+};
+
+static struct q6dsp_err_code q6dsp_err_codes[] = {
+	[ADSP_EFAILED] = { -ENOTRECOVERABLE, "ADSP_EFAILED"},
+	[ADSP_EBADPARAM] = { -EINVAL, "ADSP_EBADPARAM"},
+	[ADSP_EUNSUPPORTED] = { -ENOSYS, "ADSP_EUNSUPPORTED"},
+	[ADSP_EVERSION] = { -ENOPROTOOPT, "ADSP_EVERSION"},
+	[ADSP_EUNEXPECTED] = { -ENOTRECOVERABLE, "ADSP_EUNEXPECTED"},
+	[ADSP_EPANIC] = { -ENOTRECOVERABLE, "ADSP_EPANIC"},
+	[ADSP_ENORESOURCE] = { -ENOSPC, "ADSP_ENORESOURCE"},
+	[ADSP_EHANDLE] = { -EBADR, "ADSP_EHANDLE"},
+	[ADSP_EALREADY] = { -EALREADY, "ADSP_EALREADY"},
+	[ADSP_ENOTREADY] = { -EPERM, "ADSP_ENOTREADY"},
+	[ADSP_EPENDING] = { -EINPROGRESS, "ADSP_EPENDING"},
+	[ADSP_EBUSY] = { -EBUSY, "ADSP_EBUSY"},
+	[ADSP_EABORTED] = { -ECANCELED, "ADSP_EABORTED"},
+	[ADSP_EPREEMPTED] = { -EAGAIN, "ADSP_EPREEMPTED"},
+	[ADSP_ECONTINUE] = { -EAGAIN, "ADSP_ECONTINUE"},
+	[ADSP_EIMMEDIATE] = { -EAGAIN, "ADSP_EIMMEDIATE"},
+	[ADSP_ENOTIMPL] = { -EAGAIN, "ADSP_ENOTIMPL"},
+	[ADSP_ENEEDMORE] = { -ENODATA, "ADSP_ENEEDMORE"},
+	[ADSP_ENOMEMORY] = { -EINVAL, "ADSP_ENOMEMORY"},
+	[ADSP_ENOTEXIST] = { -ENOENT, "ADSP_ENOTEXIST"},
+};
+
+static inline int q6dsp_errno(u32 error)
+{
+	int ret = -EINVAL;
+
+	if (error <= ARRAY_SIZE(q6dsp_err_codes))
+		ret = q6dsp_err_codes[error].lnx_err_code;
+
+	return ret;
+}
+
+static inline char *q6dsp_strerror(u32 error)
+{
+	if (error <= ARRAY_SIZE(q6dsp_err_codes))
+		return q6dsp_err_codes[error].adsp_err_str;
+
+	return  "ADSP_ERR_MAX";
+}
+
+#endif /*__Q6DSP_ERR_NO_H__ */
-- 
2.15.1
