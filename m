Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8CEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85697224E0
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DG9FoSML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85697224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeKPEY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:24:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbeKPEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:24:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id s11so9558928wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJe/Lh0u4I1EWKwZUx0PaLmr2WjeZlvlzz6DRN2R6yI=;
        b=DG9FoSMLSELm3P7rhJYiwePwmjMLFaU5/G43rzF/FDkJJGO6vcpfoAU1QpY+o7a5RI
         1CuWRYu+/t/tgI2nV7GiM+gQHLPbctcV0/+XubhvHxueDJKQe/Sww0vGcQhKS+E88h9b
         kIQx2YDvMgQz8CYVlozSzI/0F3ScqsJy6NPXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJe/Lh0u4I1EWKwZUx0PaLmr2WjeZlvlzz6DRN2R6yI=;
        b=nAO9mrddEcDTV8+vsx6FY91rI/hY5Y12qJe4J785pdVoivHs9a2i6by3xTh4dJgrRx
         lGVInlRpG+ISg2KwWS+EbnjXFZTriMzWnU3reehT0VBWXRzchTD4VqEt0SOc3nPudEYD
         D2PfG5T1vB0ajRQOu+xx8vdWCsZDFbn1Udj7lJ+B5PWuIkdhWzKN3jhBHajDWGbvFTd3
         qLguk/WQl9QB536O/ni5oVwhLO4i/439uhed2IfZYsnKdSxbqQL2ZjdUZyyntmSY55mm
         ZK3dAnp6qyZA0j9dfGv7N0OAp1tfKHh8+MJG8geW8JGOINTltfnAqWhbyXd5r9h3ZBOn
         QwEA==
X-Gm-Message-State: AGRZ1gKMCOcE/bZ9yOsuHDvOVAlrfW0Nw1483wHaEH0Y4Qg9jupqzV3c
        xrWx2ereBo2yxUb8Hm2FO/EAww==
X-Google-Smtp-Source: AJdET5eyRB5WlO70ERbDOomAlPcZMFgA92yVqVXWR5YPfpxi/JHIW851TjPmkd/varO7HBj77BlFYw==
X-Received: by 2002:a1c:248b:: with SMTP id k133-v6mr5864308wmk.148.1542305731343;
        Thu, 15 Nov 2018 10:15:31 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r76-v6sm20934737wmb.21.2018.11.15.10.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 10:15:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com,
        devicetree@vger.kernel.org, srini@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/5] ALSA: compress: make use of runtime buffer for copy
Date:   Thu, 15 Nov 2018 18:13:21 +0000
Message-Id: <20181115181324.26784-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
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
2.19.1

