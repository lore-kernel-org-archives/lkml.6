Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F93C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6AA2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EbJtxlwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6AA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeLELGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:06:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53305 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeLELGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:06:25 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181205110624euoutp025b46c7e309dae8871f38fe87910a6d87~taxTZVEKV0210202102euoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 11:06:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181205110624euoutp025b46c7e309dae8871f38fe87910a6d87~taxTZVEKV0210202102euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544007984;
        bh=LRlOYMeWZ4Pn6LNSpHnLb7js4tkMWar/hUEOf/knVcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbJtxlwQ46yHFQHSB2LJomkM0zLImQ+AtocZdAoPJCYBrFLgMb2Z2UqdcCkuoOYV/
         6cX2lVm0Z7CH+2dTLEgVEz6ZeBbZmv5dnSlaW6sJO0AVQ1ls6/6LuG0NDt8eI6knmr
         6meO9oI9J6i1CQbfe4rz3l37f5b0nqHn2N/ZlbEA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205110623eucas1p1953f6d4a55bbf236020e3e50336a975f~taxSIydaK0438704387eucas1p1Q;
        Wed,  5 Dec 2018 11:06:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 73.2A.04294.E21B70C5; Wed,  5
        Dec 2018 11:06:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181205110622eucas1p23d788afd54ad34c0a2663efac8734648~taxRUAd5X1232912329eucas1p2c;
        Wed,  5 Dec 2018 11:06:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205110622eusmtrp29f0b1cca9862b24b4f8233baf824657b~taxREDk7J2724527245eusmtrp2H;
        Wed,  5 Dec 2018 11:06:22 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-2d-5c07b12e4886
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.72.04128.D21B70C5; Wed,  5
        Dec 2018 11:06:21 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110621eusmtip1224f767f833b11470b6ca303950e2723~taxQJBHz52561925619eusmtip1Z;
        Wed,  5 Dec 2018 11:06:21 +0000 (GMT)
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
Subject: [PATCH v3 3/5] devfreq: add devfreq_suspend/resume() functions
Date:   Wed,  5 Dec 2018 12:05:54 +0100
Message-Id: <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe1BMYRjGfefsuRTLsTX1Dg1jjUuGJI35GsZtMg5mqMYfhmbYdCbUruwR
        SsitK8qli1DG0mUta7e1ssSUVYRWoiVlmzLjblI7LjMGu07Gf7/veZ/ne9755mNJhZsaxW7U
        bBW0GlWSkvaVWRt/tEwLMTGxoSWmmbj+ajA2lRgpfM30lcJO9xsKl9tbKLxfZ6Txwzw1zu/9
        QGKH4wqDH+37yOCOjCBceqKOwObedgq32U7TeOCwHeESxy0CX7J3MfiCs5XAL/dW0bir+a7n
        jgdPKHywzs7gzIt9FP74+JVsPvDWG1aKN5QZEH8qo1XGF+T3I1538x3Bm/U5NH/7jIHha87v
        4X81Mnz955sEb3mWJeOPWPSIr7r4jeEHzGOihq/2nRMvJG3cJminz13nu8FlqUbJNYE72gtO
        kRmo0S8X+bDAhYO7po/wsoKrQuDKS8xFvh52I6gp6iSlwwACp2sv+S9x7st+QhpUIuhucMqk
        uCdyIDcqF7EszYVArX6LV/bndAie1AZ7/SR3jwTbl2N/6/y4xfDuUAXjZRk3ATIPFFBelnNL
        QfezgpLKxsCLlpy/xT7cMsj7fZmW9GoWrO1DJY6EXtNBJLEfvG+yMBIHwe/r5YTEIjzK1g9m
        0yHrfu2gZzbcaWqlvDuTXDAYbdMleQFc7v9KeGXghsPzTyO9MunBY9ZiUpLlkJ2pkNyTwXLo
        8WBRAFQaihjJwkPn5yTpocoQ7DPepgvQ2NL/XWcR0qNAIUVUJwhimEbYHiKq1GKKJiFk/Wa1
        GXn+4oNfTe5aZPsZ14A4FimHyeEEHaugVNvEVHUDApZU+sur5jCxCnm8KjVN0G5eq01JEsQG
        NJqVKQPlO4d0r1FwCaqtQqIgJAvaf1OC9RmVgVacvraoY0tQsU3Z54g+crLscFdh6K1obmGL
        o2Le0/ZOTVy9Ru2aCh1QGNBvjF9u6ZkYVr/Hpb2UUy13FvfMLR9tfxsX8XzV9/DxEUsU4zYl
        L24eEZbORb4OmFW3svzT0ebGNFdyJaozzIpZd/zZOF2iOT9yd1F1b8xuzbBdk9pci5QycYNq
        xhRSK6r+AHEqfGCHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7q6G9ljDFb8tbQ4uFXTYuOM9awW
        2zd+Y7W4/uU5q8X8I+dYLZoXr2ezONOda9H/+DWzxfnzG9gtzja9Ybe41SBjMWvKXiaLTY+v
        sVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3G1ewWdw9dRRoxulLrBate4+wW7St/sBq
        8ebCPRYHCY9tu7exeqyZt4bRY3bDRRaPCf2fGD0W73nJ5LFpVSebx/65a9g9Ni+p9/h3jN3j
        4Ls9TB5brrazePRtWcXosWL1d3aPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DLub1nJWLBZvOLahNnMDYzHhLsYOTkkBEwkFn1sZgKx
        hQSWMkq0dJdDxMUkJu3bzg5hC0v8udbF1sXIBVTziVFiUuMj5i5GDg42AT2JHasKQeIiAssZ
        Je7/nM0O4jALPGCW6Hi+iRWkW1jAXeJlzzKwSSwCqhJtLRPA4rwCXhKL/yxjhdggJ3HzXCcz
        iM0p4C3R/X8dG8RFXhJT+5czTWDkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwXrcd
        +7llB2PXu+BDjAIcjEo8vBJT2GKEWBPLiitzDzFKcDArifCusGGPEeJNSaysSi3Kjy8qzUkt
        PsRoCnTURGYp0eR8YCrJK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TB
        KdXAGJZR91lW8kOGSXV0p8nGu4aaqR3HjTjjjk2cuHiWsrvfxTfTdTZubtkXuMHX2IZJMi6H
        TSD1bEy7xbyjgr8nCK3LDeuc/mVN9YNjkxvU/PY2ZFVoa695dPDMwugwmVvmLzSNj32z4C3a
        G33knu45txYrEfltG16+q/Myb8/+W7pQ4eiym1Y8SizFGYmGWsxFxYkAcIb/HO0CAAA=
X-CMS-MailID: 20181205110622eucas1p23d788afd54ad34c0a2663efac8734648
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110622eucas1p23d788afd54ad34c0a2663efac8734648
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110622eucas1p23d788afd54ad34c0a2663efac8734648
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110622eucas1p23d788afd54ad34c0a2663efac8734648@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds implementation for global suspend/resume for
devfreq framework. System suspend will next use these functions.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  6 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 46517b6..0ae3de7 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -935,6 +935,50 @@ int devfreq_resume_device(struct devfreq *devfreq)
 EXPORT_SYMBOL(devfreq_resume_device);
 
 /**
+ * devfreq_suspend() - Suspend devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycles for suspending governors
+ * and devices preserving the state for resume. On some platforms the devfreq
+ * device must have precise state (frequency) after resume in order to provide
+ * fully operating setup.
+ */
+void devfreq_suspend(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_suspend_device(devfreq);
+		if (ret)
+			dev_err(&devfreq->dev,
+				"failed to suspend devfreq device\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
+ * devfreq_resume() - Resume devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycle for resuming governors and
+ * devices that are suspended with devfreq_suspend().
+ */
+void devfreq_resume(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_resume_device(devfreq);
+		if (ret)
+			dev_warn(&devfreq->dev,
+				 "failed to resume devfreq device\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
  * devfreq_add_governor() - Add devfreq governor
  * @governor:	the devfreq governor to be added
  */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d985199..fbffa74 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -205,6 +205,9 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+extern void devfreq_suspend(void);
+extern void devfreq_resume(void);
+
 /**
  * update_devfreq() - Reevaluate the device and configure frequency
  * @devfreq:	the devfreq device
@@ -331,6 +334,9 @@ static inline int devfreq_resume_device(struct devfreq *devfreq)
 	return 0;
 }
 
+static inline void devfreq_suspend(void) {}
+static inline void devfreq_resume(void) {}
+
 static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags)
 {
-- 
2.7.4

