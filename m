Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81EC208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81EC208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755106AbeFRPhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:37:11 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754852AbeFRPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:37:09 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MOjCA-1fXg1y3Ef8-0067iH; Mon, 18 Jun 2018 17:37:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Yong Zhao <yong.zhao@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Andres Rodriguez <andres.rodriguez@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] amdgpu: kfd: use modern ktime accessors
Date:   Mon, 18 Jun 2018 17:35:11 +0200
Message-Id: <20180618153649.2015346-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180618153649.2015346-1-arnd@arndb.de>
References: <20180618153649.2015346-1-arnd@arndb.de>
X-Provags-ID: V03:K1:db5AyKfnoApCkOjdUqSR4FofUO9/GgmgPAOirl2VzoUhMMbSo6t
 EAf2GFiSHkI+adSyeNgbB5KnCVG1fddyhyd8P69SkKT/KbEhNY5W5aqy5fgfqXlICKOezUb
 R3hT2GJPCD8aWjOrbmAdScldBnOmI11fg5BvN03QqrcnW8EpwIJO2YubU9dZxLAAQlNBuEQ
 noqlkbBJWrDF+52sA4H6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K5pE9ej9gxI=:m7gHveVMybd+mu/0BBmfVD
 C45wzSnVytJcPNU++6LJuS/pGphTd2xaL6GNhuWG1IP3RsXcfE9dJlpmV7Jt3/lFYbuNuiN5g
 bUDITVDz7D6XZuGWc2ysXStwWw0W9BkewJjn0iUKI0N+ZtG1xJ9hVkPpsAvByfJuGtc6TUEDk
 nRAjtXBe8EOScgQZ7Vt/YdKuyKUMpS1q1XLv27x+9G8PgHuOZkkn/L0E+JtPv1i20p5G+iVDv
 /umpn62qkppI9t8Tr/LPWIQaMAAkwllJYZ+R6oDLgGfSbMU0zxhCKXBLdnoWsGYnr0pgTnLP8
 zX+h5dg1keRSDd6nRRaY/lqx6qYDExUuuu82djE9m/RosaPPTilOldZ8e6KRjcVSbi49/4bof
 xYkx6ndApU+pzHBexqZbkEiQhlKmb7snggkenYK/TtOAtK9fa4zBTO0F6h2IsDzFUsBgLBBWm
 DB/X+zQAm1kue1iq/eEOxlJGwnUdoVPebA1N03xaFKC4LZk3GApRs9oUq/rlO1Qx0AhG38EQs
 l8BnK2KdI0tksWrGvjFvEs281ksq1h7YhtKX8QoINrWOY8KBu3W627P/HNaRKVGH8V1Hfv5/+
 iRg/hd0e+DJnULPDwZU6Gd+L1LwV1CKiY+qLFt/UxSeA7oV9gQfmaVxhGUJNU5yUuJ9PsODGw
 7VeD10ybdhaoNiT+g6OJl4VvaPZhsyGQJZjp5o02pq9v2XNAXHJ2g23/nFK/DKhUOA48=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getrawmonotonic64() and get_monotonic_boottime64() are deprecated
because of the nonstandard naming.

The replacement functions ktime_get_raw_ns() and ktime_get_boot_ns()
also simplify the callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f64c5551cdba..7e717716b90e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -754,7 +754,6 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 {
 	struct kfd_ioctl_get_clock_counters_args *args = data;
 	struct kfd_dev *dev;
-	struct timespec64 time;
 
 	dev = kfd_device_by_id(args->gpu_id);
 	if (dev)
@@ -766,11 +765,8 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 		args->gpu_clock_counter = 0;
 
 	/* No access to rdtsc. Using raw monotonic time */
-	getrawmonotonic64(&time);
-	args->cpu_clock_counter = (uint64_t)timespec64_to_ns(&time);
-
-	get_monotonic_boottime64(&time);
-	args->system_clock_counter = (uint64_t)timespec64_to_ns(&time);
+	args->cpu_clock_counter = ktime_get_raw_ns();
+	args->system_clock_counter = ktime_get_boot_ns();
 
 	/* Since the counter is in nano-seconds we use 1GHz frequency */
 	args->system_clock_freq = 1000000000;
-- 
2.9.0

