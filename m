Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A06C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA4720643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197222;
	bh=987XtclljPrTHmJ/00oQ9PRPaIndr+wTzAQnRy2yf2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h9ashaJ3GvXq6cbc0V3qqEiSEaawQHb6ssRuqPNKcPbfgmuE4vkNT+IfZ6EtwQ0yq
	 pFbADClU2/yyRFvKYPD2UvyXXaHgGazdnPbbJwVGa9vZNBqmY+25iskOirnYkus025
	 TNghVyos/cb7lTqVABqRhp9MuQ6OQmSzpHhqdnO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbfBOCUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391926AbfBOCPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:15:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19B8206BA;
        Fri, 15 Feb 2019 02:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196918;
        bh=987XtclljPrTHmJ/00oQ9PRPaIndr+wTzAQnRy2yf2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fG5dK6N06ufNBUsN3qBePfv740y2/KvpNPEVcGrRuOXW2xSGMxPvlxBg1lrUubLPy
         fYTzEC3pUzHmd71yizipPogbJrlOLpQXMYogPjj3ODr/FUgXBlX9pPWgQ2eKVXQwR1
         9w+X8Zqm9HnPhXDwgY8GqiOuNlnM6HxDxjxE3JG0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 03/20] ALSA: compress: prevent potential divide by zero bugs
Date:   Thu, 14 Feb 2019 21:14:54 -0500
Message-Id: <20190215021511.179333-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021511.179333-1-sashal@kernel.org>
References: <20190215021511.179333-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 678e2b44c8e3fec3afc7202f1996a4500a50be93 ]

The problem is seen in the q6asm_dai_compr_set_params() function:

	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
				       (prtd->pcm_size / prtd->periods),
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
				       prtd->periods);

In this code prtd->pcm_size is the buffer_size and prtd->periods comes
from params->buffer.fragments.  If we allow the number of fragments to
be zero then it results in a divide by zero bug.  One possible fix would
be to use prtd->pcm_count directly instead of using the division to
re-calculate it.  But I decided that it doesn't really make sense to
allow zero fragments.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 6163bf3e8177..2272aee12871 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -500,7 +500,8 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 {
 	/* first let's check the buffer parameter's */
 	if (params->buffer.fragment_size == 0 ||
-	    params->buffer.fragments > INT_MAX / params->buffer.fragment_size)
+	    params->buffer.fragments > INT_MAX / params->buffer.fragment_size ||
+	    params->buffer.fragments == 0)
 		return -EINVAL;
 
 	/* now codec parameters */
-- 
2.19.1

