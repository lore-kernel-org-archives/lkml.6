Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B815C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CD620661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UeoEo5r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CD620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeLELGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:06:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53306 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLELG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:06:27 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181205110626euoutp02889b760d431a791a51082c342718320d~taxU2HAN80312203122euoutp02f
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 11:06:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181205110626euoutp02889b760d431a791a51082c342718320d~taxU2HAN80312203122euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544007986;
        bh=UoqIULXgJ33xu2Pnucrdl+LhaphwYeDFo+URJwi4+eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeoEo5r0BfL75vuNMLCAr3EQr6SR3t6+hHeXbq233o4HlpTkTnmlXzALaRCEBUxZ9
         hpaw88U5abzrBDrFEfbm5zUcwBz9UK+Ao/Pqiu7aHMnNuTAygVXeEyBHkgpEA0wUvP
         eA1A8h+SYkcwiA1qLqmKLp0OVPIMneqnrtZl/Zsg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205110624eucas1p1dc94b28256d61bae3fa29ea623c54588~taxTu9Q5l1455014550eucas1p1J;
        Wed,  5 Dec 2018 11:06:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F1.01.04441.031B70C5; Wed,  5
        Dec 2018 11:06:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f~taxSt2en40100101001eucas1p1z;
        Wed,  5 Dec 2018 11:06:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205110623eusmtrp2e175437881f3d90b5017c4fc6cf5c7b9~taxSdgtmo2749027490eusmtrp2k;
        Wed,  5 Dec 2018 11:06:23 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-85-5c07b130c641
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.72.04128.F21B70C5; Wed,  5
        Dec 2018 11:06:23 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110622eusmtip196579160a294edb8f08789535970407f~taxRfT13o2314923149eusmtip1V;
        Wed,  5 Dec 2018 11:06:22 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 4/5] drivers: power: suspend: call devfreq suspend/resume
Date:   Wed,  5 Dec 2018 12:05:55 +0100
Message-Id: <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe1BMcRTH/fbufbRjc21GJ4+MNSEzKo/hN8OYjMzcwRiPYQbNZOlOmdrK
        XkWYsRUlIbOT5G0kZe1KyVZL0sMmvbSi1zAo8koqpZJH11389z3f8/mec+Y3P4ZQ9ZMTmB1h
        u3hdmCZUTSnkFttg7WyfHNrfJ+2aGpfc9sQ5adkkzs/pJ3Hj1w4SXyyvJXFcejaFq5O0OLnt
        I4Hr6m7SuCb2E41b9JPwmZQiGc5te0biJ9ZzFO49Vo5wWt09GTaXP6dxRmO9DLfGZFH4+aMH
        IzOq7CQ+VFRO4/jrX0j86fELuS9wljsWkjNdMCHurL5ezp1I7kFc+t33Mi7XmEhxxedNNHfr
        ygHup43mSj7flXF5TxPk3PE8I+Kyrn+jud5c9zXOmxWLA/nQHVG8znvJVkXwl7jwiEqnPeYu
        PalHBuYIcmKAnQ/fT2YSR5CCUbFZCHoGmpFUfEVwefA8JRW9CBqq35F/I+2POmipkYngrb2F
        /hcpG8wcyTMMxXpBgXGnGBjHpiOwF3iKDME+JMDabZCJDRd2FVzJaCFEXs56wEC3r2gr2RVg
        KBuSScvcobk2kRC1E7sSkn7d+HMRsNcYOFgX44D8oGFomJK0C3yoyKMlPQl+FV50MALUHDY6
        mP2QUFngYBZBWUU9Kd5AsJ6QbfWW7KVQbb0vF21gnaGpc6xoEyPSYDlFSLYSDserJHom5B19
        7Fg0HjJNqY7hHLx58dLxuhcQVL2+j06gKWf+L7uEkBG58pGCNogX5oTxu70EjVaIDAvy2h6u
        zUUjv7HqZ0VPAeqzbytFLIPUo5WQQvmrSE2UEK0tRcAQ6nHKrMW0v0oZqIney+vCA3SRobxQ
        iiYycrWrct+ol1tUbJBmFx/C8xG87m9XxjhN0COz4eP6VVMVrjNb3EzadcNRC8eHhJq73JZt
        VDQLcX1N7cym4Hw8b1vrKUowF+fYivyWr+9k5t6p9nvl0hMwL2FUcqG3W03iAtvYq2mxWyKS
        SjZ3eEyfNmPv5NQIy4/VMfa1fb5j1vQvqTjQxRTeJN19Onv7i22u+acDl1sDfP0aGjeo5UKw
        Zs4sQidofgNwQZ3DiQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7r6G9ljDJpmSlsc3KppsXHGelaL
        7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvcapCxmDVlL5PFpsfX
        WC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovbjSvYLO6eOgo04/QlVovWvUfYLdpWf2C1
        eHPhHouDhMe23dtYPdbMW8PoMbvhIovHhP5PjB6L97xk8ti0qpPNY//cNewem5fUe/w7xu5x
        8N0eJo8tV9tZPPq2rGL0WLH6O7vH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
        hsbmsVZGpkr6djYpqTmZZalF+nYJehkfmvMLTnJWrH3fwNrAOImji5GTQ0LAROLJqefsILaQ
        wFJGiY1fKyHiYhKT9m1nh7CFJf5c62LrYuQCqvnEKLGmdzFTFyMHB5uAnsSOVYUgcRGB5YwS
        93/OZgdxmAUeMEt0PN/ECtItLOAjsWTpLWaQBhYBVYkfHx1AwrwCXhKTDv9iglggJ3HzXCcz
        iM0p4C3R/X8dG8RBXhJT+5czTWDkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwVrcd
        +7llB2PXu+BDjAIcjEo8vBJT2GKEWBPLiitzDzFKcDArifCusGGPEeJNSaysSi3Kjy8qzUkt
        PsRoCnTTRGYp0eR8YBrJK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TB
        KdXAuI7NIIlJde2LT7268/0Sd4RtEpnCbvzV4Lm3bpFvpHlXz/0NP6d/LTvT8u2BdOq6lMPz
        1jm8zDnvEmOdqcDOsyCr3nrKG75q58/bln/qvcy13FS/hv26WXvrJRe3+NKghJBHky3fnjLM
        lW45FbObR9pl68tvf/VZihqi41cr5jZ62ATVp61TYinOSDTUYi4qTgQAqRpYi+sCAAA=
X-CMS-MailID: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq framework supports suspend of its devices.
Call the the devfreq interface and allow devfreq devices preserve/restore
their states during suspend/resume.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a690fd4..0992e67 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -32,6 +32,7 @@
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuidle.h>
+#include <linux/devfreq.h>
 #include <linux/timer.h>
 
 #include "../base.h"
@@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
+	devfreq_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
@@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
+	devfreq_suspend();
 	cpufreq_suspend();
 
 	mutex_lock(&dpm_list_mtx);
-- 
2.7.4

