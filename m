Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4620BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0101A208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L/R9Si4B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L/R9Si4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0101A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeFTIpN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:45:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932965AbeFTIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B9AEB60B15; Wed, 20 Jun 2018 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479716;
        bh=nq1Rj+IuSUxctErLN14x4dfHhRi38o79XenLWCgm4oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/R9Si4B7lNwMMXl09jK3naPFcg62nqDYe23xGiPHpLK9nozUHjvzabXCJwZ8Cyxw
         urXSSbJc9Z8yjrKeZoj6cA2KhCE2/FUHoElputYUHHHJ5SsJn7TD5quhh2VfJCoRe8
         MKwRWVUF/NjXI0AlU8RGxZQhbR5FqePv9ctG8Hgc=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 353B9605FF;
        Wed, 20 Jun 2018 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479716;
        bh=nq1Rj+IuSUxctErLN14x4dfHhRi38o79XenLWCgm4oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/R9Si4B7lNwMMXl09jK3naPFcg62nqDYe23xGiPHpLK9nozUHjvzabXCJwZ8Cyxw
         urXSSbJc9Z8yjrKeZoj6cA2KhCE2/FUHoElputYUHHHJ5SsJn7TD5quhh2VfJCoRe8
         MKwRWVUF/NjXI0AlU8RGxZQhbR5FqePv9ctG8Hgc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 353B9605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v4 11/15] mtd: rawnand: qcom: fix return value for raw page read
Date:   Wed, 20 Jun 2018 12:57:38 +0530
Message-Id: <1529479662-4026-12-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix value returned by ->read_page_raw() to be the
actual operation status, instead of always 0.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  NONE

* Changes from v2:

  1. Changed commit message

* Changes from v1:
 NEW CHANGE

 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 28361b5..887b1f6 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1898,7 +1898,7 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 
 	free_descs(nandc);
 
-	return 0;
+	return ret;
 }
 
 /* implements ecc->read_oob() */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

