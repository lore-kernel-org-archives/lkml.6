Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+7TDkp48FWFUm8YKRlfAPy+yV5SHJ7Ak9LMxDmL+Zz/aCZ7/OxzTgzBBiyDeDVlvyvjLtv
ARC-Seal: i=1; a=rsa-sha256; t=1523399464; cv=none;
        d=google.com; s=arc-20160816;
        b=voS9pUz6L25GULxRPSY/WRjO02HgGwZisDw1zEDDLGRoxSPlHTO363VJDnVRsA7TgV
         KQN3rjXe0STUXuiswDulPC82Kv/jrfecIafN7zbuADSJHb1USadA2xz6k6xTfVLTXXp5
         jCta95DnluUFIdcdhT8pARRXepT+wpq8TZojFVT9pZPgCp3dZTGzsUppxsobg2JPtUbk
         /zQKzu3+3mELc5u/MTvZrcBn8t2tD1cHGdJ0SmNon1JKNl44RHSmoah7YoPvhVNHqhur
         DQMVrJjer+1Pjnmu/mv1WhP87KY6DDtSB8XJ0x5a5E9puWCRzDkUW/SWu4yk3uMHFJXT
         LCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7Zzhaj1Z+Xsk2m1hJbC/yVbPYnJzhd/dEhB3y/AUi8U=;
        b=SkCxUWJvg++AQsFf6hRVl4oQ4TLVR2yQOJXi5k30f5vRapdnu3lEoXLoB8/7rfMqa3
         BDbPkH3g3vnM4xsLGVfSWW/ug7oyhbogg0QRFPdZzQfC08IxqblvgBDN1bvRdMaDxMzI
         KFzHDIgP5aTD+vnzei9QrGn0SFVZzfJXidHeUsu/H0t/GUxF7Iew2riF6vdZvBKcRz34
         hao/RYE8o3/c9y5lS1iKFAMS6/y/iRvzpqb10PgTrYLJE+RjapCfsdBMBRPYLEt2QTrf
         LNvjbA0caMFYuZdG0bGT7fVmkA/DnZI4xVXBjPmk7HTUf7U3aHy4sXNO7q6DofFw3rRT
         6M+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 099/168] sdhci: Advertise 2.0v supply on SDIO host controller
Date: Wed, 11 Apr 2018 00:24:01 +0200
Message-Id: <20180410212804.467826963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400117368517441?=
X-GMAIL-MSGID: =?utf-8?q?1597400117368517441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


[ Upstream commit 2a609abe71ca59e4bd7139e161eaca2144ae6f2e ]

On Intel Edison the Broadcom Wi-Fi card, which is connected to SDIO,
requires 2.0v, while the host, according to Intel Merrifield TRM,
supports 1.8v supply only.

The card announces itself as

  mmc2: new ultra high speed DDR50 SDIO card at address 0001

Introduce a custom OCR mask for SDIO host controller on Intel Merrifield
and add a special case to sdhci_set_power_noreg() to override 2.0v supply
by enforcing 1.8v power choice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-core.c |    2 ++
 drivers/mmc/host/sdhci.c          |    7 +++++++
 2 files changed, 9 insertions(+)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -805,6 +805,8 @@ static int intel_mrfld_mmc_probe_slot(st
 		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 		break;
 	case INTEL_MRFLD_SDIO:
+		/* Advertise 2.0v for compatibility with the SDIO card's OCR */
+		slot->host->ocr_mask = MMC_VDD_20_21 | MMC_VDD_165_195;
 		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
 					 MMC_CAP_POWER_OFF_CARD;
 		break;
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1470,6 +1470,13 @@ void sdhci_set_power_noreg(struct sdhci_
 	if (mode != MMC_POWER_OFF) {
 		switch (1 << vdd) {
 		case MMC_VDD_165_195:
+		/*
+		 * Without a regulator, SDHCI does not support 2.0v
+		 * so we only get here if the driver deliberately
+		 * added the 2.0v range to ocr_avail. Map it to 1.8v
+		 * for the purpose of turning on the power.
+		 */
+		case MMC_VDD_20_21:
 			pwr = SDHCI_POWER_180;
 			break;
 		case MMC_VDD_29_30:
