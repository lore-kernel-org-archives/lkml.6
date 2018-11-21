Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F8EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A829F214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jtG+xexe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A829F214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbeKVEhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38139 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732894AbeKVEhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121180209euoutp01d8787985221a3ea39350478746eff997~pNaTDD1yN1020110201euoutp01I
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:02:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121180209euoutp01d8787985221a3ea39350478746eff997~pNaTDD1yN1020110201euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542823329;
        bh=3eynck/Mbf+ZgIWq9XJF/pjnq3tsISXoGoWYpyo2FUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtG+xexeE9AQba+OvgiiqFQgGLv6JqcP2ma+gpOJ5tjlGxkuHKI4+eObV0YG3bDQ8
         zRNBjlUc4rz/sOpn/7dOvT4ucHe2t5Hq5fOP4zHOffgMCoIl88nYG0FSAhn9CbjnOJ
         lDTXHswEd1+EsXqbPB/9o0Jcr+3gYZunajL3amRs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181121180207eucas1p1984d3830de52a6d5783c34bbe03355ba~pNaR54O4K0464304643eucas1p1G;
        Wed, 21 Nov 2018 18:02:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.89.04294.F9D95FB5; Wed, 21
        Nov 2018 18:02:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180206eucas1p265865226e3938a28e842e8367233dc2e~pNaRBfqc-0549405494eucas1p2m;
        Wed, 21 Nov 2018 18:02:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181121180206eusmtrp1888e0e8f99a9e105bba70175f01f43a4~pNaQx2BEb2594725947eusmtrp1q;
        Wed, 21 Nov 2018 18:02:06 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-c8-5bf59d9f0fb0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.7C.04128.E9D95FB5; Wed, 21
        Nov 2018 18:02:06 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180205eusmtip2c70961094a7fbf7d8744cc6b268294be~pNaP26cYI1293112931eusmtip2X;
        Wed, 21 Nov 2018 18:02:05 +0000 (GMT)
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
Subject: [PATCH 5/6] drivers: power: suspend: call devfreq suspend/resume
Date:   Wed, 21 Nov 2018 19:01:40 +0100
Message-Id: <1542823301-23563-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0yMcRzH+z4/7nkuLk9X05cs242tQtcZ8yVM44+HttZm/lBMR88KXXFP
        RYSTqev8KL+SSCat61zlUldSWtdx/dD1wxSFmcSiGq60xpo7T63/Xt/3+/N5v7/77kvj0gly
        MX0wIYlTJyjjZSJ3wvxiyr6qsGAiKjjHtAw1VQcgU14FiWpMv0nUN/6VRIVWO4nOFVWI0MsL
        KpQ9+B1HnZ2PKNSRPkKhfs0SlH+9AUOVg70kelV3R4Qcl6wA5XU+w1CZ9T2Fivu6MTRwVi9C
        79ueOzPae0h0vsFKoYyHP0g00vWB2AJZ81MzyRrvGgF7W9NNsDnZvwBbVD+MsZWGLBHbWGCk
        2McPzrDTLyi2aaweY6teZxLs5SoDYPUPJynWUekX4RHpvjGGiz+Ywqnlm6Pd4/IKzNgR+7zj
        T2yeGjAk1gExDZk18GfFfVwH3GkpowdQ130JEw7jAPZ8aphxHAA2t7WA2ZWpL5dJwSgB0HDu
        xtyK7sotQgdoWsQEwVrDUdeCN1PkjKoNcM3gTAsO635exVyGF7Md2k1awsUEsxx+0lpwF0uY
        HbB6rJEU2vzgW3vWf13MhEGHIWfmFqU0nCoJcXVBZhvMcuwWZC/4zVZFCbwEtl+7SAjMww6t
        QSRwGsxsrZ2ZCYHNtm7SFYMzAbCiTi7IoVD/bJoS0j3gm1FPl4w78ar5Ji7IEqjNkArT/rDq
        Yhcm8EJYYsydCWdhoUYnEh7nLoDZf1tBDliaP1d2DwAD8OGSeVUsx69O4I4F8UoVn5wQG3Qg
        UVUJnJ+xfdo2Xgvq/u63AIYGsvkS/90TUVJSmcKnqiwA0rjMW6KNdEqSGGXqCU6duE+dHM/x
        FuBLEzIfyUm3j1FSJlaZxB3muCOcetbFaPFiDUBbT4+UT3mSbdq9kzs1lrI9KaPv/LbZGGv/
        uuPGgTDv9FKstyQxvA8Xj+Z3rD2VulLfZKpR6glFWeC3BV1uGYqluugdofFusjR7y67eweEV
        f8qJz625MtNkeGZicET1ofRF8pCsH+MevsbiD4oNPQqbRX56w4mhsa5qc+um9eEygo9TKgJx
        Na/8B3lfbbCIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7rz5n6NNvi6Rtni4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+
        xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOr
        xZsL91gcJDy27d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaP
        g+/2MHlsudrO4tG3ZRWjx4rV39k9Pm+SC+CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuYMXcbU8E57oqdxwUbGJ9ydjFyckgImEj8fNbH2sXI
        xSEksJRR4nLPWXaIhJjEpH3boWxhiT/Xutggij4xSlx9uYq5i5GDg01AT2LHqkKQuIjAckaJ
        +z9ns4M4zAIPmCU6nm9iBekWFvCUOLexgwXEZhFQlXjUcYgZxOYV8JLY+m4/K8QGOYmb5zrB
        4pwC3hKfV01gBLGFgGquzFvIOoGRbwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAeN12
        7OeWHYxd74IPMQpwMCrx8GpEfo0WYk0sK67MPcQowcGsJMLbEQUU4k1JrKxKLcqPLyrNSS0+
        xGgKdNREZinR5HxgKskriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp
        1cAYu4BZwGti+qTzl/Idb4qY6q07snsRX/MrfrFV/Z/WWj6Zpt7hEaxhE6AeVdew9HTrt9h1
        P3ZuuRwXPLFk4wSxGZLn9vwQqdL4+eXH5LXHN5fnb194XHnL7z9Wt/+sK91apsj/5/rL58pf
        /TZoGkRzP1x26uHD9TN5mQvDXyqofpq9SO1j8rFTx5RYijMSDbWYi4oTAcxK99ztAgAA
X-CMS-MailID: 20181121180206eucas1p265865226e3938a28e842e8367233dc2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180206eucas1p265865226e3938a28e842e8367233dc2e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180206eucas1p265865226e3938a28e842e8367233dc2e
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180206eucas1p265865226e3938a28e842e8367233dc2e@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq framework supports suspend of its devices.
Call the the devfreq interface and allow devfreq devices preserve/restore
their states during suspend/resume.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
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

