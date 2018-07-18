Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E332ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12A22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12A22075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeGRLzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:55:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGRLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:55:01 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mex5B-1fQAS51xYv-00OV3T; Wed, 18 Jul 2018 13:17:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sricharan R <sricharan@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Sarangdhar Joshi <spjoshi@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: fix Q6V5_WCSS dependencies
Date:   Wed, 18 Jul 2018 13:16:26 +0200
Message-Id: <20180718111730.3531477-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:dH4wWVg4U32JbnHCUrNEmZtqf3Dz7FZWxZYpyX0D+GPCJkHlyWk
 YJ8ILklc0tFKj3i418Nq5aargK9C2AIR0ab0PKXjrj8mWmMpysYAbdaFLcmpynDc25GMBOi
 9Yyll5mbTutod468WEyDAD3iWdZzWYRHZJWjNJGy5qrPjN6emuVoGnPinJzCJZ7vHp1drrz
 TYNDthrCTBNoh+xhKVdgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kIGds2URqI8=:huIKhHXue+P9CsL53rRe2U
 O/WdFWP/G9gHMxt35fMZYN/VO/xWu7Ke7KwZGn7H3F5K/hvajc7rntMaMLJ47l2hCesvdkgW5
 WtljVTahQB2MgPzGh+KT0k3guxLIQGYzh1OhJ0zVa2QGJyHkWhOz1LPKpBJqUwiBz534UDqQ2
 ssQwHYsupI1K2vmoNMK0lGABQoLIj6Z9wzIh49UufUvcyAABrgzXmhVyVKjhk3lFfU77p/jlg
 jkeH4ZRN02clTplXzkOdz2SGqiLLAPI5YeawLfKR/SMlH5XEm1ufKJcM/d7wAfapNNbwr3klJ
 YK5gsk1jULVYRaFisa2OR6wYf9W+M/xQR7svM2/aCFeFmSDD3ZYBgHeXVxKF5kZLjswINS+xJ
 BwYxF3hwFbILy+fEQSn9rfN62yZAaQJH0Vz2ExontUxQlxtfBG3opbpwxF7wUYWsCCf1+Pucu
 QhgqvFvd9ymghlHxmJgaDf/3Nj6DF/VvgkFx1RVUvTK0hSjDN1pHvOEQt+It/DB+HLYhzw2VA
 B4p4+Ih6O5jwMahG24aiVHKY4bLJT0ubiu9F7MAVwQiPLa0LWMETUTSgayrSvQuxEzlmBXzLV
 XSovxuclkMdraqYIN/9CKMXJ0za5JkGNQE5sLheBn/S3ptO9r6kvmw81Aj5tuq37wbsHPedem
 /slCtcs/66adDZBdyX1UFQrUJ76mEtzF6Tt79s28AXArwxWQZ8D4jiO5IDwE1iWtaooE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new driver got added that depends on QCOM_SMD and fails to link
as built-in with CONFIG_QCOM_SMD=m:

drivers/remoteproc/qcom_common.o: In function `smd_subdev_stop':
qcom_common.c:(.text+0x674): undefined reference to `qcom_smd_unregister_edge'
drivers/remoteproc/qcom_common.o: In function `smd_subdev_start':
qcom_common.c:(.text+0x700): undefined reference to `qcom_smd_register_edge'

We've fixed the same thing several times before, so use the same
dependency here.

Fixes: 3a3d4163e0bf ("remoteproc: qcom: Introduce Hexagon V5 based WCSS driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 0dde3753c3a5..052d4dd347f9 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -127,6 +127,7 @@ config QCOM_Q6V5_WCSS
 	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
+	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
-- 
2.9.0

