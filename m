Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbeC1OMa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:12:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeC1OM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:12:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] time: export nsec_to_clock_t
Date: Wed, 28 Mar 2018 16:11:54 +0200
Message-Id: <20180328141205.2954245-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:cEUItJOQ3WUSklK5+mc7ospzT8KZJ1Oj+3WcQbsUpIO+Dbbavog
 7r4VS7lAM7GJxc3JGZSR/DauqfiMskHPhxV12+MLNArtEufAWZHjZsi+Vb3zUbKJN+wXoPa
 hMMPb/1NJ9LxtKgQEAXsB04r7nTW4PTKRNbYZvkIJYKRjExMgBD5o19Wm3IqMfKVB3S2BVM
 NnHy+bsT7NkTlGWMTzS8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I6q46ZyDjr8=:w6iCHHKPwmgToMFrusqbMZ
 whzyRS8Uhkhrzbe5+dJkyQ9B5tRem/DkeRo+5EazsEJDfDGWGSaOzeBIRYgmuNTo5f6MKVJmP
 Gs2Q8iKM/vCqDJJashX5F5ocs/P8zKC9Zl45NpgPonnWC3z+BtwRleFf+WGLZL9T/ddvAWNOO
 ELNs1rYLISnQEhGGIYiKdpOK+7JuDzTmT5XHMYgzzpdcVQunH6BPftkzJ0ElvTWhor6hBsv6C
 Rk9Mq5myzu2wIfuJ+/Faeeg/hSVxoRnk3rticBfS2DF09qjVFDFTQ39aEZBMuJmvt2Y0LBete
 jT3JTe8h280hjRlF5kAPuyVZrGmLvZSkGd5TNDbwlX56zY0v91xkvuQ9gXuMYwK5ol6TmvZA7
 dtHCwhuqsFBAicd5oeuoFXxBBCzTVnLfKZLRc58ssjNYq/nxSPant6J1Nl//woxbjivw6qVnn
 4NAn0GYwRodaW/SGeTRNLa9EjQBZ33Ir/w5Qf5/PpVzSxJBe4Pid0B6bV3YFTjlvVLN6ZCBLC
 s9FrRS4rZrqJcHr8uFB1WP/wbveNG7Ejf2ooNUD1qMD7QiodhHgVPRDVHWzf+SBEerOZT/Oqd
 OwlFm4WfKoFSzrOpgCQLgsEq3LuJ2KDNSz4wfcJWLEA7l6fFa6qDAVtxyCEjiXbFX0wkrUoEr
 J/+9WS2Ktf3IAW8WhlNHBs13nN9zxECQ3tDPrtMuRVahxdCAKyNnm5DGX6U6byC7OEZxvfgs6
 EEgizNeubF2dweumgNXwGN005U3cTuviITpO2Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nsec_to_clock_t was traditionally used only in the core kernel, now we
have a sysfs file that needs it from a loadable module, causing a
link-time error:

ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!

This exports the function the same way that we do for related interfaces.

Fixes: 96cea33badc5 ("thermal: Add cooling device's statistics in sysfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 6fa99213fc72..97a262531f68 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -768,6 +768,7 @@ u64 nsec_to_clock_t(u64 x)
 	return div_u64(x * 9, (9ull * NSEC_PER_SEC + (USER_HZ / 2)) / USER_HZ);
 #endif
 }
+EXPORT_SYMBOL(nsec_to_clock_t);
 
 u64 jiffies64_to_nsecs(u64 j)
 {
-- 
2.9.0
