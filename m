Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101FECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A3F21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ettpMG0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A3F21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbeIUBDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45616 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbeIUBDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so71015pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ivRY1Kh/G5kVwYw1yPcZ49+4DmZqfU/mV71jpWG14bQ=;
        b=ettpMG0GHid//TOdRz9SLrainVDU2+7rof8lNE013hsFFXx2NFQc+AFLm2o5KTZvHW
         wlIbNqNqoACmKMcS9U7t6Ml5FaopohdB9FWoqNa1rl4tz5OTYSMuxN/iipKzfNqJOt7O
         QDy0RwS2Shx7RndcJS3rN/QCjxnoLcwjplc/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ivRY1Kh/G5kVwYw1yPcZ49+4DmZqfU/mV71jpWG14bQ=;
        b=S3Ds9SvtIw32ds1YDLZ1jytdyy3NX8pw6FQLU7YRaYWhwICQZ5w+wX9qCQCM9N9DdT
         rZWSmeKm68dM63HDxZdJh9ESo14QWUmzysj6sJ1Ioh61iL7rQ4nHwjVK1lHLYeWFqrfE
         tRNyOwwhKkXU4xHNglNLjqxHYi712YnSdcd8GxCVypdhaNZpof38TubSbJHZss7BoASq
         87oBGbmrGcWGsBPT1LKKeJyE5teKAk5AWxFmFTaO43BLK2Cog18QWIm5sFwcOtitf5bs
         ApRGDRQCeLxzoR3ku2P5nvfeVVXHIK17rWD5b9TMZOB13ch0O8UYaWXRLV4XlN43t9Lk
         VQGw==
X-Gm-Message-State: APzg51D0rgeZ+ak0633xX1Ds2rLy9of6LHioDrAlDJmVfkVGTEwbb5rD
        +p36etb1kB5DGC41iBji+H5Thg==
X-Google-Smtp-Source: ANB0VdYowiuXIbI/gZ9fOdROHNVimodg5f5TnMrgdKvgM0fRpMJMc27dHF63JCvnaCYxUm96pt/KOQ==
X-Received: by 2002:a63:d74f:: with SMTP id w15-v6mr38336095pgi.306.1537471121123;
        Thu, 20 Sep 2018 12:18:41 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:40 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/44] coresight: perf: Avoid unncessary CPU hotplug read lock
Date:   Thu, 20 Sep 2018 13:17:48 -0600
Message-Id: <1537471099-19781-14-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We hold the read lock on CPU hotplug to simply copy the
online mask, which is not really needed. And this can
cause a lockdep warning, like :

[   54.632093] ======================================================
[   54.638207] WARNING: possible circular locking dependency detected
[   54.644322] 4.18.0-rc3-00042-g2d39e6356bb7-dirty #309 Not tainted
[   54.650350] ------------------------------------------------------
[   54.656464] perf/2862 is trying to acquire lock:
[   54.661031] 000000007e21d170 (&event->mmap_mutex){+.+.}, at: perf_event_set_output+0x98/0x138
[   54.669486]
[   54.669486] but task is already holding lock:
[   54.675256] 000000001080eb1b (&cpuctx_mutex){+.+.}, at: perf_event_ctx_lock_nested+0xf8/0x1f0
[   54.683704]
[   54.683704] which lock already depends on the new lock.
[   54.683704]
[   54.691797]
[   54.691797] the existing dependency chain (in reverse order) is:
[   54.699201]
[   54.699201] -> #3 (&cpuctx_mutex){+.+.}:
[   54.704556]        __mutex_lock+0x70/0x808
[   54.708608]        mutex_lock_nested+0x1c/0x28
[   54.713005]        perf_event_init_cpu+0x8c/0xd8
[   54.717574]        perf_event_init+0x194/0x1d4
[   54.721971]        start_kernel+0x2b8/0x42c
[   54.726107]
[   54.726107] -> #2 (pmus_lock){+.+.}:
[   54.731114]        __mutex_lock+0x70/0x808
[   54.735165]        mutex_lock_nested+0x1c/0x28
[   54.739560]        perf_event_init_cpu+0x30/0xd8
[   54.744129]        cpuhp_invoke_callback+0x84/0x248
[   54.748954]        _cpu_up+0xe8/0x1c8
[   54.752576]        do_cpu_up+0xa8/0xc8
[   54.756283]        cpu_up+0x10/0x18
[   54.759731]        smp_init+0xa0/0x114
[   54.763438]        kernel_init_freeable+0x120/0x288
[   54.768264]        kernel_init+0x10/0x108
[   54.772230]        ret_from_fork+0x10/0x18
[   54.776279]
[   54.776279] -> #1 (cpu_hotplug_lock.rw_sem){++++}:
[   54.782492]        cpus_read_lock+0x34/0xb0
[   54.786631]        etm_setup_aux+0x5c/0x308
[   54.790769]        rb_alloc_aux+0x1ec/0x300
[   54.794906]        perf_mmap+0x284/0x610
[   54.798787]        mmap_region+0x388/0x570
[   54.802838]        do_mmap+0x344/0x4f8
[   54.806544]        vm_mmap_pgoff+0xe4/0x110
[   54.810682]        ksys_mmap_pgoff+0xa8/0x240
[   54.814992]        sys_mmap+0x18/0x28
[   54.818613]        el0_svc_naked+0x30/0x34
[   54.822661]
[   54.822661] -> #0 (&event->mmap_mutex){+.+.}:
[   54.828445]        lock_acquire+0x48/0x68
[   54.832409]        __mutex_lock+0x70/0x808
[   54.836459]        mutex_lock_nested+0x1c/0x28
[   54.840855]        perf_event_set_output+0x98/0x138
[   54.845680]        _perf_ioctl+0x2a0/0x6a0
[   54.849731]        perf_ioctl+0x3c/0x68
[   54.853526]        do_vfs_ioctl+0xb8/0xa20
[   54.857577]        ksys_ioctl+0x80/0xb8
[   54.861370]        sys_ioctl+0xc/0x18
[   54.864990]        el0_svc_naked+0x30/0x34
[   54.869039]
[   54.869039] other info that might help us debug this:
[   54.869039]
[   54.876960] Chain exists of:
[   54.876960]   &event->mmap_mutex --> pmus_lock --> &cpuctx_mutex
[   54.876960]
[   54.887217]  Possible unsafe locking scenario:
[   54.887217]
[   54.893073]        CPU0                    CPU1
[   54.897552]        ----                    ----
[   54.902030]   lock(&cpuctx_mutex);
[   54.905396]                                lock(pmus_lock);
[   54.910911]                                lock(&cpuctx_mutex);
[   54.916770]   lock(&event->mmap_mutex);
[   54.920566]
[   54.920566]  *** DEADLOCK ***
[   54.920566]
[   54.926424] 1 lock held by perf/2862:
[   54.930042]  #0: 000000001080eb1b (&cpuctx_mutex){+.+.}, at: perf_event_ctx_lock_nested+0xf8/0x1f0

Since we have per-cpu array for the paths, we simply don't care about
the number of online CPUs. This patch gets rid of the
{get/put}_online_cpus().

Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6338dd180031..6beb662d230c 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -161,15 +161,12 @@ static void *alloc_event_data(int cpu)
 	if (!event_data)
 		return NULL;
 
-	/* Make sure nothing disappears under us */
-	get_online_cpus();
 
 	mask = &event_data->mask;
 	if (cpu != -1)
 		cpumask_set_cpu(cpu, mask);
 	else
 		cpumask_copy(mask, cpu_online_mask);
-	put_online_cpus();
 
 	/*
 	 * Each CPU has a single path between source and destination.  As such
-- 
2.7.4

