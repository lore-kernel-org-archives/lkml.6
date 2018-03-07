Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsSm568JF8gkNI7Rm9R1eVi7Ipx0UetIM93cQrj1vC86USOA2xGTkGH8JOz6GDMb8upcabJ
ARC-Seal: i=1; a=rsa-sha256; t=1520451606; cv=none;
        d=google.com; s=arc-20160816;
        b=XZBPMTF9ym9wJLdQ5VSFNeBamvaBd1NmmkaYoX149NcGryVilIAjl+7x/gntIqLHlF
         Xp0SDBSlwXN0yPL26jk6zT6e6EVxnS0d54yX+QHPqDcp+1eUWFKRRQakaDUNOiQaOdwc
         WI1eTgSkpGw36eQGUqDfqlpJjpKAmVkqVU3BoerOeoHabWPSFeeKw09C+vkQWBMDmpC5
         5fPQ/9uYxHLJYaGbL5FbraVNDD9qonqRyYscdUiTdKqmCfiKgW4RbUymK/iQtdAvMy5V
         0W3BoNAVaLIuwWPZyMeAoPoUYz85gH+isvX61yMAW4Ae2fQCXs1BDJrFTaWed6yFJ4Db
         +u2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8IECWfPhSDBsXU85ljCmFkcsY7aHxLgVqmfGN74TlOQ=;
        b=wqptzUERIWL6z+JV+2kqFfXB/Vmgn10YjIUUzXpfJovy9T4c6moXd+WLspGoPlgQGF
         nP7dgZu81JBp7gOfUcdCIkpTdMdxbMI6RgDEZJO1aP8BxIMdUzqefo5jdRBoWzSqQs+E
         jJtNInifXbbNScd7zbVTbfwTeotYbTIyK8n+O6X9UwPzFsDsH0uqp9mcZ5S1go4/DRsz
         +8scJHyb/KXsej2HhuXTQZtJVuUVuxOWMPQQRUQ+bxavC/aWVwrbBTnCHBQ1jTEDOkCL
         X3PWnqVd/gXv0n6s/JBYVBKCrX/AB93awkKQOTd8PopQhgjfSD4fNjiRtoHifqA9cS0f
         s2ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 018/122] mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers
Date: Wed,  7 Mar 2018 11:37:10 -0800
Message-Id: <20180307191731.992366850@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309063564157747?=
X-GMAIL-MSGID: =?utf-8?q?1594309063564157747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit f8870ae6e2d6be75b1accc2db981169fdfbea7ab upstream.

Tuning can leave the IP in an active state (Buffer Read Enable bit set)
which prevents the entry to low power states (i.e. S0i3). Data reset will
clear it.

Generally tuning is followed by a data transfer which will anyway sort out
the state, so it is rare that S0i3 is actually prevented.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-core.c |   35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -593,9 +593,36 @@ static void byt_read_dsm(struct sdhci_pc
 	slot->chip->rpm_retune = intel_host->d3_retune;
 }
 
-static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
+static int intel_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	int err = sdhci_execute_tuning(mmc, opcode);
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (err)
+		return err;
+
+	/*
+	 * Tuning can leave the IP in an active state (Buffer Read Enable bit
+	 * set) which prevents the entry to low power states (i.e. S0i3). Data
+	 * reset will clear it.
+	 */
+	sdhci_reset(host, SDHCI_RESET_DATA);
+
+	return 0;
+}
+
+static void byt_probe_slot(struct sdhci_pci_slot *slot)
 {
+	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
+
 	byt_read_dsm(slot);
+
+	ops->execute_tuning = intel_execute_tuning;
+}
+
+static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
 				 MMC_CAP_CMD_DURING_TFR |
@@ -650,7 +677,7 @@ static int ni_byt_sdio_probe_slot(struct
 {
 	int err;
 
-	byt_read_dsm(slot);
+	byt_probe_slot(slot);
 
 	err = ni_set_max_freq(slot);
 	if (err)
@@ -663,7 +690,7 @@ static int ni_byt_sdio_probe_slot(struct
 
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
-	byt_read_dsm(slot);
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	return 0;
@@ -671,7 +698,7 @@ static int byt_sdio_probe_slot(struct sd
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
-	byt_read_dsm(slot);
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
 				 MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;
 	slot->cd_idx = 0;
