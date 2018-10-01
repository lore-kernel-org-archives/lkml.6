Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B5F208E7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B5F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeJAUC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:02:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:30490 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729286AbeJAUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:02:27 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w91DOCIN031562;
        Mon, 1 Oct 2018 15:24:12 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6bevp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 15:24:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4C3231;
        Mon,  1 Oct 2018 13:24:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7237465E;
        Mon,  1 Oct 2018 13:24:10 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Oct 2018 15:24:10
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <gottfried.haider@gmail.com>
CC:     <stefan.wahren@i2se.com>, <hsweeten@visionengravers.com>,
        <loic.pallardy@st.com>, <broonie@kernel.org>,
        <fabrice.gasnier@st.com>, <gohai@sukzessiv.net>,
        <michal.vokac@ysoft.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
Date:   Mon, 1 Oct 2018 15:23:55 +0200
Message-ID: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
- it's not possible to export more than one PWM channel
- ABI has changed, as a side effect. It may cause bad behavior as pwmchip
  attributes are wrongly added to pwm channels and report wrong values.
See [1] and [2].

One purpose of the original patch is to send uevents to udev, when exporting a
PWM channel through the sysfs. This series:
- Reverts the original patch.
- Proposes a new way to send notifications to be used by udev rules.

- With this series:
$ echo 0 > /sys/class/pwm/pwmchip0/export
$ ls /sys/class/pwm
pwmchip0 pwmchip4

$ ls /sys/class/pwm/pwmchip0/pwm0/
capture     enable      polarity    uevent
duty_cycle  period      power

- Without this series:
$ echo 0 > /sys/class/pwm/pwmchip0/export
$ ls /sys/class/pwm
pwm0 pwmchip0 pwmchip4

$ ls /sys/class/pwm/pwmchip0/pwm0/
capture     duty_cycle  export      period      power       uevent
device      enable      npwm        polarity    subsystem   unexport

- Backtrace when exporting a 2nd channel (0) on a separate pwmchip device:
$ echo 0 > /sys/class/pwm/pwmchip4/export
[   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
[   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g00b49b0 #151
[   95.301344] Hardware name: STM32 (Device Tree Support)
[   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show_stack+0xb/0xc)
[   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn_dup+0x31/0x48)
[   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_do_create_link_sd+0x75/0x88)
[   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>] (device_add+0x133/0x3b0)
[   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_store+0xb5/0x12c)
[   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_fop_write+0x87/0xda)
[   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vfs_write+0x1d/0xe0)
[   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write+0x4f/0x7c)
[   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+0x33/0x70)
[   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_syscall+0x1/0x58)
[   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
[   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4e590 00000002 00000004
[   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 00000020 00000000 00c4d008
[   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
-sh: write error: File exists

[1] https://lkml.org/lkml/2018/9/25/713
[2] https://lkml.org/lkml/2018/9/25/447

---
Changes in v2:
- update revert commit message
- new patch 2/2 to propose uevent notification (change) on pwmchip

Fabrice Gasnier (2):
  Revert "pwm: Set class for exported channels in sysfs"
  pwm: send a uevent on the pwmchip device upon channel sysfs (un)export

 drivers/pwm/sysfs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
1.9.1

