Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F0FC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C701C20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U83OMdVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C701C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeILVu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:50:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41605 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:50:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so1245829plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iSBHV4N+CfZFH8TFqEfs20bUBQJc1s8na1Lh4ikqcM=;
        b=U83OMdVBQY8wQU3Cu5OoRsxFIDF/ulCmoRor4KsW6EaXr8yyX85lRkyX2wBC2dnYMO
         gOBIeRWJLKwHbBlO6UxEj0llqORPlicXERwYsIptM/Y1j+GQZy5vy9aOuW0uMFRkYGbb
         IJ6u5dWmjcl0nzN3d5SkBrHx7gqL4WJeJctdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iSBHV4N+CfZFH8TFqEfs20bUBQJc1s8na1Lh4ikqcM=;
        b=bIyNluqIkjC48lOwVh/qsATdaflK9odt6aJJiE+5yrfVpxf0Hx71cnP2Li9WOqoV04
         pgGpWcy0oUlY3K30YYunExjuglZabJLNy05p8ZJ+DP8lC7YnHtNLcGzwN716TL/VBmMS
         keLTlsjg6rxzo2Jf4BpXQlm/Vos5yxm4QovzLb65hPT6vPRhxjWe8/OkTwksPHDiImge
         cZxSQpfZMDynbJ9v/kGVGL6cv1+X8Vm8k697Iuc2d4+kFy88+iSC0nuGuRXY5XkMGDrn
         6peQk8kaggtMH1Sp3vClv6T1JIImmSmd1A6q59lQAyHfHibvDcYo3yzX00/3//GNtrJH
         +xgw==
X-Gm-Message-State: APzg51D1EiG8Qi7fKycx7CJmqXB7YxKCRHhD6xbsHuyIHBr2xw0dn9jW
        pThPdYHvuzqooplY5Nb2n2KsGA==
X-Google-Smtp-Source: ANB0VdZyGrnZSXbA9C9UcrCduERJuY7eKwG2ggsfN/mtoXsCMJdmnjkeDoUWJ+ltFGYbxZXbC5OZZg==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5-v6mr3301855plk.338.1536770735271;
        Wed, 12 Sep 2018 09:45:35 -0700 (PDT)
Received: from zsm-linux.mtv.corp.google.com ([2620:15c:202:201:1b7c:8280:c835:b226])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm2257804pgv.48.2018.09.12.09.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:45:34 -0700 (PDT)
From:   Zubin Mithra <zsm@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        keescook@chromium.org, zsm@chromium.org
Subject: [PATCH] perf/pt: Annotate pt_cap_group with __ro_after_init
Date:   Wed, 12 Sep 2018 09:45:10 -0700
Message-Id: <20180912164510.23444-1-zsm@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt_cap_group is written to in pt_pmu_hw_init and not modified after. This makes
it a suitable candidate for annotating as __ro_after_init.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8d016ce5b80d..3a0aa83cbd07 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -95,7 +95,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 	return snprintf(buf, PAGE_SIZE, "%x\n", pt_cap_get(cap));
 }
 
-static struct attribute_group pt_cap_group = {
+static struct attribute_group pt_cap_group __ro_after_init = {
 	.name	= "caps",
 };
 
-- 
2.18.0.597.ga71716f1ad-goog

