Return-Path: <mr.nuke.me@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523984991; cv=none;
        d=google.com; s=arc-20160816;
        b=okaaRua3cf6zkUGWeh9izUwGTa+RN7ly+qV3JjFdulD2YehuWWW9zFznBe8YuFoade
         ExptoczEPaoxy3N2pMVpLNzKjTPTehBhAjkPuQQPVGpNHKHsCofmKxnYHOPp6SSMzyGt
         +jNonht0dTddT1AR364SzeWObtZGH0DGddD05AxBvtm1YnYFCcwBO8qp3r9ODUxweNzI
         2xe0CTByF2pDHwIW3I6lPTdezf0Qd58HY9BuH8qRK0pwY7tK6U8bZnbMS2UTgpFKqxON
         NWZsa0vxia3I10qYIJR54sXUdLLvq/iS4JTuICkyFzfUEL6rXLjzzKJoPDDoNkVRiHZh
         Hwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=PEYjKfzE2DRKd4gxfVIi7aHdPcHMttStVmLOsDOoXzE=;
        b=HaPNSAeXfDUcVvwdaixoV6eDdwnr3Z35h5wbM1LNYMf2WVcN+dJ+Awj5EnLAYWVOfz
         XGgXxNCdxSeOa58L0mV6aJ/O6kT3OCfVGHPyTMyhzTwcDcD8RRMLBuZiqqTY3SGV/vOr
         1RsLdEHXK4d+zcSPby3whCTtc4TilndMouf6LoDaLXSLe4RrFKU/A8T8S2QKaiJ8qcni
         mfi0cAcQQed4yhHx6nYR2EnCU9xK1HWCgdIOYwNet31EWEVdhH7mCbylVQbTtEoMtiMP
         rYZBb4Q08SwmyCYunCuj6kQdlUi/2bYENm96tguT7cnVvVz72ZI29RLwnWla+agzfVV1
         0OwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ngek7N9y;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ngek7N9y;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+uyTQJmdvhQPvIsW6pwi6UqjrBlyyOzN2/MPsFBGTHHJz9WOWMPBhqlakjJEYOCHGaRuTlQw==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	fred@fredlawl.com,
	linux-kernel@vger.kernel.org,
	alex_gagniuc@dellteam.com,
	austin_bolen@dell.com,
	keith.busch@intel.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH RESEND] PCI/AER: Use a common function to print AER error bits
Date: Tue, 17 Apr 2018 12:09:43 -0500
Message-Id: <20180417170943.1767-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1598014086120567687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On errors reported from CPER, cper_print_bits() was used to log the
AER bits. This resulted in hard-to-understand messages, without a
prefix. Instead use __aer_print_error() for both native AER and CPER
to provide a more consistent log format.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index cfc89dd57831..cfae4d52f848 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -216,28 +216,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer)
 {
-	int layer, agent, status_strs_size, tlp_header_valid = 0;
+	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
-	const char **status_strs;
+	struct aer_err_info info;
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
-		status_strs = aer_correctable_error_string;
-		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
-		status_strs = aer_uncorrectable_error_string;
-		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
 	}
 
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
+	memset(&info, 0, sizeof(info));
+	info.severity = aer_severity;
+	info.status = status;
+	info.mask = mask;
+	info.first_error = 0x1f;
+
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	cper_print_bits("", status, status_strs, status_strs_size);
+	__aer_print_error(dev, &info);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
-- 
2.14.3
