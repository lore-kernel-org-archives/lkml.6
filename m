Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Pjd3cs3r5AKUSQyCQ/eezpbwqWdFE+JyDs40a6Q8geCxcKMndu5jjxtYWrPaj1vCOXCY6
ARC-Seal: i=1; a=rsa-sha256; t=1524406257; cv=none;
        d=google.com; s=arc-20160816;
        b=h6e3999KIVsnPN6g8gFPd1R/Rn9WXch17E3oO7cDcVKM54YSt5ho/APQwhSqjJ6ioE
         LcTvh77omcMsFI6y1hAYqgHeJG3Hl7Pjl8pBck3fHcCliMesT/l6dWC3+imjghYKp3D3
         VSCvDNBYy82NDBAptkkPUtzFfBerbTDsR9ypUEfSrXIaVmBQHvlS1d90rmvcJyAgLerG
         ZbhJyhehWuIppDWAUeWb8QbGLotyS0PnH+7WQPldV3/X2tlNLXTq647fJSXtECxPUH/T
         jlSQCNSCvhmS1+5L8IF272KYofZ5uFGTadjzILBqqW0ELI2C11xgVwD39O52Vc5A82Z/
         8kPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oMyzo/sB00W0k+x3pQAZX/lr9bYWEwtdjJN25Mz9ymQ=;
        b=sKenBZoO9E+N7qBjjrTP8k6g0Jj9dCglYYnGNBW1zcY8ZkW3PH1p5acqfOP/u8jVjc
         aeK7xGUMqTQYNWoHoDzp3xZVrVacI3EV7feiELrFCr4wt/1KuF2kWvJN7xuGbFLAEP+8
         kSdwEoHdqtgp1CEiyoCm5nJjgXqUJqWfCH+C5td3e5fqNR2t2uY231SmyFDDf+fgjfIy
         Un9oWLmb2Z646+8585Mg+U0YG4dVsTQ13CvZOKgcUMgEJe0w2nqu67wyCVaO9Rdb/J4d
         0kzh/l31Y31YoEltT5K80yMbxfKjPXQZjk0o17AfPK9CHOkhMrdTJRuut8JEd5ZtJMiO
         c02g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 150/164] mmc: sdhci-pci: Only do AMD tuning for HS200
Date: Sun, 22 Apr 2018 15:53:37 +0200
Message-Id: <20180422135141.687828561@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455287957314545?=
X-GMAIL-MSGID: =?utf-8?q?1598455815722506577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Kurtz <djkurtz@chromium.org>

commit 300ad8992913025b4294d4fc37b6bfff4a8b7ad1 upstream.

Commit c31165d7400b ("mmc: sdhci-pci: Add support for HS200 tuning mode
on AMD, eMMC-4.5.1") added a HS200 tuning method for use with AMD SDHCI
controllers.  As described in the commit subject, this tuning is specific
for HS200.  However, as implemented, this method is used for all host
timings, because platform_execute_tuning, if it exists, is called
unconditionally by sdhci_execute_tuning().  This breaks tuning when using
the AMD controller with, for example, a DDR50 SD card.

Instead, we can implement an amd execute_tuning wrapper callback, and
then conditionally do the HS200 specific tuning for HS200, and otherwise
call back to the standard sdhci_execute_tuning().

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: c31165d7400b ("mmc: sdhci-pci: Add support for HS200 tuning mode on AMD, eMMC-4.5.1")
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-core.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1192,7 +1192,7 @@ static void amd_enable_manual_tuning(str
 	pci_write_config_dword(pdev, AMD_SD_MISC_CONTROL, val);
 }
 
-static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
+static int amd_execute_tuning_hs200(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1231,6 +1231,27 @@ static int amd_execute_tuning(struct sdh
 	return 0;
 }
 
+static int amd_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/* AMD requires custom HS200 tuning */
+	if (host->timing == MMC_TIMING_MMC_HS200)
+		return amd_execute_tuning_hs200(host, opcode);
+
+	/* Otherwise perform standard SDHCI tuning */
+	return sdhci_execute_tuning(mmc, opcode);
+}
+
+static int amd_probe_slot(struct sdhci_pci_slot *slot)
+{
+	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
+
+	ops->execute_tuning = amd_execute_tuning;
+
+	return 0;
+}
+
 static int amd_probe(struct sdhci_pci_chip *chip)
 {
 	struct pci_dev	*smbus_dev;
@@ -1265,12 +1286,12 @@ static const struct sdhci_ops amd_sdhci_
 	.set_bus_width			= sdhci_set_bus_width,
 	.reset				= sdhci_reset,
 	.set_uhs_signaling		= sdhci_set_uhs_signaling,
-	.platform_execute_tuning	= amd_execute_tuning,
 };
 
 static const struct sdhci_pci_fixes sdhci_amd = {
 	.probe		= amd_probe,
 	.ops		= &amd_sdhci_pci_ops,
+	.probe_slot	= amd_probe_slot,
 };
 
 static const struct pci_device_id pci_ids[] = {
