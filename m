Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE04C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47711224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTxbuD9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47711224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeKMOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:19:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43841 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:19:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id g7-v6so5365903pfo.10;
        Mon, 12 Nov 2018 20:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IGUuvH7kl0MMHina3+WTjgvkcoYaTrvBslKHRxGvyto=;
        b=jTxbuD9cPIAhgQ8Y/7d2Fnh55Ue1Az04HhP+X2AE6i7aM/dPfnG1NDpwSs4KztIXUs
         fGo0OyOu/H3zPeQ3lg03rR2XH/ul7e3gASbBWiajFWdc1sGmAOE4+rAPjbmO9Aqz0RQi
         dSCw7RJizhMEPSkxYmTny+bjNxu5ZdJ5UL+nlveRn5ySN5jrqsLwzK1+AnusfpbusUJ9
         EQam+BEL6Lo2Va+QGAz3bRhNsyxT/IkKT/k8KYAbyUAT8s0DSbRCpgxJ3hb2JaxLG03B
         Lp8F2oPg7S/HnuR1JAScYe2Z3nIxjyCVU7KEre786DZzd6/xZxsQ1suOiqRhsb4IGdp9
         fgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IGUuvH7kl0MMHina3+WTjgvkcoYaTrvBslKHRxGvyto=;
        b=NU0hhNk5k/hZiPOyGFHAA6WjQdRuKERbZ/fpcVddh7BSWP8A/07ACpWgtXxd4yQCeY
         XS3BE5jhLaXotwzHbxiAvDpr6oZQZS6gJy66/5XP3EkVgpyYMMhXwif0BLRA4AwvUV6W
         3K3LsJqq7QJqnTGUYMRolgOKZKk7VSZSpRr7EiI/tIVs+GPn+saKUgQ2oGw5X43sdtj/
         PMy7KgcFI33R+cAM9uT+Lk5WtnmegtuszNu+py5XhKjqXKf1/ELFFlz2cOKs63t5e+8F
         CQYlYK8jv3EuVRznbduDxFLllR7f7fdZ/w67RjN9MewInPrf89FxR0SpHWDCKPmCWcBU
         mDSQ==
X-Gm-Message-State: AGRZ1gIwtpfCWWRhNHvr6hvfIGRu7+ayqjR+2Y/rPpd5wXKwwvq3D+8U
        OviMbM35C8fuhWlbF3H2+nA=
X-Google-Smtp-Source: AJdET5dN/RCATRULOvD7a5s4+p86k06Gr+p1sILiIwIzH5Sso8ItX429xJbgIRsybTdhB3OlLD/lgw==
X-Received: by 2002:a62:d405:: with SMTP id a5mr621108pfh.116.1542083015074;
        Mon, 12 Nov 2018 20:23:35 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 79sm17851088pge.66.2018.11.12.20.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:23:34 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon (ina3221) Add mutex lock to shunt nodes
Date:   Mon, 12 Nov 2018 20:23:24 -0800
Message-Id: <20181113042324.852-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shunt resistor values are used to calculate shunt voltages
and currents. As a part of sysfs nodes, it would be better to
get protected with the same mutex too as other sysfs ABI nodes,
although this is not very critical because the mutex was added
to mainly protect register access.

So this patch adds the mutex lock to protect the shunt node.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 86281afd2619..f7a09ab6c440 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -532,8 +532,15 @@ static ssize_t ina3221_show_shunt(struct device *dev,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int channel = sd_attr->index;
 	struct ina3221_input *input = &ina->inputs[channel];
+	ssize_t ret;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", input->shunt_resistor);
+	mutex_lock(&ina->lock);
+
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", input->shunt_resistor);
+
+	mutex_unlock(&ina->lock);
+
+	return ret;
 }
 
 static ssize_t ina3221_set_shunt(struct device *dev,
@@ -547,14 +554,20 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 	int val;
 	int ret;
 
+	mutex_lock(&ina->lock);
+
 	ret = kstrtoint(buf, 0, &val);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&ina->lock);
 		return ret;
+	}
 
 	val = clamp_val(val, 1, INT_MAX);
 
 	input->shunt_resistor = val;
 
+	mutex_unlock(&ina->lock);
+
 	return count;
 }
 
-- 
2.17.1

