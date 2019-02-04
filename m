Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B4BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088C42070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277434;
	bh=uQVWWFOyjRigtX5JU3DMH8ApCpVAdUrXbRy28RNzu78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p/ZI1elwsoDRr0Bk3ThzBN5BB5eMfKGRkk3PEwidKAqy8tWRSa+F29zG1+VFAb5VR
	 fOki/gWcJCXMEoGnbn4e9xBHl/5qL2sbDIhr8FF2nROVYP3TpLyV+BTYKBC+EkU/Be
	 Is+5Sir3oTncQze42yW2NyqKzf/3P++SUQW/tjW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfBDKud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732227AbfBDKu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A37F2186A;
        Mon,  4 Feb 2019 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277428;
        bh=uQVWWFOyjRigtX5JU3DMH8ApCpVAdUrXbRy28RNzu78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkkOhhehZZO7t3+Ji4VW+5X4s3Il8oZ50LqloEJNrFNAQYKvbG6+kbxvLxT2CzTfn
         seHOflN22Qf3opaEfPE4MOXhOrXwGR0z1KMrVQSb0OYAeywtpRSU+J1K5LoWQaKX9x
         e+owYCLsZVBiaiquGynLrsp2Qf/xXuPIM+B3Sm5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 4.20 01/80] drm/msm/gpu: fix building without debugfs
Date:   Mon,  4 Feb 2019 11:36:21 +0100
Message-Id: <20190204103620.425565531@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit c878a628e0c483ec36fa70f4590e4a58e34a6e49 upstream.

When debugfs is disabled, but coredump is turned on, the adreno driver fails to build:

drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:4: error: 'struct msm_gpu_funcs' has no member named 'show'
   .show = adreno_show,
    ^~~~
drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: note: (near initialization for 'funcs.base')
drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: error: initialization of 'void (*)(struct msm_gpu *, struct msm_gem_submit *, struct msm_file_private *)' from incompatible pointer type 'void (*)(struct msm_gpu *, struct msm_gpu_state *, struct drm_printer *)' [-Werror=incompatible-pointer-types]
drivers/gpu/drm/msm/adreno/a3xx_gpu.c:460:11: note: (near initialization for 'funcs.base.submit')
drivers/gpu/drm/msm/adreno/a4xx_gpu.c:546:4: error: 'struct msm_gpu_funcs' has no member named 'show'
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:1460:4: error: 'struct msm_gpu_funcs' has no member named 'show'
drivers/gpu/drm/msm/adreno/a6xx_gpu.c:769:4: error: 'struct msm_gpu_funcs' has no member named 'show'
drivers/gpu/drm/msm/msm_gpu.c: In function 'msm_gpu_devcoredump_read':
drivers/gpu/drm/msm/msm_gpu.c:289:12: error: 'const struct msm_gpu_funcs' has no member named 'show'

Adjust the #ifdef to make it build again.

Fixes: c0fec7f562ec ("drm/msm/gpu: Capture the GPU state on a GPU hang")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/msm_gpu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -63,7 +63,7 @@ struct msm_gpu_funcs {
 	struct msm_ringbuffer *(*active_ring)(struct msm_gpu *gpu);
 	void (*recover)(struct msm_gpu *gpu);
 	void (*destroy)(struct msm_gpu *gpu);
-#ifdef CONFIG_DEBUG_FS
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
 	/* show GPU status in debugfs: */
 	void (*show)(struct msm_gpu *gpu, struct msm_gpu_state *state,
 			struct drm_printer *p);


