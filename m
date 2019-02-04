Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E7C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC854217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277336;
	bh=pzl6RpArk25Zp4CbfwScCvXssSIHc2kGAdSa+XOewDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jp1VmUoEHyDeelX56yx7eiXzUjpDYtWgfoWM3l9YrlWP/lSoeUED7jFHWuqDZpZOM
	 FzW7TSJNehMaTUVWYYLsEXaLlYg2yCmgoLmwqu9fmQaS2t5rngwaSiFWfdQHN8/p+I
	 DmE6Qg6EFV/ffURo9KLoX0WH+v1BvazKCEU8bFS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfBDKsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbfBDKsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793D72070C;
        Mon,  4 Feb 2019 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277331;
        bh=pzl6RpArk25Zp4CbfwScCvXssSIHc2kGAdSa+XOewDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uo9W9/pkneweT0fv/s0y+7jd/PBfAwcUe883eDaeg3hWAQmD+mZ/hf5jkRjL5l/hY
         GiIsVRyoG4eKP1FLY5UZnx32wv07t3rHwOv2T7+DNEfgs2E3fzHdgAxsHCc5EacjSG
         H8by+0cQtAVQl3k5u2shHMDRGJHQOaZBfSi4zzGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 52/74] mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay
Date:   Mon,  4 Feb 2019 11:37:05 +0100
Message-Id: <20190204103626.579946123@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -784,7 +784,7 @@ static void msdc_set_mclk(struct msdc_ho
 
 	if (timing == MMC_TIMING_MMC_HS400 &&
 	    host->dev_comp->hs400_tune)
-		sdr_set_field(host->base + PAD_CMD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
 	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);


