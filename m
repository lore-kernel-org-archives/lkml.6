Return-Path: <mr.nuke.me@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525117953; cv=none;
        d=google.com; s=arc-20160816;
        b=ruSom2wdlwBHw4Px/CH+Ws653K44aVU+XLpDlpXqmaAuo6jCIjIbJ+flGoTegGZ7CV
         2sKtcfTSPXjSIW0BmLtWIiKkqEVIiCR0dqokHWQeoNahCOlb8J40Yyt24ZZV7Xe87Wty
         iIyVMPSDHNXUzNyjfDl+Kra4yIFeomh0TnyAwps+3LKbfD2J0lEIupHmGzuJ77/QjPRx
         m/zYbadPpT/5T/m6OwfdvFaxMAQ0xCV/S+Xog0jyVTt7IBDc9cink8aw7ECqZ7bjnxWE
         NT/1YG2mWdeFu7XawdjuywC7opkw0DghCaVexgPgjfurNO37/lFVqO82vDNqhdjZnifu
         MuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ZqdagjNc4E7EH/WGEFB37DMpL5NHHCpi5AJL7EnYbuk=;
        b=Q8MRrTWMUhKkWPsWo6zlbTzeRml4Hn5kprsAP+2YNpcUdyfg6uRyMJOdVp5nO2klir
         HEiWHE/pPJJI3fk0GjsK0jzxYqQSwpgHk4fJFNAtFQ+1C3qMnw+ueARpt5Xh+j7agDi7
         qDCbjcodtvjHcUDwx9GPaP7bqHlF+VhpCLi7+n18UHPb5gn3tdg0PE+xPIRdrbndRGK0
         aUe9+aJsBv+edgSRD6mmHgqcVE2OA7KEnAZUKLEryWG8Lt6XhtmdDtcYFNSiYlBWK8Cx
         Lo/Pk36sd87ihwZOSPn/dS691rSZVmW0GLHAJ+q3tEnC30fbI6sOfr9xWIXsA0KMoMQ6
         XQnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R7U7hd5R;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R7U7hd5R;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqDHWMubI+9yUGRYtg1mBQ2ubns4mf/IHjUvVUaFe80BV3IM/lsMdqBoIcr9StM3W7QULGypg==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com,
	austin_bolen@dell.com,
	shyam_iyer@dell.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Frederick Lawler <fred@fredlawl.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI/AER: Use a common function to print AER error bits
Date: Mon, 30 Apr 2018 14:52:15 -0500
Message-Id: <20180430195218.27654-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417170943.1767-1-mr.nuke.me@gmail.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1599202083173497892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On errors reported from CPER, cper_print_bits() was used to log the
AER bits. This resulted in hard-to-understand messages, without a
prefix. Instead use __aer_print_error() for both native AER and CPER
to provide a more consistent log format.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

Changes since v1:
  - Parse aer regs for first error pointer instead of disabling it
On the Dell machine where I tested this, the first error pointer is
reported correctly by firmware.

 drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index cfc89dd57831..b5612cc51b63 100644
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
+	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	cper_print_bits("", status, status_strs, status_strs_size);
+	__aer_print_error(dev, &info);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
-- 
2.14.3
