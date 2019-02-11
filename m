Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4FA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894964;
	bh=kfx7zmtPJCmPyN/tCf5TJdPo1pBtC/LoCzcRNNT83xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvTbbeti3+GKTpyfgngymK55LexkauUEN11QP3+QDISvlPHdSsfBS6KOTu8EkrpJ/
	 VxfzqN7OT8jNtIJZc5a6mhJ9LDnvwT4vJohz6ZOHwllrx3dmYkH1W9fxHbjMHbVEtU
	 t/Hp9QA3bB3C2s7gakSRxJSpNWFwox07vNQzOgsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfBKOWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfBKOWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D139E20838;
        Mon, 11 Feb 2019 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894959;
        bh=kfx7zmtPJCmPyN/tCf5TJdPo1pBtC/LoCzcRNNT83xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkC65y1d8y0f2KVTehqVJ1qjm39TRqMvAMzFU0LbTEbzJvH/c2NZO7KXXrXtIbVLb
         T8N9Y3RKIDQnSyz7ln7EZ9YGyq+FEkrwUWn90hzrQNgUHoN9eckQ79WtL4Pxm6arFp
         Hes1SpDtkc7zVGYs1TqwImsH02l0bVudyBSNV+N8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 015/352] wil6210: fix reset flow for Talyn-mb
Date:   Mon, 11 Feb 2019 15:14:02 +0100
Message-Id: <20190211141847.365632431@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d083b2e2b7db5cca1791643d036e6597af27f49b ]

With current reset flow, Talyn sometimes get stuck causing PCIe
enumeration to fail. Fix this by removing some reset flow operations
that are not relevant for Talyn.
Setting bit 15 in RGF_HP_CTRL is WBE specific and is not in use for
all wil6210 devices.
For Sparrow, BIT_HPAL_PERST_FROM_PAD and BIT_CAR_PERST_RST were set
as a WA an HW issue.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 398900a1c29e..c54b008996ee 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -998,10 +998,13 @@ static int wil_target_reset(struct wil6210_priv *wil, int no_flash)
 
 	wil_dbg_misc(wil, "Resetting \"%s\"...\n", wil->hw_name);
 
-	/* Clear MAC link up */
-	wil_s(wil, RGF_HP_CTRL, BIT(15));
-	wil_s(wil, RGF_USER_CLKS_CTL_SW_RST_MASK_0, BIT_HPAL_PERST_FROM_PAD);
-	wil_s(wil, RGF_USER_CLKS_CTL_SW_RST_MASK_0, BIT_CAR_PERST_RST);
+	if (wil->hw_version < HW_VER_TALYN) {
+		/* Clear MAC link up */
+		wil_s(wil, RGF_HP_CTRL, BIT(15));
+		wil_s(wil, RGF_USER_CLKS_CTL_SW_RST_MASK_0,
+		      BIT_HPAL_PERST_FROM_PAD);
+		wil_s(wil, RGF_USER_CLKS_CTL_SW_RST_MASK_0, BIT_CAR_PERST_RST);
+	}
 
 	wil_halt_cpu(wil);
 
-- 
2.19.1



