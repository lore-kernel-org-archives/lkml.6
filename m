Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6BE21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QxeWXAT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6BE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbeKVEiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:38:09 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38095 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732870AbeKVEh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:29 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121180206euoutp01b8e9212e75d0e019a80e80ed96f9304e~pNaQPM4IJ1022810228euoutp01B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:02:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121180206euoutp01b8e9212e75d0e019a80e80ed96f9304e~pNaQPM4IJ1022810228euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542823326;
        bh=TC4iv9GmwSHsehFTeXbZMrcoHrnEKqBkOFvwBCjFgEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxeWXAT/PVQVYFbL6LC9XU8+LWZPTzgKGBoL530dShlA27jh2FsUsAQC9T/aOXmQW
         67PxatvFYT+ixNndCcUqn+gTuyIZImIgaLbHw5AfX8JzxmQRPrfzWP94//5tAmRQHA
         rt8/yb0FFtPmaDGYwRPWvoxiww+J7p+LUT7cKgL0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181121180204eucas1p29f01fa667282f71e870be3b662344d1c~pNaPEsQ9i1318113181eucas1p2P;
        Wed, 21 Nov 2018 18:02:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A9.B3.04806.C9D95FB5; Wed, 21
        Nov 2018 18:02:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382~pNaOXcXWN3115831158eucas1p1T;
        Wed, 21 Nov 2018 18:02:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181121180203eusmtrp205083d871e555b0038b775a845c138bb~pNaOH68rp0880408804eusmtrp26;
        Wed, 21 Nov 2018 18:02:03 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-d6-5bf59d9c12be
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.48.04284.B9D95FB5; Wed, 21
        Nov 2018 18:02:03 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180202eusmtip2ee65eeaddffccee4e927d3dfba791f47~pNaNPk8pt1293112931eusmtip2W;
        Wed, 21 Nov 2018 18:02:02 +0000 (GMT)
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
Subject: [PATCH 3/6] devfreq: add support for suspend/resume of a devfreq
 device
Date:   Wed, 21 Nov 2018 19:01:38 +0100
Message-Id: <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaWwMYRj2zezsTJdtxqJ91Zl1RCWKKL4gjiAdRFLXn/YHQ0eJ7padFkVi
        XN1uL02DNvQgPTNd2q5atbSitq2rt7tRokEUdaxWJE3ZMYt/z/u8z/O87/fmY0hDPxXE7DTH
        CRYzH2PU6jTOhp8tM3Jy+yJnDSROwreuBOPK7HIKX63sp/CT7+8onO9upvCxgnItfpBiwie7
        P5C4paWCxk1HP9L4uTQWnz1VQ2BH92MKd7hytNiT5kY4u6WWwBfdL2hc9KSNwJ1HSrX4xb16
        b8b9dgqfqHHTOLHsC4U/tnZplgLnvO6kOHueHXHnpDYNl3HyG+IKbrwnOIds03I3c+00d7nw
        MDfYQHO3em8QXNUjq4ZLr5IRV1r2g+Y8jvHh/hG6RVFCzM69gmXm4i26He+LU6ndrw37Hacv
        Iwl1+ScjhgE2FHJf8clIxxjYUgSDOWWEWnxHcKekhk5Gft7CgyDzfLSCFcOxCptWFZUguJB+
        ifrnSJE+IyVWy4ZAtbxHMYxkCxC0VwcrGpK9Q4LrayahNEaw6+Hum2akYA07BST7mz9Yz64G
        OTWdUKeNh2fNNlLBfuwa8MgZSAkCtoiBaxWVSBWtgMxvKT7DCOhprKJVPBZ+Xcv38SI0Jcla
        FR8C691qn2Yh3G5so5SlSTYYyl0zVXoZNHYqr1dO5A9PPw1XaNILM51ZpErrISnRoKqnQVVq
        q29QAJTYz/jCObj9UKLV8+QhaOp5q8lAE87+H3YeIRkFCvGiKVoQ55iFfSEibxLjzdEh22JN
        DuT9jfcHG/uqUe3A1jrEMsg4TC9F9kUaKH6vmGCqQ8CQxpH6pAgvpY/iEw4IltjNlvgYQaxD
        YxiNMVB/cMirSAMbzccJuwRht2D52yUYvyAJyfkdL1s94QETtqyYnGbDUv/WoeGpC46sCRvt
        mj8cS5ua50/N2r7x5YF18rDQvPZxYa+Le63J7keJa4utKRtWfl4ff9TTY2VHQSE/fZUj6jjZ
        ecHxwdg1sFw/tzvXLK+MjVsSNNtdq7NMnOeKdfYedBeljXO6620JpVPNMSciCp8bNeIOfvZ0
        0iLyvwHadufziQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7qz536NNji0Rd/i4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+
        xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOr
        xZsL91gcJDy27d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaP
        g+/2MHlsudrO4tG3ZRWjx4rV39k9Pm+SC+CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4uayHteCRUMWmqZsZGxjv8XUxcnJICJhING/oZOti
        5OIQEljKKPF17ydmiISYxKR929khbGGJP9e6oIo+MUp8nvwTKMHBwSagJ7FjVSFIXERgOaPE
        /Z+z2UEcZoEHzBIdzzexgnQLCwRIvJ3ZBWazCKhKNKx5yghi8wp4Sazq6WOC2CAncfNcJ9hm
        TgFvic+rJoDVCAHVXJm3kHUCI98CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgRG77djP
        zTsYL20MPsQowMGoxMOrEfk1Wog1say4MvcQowQHs5IIb0cUUIg3JbGyKrUoP76oNCe1+BCj
        KdBRE5mlRJPzgckkryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QD
        46z0npwZl9uePOU1eWHlpNnJ1firrIOraca5U99mBFevr/E7YHyGwXtOtkn3hZ3fVP2088oY
        Y7Z+v7WRrTg3Wu2FsdTLiect9M9fEZMXcaxTqBe1kd874f/CU5nLvys+dd+Zek7894xKBdU1
        M600Vr3eYCMn99n+HNtXHScXe/PfW1f/+j/PSomlOCPRUIu5qDgRAEGu3tTuAgAA
X-CMS-MailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds support for handling suspend/resume process.
It uses atomic variables to make sure no race condition
affects the process.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cf9c643..7e09de8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
-	if (!devfreq)
-		return -EINVAL;
+        int ret;
+        unsigned long prev_freq;
+        u32 flags = 0;
+
+        if (!devfreq)
+                return -EINVAL;
+
+        if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_SUSPEND, NULL);
+		if (ret)
+			return ret;
+	}
 
-	if (!devfreq->governor)
-		return 0;
+	if (devfreq->suspend_freq) {
+		if (atomic_inc_return(&devfreq->suspend_count) > 1)
+			return 0;
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_SUSPEND, NULL);
+		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
+					 &prev_freq, flags);
+		if (ret)
+			return ret;
+
+		devfreq->resume_freq = prev_freq;
+	}
+
+        return 0;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
 
@@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
  */
 int devfreq_resume_device(struct devfreq *devfreq)
 {
+        int ret;
+        unsigned long prev_freq;
+        u32 flags = 0;
+
 	if (!devfreq)
 		return -EINVAL;
 
+	if (devfreq->suspend_freq) {
+		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
+			return 0;
+
+		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
+					 &prev_freq, flags);
+		if (ret)
+			return ret;
+	}
+
 	if (!devfreq->governor)
 		return 0;
 
-- 
2.7.4

