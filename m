Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DADC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6662083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP0yucY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6662083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJZI0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:26:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39606 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeJZI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:26:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so4975807pfe.6;
        Thu, 25 Oct 2018 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jgCJL9czCPigEGOwpf3mxraCR5nZbEWiDU5Zl8DZfBo=;
        b=hP0yucY8ktiFpTgPsYLtrVtWoSfujMUYYeN24w/XBfFv40TeUsQlQ7YlDqGnxP/c17
         uL9CU5nc6gkV9m6gZE5xVGqEIAbzoKUY0d819ZuOU33dyREENZdN6MRqUNbrAKBm3Abs
         /5/OJnyL1MYfxoVo1fqwx33YcL5ZeZRQjZ5Oeq4Ayk8SLNksYZVXQ4hbrBeMLv7zQKQu
         JINz+riFoIfIGeGNQOQLvdPrbEWXZTIxUVoX0EtGVOXaMsY+UMv6C7aekosli8+iYhP7
         kWILHdF75Yo/SRQnGngKPEpS5D/1FKfAU2WTNsQ5xSWZHz/47DVaeXNaO2OYRvpLRprH
         04Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jgCJL9czCPigEGOwpf3mxraCR5nZbEWiDU5Zl8DZfBo=;
        b=bKgZyjGIaLez+HY9W0bOtMCMK9S2qoXst616uxjKsgOafGEAZA7H0XMcBXVAP+Obyh
         89dJImREbaeC63vQAPo1FUb6wnU/uNQtRNaypU3uBVjA0xmZulRBS9dkz79H6EKiM15t
         mQj1WLyTnLrOCwvd17O1VIAqBgZg+EI7er0d80J8tzmd6DpljxNxw0jXMJ5Zrrr/IPC7
         1VobZZO21uG3JP9vQZ6IeTVrvVvyvMuD1xKA3C9k7EQzvwQzzaSHg/LXfiVn6MyVznOT
         NBNLY5zjgpfAWaMV9OVZHtrV/HmPEXzm+JWrYXTp5tvOmN/5nBHyN6SeE0HypK0c8n3t
         saAQ==
X-Gm-Message-State: AGRZ1gL90GQGS5AM6J5YAGqrMJJDuuWjpk82FHaddi694c/zTKVflpd4
        LMRiBHL1aHWMQfD6nz7DVL4=
X-Google-Smtp-Source: AJdET5eLArg8BESAK6AKnHF1kbvpB6HjRmUC7EhAzZzpdCx+UxAo4ycCCr7qWvIoazEdMYOhq1T4LA==
X-Received: by 2002:a63:1765:: with SMTP id 37-v6mr1183883pgx.131.1540511490149;
        Thu, 25 Oct 2018 16:51:30 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e189-v6sm10453806pfa.91.2018.10.25.16.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 16:51:29 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] hwmon: (ina3221) Check channel status for alarms attribute read
Date:   Thu, 25 Oct 2018 16:51:19 -0700
Message-Id: <20181025235122.3240-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025235122.3240-1-nicoleotsuka@gmail.com>
References: <20181025235122.3240-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing critically wrong to read these two attributes
without having a is_enabled() check at this point. But reading
the MASK_ENABLE register would clear the CVRF bit according to
the datasheet. So it'd be safer to fence for disabled channels
in order to add pm runtime feature.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v2->v4:
 * N/A
v1->v2:
 * Returned 0 for alert flags instead of -ENODATA

 drivers/hwmon/ina3221.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index d61688f04594..26cdf3342d80 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -200,6 +200,12 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		return 0;
 	case hwmon_curr_crit_alarm:
 	case hwmon_curr_max_alarm:
+		/* No actual register read if channel is disabled */
+		if (!ina3221_is_enabled(ina, channel)) {
+			/* Return 0 for alert flags */
+			*val = 0;
+			return 0;
+		}
 		ret = regmap_field_read(ina->fields[reg], &regval);
 		if (ret)
 			return ret;
-- 
2.17.1

