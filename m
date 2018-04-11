Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Nf3rpwXOZj+wpHTvMuDKXtLn6a4z04qm5Hk9dMlTiwq2bjdjRXwPlv56vJKB4VQsbMAtw
ARC-Seal: i=1; a=rsa-sha256; t=1523473486; cv=none;
        d=google.com; s=arc-20160816;
        b=xzwPPx8on6zwwBNYu9gOCE9iAu+2lXL6/X3mmobg8DdUbPAQlul4emyUMw/Kldq+Qv
         VV2xQKA4ihr0dXx47y31pyMlHjhc+770E+dCRkYisIFYA5RnUY+AUsTQt/skB3qE6JLn
         xgy3vhXI/ZH9EdGF/EzNa/gXWAZkzYu47GyyqZXkw+WIgYepj7l6Ukp27Cr/dkIoKX9z
         oyMnH1wK/Z1xON50/+DePjxvv8rajdMzwtzvQTMzuOn1lqlU8V393ankDJHuBG88zm0Z
         pz8Zyga06kV1Pw83btqTaXE7zvPFDMtStcAivPz50Ry/+md+zgVwMmdaBh5dF/Al1Neh
         vGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F3BUbkYsi85oixU9azxZ+L4/xJK+4/b84rSughmOeq0=;
        b=goAS2Wu0/riZIl7N1ZZK36D91S6c2po/f8Ts88VjdR71NQPz44C6zhiS/vp1cbO1ub
         FNcQYlq88P0Q3dmqQ5qmaiJL/8DfTiwNNEm3/JQpMZMle6px61fnqDOeOVGxc8WPNCiC
         xxDtnLUxaBsm99KQlgXe8RaYyRCdPjjWaNgLSv/ELTtd0Dl2o4dxXZ5gtJy1VluhTTQi
         N4lt5eDpLEI4ytxJBdX7mDguagJxzpK8MzMKYuo+4Gmz/2HNmccJwLocwh1eIVFc9479
         BYlQcQiJsogQaTS9VH6KFf/TQnAt2Wf08LXvobMETPx3ffuCBrnkY7Cg8xcVzad8qKcq
         vnvw==
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
Subject: [PATCH 4.9 266/310] sdhci: Advertise 2.0v supply on SDIO host controller
Date: Wed, 11 Apr 2018 20:36:45 +0200
Message-Id: <20180411183634.103205303@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477734363264124?=
X-GMAIL-MSGID: =?utf-8?q?1597477734363264124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -492,6 +492,8 @@ static int intel_mrfld_mmc_probe_slot(st
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
@@ -1404,6 +1404,13 @@ void sdhci_set_power_noreg(struct sdhci_
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
