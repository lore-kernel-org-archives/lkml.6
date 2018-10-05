Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96FC65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C23208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KexbWbxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C23208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeJEXQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbeJEXQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433C321480;
        Fri,  5 Oct 2018 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756227;
        bh=g85A6c+yJLTRvdx3id8M2xrTJ71IsPVqEnkWXBEhvB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KexbWbxsP7JqEqfLsM+FIkIytvVjHn0rundBVinoCg9Co3lLmRwnVo0um3E0qYNme
         mW7TiTrKIUrYGX0H7g8P0C1TfdUaZmOoGUmB4Vdw3FA2lktKT/CHH6wB0Ztcxq3le9
         IelcY2VwqCnaUYbbWs1mXH13DAenCXq1AKokkys8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Danny Smith <danny.smith@axis.com>, Danny Smith <dannys@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/14] ASoC: sigmadsp: safeload should not have lower byte limit
Date:   Fri,  5 Oct 2018 12:16:52 -0400
Message-Id: <20181005161704.20704-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161704.20704-1-sashal@kernel.org>
References: <20181005161704.20704-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danny Smith <danny.smith@axis.com>

[ Upstream commit 5ea752c6efdf5aa8a57aed816d453a8f479f1b0a ]

Fixed range in safeload conditional to allow safeload to up to 20 bytes,
without a lower limit.

Signed-off-by: Danny Smith <dannys@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/sigmadsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index d53680ac78e4..6df158669420 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -117,8 +117,7 @@ static int sigmadsp_ctrl_write(struct sigmadsp *sigmadsp,
 	struct sigmadsp_control *ctrl, void *data)
 {
 	/* safeload loads up to 20 bytes in a atomic operation */
-	if (ctrl->num_bytes > 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
-	    sigmadsp->ops->safeload)
+	if (ctrl->num_bytes <= 20 && sigmadsp->ops && sigmadsp->ops->safeload)
 		return sigmadsp->ops->safeload(sigmadsp, ctrl->addr, data,
 			ctrl->num_bytes);
 	else
-- 
2.17.1

