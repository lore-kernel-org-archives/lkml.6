Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B64C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BC52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277632;
	bh=jNDHFUMnu7V9iaQBMkKC705WaKAY7WIqKopMOWI7w44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hcyy2ydE+CEvcLd6CGLc5sjMiQexrcZW1rH78+/UL4d0P+tpCU0ndE4nk/2CQE279
	 IMpspSK78fIHxlZgbS/Kz6XWRjTAQAvUOdQEdHE1Rp6eQJTWw9Rw3T9VfwgXHeY71p
	 yXyWhjdaBe1ccCOdVml+HoeR+d4gNC6Qq3ISrHNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfBDKxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732214AbfBDKxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353302070C;
        Mon,  4 Feb 2019 10:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277628;
        bh=jNDHFUMnu7V9iaQBMkKC705WaKAY7WIqKopMOWI7w44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzR8zKrPy1qWDV3LddHUuXKhmkIZgVeUjkthRNS39DUCM+vR5syMozkvBosFEqJ8V
         1QbdoD59vZgFC/1ptOo3La8mVIcDgqRXZTWGp7tEmramA6XL7zZu78CTconx0HkFVc
         QyoSey0oVFi36io1WZiX+ijL0QxC+yH6fiTbOlAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 56/80] mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay
Date:   Mon,  4 Feb 2019 11:37:16 +0100
Message-Id: <20190204103628.048088184@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Chaotian Jing <chaotian.jing@mediatek.com>

commit 3751e008da0df4384031bd66a516c0292f915605 upstream.

to set cmd internal delay, need set PAD_TUNE register but not PAD_CMD_TUNE
register.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Fixes: 1ede5cb88a29 ("mmc: mediatek: Use data tune for CMD line tune")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/mtk-sd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -846,7 +846,7 @@ static void msdc_set_mclk(struct msdc_ho
 
 	if (timing == MMC_TIMING_MMC_HS400 &&
 	    host->dev_comp->hs400_tune)
-		sdr_set_field(host->base + PAD_CMD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
 	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,


