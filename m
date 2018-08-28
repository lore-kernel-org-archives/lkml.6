Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D443C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFDF208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFDF208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeH1FoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34428 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH1FoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:08 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so46159ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xqp+qIL0DVWoiHlShF0GYKNsAVZb6YYMRMH+l1IlfPU=;
        b=dNh0a/eVDketWsqQuY4SAQE3JgJVaTOHpkJqqbPefJ6VJbi58yspFe5r0MOd9GxWUw
         wbqlS3KBF+Dpsj24he0vwEflQHNZz/BV2Sv324Z5TGGTJbc/KbCJNnZ8nYRBJnuvLt7Q
         1IgaVgTpBiOiU4Dt8PkR43egrYrlJTQ5zItK3v++SNC/gBfRCDC67FiqcrAn6WOhFmBz
         8IHhsEXo9luIyU/rI+UDOMDNK1p2T3NFUXOn/k7U7FZ8z1cO71ydb0mcDNMwJeKbTrtg
         Brkd24YRWpTsjMIqyPNNC5R2PgWb5lLwbgxX7biTrenlcYNQluzJOnYqffzdApEOWJoG
         f12Q==
X-Gm-Message-State: APzg51BNJF0538thpo4kuyrigX3hm4iduTmEn4wD3UzlKET71KppYHrh
        k9RCqxItiGR08YUhpBuOoK6N0rE=
X-Google-Smtp-Source: ANB0VdZUvgNn9NzGVlHJMZip1xwAH9wJMnpnC2KHqSmiWfHxk3aeya3qYhhWNCgG57vV+jYsU8paIA==
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr1127312oif.180.1535421292576;
        Mon, 27 Aug 2018 18:54:52 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:27 -0500
Message-Id: <20180828015252.28511-26-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/macio_sysfs.c           | 8 +++++++-
 drivers/macintosh/windfarm_smu_controls.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index ca4fcffe454b..d2451e58acb9 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -58,7 +58,13 @@ static ssize_t devspec_show(struct device *dev,
 static DEVICE_ATTR_RO(modalias);
 static DEVICE_ATTR_RO(devspec);
 
-macio_config_of_attr (name, "%s\n");
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%pOFn\n", dev->of_node);
+}
+static DEVICE_ATTR_RO(name);
+
 macio_config_of_attr (type, "%s\n");
 
 static struct attribute *macio_dev_attrs[] = {
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index d174c7437337..86d65462a61c 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -277,7 +277,7 @@ static int __init smu_controls_init(void)
 		fct = smu_fan_create(fan, 0);
 		if (fct == NULL) {
 			printk(KERN_WARNING "windfarm: Failed to create SMU "
-			       "RPM fan %s\n", fan->name);
+			       "RPM fan %pOFn\n", fan);
 			continue;
 		}
 		list_add(&fct->link, &smu_fans);
@@ -296,7 +296,7 @@ static int __init smu_controls_init(void)
 		fct = smu_fan_create(fan, 1);
 		if (fct == NULL) {
 			printk(KERN_WARNING "windfarm: Failed to create SMU "
-			       "PWM fan %s\n", fan->name);
+			       "PWM fan %pOFn\n", fan);
 			continue;
 		}
 		list_add(&fct->link, &smu_fans);
-- 
2.17.1

