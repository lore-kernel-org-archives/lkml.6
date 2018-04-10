Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49a8NV7zYfzHoucXi/FsTcEj3pnF5iQqtr80Ib9U4ttAQPPVGYbw62Njo74okTY9RzRNw8e
ARC-Seal: i=1; a=rsa-sha256; t=1523399867; cv=none;
        d=google.com; s=arc-20160816;
        b=DtKweWgMEGcTcwIFfssqtSJwGlgZiFgvfcwai//gnwNcVYx9lrJU+Z4GEZu9vVSSwO
         /pIpqj6QOSbRi75vmiSS9ImNMAxfXz8hXFEFpearI+Ild3c4N59d9eJVeWcm/iAYlGV5
         CQLCz61o1LP/8lQu7iciIh+iCY0rBuI1V3Ge0UJ9+cw7KUUIIiJoqoT8p4JACVLyHUSp
         EydrqBqukd5Y1CubeRslkQ2Ps2M2PuHdKszQ23bB+GhQIo3hlQKRvR06q4Br/wi3Y0rf
         6+hhQh0cm7fRI0dcGXjWqTXIBQWEgCW6zJdxifTByRNTPFgEkMBzunMam50E8L9gNZz9
         O8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JXaymgDGUZ3KXmpr416jPo+y+MF/pJ3Fu6eRrS8brYc=;
        b=vfy5EJZIxQIe7WBGK1f3YTFuQOM/hgAcLf9O0eWalyDRFwQ0CLOW5JHSG+yBdqAI6T
         PK2y1K4mEqrGFLwDNLLILelDSYqvXwuASez/ED9aenFRKViYistSCZVknfcM4GhHHu1e
         lfhNcevQoBnUCvphhipUD7x7gLmfF58VAtvFWD9RfqEbIkrHCRmBSyWfxNh4lKVNUzPx
         oYvNEbBwPA4+x+ojgbl4v2qynGHh3Ui2X8UXG66yhEzJK/X5iBINE3Yk+AdXWjSBSXdP
         PAJ4FdK/DJ28n6GvsNiOqYgZmKpuPiNi924YQT34W/WPG8rJulpoOgkuE/ycL/wechnl
         XhkA==
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
Subject: [PATCH 4.14 075/138] sdhci: Advertise 2.0v supply on SDIO host controller
Date: Wed, 11 Apr 2018 00:24:25 +0200
Message-Id: <20180410212910.844252189@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400117368517441?=
X-GMAIL-MSGID: =?utf-8?q?1597400539236459956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -806,6 +806,8 @@ static int intel_mrfld_mmc_probe_slot(st
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
