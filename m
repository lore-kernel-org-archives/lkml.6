Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqHqPYtNo3bOdBI3F5tpEPE+iLQt1uiy0ONT+wYceUWQkCvodqBIcnlBQG1PAwjcqmCjM+8
ARC-Seal: i=1; a=rsa-sha256; t=1524837814; cv=none;
        d=google.com; s=arc-20160816;
        b=DESD05nHZdMHSzliL+WiZtrmgqdjMcwLhHSaxlAu8TtxO+G5sZA6ypw83ylbfgLyk9
         tP9dBgQhuF9ahLW37jtTZmbB7asWGsIH/910klb2YRwuxkm72iu86XEUo8snbH9ZIUiL
         nF3I66FlDahHPp0wtEKij+d686u+hq4R3JeDNAWMMLcCQyMLyRHvrYPDo9RZoJRwl6ZC
         RlWme885NM1EIVel2LRC4BnVkBF06ddfMyEsmwQLl+bhgvNVturv9h68c5JiM+2YYYjo
         dDeur4geN5a/Seg6LnVpZALmG/5T6mBka/oxfSU/RU6jnyx49LY5qxEzorCJ3KaECyap
         9VmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+mLZmTKX8Tn/J3c52ChCclAqElOaraHE6p+22Lc19d0=;
        b=G7dT03RlUPFnPJ1qbPVFBKeuLax/jPkZHp7s10IQyV+LHe7pUxPpZBo8iQBZg6WR9q
         pzX2t4bror0xrXY/sbCU/5mr6u33Rrd3iI7yKxd5/WB4lgoVqYlHQ3yPXSSWE4lpIo4s
         NT7moH6pGsbvQaMtCmS5BJuTHEn2URFnjCq4CyTXM2aCTBISDIN1+/PtaQQY39prSgsF
         MDvqgUu31P3w6yWv5pMDXQ5VCQh5xT2KLou2Tfo6j83ZbMSXMtnLRaXzpBu7tO7PcYr1
         H4DwwHeDjj4X8+onUr9K5AQSh4oi23DP01r1ICLdSwJPYbe4Kfos8I27gCXRfJsqZPDR
         tkew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A742621890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.9 27/74] PCI: Wait up to 60 seconds for device to become ready after FLR
Date: Fri, 27 Apr 2018 15:58:17 +0200
Message-Id: <20180427135711.058892150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908336248664416?=
X-GMAIL-MSGID: =?utf-8?q?1598908336248664416?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sinan Kaya <okaya@codeaurora.org>

commit 821cdad5c46cae94ce65b9a98614c70a6ff021f8 upstream.

Sporadic reset issues have been observed with an Intel 750 NVMe drive while
assigning the physical function to the guest machine.  The sequence of
events observed is as follows:

  - perform a Function Level Reset (FLR)
  - sleep up to 1000ms total
  - read ~0 from PCI_COMMAND (CRS completion for config read)
  - warn that the device didn't return from FLR
  - touch the device before it's ready
  - device drops config writes when we restore register settings (there's
    no mechanism for software to learn about CRS completions for writes)
  - incomplete register restore leaves device in inconsistent state
  - device probe fails because device is in inconsistent state

After reset, an endpoint may respond to config requests with Configuration
Request Retry Status (CRS) to indicate that it is not ready to accept new
requests. See PCIe r3.1, sec 2.3.1 and 6.6.2.

Increase the timeout value from 1 second to 60 seconds to cover the period
where device responds with CRS and also report polling progress.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
[bhelgaas: include the mandatory 100ms in the delays we print]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |   52 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3756,27 +3756,49 @@ int pci_wait_for_pending_transaction(str
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-/*
- * We should only need to wait 100ms after FLR, but some devices take longer.
- * Wait for up to 1000ms for config space to return something other than -1.
- * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
- * dword because VFs don't implement the 1st dword.
- */
 static void pci_flr_wait(struct pci_dev *dev)
 {
-	int i = 0;
+	int delay = 1, timeout = 60000;
 	u32 id;
 
-	do {
-		msleep(100);
+	/*
+	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	/*
+	 * After 100ms, the device should not silently discard config
+	 * requests, but it may still indicate that it needs more time by
+	 * responding to them with CRS completions.  The Root Port will
+	 * generally synthesize ~0 data to complete the read (except when
+	 * CRS SV is enabled and the read was for the Vendor ID; in that
+	 * case it synthesizes 0x0001 data).
+	 *
+	 * Wait for the device to return a non-CRS completion.  Read the
+	 * Command register instead of Vendor ID so we don't have to
+	 * contend with the CRS SV value.
+	 */
+	pci_read_config_dword(dev, PCI_COMMAND, &id);
+	while (id == ~0) {
+		if (delay > timeout) {
+			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
+				 100 + delay - 1);
+			return;
+		}
+
+		if (delay > 1000)
+			dev_info(&dev->dev, "not ready %dms after FLR; waiting\n",
+				 100 + delay - 1);
+
+		msleep(delay);
+		delay *= 2;
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	}
 
-	if (id == ~0)
-		dev_warn(&dev->dev, "Failed to return from FLR\n");
-	else if (i > 1)
-		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
+	if (delay > 1000)
+		dev_info(&dev->dev, "ready %dms after FLR\n", 100 + delay - 1);
 }
 
 static int pcie_flr(struct pci_dev *dev, int probe)
