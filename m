Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A8EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEBA21920
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbfBMKux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:50:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47897 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731311AbfBMKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:50:51 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DAkvCW020740;
        Wed, 13 Feb 2019 11:50:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qjfy6akcc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Feb 2019 11:50:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D40831;
        Wed, 13 Feb 2019 10:50:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E95094EDC;
        Wed, 13 Feb 2019 10:50:35 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb 2019 11:50:35
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>, <tduszyns@gmail.com>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 0/3] Add PM support to STM32 LP Timer drivers
Date:   Wed, 13 Feb 2019 11:50:09 +0100
Message-ID: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds power management support for STM32 LP Timer:
- PWM driver
- Document the pinctrl states for sleep mode

It also adds device link between the PWM consumer and the PWM provider.
This allows proper sequencing for suspend/resume (e.g. user will likely
do a pwm_disable() before the PWM provider suspend executes), see [1].

[1] https://lkml.org/lkml/2019/2/5/770

---
Changes in v3:
- Move the device_link_add() call to of_pwm_get() as discussed with Uwe.

Changes in v2:
- Don't disable PWM channel in PWM provider: rather refuse to suspend
  and report an error as suggested by Uwe and Thierry.
- Add patch 3/3 to propose device link addition.
- No updates for STM32 LP Timer IIO driver. Patches can be send separately.

Fabrice Gasnier (3):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  pwm: core: add consumer device link

 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 +++++---
 drivers/pwm/core.c                                 | 14 +++++++++---
 drivers/pwm/pwm-stm32-lp.c                         | 25 ++++++++++++++++++++++
 include/linux/pwm.h                                |  6 ++++--
 4 files changed, 46 insertions(+), 8 deletions(-)

-- 
1.9.1

