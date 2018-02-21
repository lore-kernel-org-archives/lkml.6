Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x227Jye467YhcsFc9MZArEiImt7AgbaMtbb5nLok8mXdkNo4h0cpazghj4CsycAhUuMLABInD
ARC-Seal: i=1; a=rsa-sha256; t=1519208832; cv=none;
        d=google.com; s=arc-20160816;
        b=AAnfvx4npbnjoWoN9yvp/pyyBn6K/jLGqyPfbDCD3OG/H//zS6GMiMWb1m4sI4oV9w
         j8nE0/OYMARdtrtU+LjynuDknQD1dkIThRnu820pW0WWmbk1EzQ3ZPUqAmSGfgglbowO
         EpQo28xh8B/o0dnkmOggx9l/hOyBVLGFfmIRszy9Mm4NVMrxlxttf/U52X4i93wPWeR3
         8WIZf6EG2+5gqszrFNSg4Hyrx6naiNK7wczUcHK8zaDHaeblhNyXY3rDOTb4dZWFLKuv
         1/qPhMwdR8U1Y/12k8o2PCyXKpUUN0E2vjasY2cAEjHdUiybhBoFDulnjciY4pXZHZv8
         K0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=BQ9xOmpdx+7MmhmvbBgaPrXlqHbjNItDnJ/z45n11ew=;
        b=nVb96xfd8nVDUr9tlMMcr82vb875Z3tnFu+paeKes3vvVJT3eK5AYM9YeWXrZkg0hd
         DIQGdw73s5Ngr14j/G1J8s4+YVvWPVOurtG4iMs0i2vLqQLYeLGSZNoDNISM/m0G8f60
         apzeVTNuLBOLi4AfZZzMC4l9nh03yPSSqo9DmnjaW72NptQqemOyHvetnwX9ekbD5LdA
         YgATeETMW2Q4/40Xp7kBCGVqGRu8yM6IQrClH3MtGGu+aDdWYVNM8SzKK1uldji0Hfku
         GLUZ8rtxX+SMgbM3fadjrE3tZYeSSUeKWj7csZQVSJ6BETk39VoZzMETs8+XuwkKWpmy
         dGmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=f4EQ29S/;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=pAqbk1E9;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=f4EQ29S/;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=pAqbk1E9;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D50266070D
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
Subject: [PATCH v8 3/7] PCI/ERR: add mutex to synchronize recovery
Date: Wed, 21 Feb 2018 15:56:40 +0530
Message-Id: <1519208804-24512-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
References: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593005920567127499?=
X-GMAIL-MSGID: =?utf-8?q?1593005920567127499?=
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
