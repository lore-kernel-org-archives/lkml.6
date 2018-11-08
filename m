Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA32C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DB420857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wB6NEmlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DB420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeKIHhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbeKIHhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C202146E;
        Thu,  8 Nov 2018 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714410;
        bh=oj+1wSQgQHnGkACQFKblGUDmwTcXQPN8VromB72ZuI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wB6NEmlGiG27Tn3GLHkLxpGSkTBgajtPaypRngjY9/MxOGJqwHepHmmL3r53XO1Gz
         z4qtzWgy4qwh2ltXLjEK46C8066FX7lfcs5R6v6S3plkjA9XwVSARSZggLVhXglESq
         xYf6+HdYm4l6JxLkc/98lexLOY4OGF2/Ftl/jTqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 067/114] gpu: host1x: fix error return code in host1x_probe()
Date:   Thu,  8 Nov 2018 13:51:22 -0800
Message-Id: <20181108215107.121418023@linuxfoundation.org>
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

[ Upstream commit 7b2c63de20080c18d0de35b292ad61fc9bc8328e ]

platform_get_irq() returns an error code, but the host1x driver
ignores it and always returns -ENXIO. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 53d3d1d45b48..ce1b10a2ae85 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -116,8 +116,8 @@ static int host1x_probe(struct platform_device *pdev)
 
 	syncpt_irq = platform_get_irq(pdev, 0);
 	if (syncpt_irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
-		return -ENXIO;
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", syncpt_irq);
+		return syncpt_irq;
 	}
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
-- 
2.17.1



