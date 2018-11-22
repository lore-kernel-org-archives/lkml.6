Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CB6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1694C20645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlmKs7uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1694C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438423AbeKWGeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438400AbeKWGeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:34:09 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA34920864;
        Thu, 22 Nov 2018 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916396;
        bh=h+YMZ8SR7cQZc7QObpkr1rGuCHM8NSrC4r+nLMF4bZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlmKs7uOgq9Ch/dtST/LvuCo1MUy+56YVieJ5cyfpAS52JSBKrBfRIxGI8aKZZAjK
         b6aodytQOS0bOapAOlGYSwTSac+qUeFeVpY/DXa8oqrVL5CdGSas5ILtbrHkrcjKkk
         NzHnBfrE3EqKSmHwKoyTSbTlEgF15E4IBYGpEc8s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/36] rtc: cmos: Do not export alarm rtc_ops when we do not support alarms
Date:   Thu, 22 Nov 2018 14:52:16 -0500
Message-Id: <20181122195240.13123-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit fbb974ba693bbfb4e24a62181ef16d4e45febc37 ]

When there is no IRQ configured for the RTC, the rtc-cmos code does not
support alarms, all alarm rtc_ops fail with -EIO / -EINVAL.

The rtc-core expects a rtc driver which does not support rtc alarms to
not have alarm ops at all. Otherwise the wakealarm sysfs attr will read
as empty rather then returning an error, making it impossible for
userspace to find out beforehand if alarms are supported.

A system without an IRQ for the RTC before this patch:
[root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
[root@localhost ~]#

After this patch:
[root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
cat: /sys/class/rtc/rtc0/wakealarm: No such file or directory
[root@localhost ~]#

This fixes gnome-session + systemd trying to use suspend-then-hibernate,
which causes systemd to abort the suspend when writing the RTC alarm fails.

BugLink: https://github.com/systemd/systemd/issues/9988
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-cmos.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index df0c5776d49b..a5a19ff10535 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -257,6 +257,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned char	rtc_control;
 
+	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
@@ -452,6 +453,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	unsigned char mon, mday, hrs, min, sec, rtc_control;
 	int ret;
 
+	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
@@ -516,9 +518,6 @@ static int cmos_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned long	flags;
 
-	if (!is_valid_irq(cmos->irq))
-		return -EINVAL;
-
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	if (enabled)
@@ -579,6 +578,12 @@ static const struct rtc_class_ops cmos_rtc_ops = {
 	.alarm_irq_enable	= cmos_alarm_irq_enable,
 };
 
+static const struct rtc_class_ops cmos_rtc_ops_no_alarm = {
+	.read_time		= cmos_read_time,
+	.set_time		= cmos_set_time,
+	.proc			= cmos_procfs,
+};
+
 /*----------------------------------------------------------------*/
 
 /*
@@ -855,9 +860,12 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 			dev_dbg(dev, "IRQ %d is already in use\n", rtc_irq);
 			goto cleanup1;
 		}
+
+		cmos_rtc.rtc->ops = &cmos_rtc_ops;
+	} else {
+		cmos_rtc.rtc->ops = &cmos_rtc_ops_no_alarm;
 	}
 
-	cmos_rtc.rtc->ops = &cmos_rtc_ops;
 	cmos_rtc.rtc->nvram_old_abi = true;
 	retval = rtc_register_device(cmos_rtc.rtc);
 	if (retval)
-- 
2.17.1

