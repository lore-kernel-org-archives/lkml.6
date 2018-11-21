Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C9FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA83C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kYu6bT+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA83C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbeKVEh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:28 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60166 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbeKVEh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181121180203euoutp0215610cfb4f22359da16272e5068fdad9~pNaNrsfBL1582515825euoutp02E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181121180203euoutp0215610cfb4f22359da16272e5068fdad9~pNaNrsfBL1582515825euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542823323;
        bh=oORLA3xIklIVwCz1S5SVDzYoqoM0P6trXJ3cqtDIJMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYu6bT+5N/+GPcs9sJeGSfoFt7ZlhM9HFTWl4bSECRNpXWm3lQ/YqyHXz1PYmzjoB
         gn/4zCKE/iqSPE85JSJ2N+i6xyusDNIGiPTOtaSTZEan0wxCUsHt6x0zghHYZAIzCo
         vLlcFzNJsowBbfwEOXYhf/M5VTNCBba29PxLXcbY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181121180202eucas1p17a1d057c3e02a04be49c6cda2bb314a5~pNaMdoqy03116331163eucas1p1Y;
        Wed, 21 Nov 2018 18:02:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.D7.04441.99D95FB5; Wed, 21
        Nov 2018 18:02:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80~pNaLnqHcb1762417624eucas1p1X;
        Wed, 21 Nov 2018 18:02:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181121180200eusmtrp1f9c45123686b2d8dc0ffcc4064919291~pNaLX8YLs2594725947eusmtrp1l;
        Wed, 21 Nov 2018 18:02:00 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-91-5bf59d990b99
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.7C.04128.89D95FB5; Wed, 21
        Nov 2018 18:02:00 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180159eusmtip29e2c5e45e6cec76b3ae8f36b8cd39c9d~pNaKfGZ3v1293112931eusmtip2V;
        Wed, 21 Nov 2018 18:01:59 +0000 (GMT)
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
Subject: [PATCH 1/6] devfreq: add basic fileds supporting suspend
 functionality
Date:   Wed, 21 Nov 2018 19:01:36 +0100
Message-Id: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvbPT2DpUIldESJpIwASUxIcbMUaDD+MWNW4BErXgBFRaSgdU
        1GjRWAouIKKgsphUpJYaoNZCABeggsomEEVFXNBEWVR2JShKnapv3/nPf85/cnMZXD5OejF7
        1Am8Vq2MVVASwl4/0Rp4KW8sYvHzd/6o5nYAKsspIVF52TiJOkc/kqjA0UKiE8YSCjWdUqH0
        9/04am0tpVHz8QEavdR5o8tZdzBkff+MRB2VuRQaOeMAKKf1LoZuOrppVNjZhqGuZBOFuh8/
        mN7R2E6ik3ccNNIXD5Jo4MlrYgXk7FV2krPkWwB3RddGcBnpw4AzVvdinNWcSnH38iw0d+va
        MW6qnuZqvlRjnO1pCsGdtZkBZyr+RnMjVp+NsnDJst187J79vHbR8l2SmKbr45SmTnZwIDMZ
        14HCmWnAjYHsEtg9cJNOAxJGzpoALKsbxMRiFMCW702uYgTA/KoG/O9IUb+DEhtFAL75mkf+
        G5koLSfSAMNQbBCsMMc7BzxYI4DtFQFOD84+xGHlUCbmbMxmN8Gh3gnSyQS7AFrazX90KbsG
        Tn16RYhpPvBFS+qfZDd2LRwxZwBRv8HA5LL1Iq+CBnu9yz8b9jXYaJG9YeP50y5dgM0GMyXy
        EZjyqMLlCYF1DW2k82acDYAllYucCNmV8MOkr4gy+Pyzu9OMT2OmPRsXZSk06OXiDn9oO/0E
        E3kOLLJcdO3moO5pNiE+Tj6AvemVeAbwvfw/6yoAZuDJJwqqaF4IVvMHggSlSkhURwdFxams
        YPo3Nk41DFeAsfbIWsAyQDFT6h82FiEnlfuFJFUtgAyu8JAawqcl6W5l0iFeG7dTmxjLC7Vg
        HkMoPKWHZ7yNkLPRygR+H89reO3fLsa4eenAfBNzwM+u3Lilryu5R4GMsn59WN7XJWGhpp8h
        syIfu0ev9vqxwW3zjr25RJZ3sD4tJyoqW1ad4helS6I6tBKDdW2Y78v77LqjKx9ujz+57UGu
        kNCBgcbJngvgVp9nYJxtlqZA75B3DY9qqnZFSmPmamJnrFta/Fq91fgrNLTnnIIQYpTBC3Gt
        oPwN7IAIOIkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7oz5n6NNjhyxdDi4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+
        xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOr
        xZsL91gcJDy27d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaP
        g+/2MHlsudrO4tG3ZRWjx4rV39k9Pm+SC+CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4s+wbW8Fhvoo3kxqZGxiX8nQxcnJICJhILH99hK2L
        kYtDSGApo8S1j19ZIRJiEpP2bWeHsIUl/lzrgir6xCix++16oCIODjYBPYkdqwpB4iICyxkl
        7v+czQ7iMAs8YJboeL4JbJKwgL/E8peHwGwWAVWJNZdWMYHYvAJeEv9e3GGB2CAncfNcJzOI
        zSngLfF51QRGEFsIqObKvIWsExj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM2G3H
        fm7Zwdj1LvgQowAHoxIPr0bk12gh1sSy4srcQ4wSHMxKIrwdUUAh3pTEyqrUovz4otKc1OJD
        jKZAR01klhJNzgcmk7ySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxS
        DYxrbUOvqD7lWaV407c2xvquaPul7G2a6jdqX03w/X3vgBmvRdHvyJ4y94wWcXW5pe8ZRIMm
        J+s9LNGWvVP4wOPWj44PP3dUvH7FIXR9xt+5R7dmyYrcd+HPYWZJ4ZLrvLnp69uNIflrpzHV
        zJt6Mj/xeabPNRZ7pss29bw3tzWJfUl2O+LfeFSJpTgj0VCLuag4EQCYBQT07gIAAA==
X-CMS-MailID: 20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch prepares devfreq device for handling suspend/resume functionality.
The new fields will store needed information during this process.
Devfreq framework handles opp-suspend DT entry and there is no need of
modyfications in the drivers code.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 3 +++
 include/linux/devfreq.h   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1414130..e20e7e4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -657,6 +657,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
+	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	atomic_set(&devfreq->suspend_count, 0);
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index e4963b0..7fe96f9 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -167,6 +167,10 @@ struct devfreq {
 	unsigned long scaling_max_freq;
 	bool stop_polling;
 
+	unsigned long suspend_freq;
+	unsigned long resume_freq;
+	atomic_t suspend_count;
+
 	/* information for device frequency transition */
 	unsigned int total_trans;
 	unsigned int *trans_table;
-- 
2.7.4

