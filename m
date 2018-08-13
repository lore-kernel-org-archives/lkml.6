Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2290EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69DA21781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69DA21781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeHNAID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:08:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNAID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:08:03 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LrKaC-1g1Bkw20GS-0136zU; Mon, 13 Aug 2018 23:23:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/msm/gpu: fix building without debugfs
Date:   Mon, 13 Aug 2018 23:23:44 +0200
Message-Id: <20180813212351.2555757-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180813212351.2555757-1-arnd@arndb.de>
References: <20180813212351.2555757-1-arnd@arndb.de>
X-Provags-ID: V03:K1:5C9zMnJIm2j7aonRZ0RUaJoxxro5gafvjRhMgH0MCak7wLdTkUa
 zyun0g7K1f1otb2jXQNiADlqmeT57rnDB+VmT6MUZvsvJ4zT8zbYoXQJuBAVsZOyU9LyZ57
 stSrWwmSPiA37Vb5PmRVPxQ3ejBNQND3EPkt4NlwHBcnEBsBHUBV27TxejoWSYklzpkZ+AQ
 Qwy6CcqCidW5tswvVwn6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7dhPx8wMYqI=:f3Ougk7mbz7qgLOnustbh0
 dejwPbW4f4RM16aI1nylAUyPn/8Y8jdBNrEhhFQoIdb3MUGUhUi1nngO0yguKM1KliTX4A9QA
 H072eOE4bPtyeaRIOV2r33zU7XJhk1/mG8CVgjHAKDlxcGyFcOYeW2ItFoF7sE5zkWlKD7n5Y
 daMcQnn1W3i6A3Detjs3N6gcpn8Ussx5vUbGvS20vCpbltcPEN+bmoTuVcZWc0eIyDYMJHTeH
 vhBqchwiC69ZPiw3O2V/L0R6nYdRhBXo/erH69XHCpeykz2ffyuSV+/6XG/Phi5eHcn3EGrX2
 tL+QSWqq1VUToI56K9fqy35WwUYQeiFjRhiDKeSbK99iKfaCnqqJ6b6WbKNg1pXM0BNLdjvAC
 MgAhh2Xq0tLYz2rEgrvN+45J/QfTceOAM7WFWXkxK9MwNVK4P/Z5kFe3SDmYZ5ySL6AaY4ht6
 CqYfTt7wkeWtiHjekfwAwL/kydyoq2pDFoCZenP/ibrbkIaoPNXqZAha9HgmWzH5HLgiBEybn
 FoFbEs7BVp0zrZRMNCHf46D/HYT4wDkpCA3Tl08nR/feLtLnU+MXKLyJ0LY6cjRXp1eznKgt1
 RV7e2jlBMVVcv/jtcnqF+hOT7YfaKXP6B7ZZ7i7drMwRWWhXtZjeq8g/2V337Nwkjt7HPl0Rh
 QgF3MkPEz++ZsGYwspULobzZPmq5uLe3ry9fkkaXaQxV0KdFfOXzt6UPhfGEpwBI5IFg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Not sure if this does the right thing, but it does fix the build regression
---
 drivers/gpu/drm/msm/msm_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 9122ee6e55e4..1fe93920fb25 100644
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
-- 
2.18.0

