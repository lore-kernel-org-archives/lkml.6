Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26B0213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcPmX8US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26B0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbeK3Bgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbeK3Bgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FA2213A2;
        Thu, 29 Nov 2018 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501871;
        bh=O0/difCFKisKCyBXuM8xEWeDBDj6VqhKRfyHHkaYUuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcPmX8USSi6NNS9215gn7UcMiK2AM0tB44NFw58YIKzbTyfMabkaT6X8uACr7oPYJ
         ++xU0lGtg8zURKmb6vtxVizMY4dNiWXqG9fKuTqftZtDzYOPHHoKJIghCMhHrn8ucV
         Iyj9IruXo3VP0OAYS6AQSTY0O3YCfGUv1UfFg+oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/110] rtc: cmos: Do not export alarm rtc_ops when we do not support alarms
Date:   Thu, 29 Nov 2018 15:12:46 +0100
Message-Id: <20181129135924.281270217@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



