Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4731C21734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129400;
	bh=RdAUZ+lsVawI2fCI3IpPwwE9X/qrovRRVh2AyrkT6RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TmOpzkJr5UTCVl0/r1IJanLXuSaHsYg227y4Pe9M8ZH4NtbVznrZeNfCExWTTrioO
	 6bRza2XIro0V99S+mvCi4DLDIOl2BPq9K3n+WZ/6ZdO3CSfsTVHqSJpbDl46mXWW6M
	 lsQnE5jrgpk0eZbs50/wjB3zBBqeHaPJe5VpmP4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfBYVQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbfBYVQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:16:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150FB2147C;
        Mon, 25 Feb 2019 21:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129392;
        bh=RdAUZ+lsVawI2fCI3IpPwwE9X/qrovRRVh2AyrkT6RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yWNnXvCtcerI7h4pmAhR+80+oYIorfY7Xedy3lnxnUV8WlEJSvJ5aCqdy3oQJ6PG+
         ZjtrECzHeHQhzbJOHHQ9O5DG6Hr0+aKqfuIqw7/MOWtqylHflNhvXeHHe6Y9KIy5pr
         05sLo52Qpb0/jkOUV0G5cxBrGlY0E2FxGiJ5HzxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dien Pham <dien.pham.ry@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/71] mfd: bd9571mwv: Add volatile register to make DVFS work
Date:   Mon, 25 Feb 2019 22:11:19 +0100
Message-Id: <20190225195035.813134792@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b0aff01e7aa6ad2d6998ef1323843212d1db8b04 ]

Because BD9571MWV_DVFS_MONIVDAC is not defined in the volatile table,
the physical register value is not updated by regmap and DVFS doesn't
work as expected. Fix it!

Fixes: d3ea21272094 ("mfd: Add ROHM BD9571MWV-M MFD PMIC driver")
Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[wsa: rebase, add 'Fixes', reword commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/bd9571mwv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 64e088dfe7b05..98192d4863e4c 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -57,6 +57,7 @@ static const struct regmap_access_table bd9571mwv_writable_table = {
 };
 
 static const struct regmap_range bd9571mwv_volatile_yes_ranges[] = {
+	regmap_reg_range(BD9571MWV_DVFS_MONIVDAC, BD9571MWV_DVFS_MONIVDAC),
 	regmap_reg_range(BD9571MWV_GPIO_IN, BD9571MWV_GPIO_IN),
 	regmap_reg_range(BD9571MWV_GPIO_INT, BD9571MWV_GPIO_INT),
 	regmap_reg_range(BD9571MWV_INT_INTREQ, BD9571MWV_INT_INTREQ),
-- 
2.19.1



