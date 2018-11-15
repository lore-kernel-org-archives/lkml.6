Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E89C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27650223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PD2Miuqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27650223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbeKPEYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:24:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37121 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbeKPEYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:24:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so8020267wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3gLC+nmyp2mq9QJP7D6LeLPOksVBsoxF3h1ogX1tDA=;
        b=PD2MiuqtbVX1pUtDQ5uG7knacHELfzxsm2rl4tC/L3ngPzrHoSpuX51Kj5XLtACe+8
         TJyJoirK/chyhTCMDRGoAhgTM1HtEze10ObZ9eS24yWH3hRdYffonVmRxdc5UjMzb18n
         uEU3XUq52bRvcCBp+erqp9e6Ut6bP9aGmhXNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3gLC+nmyp2mq9QJP7D6LeLPOksVBsoxF3h1ogX1tDA=;
        b=sdg5FnRJRXioWRUAV1WYUm+wtrr6pbr5OtrZ037W9m9PU0JF+rdrolBn/V/3ObwZ4e
         rTF0ueG5+uksbd2Wc6n5VVbB7vxwKeGTnKFFKiFkTA8PbwjtzSZxXqAPlw9yyDeeMHA+
         t3DvXo3UIGNygPimBXPMOnWQtI9NEFR3f5PrH1/J4nLs6M+zRoWp5+12vNcmMgvklkId
         Oe7m8J1K31BLDSPEosSydA+Cs5QawBZmF4qOC1exEJtbXcEVGk4WFMTbE29B8N0SukFr
         OXTAgv9MhbNEjD5TfqKF+u/l4tiKFnephA/5ezDMt76se6UdttiYtwkC/OBJ2Rx/AR5Z
         gL2Q==
X-Gm-Message-State: AGRZ1gJpGwG8sGCX05XJnTv6g9gi1uUeco303fkCGW/vxPb57N6Xi8/f
        pUIqGpe8T3jNbELkMq+aJMqAYg==
X-Google-Smtp-Source: AJdET5fnRA4SvEnBPKfr4dd6BpBU5UWc+RQGAc7NKwKUAJohxZFeZpXNhRGiZkqx4J4EJ0BkRRlI9g==
X-Received: by 2002:adf:a78a:: with SMTP id j10-v6mr6975400wrc.286.1542305729876;
        Thu, 15 Nov 2018 10:15:29 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r76-v6sm20934737wmb.21.2018.11.15.10.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 10:15:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com,
        devicetree@vger.kernel.org, srini@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/5] ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
Date:   Thu, 15 Nov 2018 18:13:20 +0000
Message-Id: <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing compress offload code allocates data buffers using simple kmalloc,
however there are situations where these buffers have to be mapped
in smmu. So provide a way to set the runtime buffer by the driver itself,
simillar to what we do with pcm.

This patch adds support to set runtime dma buffer on compressed stream.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/compress_driver.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index ea8c93bbb0e0..0cdc3999ecfa 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -23,6 +23,7 @@ struct snd_compr_ops;
  * struct snd_compr_runtime: runtime stream description
  * @state: stream state
  * @ops: pointer to DSP callbacks
+ * @dma_buffer_p: runtime dma buffer pointer
  * @buffer: pointer to kernel buffer, valid only when not in mmap mode or
  *	DSP doesn't implement copy
  * @buffer_size: size of the above buffer
@@ -37,6 +38,7 @@ struct snd_compr_ops;
 struct snd_compr_runtime {
 	snd_pcm_state_t state;
 	struct snd_compr_ops *ops;
+	struct snd_dma_buffer *dma_buffer_p;
 	void *buffer;
 	u64 buffer_size;
 	u32 fragment_size;
@@ -175,6 +177,23 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	wake_up(&stream->runtime->sleep);
 }
 
+/**
+ * snd_compr_set_runtime_buffer - Set the Compress runtime buffer
+ * @substream: compress substream to set
+ * @bufp: the buffer information, NULL to clear
+ *
+ * Copy the buffer information to runtime buffer when @bufp is non-NULL.
+ * Otherwise it clears the current buffer information.
+ */
+static inline void snd_compr_set_runtime_buffer(
+					struct snd_compr_stream *substream,
+					struct snd_dma_buffer *bufp)
+{
+	struct snd_compr_runtime *runtime = substream->runtime;
+
+	runtime->dma_buffer_p = bufp;
+}
+
 int snd_compr_stop_error(struct snd_compr_stream *stream,
 			 snd_pcm_state_t state);
 
-- 
2.19.1

