Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE784C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7206420844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7nOTdPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7206420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeKIIGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbeKIHij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:39 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827042147D;
        Thu,  8 Nov 2018 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714470;
        bh=tTXxsua6lbTzqyWANVp/yIqb2tG8b3SrAFoJ4H6q95M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7nOTdPJzQmfW2CcC3nNkZtFGrkuSSmwGYsDWJ8nUnCjvcbuq/7z4oO6Uc5G6ry8v
         fsZ8XUsFrxzdF9pEOhrlm9gmh1Qp3+Iuneebjq9ply+0nC++Qcf0rCi0FbujoGnFLZ
         j1sAhh9c80Lcm1/h76DtoGfK4UQFTKBZOvbUHTFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 077/114] ASoC: spear: fix error return code in spdif_in_probe()
Date:   Thu,  8 Nov 2018 13:51:32 -0800
Message-Id: <20181108215107.938021386@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 27d30400c448264c1ac9434cb836de0c230af213 ]

platform_get_irq() returns an error code, but the spdif_in driver
ignores it and always returns -EINVAL. This is not correct, and
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print error message and propagate the return value of platform_get_irq
on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/spear/spdif_in.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 977a078eb92f..7f32527fc3c8 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -223,8 +223,10 @@ static int spdif_in_probe(struct platform_device *pdev)
 
 	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0)
-		return -EINVAL;
+	if (host->irq < 0) {
+		dev_warn(&pdev->dev, "failed to get IRQ: %d\n", host->irq);
+		return host->irq;
+	}
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))
-- 
2.17.1



