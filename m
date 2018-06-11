Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 450D0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF5B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oJJKpjai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF5B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934307AbeFKVKI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:10:08 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43442 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbeFKVKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:10:02 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so9734615pgw.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4N1pUEOqtYoE4QrdjqlrMFZw5wZoa1dipcGG1369/Aw=;
        b=oJJKpjaix09E94mcXEet12pwrhpx7j+CL5fNO063w+R3UdOfuv6S21LlKMq0doD0BT
         kXR4Ae/rv3CQb3dXppGRyTLTiblkqTwcWprf8pwAYHdM9cdmIXSBz7DxwY0hY+U+Bwfc
         Z48ivrIwjI+76CZmBKCXVICmnVvRumZbEsYAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4N1pUEOqtYoE4QrdjqlrMFZw5wZoa1dipcGG1369/Aw=;
        b=WDYURkbLRTT4oTHzfomklvdFMe/VEVe+R3E7Ca0v3FLi1j83tFHutNQW2oMpDWCXis
         m7OWPPE9v7plCyKn5GsiPRn5HlDrhvDlOaYjzQvb0Qe8V6F0ILQ55xnCrOY4zc4PTbMK
         5zCFoas9Eniuti6x59mp74dZjMGx24A78XSGYRFET6dY7pt90cZjtuZgnOr5tNK7Weff
         bT/xmOHmE16Yc+g7qT3bBrbG5jJ9ED1OX+Y0/w+9oWWrO7a/G2w5fr/0OPhL+s5m3ksM
         YxRc4YkXk5EJ9LO9PY4fmBfgCyTsJLULi+HjmBMb5ArJ82v4kDlXyXKnEjAbX9cMyvIe
         TRFw==
X-Gm-Message-State: APt69E0Iz1nH3uWaalpyG/oG4XUTo4SnBSTYZxRVotQUgM99Bcpo4FCU
        VrgiUP92mw6qLJQgaPUoWkUzeYIxiPU=
X-Google-Smtp-Source: ADUXVKJYQapMSht1dA/6twVYsUzknjvwG2homiHZU+PSQH4nhA0XAZtUqAJrFZwQL/oRuI1jdOEQSA==
X-Received: by 2002:a62:ed13:: with SMTP id u19-v6mr754569pfh.125.1528751401663;
        Mon, 11 Jun 2018 14:10:01 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id c4-v6sm49116184pfe.53.2018.06.11.14.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:10:00 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/4] ath10k: snoc: stop including pci.h
Date:   Mon, 11 Jun 2018 14:09:44 -0700
Message-Id: <20180611210946.241341-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180611210946.241341-1-briannorris@chromium.org>
References: <20180611210946.241341-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easier to violate abstractions and introduce bugs when snoc.h is
including pci.h. Let's not do that.

I'm not extremely familiar with this driver yet, but several of the
shared PCI/SNOC bits seem to be related to the Copy Engine, so move them
to ce.h.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/ce.h   | 42 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/pci.h  | 42 --------------------------
 drivers/net/wireless/ath/ath10k/snoc.h |  1 -
 3 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index dbeffaef6024..b8fb5382dede 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -383,4 +383,46 @@ static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
 		return CE_INTERRUPT_SUMMARY;
 }
 
+/* Host software's Copy Engine configuration. */
+#define CE_ATTR_FLAGS 0
+
+/*
+ * Configuration information for a Copy Engine pipe.
+ * Passed from Host to Target during startup (one per CE).
+ *
+ * NOTE: Structure is shared between Host software and Target firmware!
+ */
+struct ce_pipe_config {
+	__le32 pipenum;
+	__le32 pipedir;
+	__le32 nentries;
+	__le32 nbytes_max;
+	__le32 flags;
+	__le32 reserved;
+};
+
+/*
+ * Directions for interconnect pipe configuration.
+ * These definitions may be used during configuration and are shared
+ * between Host and Target.
+ *
+ * Pipe Directions are relative to the Host, so PIPEDIR_IN means
+ * "coming IN over air through Target to Host" as with a WiFi Rx operation.
+ * Conversely, PIPEDIR_OUT means "going OUT from Host through Target over air"
+ * as with a WiFi Tx operation. This is somewhat awkward for the "middle-man"
+ * Target since things that are "PIPEDIR_OUT" are coming IN to the Target
+ * over the interconnect.
+ */
+#define PIPEDIR_NONE    0
+#define PIPEDIR_IN      1  /* Target-->Host, WiFi Rx direction */
+#define PIPEDIR_OUT     2  /* Host->Target, WiFi Tx direction */
+#define PIPEDIR_INOUT   3  /* bidirectional */
+
+/* Establish a mapping between a service/direction and a pipe. */
+struct service_to_pipe {
+	__le32 service_id;
+	__le32 pipedir;
+	__le32 pipenum;
+};
+
 #endif /* _CE_H_ */
diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index e52fd83156b6..0ed436657108 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -86,48 +86,6 @@ struct pcie_state {
 /* PCIE_CONFIG_FLAG definitions */
 #define PCIE_CONFIG_FLAG_ENABLE_L1  0x0000001
 
-/* Host software's Copy Engine configuration. */
-#define CE_ATTR_FLAGS 0
-
-/*
- * Configuration information for a Copy Engine pipe.
- * Passed from Host to Target during startup (one per CE).
- *
- * NOTE: Structure is shared between Host software and Target firmware!
- */
-struct ce_pipe_config {
-	__le32 pipenum;
-	__le32 pipedir;
-	__le32 nentries;
-	__le32 nbytes_max;
-	__le32 flags;
-	__le32 reserved;
-};
-
-/*
- * Directions for interconnect pipe configuration.
- * These definitions may be used during configuration and are shared
- * between Host and Target.
- *
- * Pipe Directions are relative to the Host, so PIPEDIR_IN means
- * "coming IN over air through Target to Host" as with a WiFi Rx operation.
- * Conversely, PIPEDIR_OUT means "going OUT from Host through Target over air"
- * as with a WiFi Tx operation. This is somewhat awkward for the "middle-man"
- * Target since things that are "PIPEDIR_OUT" are coming IN to the Target
- * over the interconnect.
- */
-#define PIPEDIR_NONE    0
-#define PIPEDIR_IN      1  /* Target-->Host, WiFi Rx direction */
-#define PIPEDIR_OUT     2  /* Host->Target, WiFi Tx direction */
-#define PIPEDIR_INOUT   3  /* bidirectional */
-
-/* Establish a mapping between a service/direction and a pipe. */
-struct service_to_pipe {
-	__le32 service_id;
-	__le32 pipedir;
-	__le32 pipenum;
-};
-
 /* Per-pipe state. */
 struct ath10k_pci_pipe {
 	/* Handle of underlying Copy Engine */
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index 05dc98f46ccd..f9e530189d48 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -19,7 +19,6 @@
 
 #include "hw.h"
 #include "ce.h"
-#include "pci.h"
 
 struct ath10k_snoc_drv_priv {
 	enum ath10k_hw_rev hw_rev;
-- 
2.18.0.rc1.242.g61856ae69a-goog

