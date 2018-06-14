Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E15F3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F973208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F973208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936135AbeFNTrh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:47:37 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44915 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936115AbeFNTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id p21-v6so3370982pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=93LuuHsiXv3xJdqc6HhDcgdFIGGpIx8xIdJfw9X8aOQ=;
        b=SyUfH0gBy4z5aV6kLrATYVHlrPTr16xAbVwD4DcF/TtRNprXHrHWtdntbjjr+JuRGp
         ztFZ82Qcddwlv5+kDUZmVvx2PIIaqt8mI+iiPTrhWPpmJfHmo18JJ7GsQGpV9qaWZU7n
         jEIERagag427WL5V3oBpXTD9TECLRTDvMMnRizcsZogAnAqAOZu7vvOApmczEWDvRX7w
         NBiDq8vZ35OK6nxCKEVcSpTioRnpnMeDqDQDH0BXPAbI8macTFw6P7uWhYHSmPqegWeq
         51WWYbcmViMBHCR885N86jRB34lZDEPaAGjB9A0FrSLoycutYRZQ+bjhDwpnzt+iEOh1
         GmrA==
X-Gm-Message-State: APt69E1aniySHPlyS7+HOHoTgRhLFohDU8FRRTVIYTk0oh5QTa4IHstI
        Gq1XQhQw5s7OXIs8FukDnoaXoQ==
X-Google-Smtp-Source: ADUXVKL4xU6ZqA9ZNvY21bkltUKF5zlSce6LYPDPid+TLTB6JtjX4AjRo8V3Nja1nvuc9JudqXjDBg==
X-Received: by 2002:a62:5d83:: with SMTP id n3-v6mr10936041pfj.68.1529005651834;
        Thu, 14 Jun 2018 12:47:31 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:30 -0700 (PDT)
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
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 07/12] PM / devfreq: export devfreq_class
Date:   Thu, 14 Jun 2018 12:47:07 -0700
Message-Id: <20180614194712.102134-8-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting the device class allows other parts of the kernel to enumerate
the devfreq devices and receive notification when a devfreq device is
added or removed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- none

Changes in v2:
- patch added to series

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
2.18.0.rc1.242.g61856ae69a-goog

