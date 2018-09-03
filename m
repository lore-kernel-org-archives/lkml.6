Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA1EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B405E20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jCmoLHjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B405E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeICTKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:10:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45462 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeICTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180903144949euoutp02b2a9b02b6cbd2080a2ba8a7d0801a1c4~Q600dvih10365203652euoutp02_;
        Mon,  3 Sep 2018 14:49:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180903144949euoutp02b2a9b02b6cbd2080a2ba8a7d0801a1c4~Q600dvih10365203652euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535986189;
        bh=97lcJSBwEJUUh7h8LYu/i2eHSpinkv2R8qJwHk9r6Yw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=jCmoLHjSC4aG+KBtNAZKfWcUobj8Ph5hD0shTiw5FSUumD7affEMDhl8oSnhmXV+L
         1QfEGd7jHVgJyo1Qgy4aOj1Z4Jj3Z1QFFNIP0Te4TgQEsHe/po89Volh656R0ABFLj
         SV1CbZv5VBks6IYo8Ay+njpXCJrRIxxu57957R3Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180903144948eucas1p1e08f033466cf4dc66fe9ae1af8e89615~Q60z8vth51401214012eucas1p1o;
        Mon,  3 Sep 2018 14:49:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 74.6F.04806.C0A4D8B5; Mon,  3
        Sep 2018 15:49:48 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a~Q60zEI0Z00770907709eucas1p2s;
        Mon,  3 Sep 2018 14:49:47 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-23-5b8d4a0c9032
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.B9.04284.B0A4D8B5; Mon,  3
        Sep 2018 15:49:47 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PEH00LLMIIVL500@eusync4.samsung.com>;
        Mon, 03 Sep 2018 15:49:47 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] regulator: Fix useless O^2 complexity in suspend/resume
Date:   Mon, 03 Sep 2018 16:49:36 +0200
Message-id: <20180903144937.16507-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20180903144937.16507-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7djP87o8Xr3RBgfny1tsnLGe1WLqwyds
        Ft+udDBZXN41h81ixvl9TBZrj9xlt5i86CCrA7vHzll32T02repk87hzbQ+bR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGV8+C1aMFW0omP2bqYGxuOCXYycHBICJhL9Ow+ydzFycQgJrGCU
        6F/9iRHC+cwo0XPiBQtM1atdTxhBbCGBZYwSuw/xQRQ1MEnsvHyWCSTBJmAo0fW2iw3EFhHI
        lXh/5RcbSBGzwEZGiSmP3gPt4OAQFvCReHXEEaSGRUBV4sOmKWBDeQVsJT5+2s0EsUxeYvWG
        A8wgNqeAncT7/3vBLpIQaGSTWPesnRmiyEWi880JVghbWOLV8S3sELaMRGfHQSaIhmZGifYZ
        s9ghnB5Gia1zdrBBVFlLHD5+EaybWYBPYtK26cwg10kI8Ep0tAlBmB4Sh89AfTkR6OMHPewT
        GCUXMDKsYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECIy/0/+Of93BuO9P0iFGAQ5GJR7e
        H7q90UKsiWXFlbmHGCU4mJVEeBvdgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5+bTSooUE0hNL
        UrNTUwtSi2CyTBycUg2MLSd/7Wu4HdJTeeelTa7LdukzBS8clL5N1FQ7xd4RWFhs/ivPbiX7
        q4RgI9NldeIrRPyuFXtkbXv7UkVvqZPV671+G80vdJqE+Gf4fDksqBBgs69RP075SvUN7sRo
        5sDk9IfS9lHpK7Zr7VPy+dm98Hvw7knPVM8Xabz8LLMjSdp5x61nh/uUWIozEg21mIuKEwF9
        aJ3UuwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjluLIzCtJLcpLzFFi42I5/e/4NV1ur95og92LjS02zljPajH14RM2
        i29XOpgsLu+aw2Yx4/w+Jou1R+6yW0xedJDVgd1j56y77B6bVnWyedy5tofNo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDI+/BYtmCpa0TF7N1MD43HBLkZODgkBE4lXu54wdjFycQgJLGGU
        eHlvKzuE08QkMff4FEaQKjYBQ4mut11sILaIQK7E/mudTCBFzAKbGSX+7z4AVMTBISzgI/Hq
        iCNIDYuAqsSHTRC9vAK2Eh8/7WaC2CYvsXrDAWYQm1PATuL9/71gNUJANZfvrWKdwMizgJFh
        FaNIamlxbnpusaFecWJucWleul5yfu4mRmDobDv2c/MOxksbgw8xCnAwKvHwBhj0RguxJpYV
        V+YeYpTgYFYS4W10BwrxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5YkpqdmlqQWgST
        ZeLglGpgrDnNIKfJvmDPysez5pmkxHvfPranxfvO6tv33YszGtxMPx4q3j/56gunI0yuy/UT
        TAqW9b/KtPR8tHrFZcPgSM6VuXzx74pYJhrMkTGJquZebVobeviywaWkril7rjsUnYiq+n/p
        qF+M4GmZ5j8XXZL/pRfFK3EfuB/LurZV+quxsERYTf1HJZbijERDLeai4kQAFyinohkCAAA=
X-CMS-MailID: 20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a
References: <20180903144937.16507-1-m.szyprowski@samsung.com>
        <CGME20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator_pm_ops with regulator_suspend and regulator_resume functions are
assigned to every regulator device registered in the system, so there is no
need to iterate over all again in them. Replace class_for_each_device()
construction with direct operation on the rdev embedded in the given
regulator device. This saves a lots of useless operations in suspend and
resume paths.

Fixes: f7efad10b5c4: regulator: add PM suspend and resume hooks
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/core.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bb1324f93143..71ba040c7c5b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4455,19 +4455,6 @@ void regulator_unregister(struct regulator_dev *rdev)
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
 #ifdef CONFIG_SUSPEND
-static int _regulator_suspend(struct device *dev, void *data)
-{
-	struct regulator_dev *rdev = dev_to_rdev(dev);
-	suspend_state_t *state = data;
-	int ret;
-
-	regulator_lock(rdev);
-	ret = suspend_set_state(rdev, *state);
-	regulator_unlock(rdev);
-
-	return ret;
-}
-
 /**
  * regulator_suspend - prepare regulators for system wide suspend
  * @state: system suspend state
@@ -4476,20 +4463,25 @@ static int _regulator_suspend(struct device *dev, void *data)
  */
 static int regulator_suspend(struct device *dev)
 {
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	suspend_state_t state = pm_suspend_target_state;
+	int ret;
+
+	regulator_lock(rdev);
+	ret = suspend_set_state(rdev, state);
+	regulator_unlock(rdev);
 
-	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_suspend);
+	return ret;
 }
 
-static int _regulator_resume(struct device *dev, void *data)
+static int regulator_resume(struct device *dev)
 {
-	int ret = 0;
+	suspend_state_t state = pm_suspend_target_state;
 	struct regulator_dev *rdev = dev_to_rdev(dev);
-	suspend_state_t *state = data;
 	struct regulator_state *rstate;
+	int ret = 0;
 
-	rstate = regulator_get_suspend_state(rdev, *state);
+	rstate = regulator_get_suspend_state(rdev, state);
 	if (rstate == NULL)
 		return 0;
 
@@ -4504,15 +4496,6 @@ static int _regulator_resume(struct device *dev, void *data)
 
 	return ret;
 }
-
-static int regulator_resume(struct device *dev)
-{
-	suspend_state_t state = pm_suspend_target_state;
-
-	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_resume);
-}
-
 #else /* !CONFIG_SUSPEND */
 
 #define regulator_suspend	NULL
-- 
2.17.1

