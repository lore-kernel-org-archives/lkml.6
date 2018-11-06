Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C7DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9757020827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YJrST7B/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jbLnU8JR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9757020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbeKFPeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:34:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbeKFPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:34:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 13B0260ADB; Tue,  6 Nov 2018 06:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541484627;
        bh=Cn3HO29ZZ1PWta/JA8C2cL6tD/wzqk1MvMJZ30dT5bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJrST7B/VE61p/ifamGYdJyYKDFoTD4YTEHJAFv3UD+mncXsBQTqMmbfFZnCMDr3P
         YGFHXl2pqM7b3Uw1YmwelBWe5siISoiK3R+EEXDrSNeJdAtzLnKVehgp4mP7r15Cbd
         NQOiQoXpuznF7z4iDR7X0oVi7RMoUo7m4l/fbg/E=
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 428C360A9B;
        Tue,  6 Nov 2018 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541484626;
        bh=Cn3HO29ZZ1PWta/JA8C2cL6tD/wzqk1MvMJZ30dT5bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbLnU8JR1Z5joEXHE0GJ04EA+cIHsZ2mttks74EpJLES46dxnBmHLMj3v88EZINFU
         bMRyJEBs4l3WRQoPadz0M2P7f3MNcwBn9Y+zNOkBR/Uvt46L2kUeLu4DIc8VV5xlFN
         Wn2z7xnFWn/q6+MifejKrCiJHEltC3jMQHCTi8jw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 428C360A9B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        chris@chris-wilson.co.uk, jcrouse@codeaurora.org,
        robdclark@gmail.com, linux-kernel@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH 3/3] drm/msm: Optimize adreno_show_object()
Date:   Tue,  6 Nov 2018 11:40:06 +0530
Message-Id: <1541484606-20813-3-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
References: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the userspace tries to read the crashstate dump, the read side
implementation in the driver currently ascii85 encodes all the binary
buffers and it does this each time the read system call is called.
A userspace tool like cat typically does a page by page read and the
number of read calls depends on the size of the data captured by the
driver. This is certainly not desirable and does not scale well with
large captures.

This patch encodes the buffer only once in the read path. With this there
is an immediate >10X speed improvement in crashstate save time.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 76 ++++++++++++++++++++++++---------
 drivers/gpu/drm/msm/msm_gpu.h           |  2 +
 2 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c93702d..e29093e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -475,34 +475,70 @@ int adreno_gpu_state_put(struct msm_gpu_state *state)
 
 #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
 
-static void adreno_show_object(struct drm_printer *p, u32 *ptr, int len)
+static char *adreno_gpu_ascii85_encode(u32 *src, size_t len)
 {
-	char out[ASCII85_BUFSZ];
-	long l, datalen, i;
+	void *buf;
+	size_t buf_itr = 0;
+	long i, l;
 
-	if (!ptr || !len)
-		return;
+	if (!len)
+		return NULL;
+
+	l = ascii85_encode_len(len);
 
 	/*
-	 * Only dump the non-zero part of the buffer - rarely will any data
-	 * completely fill the entire allocated size of the buffer
+	 * ascii85 outputs either a 5 byte string or a 1 byte string. So we
+	 * account for the worst case of 5 bytes per dword plus the 1 for '\0'
 	 */
-	for (datalen = 0, i = 0; i < len >> 2; i++) {
-		if (ptr[i])
-			datalen = (i << 2) + 1;
-	}
+	buf = kvmalloc((l * 5) + 1, GFP_KERNEL);
+	if (!buf)
+		return NULL;
 
-	/* Skip printing the object if it is empty */
-	if (datalen == 0)
+	for (i = 0; i < l; i++)
+		buf_itr += ascii85_encode_to_buf(src[i], buf + buf_itr);
+
+	return buf;
+}
+
+/* len is expected to be in bytes */
+static void adreno_show_object(struct drm_printer *p, void **ptr, int len,
+		bool *encoded)
+{
+	if (!*ptr || !len)
 		return;
 
-	l = ascii85_encode_len(datalen);
+	if (!*encoded) {
+		long datalen, i;
+		u32 *buf = *ptr;
+
+		/*
+		 * Only dump the non-zero part of the buffer - rarely will
+		 * any data completely fill the entire allocated size of
+		 * the buffer.
+		 */
+		for (datalen = 0, i = 0; i < len >> 2; i++) {
+			if (buf[i])
+				datalen = ((i + 1) << 2);
+		}
+
+		/*
+		 * If we reach here, then the originally captured binary buffer
+		 * will be replaced with the ascii85 encoded string
+		 */
+		*ptr = adreno_gpu_ascii85_encode(buf, datalen);
+
+		kvfree(buf);
+
+		*encoded = true;
+	}
+
+	if (!*ptr)
+		return;
 
 	drm_puts(p, "    data: !!ascii85 |\n");
 	drm_puts(p, "     ");
 
-	for (i = 0; i < l; i++)
-		drm_puts(p, ascii85_encode(ptr[i], out));
+	drm_puts(p, *ptr);
 
 	drm_puts(p, "\n");
 }
@@ -534,8 +570,8 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 		drm_printf(p, "    wptr: %d\n", state->ring[i].wptr);
 		drm_printf(p, "    size: %d\n", MSM_GPU_RINGBUFFER_SZ);
 
-		adreno_show_object(p, state->ring[i].data,
-			state->ring[i].data_size);
+		adreno_show_object(p, &state->ring[i].data,
+			state->ring[i].data_size, &state->ring[i].encoded);
 	}
 
 	if (state->bos) {
@@ -546,8 +582,8 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 				state->bos[i].iova);
 			drm_printf(p, "    size: %zd\n", state->bos[i].size);
 
-			adreno_show_object(p, state->bos[i].data,
-				state->bos[i].size);
+			adreno_show_object(p, &state->bos[i].data,
+				state->bos[i].size, &state->bos[i].encoded);
 		}
 	}
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index f82bac0..efb49bb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -187,6 +187,7 @@ struct msm_gpu_state_bo {
 	u64 iova;
 	size_t size;
 	void *data;
+	bool encoded;
 };
 
 struct msm_gpu_state {
@@ -201,6 +202,7 @@ struct msm_gpu_state {
 		u32 wptr;
 		void *data;
 		int data_size;
+		bool encoded;
 	} ring[MSM_GPU_MAX_RINGS];
 
 	int nr_registers;
-- 
1.9.1

