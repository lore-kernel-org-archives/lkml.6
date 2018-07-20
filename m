Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2617520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbeGTNdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:33:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389194AbeGTNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:33:46 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89ADDCA0;
        Fri, 20 Jul 2018 12:40:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.17 064/101] rtlwifi: rtl8821ae: fix firmware is not ready to run
Date:   Fri, 20 Jul 2018 14:14:10 +0200
Message-Id: <20180720121426.005802004@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

commit 9a98302de19991d51e067b88750585203b2a3ab6 upstream.

Without this patch, firmware will not run properly on rtl8821ae, and it
causes bad user experience. For example, bad connection performance with
low rate, higher power consumption, and so on.

rtl8821ae uses two kinds of firmwares for normal and WoWlan cases, and
each firmware has firmware data buffer and size individually. Original
code always overwrite size of normal firmware rtlpriv->rtlhal.fwsize, and
this mismatch causes firmware checksum error, then firmware can't start.

In this situation, driver gives message "Firmware is not ready to run!".

Fixes: fe89707f0afa ("rtlwifi: rtl8821ae: Simplify loading of WOWLAN firmware")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Cc: Stable <stable@vger.kernel.org> # 4.0+
Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -130,7 +130,6 @@ found_alt:
 		       firmware->size);
 		rtlpriv->rtlhal.wowlan_fwsize = firmware->size;
 	}
-	rtlpriv->rtlhal.fwsize = firmware->size;
 	release_firmware(firmware);
 }
 


