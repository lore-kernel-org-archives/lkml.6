Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD92C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D752F214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWqQE2Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D752F214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeIZQiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:38:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38100 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeIZQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:38:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id z16-v6so1710193wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TN2IJYdHgtT3BemFu8Zp1UT/5yhsLzCn9bEmOt6lOpI=;
        b=XWqQE2IlUVNjMtveRD6CAvGlRmZ/OpsYOg/IqRzN+4gUlbqaODkme2cXgvvgtNOYIb
         rl+o44RLqc6nYU44jqWDMUAZiaRLOXpzX92CALCquPVR/MXXkAN9Y15ZL7VSx8tCvFjG
         e2BwbnieNa3JuEMRFoFkEULU0C+4TENskguac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TN2IJYdHgtT3BemFu8Zp1UT/5yhsLzCn9bEmOt6lOpI=;
        b=IU54IP06KXwQei2+yEdmCJYk8CRetA3jo8r2WmPEiB3IXuNLJJSJibuPDkaUwXb7er
         VVzOl5mlgALQU9kIhQB3Zv5IkcX7wKpVkwIJqJ2Dl6hQOiNxY18AOffHDGW2O0ZmfAf3
         86FqHfPB9iHnFuQ+TljwK1xEaHuLRI6qfVBaXP4UoISXKd1FRUckVnkvDNnnpVKrszPC
         UR/fzphik5whOcGpQ/eaI9IyJgx60WdWbWm6aEkpboNDyPthbHqnA57/Nug54hxbnV0e
         VEaRG4loGLKRcecfzlLbHm8XyjnIobxduzPaa3TOkWqhnAiPbfglEifWPBW7k4t3IZx/
         gKOg==
X-Gm-Message-State: ABuFfojiyl8K0IPaI7WebIM1OEbkyL9BlBDJ6hULPZuoVYN7ZjCeOcPK
        o5/FSYvUXXLTa7mxkqarBnyd5w==
X-Google-Smtp-Source: ACcGV61IQc4UNYNuueAkF8cfA2HqxkNRLoh9Mv5p5MjB4ce+iIXd2DxO11NlR7+zr5Tndi8WW/ROUA==
X-Received: by 2002:a1c:c145:: with SMTP id r66-v6mr3813360wmf.131.1537957558038;
        Wed, 26 Sep 2018 03:25:58 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b12sm4442648wrx.11.2018.09.26.03.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 03:25:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] ALSA: compress: make use of runtime buffer for copy
Date:   Wed, 26 Sep 2018 11:23:46 +0100
Message-Id: <20180926102349.23481-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default copy function uses kmalloc to allocate buffers, lets check
if the runtime buffers are setup before making this allocations.
This can be useful if the buffers are dma buffers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/core/compress_offload.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 26b5e245b074..a5b09e75e787 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -171,7 +171,8 @@ static int snd_compr_free(struct inode *inode, struct file *f)
 	}
 
 	data->stream.ops->free(&data->stream);
-	kfree(data->stream.runtime->buffer);
+	if (!data->stream.runtime->dma_buffer_p)
+		kfree(data->stream.runtime->buffer);
 	kfree(data->stream.runtime);
 	kfree(data);
 	return 0;
@@ -505,7 +506,7 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 		struct snd_compr_params *params)
 {
 	unsigned int buffer_size;
-	void *buffer;
+	void *buffer = NULL;
 
 	buffer_size = params->buffer.fragment_size * params->buffer.fragments;
 	if (stream->ops->copy) {
@@ -514,7 +515,18 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 		 * the data from core
 		 */
 	} else {
-		buffer = kmalloc(buffer_size, GFP_KERNEL);
+		if (stream->runtime->dma_buffer_p) {
+
+			if (buffer_size > stream->runtime->dma_buffer_p->bytes)
+				dev_err(&stream->device->dev,
+						"Not enough DMA buffer");
+			else
+				buffer = stream->runtime->dma_buffer_p->area;
+
+		} else {
+			buffer = kmalloc(buffer_size, GFP_KERNEL);
+		}
+
 		if (!buffer)
 			return -ENOMEM;
 	}
-- 
2.19.0

