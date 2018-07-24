Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C100F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C100F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeGXKmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:42:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41737 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeGXKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:42:15 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lo2Ke-1gEka42Ecy-00g2wo; Tue, 24 Jul 2018 11:36:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jacob Chen <jacob-chen@iotwrt.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: cros-ec-cec: fix dependency on MFD_CROS_EC
Date:   Tue, 24 Jul 2018 11:35:59 +0200
Message-Id: <20180724093624.1670671-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:5wE6/zZnGM93XxbcP+X04QrxoC1REJYXYxT9bTmgAtrnRoEBST1
 jMpJEOMNdtXBz17gEDYlz3zUD/PiVzroamn51UHR3I7Q1r8z1WQUL0J4s/8nN6k6BDt4DhP
 RomabAJK4fWrW+mbQVT5eM8W0WRaddjUWe+Tl8S6QdYJjYzEAB1REDLLBc2rLWUB8sCKcNC
 cALz2KuQvinQWN285T+Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6d5EYb9kV+c=:C0IWJjJ4cRkUkMDCuomgIP
 QslonKouI5Ecghwhjv/XEBdu859Y5Z3wPNOJ58cGBPJL80JvIUt7+MK7NjF9X+VFbVbj8jFxC
 9W0d0cS+/sOEKAEfDK+d210VRmPP4VIoJlqYCvHLrvn/IGRr6ELt3gkZt2JBsjc/3LeD3TWdQ
 X920tKpBwhkswSnOteV6PWx0srRf1PxeyujcqVTkdW0coImtd2qf/faE0dI8XWJJBJTxcA5ak
 utHYmw3nRDg7vlDTmCmaTcraveHtKLNe7Z0THtQ0ZwUolty8GGfEdCQivxw4dwNQlRd0c4fB4
 XuUD/IlGQ08tkGt0rzIN27eFglsZ38IhaLD7QtH+1+T98UA8HIp13910ziVxtOgWa/1CRJjjx
 I0Gvf5o06sQj2w+guXxxtKEUIKqAEeXzAA/Em6Cae3bhAeBIVpcGtvECn7O65VOgurUqMDkCD
 HMq15vI+oCs/VV2XtVh8tVmBltg+3l1a1+ra1GCua5QGmOR//4eoJ6RWRU6L/10UAftTErPin
 Dnf4w73IMql9rQW3gQlb+zXu4R5mWvWapJD1WFRf4O6EXtdnyeleRjw7I3T+u/GRjfvQ0KYpN
 ceF4mcrnEqTKEysV32BLwopcN5o+fTGBSv43i9J1flX9xRPuSzisGuMQ+6heXNcdXxIUXEH3p
 ep3/2hBT5Y5zLCzxQiKCXJiwzaNuhVsXoQiwekCAyltQg/P2mZK3VstgZI1SXJnymVnE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the MFD driver, we run into a link error:

drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_transmit':
cros-ec-cec.c:(.text+0x474): undefined reference to `cros_ec_cmd_xfer_status'
drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_set_log_addr':
cros-ec-cec.c:(.text+0x60b): undefined reference to `cros_ec_cmd_xfer_status'
drivers/media/platform/cros-ec-cec/cros-ec-cec.o: In function `cros_ec_cec_adap_enable':
cros-ec-cec.c:(.text+0x77d): undefined reference to `cros_ec_cmd_xfer_status'

As we can compile-test all the dependency, the extra '| COMPILE_TEST' is
not needed to get the build coverage, and we can simply turn MFD_CROS_EC
into a hard dependency to make it build in all configurations.

Fixes: cd70de2d356e ("media: platform: Add ChromeOS EC CEC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 92b182da8e4d..018fcbed82e4 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -535,7 +535,7 @@ if CEC_PLATFORM_DRIVERS
 
 config VIDEO_CROS_EC_CEC
 	tristate "ChromeOS EC CEC driver"
-	depends on MFD_CROS_EC || COMPILE_TEST
+	depends on MFD_CROS_EC
 	select CEC_CORE
 	select CEC_NOTIFIER
 	---help---
-- 
2.18.0

