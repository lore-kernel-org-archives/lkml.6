Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF00C65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A21206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A21206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeJETl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:41:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:8943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:41:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 05:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97687793"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 05:43:22 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 06/16] stm class: Factor out default framing protocol
Date:   Fri,  5 Oct 2018 15:42:56 +0300
Message-Id: <20181005124306.54870-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STP framing pattern that the stm class implicitly applies to the
data payload is, in fact, a protocol. This patch moves the relevant code
out of the stm core into its own driver module.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/stm/Kconfig   | 15 +++++++++++
 drivers/hwtracing/stm/Makefile  |  4 +++
 drivers/hwtracing/stm/p_basic.c | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 drivers/hwtracing/stm/p_basic.c

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index 723e2d90083d..262e7891fb97 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -11,6 +11,21 @@ config STM
 
 if STM
 
+config STM_PROTO_BASIC
+	tristate "Basic STM framing protocol driver"
+	default CONFIG_STM
+	help
+	  This is a simple framing protocol for sending data over STM
+	  devices. This was the protocol that the STM framework used
+	  exclusively until the MIPI SyS-T support was added. Use this
+	  driver for compatibility with your existing STM setup.
+
+	  The receiving side only needs to be able to decode the MIPI
+	  STP protocol in order to extract the data.
+
+	  If you want to be able to use the basic protocol or want the
+	  backwards compatibility for your existing setup, say Y.
+
 config STM_DUMMY
 	tristate "Dummy STM driver"
 	help
diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
index effc19e5190f..1571de66eca4 100644
--- a/drivers/hwtracing/stm/Makefile
+++ b/drivers/hwtracing/stm/Makefile
@@ -3,6 +3,10 @@ obj-$(CONFIG_STM)	+= stm_core.o
 
 stm_core-y		:= core.o policy.o
 
+obj-$(CONFIG_STM_PROTO_BASIC) += stm_p_basic.o
+
+stm_p_basic-y		:= p_basic.o
+
 obj-$(CONFIG_STM_DUMMY)	+= dummy_stm.o
 
 obj-$(CONFIG_STM_SOURCE_CONSOLE)	+= stm_console.o
diff --git a/drivers/hwtracing/stm/p_basic.c b/drivers/hwtracing/stm/p_basic.c
new file mode 100644
index 000000000000..8980a6a5fd6c
--- /dev/null
+++ b/drivers/hwtracing/stm/p_basic.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic framing protocol for STM devices.
+ * Copyright (c) 2018, Intel Corporation.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/stm.h>
+#include "stm.h"
+
+static ssize_t basic_write(struct stm_data *data, struct stm_output *output,
+			   unsigned int chan, const char *buf, size_t count)
+{
+	unsigned int c = output->channel + chan;
+	unsigned int m = output->master;
+	const unsigned char nil = 0;
+	ssize_t sz;
+
+	sz = stm_data_write(data, m, c, true, buf, count);
+	if (sz > 0)
+		data->packet(data, m, c, STP_PACKET_FLAG, 0, 0, &nil);
+
+	return sz;
+}
+
+static const struct stm_protocol_driver basic_pdrv = {
+	.owner	= THIS_MODULE,
+	.name	= "p_basic",
+	.write	= basic_write,
+};
+
+static int basic_stm_init(void)
+{
+	return stm_register_protocol(&basic_pdrv);
+}
+
+static void basic_stm_exit(void)
+{
+	stm_unregister_protocol(&basic_pdrv);
+}
+
+module_init(basic_stm_init);
+module_exit(basic_stm_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Basic STM framing protocol driver");
+MODULE_AUTHOR("Alexander Shishkin <alexander.shishkin@linux.intel.com>");
-- 
2.19.0

