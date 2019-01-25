Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B40C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D5820881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kToesyks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAYNyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:54:19 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42157 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:54:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190125135415euoutp0186c0e5aa1f44b307da90cf555ee7cd45~9G9as7hCM2639226392euoutp01x;
        Fri, 25 Jan 2019 13:54:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190125135415euoutp0186c0e5aa1f44b307da90cf555ee7cd45~9G9as7hCM2639226392euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548424455;
        bh=jWw/l4QLnjeXzLowJnTJlB0lCENMN4uoWKH1dHHjzMA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kToesyksiQ+1G/7QohxpLcYOrYWYp0/zOqZhl2mu5DaAjZielVsBi9KlItYWePT7d
         VODLk14cNueazWe0iQ0kDNict+iM1MdNNwszcPS6jTvVspLPls0TfjshIke2AInV7J
         ohISyqeiOuQgZds2Cp1vFOdGSvZqIB39HOQP4JDc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190125135414eucas1p15178f2d37fcb8650184986641374ac2d~9G9Z9d4sD0209302093eucas1p1i;
        Fri, 25 Jan 2019 13:54:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1B.02.04441.6051B4C5; Fri, 25
        Jan 2019 13:54:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40~9G9ZSKu2o1260312603eucas1p2v;
        Fri, 25 Jan 2019 13:54:14 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c0-5c4b150637c3
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 22.D0.04284.6051B4C5; Fri, 25
        Jan 2019 13:54:14 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PLW00JUW3Y9R020@eusync3.samsung.com>;
        Fri, 25 Jan 2019 13:54:14 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH] devfreq: Suspend all devices on system shutdown
Date:   Fri, 25 Jan 2019 14:54:03 +0100
Message-id: <20190125135403.10228-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7djP87psot4xBh+eqVhsnLGe1eL6l+es
        FufPb2C3uNUgY3F51xw2i8+9RxgtZpzfx2Tx8sgPRou1R+6yW9xuXMHmwOVx6069x6ZVnWwe
        B9/tYfLo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujCnd/xgLPnJX3L74kqWB8S9nFyMnh4SA
        icTGZx9Zuhi5OIQEVjBKTJywBsr5zCixctE2VpiqV13vmSASyxglbh5bywjhNDBJzLv+khmk
        ik3AUKLrbRcbiC0iEC9x/c8xsFHMAluZJLpb54AVCQs4SKz9sgTMZhFQlVjbd5MFxOYVsJXo
        XnWHGWKdvMTqDQeYQZolBBrZJOZeuMcIkXCRmDxpC5QtI9HZcZAJoqiZUaJ9xix2CKeHUWLr
        nB1sEFXWEoePXwT7glmAT2LStulAYzmA4rwSHW1CECUeEs83XwfbLCQQK/H7YhPzBEbxBYwM
        qxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLj7fS/4592MH69lHSIUYCDUYmHd4Ogd4wQ
        a2JZcWXuIUYJDmYlEV5OAaAQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakF
        qUUwWSYOTqkGRslHgXdXWR3L3iWpm3FiYv80XpblWxvfr2a+84XBvoLrYfFtdmu59RlPPv7s
        WzZ7i5Jt29xJaW9DoxQONb1j+xt1cefXqHY14ZZLS9kV0wMvpArr+B/R/Wh0crbsBbuLrWl9
        mo/k5b/Pjbfi0lkgo2D1dcqh8y2F6jNX/F3JX/nKft+dq0qq5UosxRmJhlrMRcWJAPA5+WWz
        AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsVy+t/xq7psot4xBqtesVtsnLGe1eL6l+es
        FufPb2C3uNUgY3F51xw2i8+9RxgtZpzfx2Tx8sgPRou1R+6yW9xuXMHmwOVx6069x6ZVnWwe
        B9/tYfLo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujCnd/xgLPnJX3L74kqWB8S9nFyMnh4SA
        icSrrvdMXYxcHEICSxglnr9YxgLhNDFJrH9wiB2kik3AUKLrbRdbFyMHh4hAvMTJabUgNcwC
        25kk9j79wARSIyzgILH2yxJmEJtFQFVibd9NFhCbV8BWonvVHWaIbfISqzccYJ7AyLWAkWEV
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYJhsO/Zz8w7GSxuDDzEKcDAq8fBG8HvHCLEmlhVX
        5h5ilOBgVhLh5RQACvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl
        4uCUamBU+/wxr9zt4uaiDQdDF5/0vL1YJiTW/4C062WJVWwfVL+eSU9fk+kluy5nKePO4HW/
        Ob2KindEye98WHK04Jv1GZPb2sf/h6R+bbRlF4zoSA63eaX8Psz9cENb7N19rZlL/pssfv/T
        3j65yuJf3AOhfL5Sl5Xl3+ZqsD7/kllx3JfpTTC71BklluKMREMt5qLiRABZLXIaDwIAAA==
X-CMS-MailID: 20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40
CMS-TYPE: 201P
X-CMS-RootMailID: 20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way devfreq core ensures that all its devices will be set to safe
operation points before reboot operation. There are board on which some
aggressive power saving operation points are behind the capabilities of
the bootloader to properly reset the hardware and boot the board. This
way one can avoid board crash early after reboot.

Similar pattern is used in CPUfreq subsystem.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/devfreq/devfreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..f6aba8344c56 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -23,6 +23,7 @@
 #include <linux/devfreq.h>
 #include <linux/workqueue.h>
 #include <linux/platform_device.h>
+#include <linux/syscore_ops.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
@@ -1422,6 +1423,10 @@ static struct attribute *devfreq_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devfreq);
 
+static struct syscore_ops devfreq_syscore_ops = {
+	.shutdown = devfreq_suspend,
+};
+
 static int __init devfreq_init(void)
 {
 	devfreq_class = class_create(THIS_MODULE, "devfreq");
@@ -1438,6 +1443,8 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	register_syscore_ops(&devfreq_syscore_ops);
+
 	return 0;
 }
 subsys_initcall(devfreq_init);
-- 
2.17.1

