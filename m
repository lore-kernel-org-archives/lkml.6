Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224WFX/MUmFau7YdevagsslWgRF32TOZkUO3m3jLebo1TKAl2mJQtc6+erbZcJ5U0y4Rcqko
ARC-Seal: i=1; a=rsa-sha256; t=1519315364; cv=none;
        d=google.com; s=arc-20160816;
        b=kljegowBlq0iZpeGroB3lOG2VKUixNDd7vwBDWPy7Hnw6A+uJCqZ6C9CXi12tZaqmd
         9PoB/uhQVfH3Dkxw/vjau68oRhODBxztgycYfY0kdeDXRiP2VDOwWXmu7pxeg01Jxgb4
         BZQev//G7JG7am9asxdqPj4sDkRlGxNkLUpmbcxI5D++iWRQ9AKZ24g2FUFNmzTPyQ7B
         YK0pLLX0wD1gSfAj2VB4dPs8IAUFtBlakmMSUZoNvAPIQI0orqFJQiaMImoEbNRwaRql
         V3QU1DKWKomj56xQ827czpoofhX+GUio3SttC6fZ8MjwB8v0ELqD+oPH+3bLEZpv0jU0
         0hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=BQ9xOmpdx+7MmhmvbBgaPrXlqHbjNItDnJ/z45n11ew=;
        b=XQpEJ0+3EvMeyNMuSUiJ6oO+nVwGAIq2N7MvrmWCHLRZ7YvC7OWyrP58nt4i0uUjYP
         XEzy/tnUsCI8GGMv0Jl/HfOi5uZ3WZ+5uyF8wxGrHvW136P29MeqQktOI6X5yhKIFyuC
         g/u5H0JmVyfkN2YlTGf9b94qeP3k2iYrM+Jl/n7tgOdFccbNaenEa01ExfMp1qqfm9Ta
         GTrVcO3q9lzMuI+1f1lOcombHLayAtb+szFsWMgH2aZOqvJVJCuxbO0XgNmQVbjrVVfc
         /SVS1YmX/RnJG6VdoBe58O0VK6CSBTTEJOSCDreNy57eM5epa5knp4yEUhOnWeOfNV+C
         eEgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eTHxua7D;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=g0yiuWV1;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eTHxua7D;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=g0yiuWV1;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E94E360F8E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=poza@codeaurora.org
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v10 3/7] PCI/ERR: add mutex to synchronize recovery
Date: Thu, 22 Feb 2018 21:32:08 +0530
Message-Id: <1519315332-26852-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086412177501980?=
X-GMAIL-MSGID: =?utf-8?q?1593117627585397329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch protects pci_do_recovery with mutex.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index a532fe0..8318c84 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -20,6 +20,8 @@
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
 
+static DEFINE_MUTEX(pci_err_recovery_lock);
+
 struct aer_broadcast_data {
 	enum pci_channel_state state;
 	enum pci_ers_result result;
@@ -283,6 +285,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
+	mutex_lock(&pci_err_recovery_lock);
+
 	if (severity == AER_FATAL)
 		state = pci_channel_io_frozen;
 	else
@@ -326,9 +330,11 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 				report_resume);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
+	mutex_unlock(&pci_err_recovery_lock);
 	return;
 
 failed:
 	/* TODO: Should kernel panic here? */
 	dev_info(&dev->dev, "Device recovery failed\n");
+	mutex_unlock(&pci_err_recovery_lock);
 }
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
