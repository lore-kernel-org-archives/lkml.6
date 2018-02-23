Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x227OeTTKjrj0n75oiVXBIcSP/v4oG1fJn5H/R9x69oU65fSEgWlbE7E9ij9vdeYIOBpTpSvx
ARC-Seal: i=1; a=rsa-sha256; t=1519374268; cv=none;
        d=google.com; s=arc-20160816;
        b=CFasSstpgmK42u/76O6BZrf79Dksg0pFgARzq2fJcJCzVx1NRWdbb1l5KHAGgisy1k
         kGK4DCzWnOn59qUDNS8APpK963ngzVkVzWFxUFDh8xpVDXKgoahV7SeUFAfThvxn8qVd
         C8t+wYruWOHBpHGjPsznBCEmd5pmQpxYlKBhl66G0J6kUASNp9BQCaeJsLVeIBOOUfWH
         6p0HBQqQQEme7hgJrUuJyaFYT9NefmSe4Kv/kbvCN2Ym76JjfzgfQsXW8Xm/W8WvnK7E
         wwIu+bC2NQ6VpZA7CQqsCHUlgaUCDGne72gMcTHmhJXpGC78iKEyRoccU94XS1io7Ui+
         iK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=I66auP7Odxgw/yAkDnrgZ/4PugO/xZ35+kA3agpTmcc=;
        b=mE2ch9Y8yW38jh4NSTb6YB9AKvT7b3SIfq7tqetjyfTP0JA91khNlLRmxNa5uw6wNi
         O/wdF0q6riJdnUuGGEV90h6Lu66Fyu4QzmwWsgdIcLJntKi7C6cGhlv06bNGQz0xQ3se
         lYMS3HJiLbdk27BzSCKQqTXnGkgDkU2CK4dSnhg1HGWNXGfdz1sCapAibopv+LxY2pw+
         W8UO9lYREFT9M3MSaUfn+amJjVuV7hOD1f1fgGdqGvZ546qPRyV8ySvewyKJtmdzwYSc
         dSFOI1N81Ko2glw9adOb0MM5iGsusj57Aik/XHq+Q/mxCyqEmmEw/uPK+TMRa3T/iIXk
         uOyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q12K9W8J;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LeI94hEr;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q12K9W8J;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LeI94hEr;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0522607C6
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
Subject: [PATCH v11 3/7] PCI/ERR: add mutex to synchronize recovery
Date: Fri, 23 Feb 2018 13:54:00 +0530
Message-Id: <1519374244-20539-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086412177501980?=
X-GMAIL-MSGID: =?utf-8?q?1593179392587746514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch protects pci_do_recovery with mutex.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index fcd5add..f830975 100644
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
@@ -283,6 +285,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
+	mutex_lock(&pci_err_recovery_lock);
+
 	if (severity == AER_FATAL)
 		state = pci_channel_io_frozen;
 	else
@@ -326,9 +330,11 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
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
