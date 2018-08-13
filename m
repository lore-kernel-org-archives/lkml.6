Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD6C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245F721745
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSQjA8f5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245F721745
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeHMQKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:10:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37852 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeHMQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:10:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so6897542pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DDw/ngD3LqNIF0g2XtCCp00AjuPU6Vq5WuRbE5V0aE8=;
        b=sSQjA8f5k43ihVVm34RhMLc/G5107hg3IqIV4wKzcAb4bo9mrdFsf1rUUMcGigwbR3
         BIIa6GbptLSeq06F4bgbL4i0ifwL79N9nHJLY/qudQMzoOF9dSMv/OwDfuf4lGgiLmtu
         X6M6zsNmiZLSBw+u/C08p7dNSMEbXKpAQ4ExvrHEJ0OsAGejMhquUTnUwrGCVfl/cvnh
         SUYoOh264I2Vi3gqPO1LxEue8fOXP0gnAvCJJTBDNPBzQA2++GrFMAYtTO6polIw9JpN
         glf7RMM43XI6EokMK3JvfjaEvSG2ag44XebYNaAQPLmpfUMjZihl1cQk872KPQmQcIXO
         F8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DDw/ngD3LqNIF0g2XtCCp00AjuPU6Vq5WuRbE5V0aE8=;
        b=jqCUzgoSUEPbDslGzlsC5NETWP/56GWKeqdfomO5gCGuQbC7dNqkBm7Yyod4F/idcg
         OLjawxk1/DCN81K4DVgG/D44us/jm6Qa+r1U9EMrpXHIKPW7aDmIWBesSFx9ZRyazSto
         j/TPpBfQHfWXhiMTTsVA0s778lDJekIax5YWhFiwe+aIk+/uhCk0UksZJR3UqToglB/t
         LXPGA/OVKfoLgozdqmlFQrxmlPH4+Fjeyb9QCnbKEsqVlFpkX1ZUY72mmck7xMYWEiLb
         dS0OHlJfO8Pz9xoAwaNzR1RGRdchC2/2TWimXWcg7bFjhauIuUHUEF8+vEUpQ3Sx7sC7
         iNnQ==
X-Gm-Message-State: AOUpUlG3I4vOiOlZo+euUcOFk0jAIDoeDv4/R5yDS7CNNsnNyHFbADN4
        owb5LFyAhZdxJ6/cktXw78I=
X-Google-Smtp-Source: AA+uWPxIlT1fglDVq2DBXQBXEBeVmfb+WdrDFO0QM1Kb+qSfmP3nKUh5AtifZPcXv6wTVAm12UVtVw==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr16380803pli.191.1534166905807;
        Mon, 13 Aug 2018 06:28:25 -0700 (PDT)
Received: from linux-zmni.DHCP ([59.63.206.215])
        by smtp.gmail.com with ESMTPSA id n12-v6sm38631952pfh.146.2018.08.13.06.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 06:28:25 -0700 (PDT)
From:   Sean Fu <fxinrong@gmail.com>
To:     ccaulfie@redhat.com
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Sean Fu <fxinrong@gmail.com>
Subject: [PATCH] fs/dlm: Remove NULL check.
Date:   Mon, 13 Aug 2018 21:28:15 +0800
Message-Id: <1534166895-7185-1-git-send-email-fxinrong@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnessesary NULL check before kmem_cache_destroy() in
fs/dlm/memory.c

Signed-off-by: Sean Fu <fxinrong@gmail.com>
---
 fs/dlm/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 7cd24bc..0349c89 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -38,10 +38,8 @@ int __init dlm_memory_init(void)
 
 void dlm_memory_exit(void)
 {
-	if (lkb_cache)
-		kmem_cache_destroy(lkb_cache);
-	if (rsb_cache)
-		kmem_cache_destroy(rsb_cache);
+	kmem_cache_destroy(lkb_cache);
+	kmem_cache_destroy(rsb_cache);
 }
 
 char *dlm_allocate_lvb(struct dlm_ls *ls)
-- 
2.6.2

