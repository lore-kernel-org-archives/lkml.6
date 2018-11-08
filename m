Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E9AC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7060C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Yflexb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7060C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbeKIHnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbeKIHnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:03 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D145920892;
        Thu,  8 Nov 2018 22:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714732;
        bh=hzQ9V+jeRVJoEg68oudqP3zdtebOduqRFI3jnhmPogE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0YflexbXW4qoNlefaaKzAUFqyUl7BkigzoH40xnzzXOd4aTjizN3/8/fzNxp91hp
         TkyjXCBbGFMD8lGFeRaxcxnSJbWZoFsRRLJibST1+y7sMKxvGKlHTU7IwlOm4ID1l7
         e5Bpke3azLNDY9EJ9Gxx0heLu4NaDPfQbU7MyqhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 092/171] ath10k: convert warning about non-existent OTP board id to debug message
Date:   Thu,  8 Nov 2018 13:51:02 -0800
Message-Id: <20181108215134.047693755@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7be52c03bbf7c8f53211ed13810d64dcb2bc7168 ]

Currently ath10k unncessarily warns about board id not available from OTP:

ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chip_id 0x043202ff sub 0000:0000
ath10k_pci 0000:02:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 1 testmode 1
ath10k_pci 0000:02:00.0: firmware ver 10.2.4.70.9-2 api 5 features no-p2p,raw-mode crc32 b8d50af5
ath10k_pci 0000:02:00.0: board id is not exist in otp, ignore it
ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 bebc7c08
ath10k_pci 0000:02:00.0: htt-ver 2.1 wmi-op 5 htt-op 2 cal otp max-sta 128 raw 0 hwcrypto 1

But not all boards have the board id in OTP so this is not a problem and no
need to confuse the user with that info. So this can be safely changed to a
debug message.

Also fix grammar in the debug message.

Fixes: d2e202c06ca4 ("ath10k: ignore configuring the incorrect board_id")
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 65ad7a130ca1..1e41d6c6de36 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -698,7 +698,8 @@ static int ath10k_core_get_board_id_from_otp(struct ath10k *ar)
 
 	if ((result & ATH10K_BMI_BOARD_ID_STATUS_MASK) != 0 ||
 	    (board_id == 0)) {
-		ath10k_warn(ar, "board id is not exist in otp, ignore it\n");
+		ath10k_dbg(ar, ATH10K_DBG_BOOT,
+			   "board id does not exist in otp, ignore it\n");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.17.1



