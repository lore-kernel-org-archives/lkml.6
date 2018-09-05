Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7893C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5AD20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k7izhiRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5AD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIEQYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:24:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38659 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeIEQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:24:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180905115423euoutp0254036e0e2b2e06dcdc8272b4e05291de~RfuOPtteC1862518625euoutp02X;
        Wed,  5 Sep 2018 11:54:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180905115423euoutp0254036e0e2b2e06dcdc8272b4e05291de~RfuOPtteC1862518625euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536148463;
        bh=VGW+6ZtUdfeAzYdRzkxW1/tRrq/iy+dSwSDyNUO/RP0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=k7izhiRaD7lrtA3ssnk5QausR0g1e29d/nPxEv3Wqfw1FuJr29929Ca1Q/rILQpRm
         n9V9Ic1MLbB8LBAuZJzcMigttolzCP03oCE3JC4BKewZkU6WnEyf5Xmpa4CQJETSMo
         bShVAoA4wIHrrUVzaAETIfpJ1/rhCboaOJ9LfnHk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180905115422eucas1p2c311ecd762007e9b6c5b294c934e76ac~RfuNiL0II0878308783eucas1p2y;
        Wed,  5 Sep 2018 11:54:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.4B.04806.EE3CF8B5; Wed,  5
        Sep 2018 12:54:22 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180905115422eucas1p2150fd04724ec667bd8798023a73f1127~RfuMxvCjQ0330503305eucas1p2-;
        Wed,  5 Sep 2018 11:54:22 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-f7-5b8fc3ee6320
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B5.CB.04128.DE3CF8B5; Wed,  5
        Sep 2018 12:54:21 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PEK00C3NZQIOQ00@eusync4.samsung.com>;
        Wed, 05 Sep 2018 12:54:21 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] mfd: max8997: Enale irq-wakeup unconditionally
Date:   Wed, 05 Sep 2018 13:54:07 +0200
Message-id: <20180905115407.10595-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7djP87rvDvdHG/zbpWWxccZ6Vov7X48y
        WlzeNYfNYsb5fUwWa4/cZbe43biCzYHN4861PWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fA
        lfF74Wm2ggV8Fbc3PWZpYLzM3cXIySEhYCJxreE8YxcjF4eQwApGiaUNT5ggnM+MEp9XvGKB
        qfp+ZTcLRGIZo0Tj41nMEE4Dk8S5Kd1sIFVsAoYSXW+7wGwRAWeJ2x++gXUwC2xhlJh+9RHY
        KGEBJ4nrHdMZQWwWAVWJJZ83s4PYvAK2EjdeNTJCrJOXWL3hANgGCYGrrBI7bq5ng0i4SOz/
        18UOYQtLvDq+BcqWkbg8uZsFoqGZUaJ9xix2CKeHUWLrnB1Q3dYSh49fZAWxmQX4JCZtmw60
        ggMozivR0SYEUeIhsWnlJGYQW0ggVuLQ/QbGCYwSCxgZVjGKp5YW56anFhvnpZbrFSfmFpfm
        pesl5+duYgTG0+l/x7/uYNz3J+kQowAHoxIPr0ZLX7QQa2JZcWXuIUYJDmYlEV4Vrv5oId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rx8WmnRQgLpiSWp2ampBalFMFkmDk6pBsZ9jh4yMpEXD38p
        bd8i2n/3urHTDKePJg4rwi5WfmsRDCp/bKk15+hEi1RxTtmJXr4zp1U793Oddw2b07Xl1OkJ
        O141ntqZ7dt34VH+IRWzHQ3rn5Zvmrij5Mrnhbv7vmdP63H1fMnrnO/y0sSEfW/84vt2E1+p
        p2ZV+YRq/Z60SKxK+9EbHgElluKMREMt5qLiRAAyppmmowIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJMWRmVeSWpSXmKPExsVy+t/xa7pvD/dHGzxpNrXYOGM9q8X9r0cZ
        LS7vmsNmMeP8PiaLtUfuslvcblzB5sDmcefaHjaPvi2rGD0+b5ILYI7isklJzcksSy3St0vg
        yvi98DRbwQK+itubHrM0MF7m7mLk5JAQMJH4fmU3SxcjF4eQwBJGieYVb5ghnCYmifP3lrKD
        VLEJGEp0ve1iA7FFBJwlbn/4BtbBLLCFUeLljv0sIAlhASeJ6x3TGUFsFgFViSWfN4M18wrY
        Stx41cgIsU5eYvWGA8wTGLkWMDKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECPT4tmM/t+xg
        7HoXfIhRgINRiYe3oa0vWog1say4MvcQowQHs5IIrwpXf7QQb0piZVVqUX58UWlOavEhRmkO
        FiVx3vMGlVFCAumJJanZqakFqUUwWSYOTqkGRluRK+82LFByr794YZan390zGoLqu9n2nT12
        hMWia9Mr7+pkhqQzk8pZ5+6St69deuWR2cbbjBwKkTv///zQWp9e/at/9r89nJYVD+VFSr/w
        LvWZxPzxd3rTv14VT91Au++/lt05+fy5X4Re/kzeidONV7roiPws0zia0XvjXaHwzZSPAhlT
        g5RYijMSDbWYi4oTAQAWlM70AQAA
X-CMS-MailID: 20180905115422eucas1p2150fd04724ec667bd8798023a73f1127
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180905115422eucas1p2150fd04724ec667bd8798023a73f1127
References: <CGME20180905115422eucas1p2150fd04724ec667bd8798023a73f1127@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ wake up support for MAX8997 driver was initially configured by
respective property in pdata. However, after the driver conversion to
device-tree, setting it was left as 'todo'. Nowadays most of other PMIC MFD
drivers initialized from device-tree assume that they can be an irq wakeup
source, so enable it also for MAX8997. This fixes support for wakeup from
MAX8997 RTC alarm.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
changelog:
v2:
- removed pdata->wakeup entry as suggested by Krzysztof Kozlowski
---
 drivers/mfd/max8997.c       | 8 +-------
 include/linux/mfd/max8997.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 3f554c447521..d1495d76bf2c 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -153,12 +153,6 @@ static struct max8997_platform_data *max8997_i2c_parse_dt_pdata(
 
 	pd->ono = irq_of_parse_and_map(dev->of_node, 1);
 
-	/*
-	 * ToDo: the 'wakeup' member in the platform data is more of a linux
-	 * specfic information. Hence, there is no binding for that yet and
-	 * not parsed here.
-	 */
-
 	return pd;
 }
 
@@ -246,7 +240,7 @@ static int max8997_i2c_probe(struct i2c_client *i2c,
 	 */
 
 	/* MAX8997 has a power button input. */
-	device_init_wakeup(max8997->dev, pdata->wakeup);
+	device_init_wakeup(max8997->dev, true);
 
 	return ret;
 
diff --git a/include/linux/mfd/max8997.h b/include/linux/mfd/max8997.h
index cf815577bd68..3ae1fe743bc3 100644
--- a/include/linux/mfd/max8997.h
+++ b/include/linux/mfd/max8997.h
@@ -178,7 +178,6 @@ struct max8997_led_platform_data {
 struct max8997_platform_data {
 	/* IRQ */
 	int ono;
-	int wakeup;
 
 	/* ---- PMIC ---- */
 	struct max8997_regulator_data *regulators;
-- 
2.17.1

