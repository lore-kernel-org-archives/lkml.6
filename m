Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33508ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3DA206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3DA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGPIGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:06:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:06:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B369BCA4;
        Mon, 16 Jul 2018 07:40:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 4.14 10/54] staging: r8822be: Fix RTL8822be cant find any wireless AP
Date:   Mon, 16 Jul 2018 09:35:07 +0200
Message-Id: <20180716073452.766583248@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

commit d59d2f9995d28974877750f429e821324bd603c7 upstream.

RTL8822be can't bring up properly on ASUS X530UN, and dmesg says:
[ 8.591333] r8822be: module is from the staging directory, the quality
is unknown, you have been warned.
[ 8.593122] r8822be 0000:02:00.0: enabling device (0000 -> 0003)
[ 8.669163] r8822be: Using firmware rtlwifi/rtl8822befw.bin
[ 9.289939] r8822be: rtlwifi: wireless switch is on
[ 10.056426] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
...
[ 11.952534] r8822be: halmac_init_hal failed
[ 11.955933] r8822be: halmac_init_hal failed
[ 11.956227] r8822be: halmac_init_hal failed
[ 22.007942] r8822be: halmac_init_hal failed

Jian-Hong reported it works if turn off ASPM with module parameter aspm=0.
In order to fix this problem kindly, this commit don't turn off aspm but
enlarge ASPM L1 latency to 7.

Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtlwifi/rtl8822be/hw.c |    2 +-
 drivers/staging/rtlwifi/wifi.h         |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/rtlwifi/rtl8822be/hw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/hw.c
@@ -814,7 +814,7 @@ static void _rtl8822be_enable_aspm_back_
 		return;
 
 	pci_read_config_byte(rtlpci->pdev, 0x70f, &tmp);
-	pci_write_config_byte(rtlpci->pdev, 0x70f, tmp | BIT(7));
+	pci_write_config_byte(rtlpci->pdev, 0x70f, tmp | ASPM_L1_LATENCY << 3);
 
 	pci_read_config_byte(rtlpci->pdev, 0x719, &tmp);
 	pci_write_config_byte(rtlpci->pdev, 0x719, tmp | BIT(3) | BIT(4));
--- a/drivers/staging/rtlwifi/wifi.h
+++ b/drivers/staging/rtlwifi/wifi.h
@@ -99,6 +99,7 @@
 #define RTL_USB_MAX_RX_COUNT			100
 #define QBSS_LOAD_SIZE				5
 #define MAX_WMMELE_LENGTH			64
+#define ASPM_L1_LATENCY				7
 
 #define TOTAL_CAM_ENTRY				32
 


