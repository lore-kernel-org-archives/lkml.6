Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA101C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B66C247DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B66C247DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeGCXrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:47:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46300 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753606AbeGCXrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id l123-v6so1722752pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CcDxclZT+Ks3JwcbvTbM/8mgbIqbve7zsaiHY28IDao=;
        b=ayeH1Xoz7Njs74fIObz7MurB5VZpuq4yUF0RToRRKoTv+YZF/pVosffE5kmu5JCcRQ
         /j5ziJLI6l2vgGqcNBvFrZYs2c7jM3kHmAGZxLZcE0ME0ap7AflF38Wm7tzFo+KvAXGt
         54u0KAe2mZBtE66n2+InAD4t7EZ8HDPCmAsYoZiYClUs+e7Wje6r6b2EIhOV/85F3Hss
         gksE8T1Mv7jnyItuLT6pLEOrOyZqDr/qgehqswlP6b2IlB1xaMm572NiSOGGj+pG8fY3
         6zgS1VtgdGG/KwH4TQox8fwPSsvM3cF92p3WkNOzqL9jcaNPDJSB6sqNG2xajol7udxc
         29oQ==
X-Gm-Message-State: APt69E2YP+bIpSsLeTeh62B4NZmoWoOj0KidVQzkgUVziVpZo7r4P4CJ
        DNc16RFs3syd1vnEVI+uCnC5dA==
X-Google-Smtp-Source: AAOMgpcT10Qo0MXuuXV+BvGygiXv/gRYKzeUivrm1HR+UMXYXlCUhd+l0lsgnejZzjFYUZYjB8CsHw==
X-Received: by 2002:a62:f50b:: with SMTP id n11-v6mr21637936pfh.120.1530661652966;
        Tue, 03 Jul 2018 16:47:32 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:32 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Date:   Tue,  3 Jul 2018 16:47:00 -0700
Message-Id: <20180703234705.227473-8-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting the device class allows other parts of the kernel to enumerate
the devfreq devices and receive notification when a devfreq device is
added or removed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v5:
- none

Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- patch added to series
---
 drivers/devfreq/devfreq.c | 3 ++-
 include/linux/devfreq.h   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4cbaa7ad1972..38b90b64fc6e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -31,7 +31,8 @@
 #define MAX(a,b)	((a > b) ? a : b)
 #define MIN(a,b)	((a < b) ? a : b)
 
-static struct class *devfreq_class;
+struct class *devfreq_class;
+EXPORT_SYMBOL_GPL(devfreq_class);
 
 /*
  * devfreq core provides delayed work based load monitoring helper
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index c4f84a769cb5..964e064a951f 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -206,6 +206,8 @@ struct devfreq_freqs {
 };
 
 #if defined(CONFIG_PM_DEVFREQ)
+extern struct class *devfreq_class;
+
 extern struct devfreq *devfreq_add_device(struct device *dev,
 				  struct devfreq_dev_profile *profile,
 				  const char *governor_name,
-- 
2.18.0.203.gfac676dfb9-goog

