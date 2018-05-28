Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161678AbeE1KdL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161665AbeE1KdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 121/329] drm/exynos: g2d: use monotonic timestamps
Date: Mon, 28 May 2018 12:00:50 +0200
Message-Id: <20180528100252.774355964@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a588a8bb7b25a3fb4f7fed00feb7aec541fc2632 ]

The exynos DRM driver uses real-time 'struct timeval' values
for exporting its timestamps to user space. This has multiple
problems:

1. signed seconds overflow in y2038
2. the 'struct timeval' definition is deprecated in the kernel
3. time may jump or go backwards after a 'settimeofday()' syscall
4. other DRM timestamps are in CLOCK_MONOTONIC domain, so they
   can't be compared
5. exporting microseconds requires a division by 1000, which may
   be slow on some architectures.

The code existed in two places before, but the IPP portion was
removed in 8ded59413ccc ("drm/exynos: ipp: Remove Exynos DRM
IPP subsystem"), so we no longer need to worry about it.

Ideally timestamps should just use 64-bit nanoseconds instead, but
of course we can't change that now. Instead, this tries to address
the first four points above by using monotonic 'timespec' values.

According to Tobias Jakobi, user space doesn't care about the
timestamp at the moment, so we can change the format. Even if
there is something looking at them, it will work just fine with
monotonic times as long as the application only looks at the
relative values between two events.

Link: https://patchwork.kernel.org/patch/10038593/
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -926,7 +926,7 @@ static void g2d_finish_event(struct g2d_
 	struct drm_device *drm_dev = g2d->subdrv.drm_dev;
 	struct g2d_runqueue_node *runqueue_node = g2d->runqueue_node;
 	struct drm_exynos_pending_g2d_event *e;
-	struct timeval now;
+	struct timespec64 now;
 
 	if (list_empty(&runqueue_node->event_list))
 		return;
@@ -934,9 +934,9 @@ static void g2d_finish_event(struct g2d_
 	e = list_first_entry(&runqueue_node->event_list,
 			     struct drm_exynos_pending_g2d_event, base.link);
 
-	do_gettimeofday(&now);
+	ktime_get_ts64(&now);
 	e->event.tv_sec = now.tv_sec;
-	e->event.tv_usec = now.tv_usec;
+	e->event.tv_usec = now.tv_nsec / NSEC_PER_USEC;
 	e->event.cmdlist_no = cmdlist_no;
 
 	drm_send_event(drm_dev, &e->base);
