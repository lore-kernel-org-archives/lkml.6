Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EECDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C006D20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1KUaOzJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C006D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbeKAIUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbeKAILZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F632087A;
        Wed, 31 Oct 2018 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027472;
        bh=VK9akVamZ5RhuqjSu2RMnDGjcAYsOTQpeZvE4m9ywtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KUaOzJCSQPhZy2NWeUMzNyjGR2h4bLP3qEGtGdwTug2RIzS/iNS8MwulEUrZjFyc
         jbwrKbN0IIPwk7gdwUApm0ZP6GJxgMUFOjhdvPC47OGWgGBkzFA94JZjOYvN0/ohQx
         ale1Xtpa6Dlp765gte2uldkQ9z2ttDykDaTQ/Fog=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 20/48] brcmfmac: fix for proper support of 160MHz bandwidth
Date:   Wed, 31 Oct 2018 19:10:26 -0400
Message-Id: <20181031231054.29333-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arend van Spriel <arend.vanspriel@broadcom.com>

[ Upstream commit 330994e8e8ec5d0b269a5265e6032b37e29aa336 ]

Decoding of firmware channel information was not complete for 160MHz
support. This resulted in the following warning:

  WARNING: CPU: 2 PID: 2222 at .../broadcom/brcm80211/brcmutil/d11.c:196
	brcmu_d11ac_decchspec+0x2e/0x100 [brcmutil]
  Modules linked in: brcmfmac(O) brcmutil(O) sha256_generic cfg80211 ...
  CPU: 2 PID: 2222 Comm: kworker/2:0 Tainted: G           O
  4.17.0-wt-testing-x64-00002-gf1bed50 #1
  Hardware name: Dell Inc. Latitude E6410/07XJP9, BIOS A07 02/15/2011
  Workqueue: events request_firmware_work_func
  RIP: 0010:brcmu_d11ac_decchspec+0x2e/0x100 [brcmutil]
  RSP: 0018:ffffc90000047bd0 EFLAGS: 00010206
  RAX: 000000000000e832 RBX: ffff8801146fe910 RCX: ffff8801146fd3c0
  RDX: 0000000000002800 RSI: 0000000000000070 RDI: ffffc90000047c30
  RBP: ffffc90000047bd0 R08: 0000000000000000 R09: ffffffffa0798c80
  R10: ffff88012bca55e0 R11: ffff880110a4ea00 R12: ffff8801146f8000
  R13: ffffc90000047c30 R14: ffff8801146fe930 R15: ffff8801138e02e0
  FS:  0000000000000000(0000) GS:ffff88012bc80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f18ce8b8070 CR3: 000000000200a003 CR4: 00000000000206e0
  Call Trace:
   brcmf_setup_wiphybands+0x212/0x780 [brcmfmac]
   brcmf_cfg80211_attach+0xae2/0x11a0 [brcmfmac]
   brcmf_attach+0x1fc/0x4b0 [brcmfmac]
   ? __kmalloc+0x13c/0x1c0
   brcmf_pcie_setup+0x99b/0xe00 [brcmfmac]
   brcmf_fw_request_done+0x16a/0x1f0 [brcmfmac]
   request_firmware_work_func+0x36/0x60
   process_one_work+0x146/0x350
   worker_thread+0x4a/0x3b0
   kthread+0x102/0x140
   ? process_one_work+0x350/0x350
   ? kthread_bind+0x20/0x20
   ret_from_fork+0x35/0x40
  Code: 66 90 0f b7 07 55 48 89 e5 89 c2 88 47 02 88 47 03 66 81 e2 00 38
	66 81 fa 00 18 74 6e 66 81 fa 00 20 74 39 66 81 fa 00 10 74 14 <0f>
	0b 66 25 00 c0 74 20 66 3d 00 c0 75 20 c6 47 04 01 5d c3 66
  ---[ end trace 550c46682415b26d ]---
  brcmfmac: brcmf_construct_chaninfo: Ignoring unexpected firmware channel 50

This patch adds the missing stuff to properly handle this.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../broadcom/brcm80211/brcmutil/d11.c         | 34 ++++++++++++++++++-
 .../broadcom/brcm80211/include/brcmu_wifi.h   |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c b/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
index d8b79cb72b58..e7584b842dce 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
@@ -77,6 +77,8 @@ static u16 d11ac_bw(enum brcmu_chan_bw bw)
 		return BRCMU_CHSPEC_D11AC_BW_40;
 	case BRCMU_CHAN_BW_80:
 		return BRCMU_CHSPEC_D11AC_BW_80;
+	case BRCMU_CHAN_BW_160:
+		return BRCMU_CHSPEC_D11AC_BW_160;
 	default:
 		WARN_ON(1);
 	}
@@ -190,8 +192,38 @@ static void brcmu_d11ac_decchspec(struct brcmu_chan *ch)
 			break;
 		}
 		break;
-	case BRCMU_CHSPEC_D11AC_BW_8080:
 	case BRCMU_CHSPEC_D11AC_BW_160:
+		switch (ch->sb) {
+		case BRCMU_CHAN_SB_LLL:
+			ch->control_ch_num -= CH_70MHZ_APART;
+			break;
+		case BRCMU_CHAN_SB_LLU:
+			ch->control_ch_num -= CH_50MHZ_APART;
+			break;
+		case BRCMU_CHAN_SB_LUL:
+			ch->control_ch_num -= CH_30MHZ_APART;
+			break;
+		case BRCMU_CHAN_SB_LUU:
+			ch->control_ch_num -= CH_10MHZ_APART;
+			break;
+		case BRCMU_CHAN_SB_ULL:
+			ch->control_ch_num += CH_10MHZ_APART;
+			break;
+		case BRCMU_CHAN_SB_ULU:
+			ch->control_ch_num += CH_30MHZ_APART;
+			break;
+		case BRCMU_CHAN_SB_UUL:
+			ch->control_ch_num += CH_50MHZ_APART;
+			break;
+		case BRCMU_CHAN_SB_UUU:
+			ch->control_ch_num += CH_70MHZ_APART;
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			break;
+		}
+		break;
+	case BRCMU_CHSPEC_D11AC_BW_8080:
 	default:
 		WARN_ON_ONCE(1);
 		break;
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
index 7b9a77981df1..75b2a0438cfa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
@@ -29,6 +29,8 @@
 #define CH_UPPER_SB			0x01
 #define CH_LOWER_SB			0x02
 #define CH_EWA_VALID			0x04
+#define CH_70MHZ_APART			14
+#define CH_50MHZ_APART			10
 #define CH_30MHZ_APART			6
 #define CH_20MHZ_APART			4
 #define CH_10MHZ_APART			2
-- 
2.17.1

