Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x225V52TFpgDAWY+22WkNtvOpD6QqCmD0L03rRxtZ5Pt2etBcnoyWXIIpJFFn6iDkKk4GVUsS
ARC-Seal: i=1; a=rsa-sha256; t=1519285594; cv=none;
        d=google.com; s=arc-20160816;
        b=yUTmEkc1Edi43XVtacdz+5d5cLcMv6Lgm9lfXdLEEG2S9sgxYFb+3rswoOovqUq8eY
         NK40TyzVo4MuUkXJj1WX06iLbCRfGTzEZfLZBgQhhcuvFZOUad1n1ei6iLqkRZE7n23s
         E/TVR8l37yPHKAg/zATmenxK7LK4MTVkvv5kvX1gFGZ/WdMhIUEDzo1nNXFQtecWz1Ru
         lptW2FsR/1R9SGjfbpaZ+vktn3L7M9q1RGTfjxJcYvj/Ky5w1kFoW+sQtL4DAEspas60
         wAUtTWvAeZFr8YfSIl8jkwOugqh0Qvq3zeZvojj2sLpzYtbu2bPUkMT7TzKA2XBbLpe8
         eenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=BQ9xOmpdx+7MmhmvbBgaPrXlqHbjNItDnJ/z45n11ew=;
        b=wzn1nu34hABNr1t/m8sviX2trVakfVzIW5ls+0fCqSmnVBH5CLbplIcip2hof3zf+b
         t9s08FT2lGQZCZwKK1GW/UXmWfdN0lMIVn+dXecAJDwYvfp5Xl/NF9gQvBP3K4yTjirE
         WBo5PhSCGopykp+hSPxR/mN4VIjlHikqJn0HQRoUuWWngyiv7SDJCuf5WmHK9hTDp2BL
         WuF9T87NSXVRG1oOFp3NJvdxYEFfOdEjsydCVXNLoHcUKzRWi4jzekBwmXTu7EorS3K9
         EDsTgwaDPMbDuVbUbM8Qw0LO4m5+kC5JUxuP+p/779FPtUVqa5ZVDMXQPfFx/SuFg3Ck
         sdzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GKO9FhVq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jcrK8R3/;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GKO9FhVq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jcrK8R3/;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CEC3606DC
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
Subject: [PATCH v9 3/7] PCI/ERR: add mutex to synchronize recovery
Date: Thu, 22 Feb 2018 13:16:07 +0530
Message-Id: <1519285571-5634-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086412177501980?=
X-GMAIL-MSGID: =?utf-8?q?1593086412177501980?=
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
