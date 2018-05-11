Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZoJS0x3jtCWkdJPGqMlX1KoO9stmpKcEC+Ez2QGAni/7DVvFCl/kyMVR4jRGOF+j25shfF1
ARC-Seal: i=1; a=rsa-sha256; t=1526035414; cv=none;
        d=google.com; s=arc-20160816;
        b=thnijyALua52vI8stfONCDlAUnwXIwACcSJt7aPSM8pWx5kubJIynJcb5C8BXK1DG1
         /hZfp5JvV8zfIb+k4OOHVq3OGc1h6UCEZNu0oCwLEQbv40LK4qhfnultWpyK1QNZM8dH
         tZ35ZPIoRMn0VG2pfeHn+6oaWKRUKa2iqZhdoLeGCPpYqtNn6FQaPmt1Ycu7qNLCVmIO
         6dUOYNvPIPjdddsiSnfu/J7efMB4c2qY7cf1rg9ZcKCP5sMvZRkDxiWrO0rQZyYCxgLV
         qOyMBkRM6An7BHeDG/SyRRLXHZT7+tXEPcn71R2AygLKo2qYNACx6BPfp+f2iQHslFFF
         4jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hbeO4XfohJBcyyd41JIedMDgRCkC8nFkwL/10yzrx9c=;
        b=COHMXc3aoUjTV8RZ3XMJa0RHPhRUjZum/7k8tEVrw2AGg6tL2v7C1SH9oaSqgrlWw2
         qclS+yPqXwkMULMifQqWlx7Tqjn6Zw2PxiJDtJcsiGeiF8mtGwVagzkBF2NzJiZh99OW
         yZZphDWMdGii/+irGB07uQeIe5GwOQVDIJwqUKkZ5oxuXKtdpnSxSyQbXtxubgpiwjMB
         Z85tUcL2nyKxQ2pnjwe3c60gLM/eu+q3j/nTA6mDZP/ZjTwX4Qw7Y97dWPukjJXQGbhW
         al/c0Fls8fz0xCgLsh7tD1OWlrqZcgIVpMb8V3EP1LEt5u0mQ79bKuIz8YVPJEU5Cn0S
         msHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="435728396"
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
Subject: [PATCH v16 9/9] PCI/DPC: Disable ERR_NONFATAL and enable ERR_FATAL for DPC
Date: Fri, 11 May 2018 06:43:28 -0400
Message-Id: <1526035408-31328-10-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164110297990629?=
X-GMAIL-MSGID: =?utf-8?q?1600164110297990629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch disables ERR_NONFATAL trigger for DPC, so now DPC
handles only ERR_FATAL.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 5680c13..358b4324 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -273,7 +273,7 @@ static int dpc_probe(struct pcie_device *dev)
 		}
 	}
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -291,7 +291,7 @@ static void dpc_remove(struct pcie_device *dev)
 	u16 ctl;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 }
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 103ba79..5182e0d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -981,6 +981,7 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
+#define  PCI_EXP_DPC_CTL_EN_FATAL 	0x0001	/* Enable trigger on ERR_FATAL message */
 #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
 #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
 
-- 
2.7.4
