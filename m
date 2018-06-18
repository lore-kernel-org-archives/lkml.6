Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68CBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1DD20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1DD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934957AbeFRO1c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:27:32 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934269AbeFRO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:27:31 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M21ZH-1gMtae2vjH-00u0kz; Mon, 18 Jun 2018 16:27:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: Change to ktime_get_ts64()
Date:   Mon, 18 Jun 2018 16:27:09 +0200
Message-Id: <20180618142717.3683096-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:xQUMiYObpIAXkOFE9+aBJ6Mh7XpmaUZv71wXve5M+q394UXQQsX
 uLQDk/QEQ/Y53iKX7FE6AzfhaojvyJufy4DBdz3Cs+dhD4JWuucW2/U78Mb/kfpZndt3Vs/
 Jyt1E9kTFGMnW7/YI7yj2zRFmI6MLhggbNQRby692qcod8225lG9OO0UWExtp0bptjph6Mp
 sStJN/TD0tXrlzu2msYxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dhzkciyFwCM=:ub9r1D0D75oGGRB8UWYf7r
 WmK3M+aLZQUxQgIV0UJLm4jWYA5iUvUj1LfG6tTjwstIztcRvY/ClJbYngrxiiHW30ng/LVCY
 1IUa2temE8i0LS2/cdawFxzOwLDD9Fx8VUcFffHMQo1SFtktcCMNnX4VJ8PNXs+oRqTnM4pt3
 hhSIxuXmYF/mtYwZTeeqclDPn5zYWs41jV9dozDwir8pW8aFbZ1L2A5hgXEdvvldgf1v958fZ
 KHm9Yy/3oFUHGz92Z/Dss3Dj2zn4Ix5rbJrftzbmF9kjJ7BgAbWhj9b2K/dFTmW581EmZXE5u
 PGyPprl2gx8CYNNaxkoJDG9/ZQme5q3N1l1WCwhUUHyQ2NsycQRwXGOzONt1t0U2irP5aeh+2
 mRs24IHKyg/XyvXnIdVE6uNVN55XAFh7bi/3P/a/BC6CjysAmhDSXuAzIvauOgxZDEf6hQadN
 qTOa8Hk5As5dfghwji6zEkxN82q4pT6D1rtLZ5d1qSRodn7vH7m3fkDXoVKqbMhfQkQGbAFTd
 0z+sxorFuJ9riGP6lnQM9/KQcCHdPZzT7nxMUiY4HJP3eDC2TscyQz9F1uVwcXMKHmRRPI6QS
 A8jgoByNFCUB8v1MRN7K4r8lEQRtRdPMbs6noTHhfbrdaqCrxVK1D9pgBolwYmDgfVNLImW3A
 IS9EO6uSpPvbV1Xk943Dv2s2rYE9GNtAET7owTK83CJTewZrSXCKv7oJ3CU1MyHEWjDk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getnstimeofday64() is deprecated because of the inconsistent naming,
it is only a wrapper around ktime_get_real_ts64() now, which could be
used as a direct replacement.

However, it is generally better to use CLOCK_MONOTONIC timestamps
where possible, to avoid glitches with a concurrent settimeofday()
or leap second.

The uses in ipmi are either for debugging prints or for comparing against
a prior timestamp, so using a monotonic ktime_get_ts64() is probably
best here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ipmi/ipmi_si_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index ad353be871bf..fb19c796f0fa 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -269,7 +269,7 @@ void debug_timestamp(char *msg)
 {
 	struct timespec64 t;
 
-	getnstimeofday64(&t);
+	ktime_get_ts64(&t);
 	pr_debug("**%s: %lld.%9.9ld\n", msg, (long long) t.tv_sec, t.tv_nsec);
 }
 #else
@@ -961,12 +961,12 @@ static inline int ipmi_thread_busy_wait(enum si_sm_result smi_result,
 	if (max_busy_us == 0 || smi_result != SI_SM_CALL_WITH_DELAY)
 		ipmi_si_set_not_busy(busy_until);
 	else if (!ipmi_si_is_busy(busy_until)) {
-		getnstimeofday64(busy_until);
+		ktime_get_ts64(busy_until);
 		timespec64_add_ns(busy_until, max_busy_us*NSEC_PER_USEC);
 	} else {
 		struct timespec64 now;
 
-		getnstimeofday64(&now);
+		ktime_get_ts64(&now);
 		if (unlikely(timespec64_compare(&now, busy_until) > 0)) {
 			ipmi_si_set_not_busy(busy_until);
 			return 0;
-- 
2.9.0

