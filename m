Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3646FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F041920852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F041920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeFROIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:08:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754601AbeFROIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:08:37 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Mb8iR-1fnx6y0B8l-00KekP; Mon, 18 Jun 2018 16:08:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] posix-timers: fix nanosleep_copyout() for CONFIG_COMPAT_32BIT_TIME
Date:   Mon, 18 Jun 2018 16:07:59 +0200
Message-Id: <20180618140811.2998503-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:KWcztfOL8CF0VfxuTS9pFEZN5Pz4QPo0cxd06aMQ3S4ucXfTmnN
 pa6lkzGkFn4M7g3ab+oJA16LLEDrEgnYusH7pTayUomDDBrB0075pgZEaXtqO/Bq1YkyN16
 2L+J+EebgME7t28FnV6NTa3NKe+tH2HdNdf8VOS0sMVEP6OBgMdNkIcPBtN5AbYPMhQVVj4
 9/guOoL0Z4VcZgRJikLrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uct43v7Tppw=:vUicSlTQrWWgXrn4a1rmOw
 tEunvrSw7KawJ1wB9xCYqliIiLVQuRgjnDwSGW5bqscIi9zgkddMZNyB7raUvrQTWcbPAijM9
 yx/vZ5ODUDaVa4P0eGFh8DHx5Ve9+cM5nrpyAT7L/jaOgo1/cAqbSmw9q3FXU/F/sJcsV9eul
 p51JovstadcnaTezWbDWD0wIbpVhvbwX4HMHGHlwnxCUsZxgFbwGJ15kMMo0aJXOqFVzQZBe4
 0Ten5SF47ARRMgs0so3Yg3qyoxXHHmpZxJrMyoj08pZbCGyQOwK/+LER6rnwADg3JcSjwxbH3
 x2N/ffC+5miCvSCeX63v6oZLQkZ+TR+hFtxB/PYdr22e/xdPRC6stXwOHWDQ2NLJ4ZV0BhASj
 FdsywdQSHDMUtdKNlt/b602nCu/IaL9noCBprzxvLBDXbrPwTgcK1HvVzCCY+QYw0keI7M1wf
 OScel5vMB0qaPnDXuGecM+qc4YFHPiE6IBVQYqAYg/pyIN6csU4Ug2F7GKVZ82l+g4QhEh8Dd
 6+U2zH0PBZzkEspLlemxZf72V6FfiMwOHnfraLiaHCuC2L2CniPZx9OxfxTNs3KMWp77MImOV
 cdOB/kEWRLIUwKDl8YUXPsS/cwO1pi9yx01N+epcuc+R8Dy4dtcmI5welIBWlI2oFrzyVthzq
 rHW/LvQ97977KQiDMlMwFZ2u+yckpn09p950MLOZt67ilD/BBX60wkrfWAMMB8p6QStY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b5793b0d92c9 ("posix-timers: Make compat syscalls depend on
CONFIG_COMPAT_32BIT_TIME") added support for building the nanosleep
compat system call on 32-bit architectures, but missed one change
in nanosleep_copyout(), which would trigger a BUG() as soon as we
switch any architecture over to use it.

This makes sure the TT_COMPAT handler is available when we need it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 055a4a728c00..3e93c54bd3a1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1659,7 +1659,7 @@ EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 	case TT_COMPAT:
 		if (compat_put_timespec64(ts, restart->nanosleep.compat_rmtp))
 			return -EFAULT;
-- 
2.9.0

