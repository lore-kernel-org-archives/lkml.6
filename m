Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BfxDXcN7M9aIOi1Ptzn4trLlw9Jwt8j7g1zn1/Y7rqZaM0ZENPmYzDvBo/9wfn1IoD+xF
ARC-Seal: i=1; a=rsa-sha256; t=1524405753; cv=none;
        d=google.com; s=arc-20160816;
        b=esZejgn9DWR5JjgB63qoIEXpaFTKa2F92ndlsgZIQXC6S8qKLvVY+VJqVDGx0droMC
         K2n2KQi6lsO9NxChp5UR+i1/yySp834XNsdZFiP4izE7Qvd0QPCW+4CIO1DuGKvwh66I
         3L/LVWE2tmDTfCVsverS5gWx2w2Dk5vGjnNLmj72jaPXia1MedY28Z+9jjDhvhdnj22i
         0vZrLbJax5qp9tiDERUdVlrDe0/SUSxdtHFMMeoplkFzA2N6tPWhjwbzS1z13+v1XzO/
         VVtd0mxsdBW1iaCWFWNxWJLM1QPzTOs4LpICI3bRoKx4qUTwK5939yr6IxUhG8ko0f5K
         N1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1x1blfnDkg3u3q91wGVgF0E085xnGj3KLoSCVcPZnZM=;
        b=OTxfN5xAiYvnKtQeDb/9LzfueHiAVnmG28tkjbcTKOPoAAf/W44YPoP2N260hJufYk
         XLrSNx6FDZqQOewwwEq4LVCPnDI8uCGYR9B/UFzOCVBU5CDrdT254QPRKhcEZJ4pktvz
         KGdk98kbzVRAozmoPz6YfpjTC2FxhRPPaoTCfVP/UfxfVPo1AbN9V1b1iBUJypud9LEX
         qoVEI92dxh79rhUMX9ck7ECjPJ3VCwErwRfCMWln9sV6MBFW2pYTRweBkVaaO14QFiyS
         YxX/d1U768gZZhoyuGqRNwlPVadsYhapCJ9O/InO5Cu0O9UCqP3RuYOrSA54XK8tMbvC
         KITA==
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
Subject: [PATCH 4.16 182/196] mmc: sdhci-pci: Only do AMD tuning for HS200
Date: Sun, 22 Apr 2018 15:53:22 +0200
Message-Id: <20180422135113.670412371@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455287957314545?=
X-GMAIL-MSGID: =?utf-8?q?1598455287957314545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1318,7 +1318,7 @@ static void amd_enable_manual_tuning(str
 	pci_write_config_dword(pdev, AMD_SD_MISC_CONTROL, val);
 }
 
-static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
+static int amd_execute_tuning_hs200(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1357,6 +1357,27 @@ static int amd_execute_tuning(struct sdh
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
@@ -1391,12 +1412,12 @@ static const struct sdhci_ops amd_sdhci_
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
