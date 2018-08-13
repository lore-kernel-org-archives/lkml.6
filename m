Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF60C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB712171F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB712171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbeHNAH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:07:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNAH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:07:58 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lm4C9-1gO72H2RH7-00ZeGn; Mon, 13 Aug 2018 23:23:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/msm/gpu: fix msm_gpu_crashstate_capture stub prototype
Date:   Mon, 13 Aug 2018 23:23:43 +0200
Message-Id: <20180813212351.2555757-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:aAPMKN6LEn05fLMvFvs3Ego/oMlVt7g/vCqLOyqWT2xQOc9FmGw
 IuU1/S36zbMj9c2qZacPMilnH2rRjXZqY7FnkcliGXFm5W439wLBP+ecGLKoLTcCSQ+cQne
 gHLtBVscwMvY4EKUJRtHMasPBWbh7vcmMy2oruCrOvq+R35sSz0DtdB8j19ATm7nims9xmV
 6ki7Sw3KC+8Lw8/hl0qug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wp2a2UUF9e4=:gzv1v6e42YtcuflDzTRraK
 NR4rDikwqPofO2UaO0YrTM4ll8i0SZmXyc8fdsceVYGeld3CHA8wr5nWp94sur7DBbgFh+D47
 l7e+0OIS88a6lAQk28h5DmsrbMFr5T80NexT1Kg/VLpSYJKkLvsGfzfNSWw/1Qnvwd17j+B03
 IrqWxEJPRKQXvmvG5UoNumEh8EX+QHp0jYYKIc4kWgxaCy5ekkIpFME2FTGccb1XSAfCv21EE
 imgqzsKa3b+6uTk+aW4NQPs4b5xRcw6gohrvnNXnqqbAJqPIVuTEQSaLaFDjXIG0PZfoE5Mb5
 hIYNWDzn6SmozmHkbe55Vwit9nc+PvIJmr7dQnF4F4N31IUoF/lrGfKTB4h6gC+x8ym/alqd+
 3eYlcR1A3qxHeHaH5Ohj5dmikEI2SwgWqu5JaTsd5bhmYGu9BFyOXyr3QnIrCyeVTYP5cRvrw
 pOwEZD/dz5Nu8e3CVdnTkWj5WOa8tLWcc3YthXuLv7EQC2yZcU9zJm+aR8pNHZK7eladVjHED
 FOnk5EevBGxGwRxNFHfhVUwPNSJQbmS+pce+N/U6G1QCiE/62l0M5ThlxNTBUViW/SjE/fNDq
 I6wyVmYcY47U2n6cdjd+YUDgOqPkRUhV1fByiR94umlvqcvOGv1BrUjOrRD1pn4q3/cJxAcGR
 1mOV2AVqEMJMzeMX/Nskt36v8YOVv7G47f2+N8QVgrFN5G+NE9RWHQOjMgb9XuRuuqY4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype recently changed, but the patch missed the
second prototype that is used when CONFIG_DEV_COREDUMP is disabled:

drivers/gpu/drm/msm/msm_gpu.c: In function 'recover_worker':
drivers/gpu/drm/msm/msm_gpu.c:461:34: error: passing argument 2 of 'msm_gpu_crashstate_capture' from incompatible pointer type [-Werror=incompatible-pointer-types]
  msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
                                  ^~~~~~
drivers/gpu/drm/msm/msm_gpu.c:370:67: note: expected 'char *' but argument is of type 'struct msm_gem_submit *'
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
                                                             ~~~~~~^~~~
drivers/gpu/drm/msm/msm_gpu.c:461:2: error: too many arguments to function 'msm_gpu_crashstate_capture'
  msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/msm/msm_gpu.c:370:13: note: declared here
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,

Change the stub to match the normal function.

Fixes: cdb95931dea3 ("drm/msm/gpu: Add the buffer objects from the submit to the crash dump")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/msm_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 5e808cfec345..46e6b82f7b66 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -367,8 +367,8 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		msm_gpu_devcoredump_read, msm_gpu_devcoredump_free);
 }
 #else
-static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
-		char *cmd)
+static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
+		struct msm_gem_submit *submit, char *comm, char *cmd)
 {
 }
 #endif
-- 
2.18.0

