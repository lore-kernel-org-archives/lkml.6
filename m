Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E5A20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xkdHpFu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E5A20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbeKLKBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:01:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbeKLIRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D9421582;
        Sun, 11 Nov 2018 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975247;
        bh=jeXfFLvaqa0weiquCPdLv1YnOC6yHFfjSjsrXZT9Vng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkdHpFu+PBVc8OCVQDn2UpeQzGV9cfi0brn5yQE2q25Jqy4mLVYfVNLi6vqcsSR7P
         K+QxmacuBR8UzInRM2ANIBU32k+aosl6+7916iNDZbQyxEIqSOo1oYFmv8sv0mn4bK
         oZPGdIOSh5NMpTDq3a+8gJJkHDYtwJzKbrrzqd98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/361] mmc: sdhci-pci-o2micro: Add quirk for O2 Micro dev 0x8620 rev 0x01
Date:   Sun, 11 Nov 2018 14:16:57 -0800
Message-Id: <20181111221629.851793510@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit 5169894982bb67486d93cc1e10151712bb86bcb6 ]

This device reports SDHCI_CLOCK_INT_STABLE even though it's not
ready to take SDHCI_CLOCK_CARD_EN. The symptom is that reading
SDHCI_CLOCK_CONTROL after enabling the clock shows absence of the
bit from the register (e.g. expecting 0x0000fa07 = 0x0000fa03 |
SDHCI_CLOCK_CARD_EN but only observed the first operand).

mmc1: Timeout waiting for hardware cmd interrupt.
mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x005800c8
mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc1: sdhci: Host ctl2: 0x00000008
mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
mmc1: sdhci: ============================================

The problem happens during wakeup from S3. Adding a delay quirk
after power up reliably fixes the problem.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-o2micro.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -490,6 +490,9 @@ int sdhci_pci_o2_probe(struct sdhci_pci_
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
 	case PCI_DEVICE_ID_O2_SEABIRD0:
+		if (chip->pdev->revision == 0x01)
+			chip->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
+		/* fall through */
 	case PCI_DEVICE_ID_O2_SEABIRD1:
 		/* UnLock WP */
 		ret = pci_read_config_byte(chip->pdev,


