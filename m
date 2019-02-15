Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B208EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061A2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197730;
	bh=ldNhhAbC2FdOyzUuSS3YUvKcfzA+jzkS6VxIokd35fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WXegfUW/ErDLyztl8ld9Mr4hi0ouHcwBDh7Dy25Nw6kzH558qbnlVJU4BcaVdHBKY
	 gLyLmXTTSQaod6YmlVKoAoP0ZsKLUcgxAnAYhamrrfEehTvhM6PVoB465WX/F6BTHf
	 w0AgxE0Uqu4S7FRaP40nL8tnf/1qlTo//fhWqhQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfBOC2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404637AbfBOCNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B9921B1C;
        Fri, 15 Feb 2019 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196800;
        bh=ldNhhAbC2FdOyzUuSS3YUvKcfzA+jzkS6VxIokd35fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbnVaKyJq+yHslvC42EUba1LAuwKPCKHHCJRYzQCBGYO9CTPGkutS4fa0qOEMGxnQ
         du5mprnV4xSxkGq9shrGY9J5du2zSYrgRCyxOrpSnD/LAHwRt4gfA9gBfQbTS0H+PO
         FyKxEXsYzxbs/54SKIBijghEOJ8Lj0IV1I9CIMcI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 03/40] ALSA: compress: prevent potential divide by zero bugs
Date:   Thu, 14 Feb 2019 21:12:36 -0500
Message-Id: <20190215021313.178476-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
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
index 4490a699030b..555df64d46ff 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -529,7 +529,8 @@ static int snd_compress_check_input(struct snd_compr_params *params)
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

