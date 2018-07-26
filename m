Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BB1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A11320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A11320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbeGZN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:56:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbeGZN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:56:31 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LtX2S-1gA07I0uSy-010y4e; Thu, 26 Jul 2018 14:39:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/gpu: avoid deprecated do_gettimeofday
Date:   Thu, 26 Jul 2018 14:39:25 +0200
Message-Id: <20180726123942.4172219-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Hm34pELgHedz40WKDazuD+Pq1FNMFo6qcWrEOPtyKAwm6xMaIM3
 irpU+jc0kZPu9AbM89kiNf2lEQWO6H+gkQ158a3VPrwZNjPYXkuahXM1xhPW6firoCfOwtI
 n/lGiofY43eeODPAOH0PL7kmk1af06whrBP8mpdGPLWpNAFPypUlhTZTK5M0rahqiJGBo1S
 klZgar6ZFdYMlcH1Gf00w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BT1nGARZdSs=:Ghy9VhzOljDxMYLitgs4fy
 sfvXXSvY0gpZk6o1He1ur6cMNWhkfeZiRXgw5JZXV7WdzrJipSSZygf1G3ZpcSWvE6JzYo/lG
 8fP+OVDD5vwCarOqT22jtgt7YR08iSvFcu58uoPOe3fBP2h4hqliDwjnF/CUWF+DGjQlEsVHj
 8Hw2VS1m3kgAVKja7jnXlmeKsW2GEU2NfVsYGULDjfqb5u2qsoM0p0+cV8Z/5hyagCx390+mp
 aluH6laNLsM4SAmUY1xe1Wfq//psCfDOMpUbcUkEFDQGme6HAUzYaigncFg+fnZEKpPOsaNUj
 MLfObBe7ousBLY4BtaShhfQi78o8y/VrlPpDseonwGbwDhr4t87aIM13rtLptmeUcpzMfeqOu
 r/O9wq5CnkPpaE3ID+ni9bbpUdKz5n1nD4jo5nwG9IexcEuXRqD0NjxXO9uOOGC/3TYSkvXx6
 ALhIGrY/QO9xs2W7U9YdK04Sb++hH3Rz0AYKhNmOv2/MWfKvBfksdklDmwAjmfFK4aB99anms
 G6DLj5gUxXehTG7WyyMEBeOz2x6DVOUn/8I9+2131nse5vDxMmQKhYk41qovKyJEXXtlmJKk2
 QfBcSNCiRfHmVz7Rg9B+x20UYYbW7TwiYzmVJAsNKlBYqtrQ/NTvjHdMHp4nl/8X56eXNSGci
 6pB9kIN/gqhHz2ZK+dd10Q+ya+LlHKSUIXtzy1Dt4mPChDb3hu82v+rlBmPOw9dzoYEQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of do_gettimeofday() have been removed, but this one recently
crept in, along with an incorrect printing of the microseconds portion.

This converts it to using ktime_get_real_timespec64() as a direct
replacement, and adds the leading zeroes. I considered using monotonic
times (ktime_get()) instead, but as this timestamp appears to only
be used for humans rather than compared with other timestamps, the
real time domain is probably good enough.

Fixes: e43b045e2c82 ("drm/msm/gpu: Capture the state of the GPU")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 drivers/gpu/drm/msm/msm_gpu.c           | 4 ++--
 drivers/gpu/drm/msm/msm_gpu.h           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 08d3c618b7de..38ac50b73829 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -376,7 +376,7 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
 
 	kref_init(&state->ref);
 
-	do_gettimeofday(&state->time);
+	ktime_get_real_ts64(&state->time);
 
 	for (i = 0; i < gpu->nr_rings; i++) {
 		int size = 0, j;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 3cf8e8d29812..f388944c93e2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -297,8 +297,8 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 	drm_printf(&p, "---\n");
 	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
-	drm_printf(&p, "time: %ld.%ld\n",
-		state->time.tv_sec, state->time.tv_usec);
+	drm_printf(&p, "time: %lld.%09ld\n",
+		state->time.tv_sec, state->time.tv_nsec);
 	if (state->comm)
 		drm_printf(&p, "comm: %s\n", state->comm);
 	if (state->cmd)
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 57380ef8d1f7..1c6105bc55c7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -189,7 +189,7 @@ struct msm_gpu_state_bo {
 
 struct msm_gpu_state {
 	struct kref ref;
-	struct timeval time;
+	struct timespec64 time;
 
 	struct {
 		u64 iova;
-- 
2.18.0

