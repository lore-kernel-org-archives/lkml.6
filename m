Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF62ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936512064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwXlbdRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936512064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJYEDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:03:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeJYEDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:03:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so2930097pfi.4;
        Wed, 24 Oct 2018 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jxA/4tYnI4eV6Lr2ToAINbnH9pilQBxyPt4EVIDdWSE=;
        b=VwXlbdRPfMzgpyZ0bBYA5d+ng6Z/TziXIfrohQN91Xbp2Yq9bej3HRV0MV+66kNdcN
         0I6oeU3+WlL0K6e+mJDlKNbzvROIQEASsJ9KfweBPADd8FkId3U5BdJOeSSwukSou0LL
         P8v42TU70rCxkARmvW0ZmUJr3DFkHdfJJJvUeGDfGnc92h+HPpGhRUkv+6U1ejuZjnPo
         GEUMGdiQe1UZBpOIoQfd9moDF1bqENy69KK1q9A36YQZ+ButQtXHnsWXaS7opkuPsZy0
         hQVwkKqnvpemQTyOeAXxPV9LqoWnjkdowSnLK1wl98boYAXNCwCPyAZEbDKD2wgr6irO
         lRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jxA/4tYnI4eV6Lr2ToAINbnH9pilQBxyPt4EVIDdWSE=;
        b=cewdvoLfs2p4c3Ob8g87zBFOWobKGg7xG7WAnHaS84sdsdJzhs4+h1oZm3gE0VH44O
         vm5mD57MQCdAG55arPRJs3tZYkTlAkdVKOKPnhpYontnk5ERxurqSh3Tz5zNhkhmwv0z
         yOfPL6hT6hIMqB07tvf3AWHyWpB1hNMocE+qox1ioGbOXPJ/POVkrLV/UyzRrRHm/CTj
         sLAFZJuDwZKd3RcVMMQT1zB7XAlhB1YPltjby/IpGC6ojy0XD54h6M79qw7a1NGnsZcR
         6n3vAo76mvAKJxcMDWKMRnvMQAZDSdabwnHyGuUTf6yNpK6FPZ+QRt8TSG35vlNixto0
         Rf0A==
X-Gm-Message-State: AGRZ1gKCWSZXSMdDj5gc9fJy1bhEK+pOdFl77gOXWtefrdMmeqru+5sK
        n3ltOL9YACOox1hrWPrTBDc=
X-Google-Smtp-Source: AJdET5ep81f6KzDr0rQB+6Kit4o4gtnOF0rGLh+jKXFN3vFv6QnCcSF7fCIby/TMl7ijK8wpouOh6A==
X-Received: by 2002:aa7:84cc:: with SMTP id x12-v6mr3893607pfn.220.1540409656411;
        Wed, 24 Oct 2018 12:34:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r81-v6sm19921633pfa.110.2018.10.24.12.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:34:15 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] hwmon: (core) Inherit power properties to hdev
Date:   Wed, 24 Oct 2018 12:33:58 -0700
Message-Id: <20181024193402.16698-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024193402.16698-1-nicoleotsuka@gmail.com>
References: <20181024193402.16698-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hdev is a child device related to the original parent
hwmon driver and its device. However, it doesn't support the
power features, typically being defined in the parent driver.

So this patch inherits three necessary power properties from
the parent dev to hdev: power, pm_domain and driver pointers.

Note that the dev->driver pointer is the place that contains
a dev_pm_ops pointer defined in the parent device driver and
the pm runtime core also checks this pointer:
       if (!cb && dev->driver && dev->driver->pm)

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v2->v3:
 * N/A
v1->v2:
 * Added device pointers

 drivers/hwmon/hwmon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 975c95169884..14cfab64649f 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -625,7 +625,12 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	hwdev->name = name;
 	hdev->class = &hwmon_class;
 	hdev->parent = dev;
-	hdev->of_node = dev ? dev->of_node : NULL;
+	if (dev) {
+		hdev->driver = dev->driver;
+		hdev->power = dev->power;
+		hdev->pm_domain = dev->pm_domain;
+		hdev->of_node = dev->of_node;
+	}
 	hwdev->chip = chip;
 	dev_set_drvdata(hdev, drvdata);
 	dev_set_name(hdev, HWMON_ID_FORMAT, id);
-- 
2.17.1

