Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A82C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F170421570
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIxSKjjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F170421570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHUPW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:22:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33381 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeHUPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:22:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so14099470ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASEXKtE9J3QGtrXxj8rWJowtdn/xKqROXNTd0odm7rg=;
        b=SIxSKjjD8de5Dj7M2/G6qMTTSSTSaRJyL/moXpUvTh+A+iwzYZyfgfwtQCab8qxByv
         O8h2MxRd9oXSqrlJ3QEueM2vCrwBnHRBaEEJQN6ssyv8nq1Jn7f1ZXOg+haSHj8oBYZ3
         5U18O7BwLedAy5aYM1WW8acbLu8Sb+mkpXEEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASEXKtE9J3QGtrXxj8rWJowtdn/xKqROXNTd0odm7rg=;
        b=ZhVcDH49uMp2lHTyqeh+TUXmw2M35VwdG+u4g9T4WOUB9XXb1/b6YCxdAwA4FuKFZB
         njUreBlEtnvYByi889c7LwT8BoVycn7ZBt+y3Bfaxwb7lLw0PDk36tW31JTnIJ6HhagC
         z2uAqMjYyqi/LBlCnXRQWKwFEK1hunjS1kB/fMfBS6ImvoTUp+OKK22fJm+mzDT4x9Fb
         JYbaruh2+1cXIv0KAx1N8PCZPdr68gmtAK7iZ7zxKjwYvme7mXiwyDLZYDp6xobdWVn1
         a1o33Ti5D0ruddd7bk2aG4ouNiDfcUGc+KdMhd8ovLG3NJwxr6NXLycf8COzHaYvAMx1
         /Nig==
X-Gm-Message-State: AOUpUlHxl+LbaWE02Fqaegi03VL3g/OUkz5sFlcFg/6i+ZTxFrrKM4//
        WE72uN2IuxTjxIHAaw5oTeivJQ==
X-Google-Smtp-Source: AA+uWPz7l6V/1e60fNx4uJZqpBiZFQdU3twS8gLWwy4a510sOTlrYO3nBCKWI+Qj4oOKL6sgIOMJwQ==
X-Received: by 2002:a2e:97c8:: with SMTP id m8-v6mr36334195ljj.52.1534852951686;
        Tue, 21 Aug 2018 05:02:31 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2059688lje.51.2018.08.21.05.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 05:02:31 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] cpupower: remove stringop-truncation waring
Date:   Tue, 21 Aug 2018 14:02:25 +0200
Message-Id: <20180821120225.3516-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strncpy doesn't null terminate the string because the size is too
short by one byte.

parse.c: In function ‘prepare_default_config’:
parse.c:148:2: warning: ‘strncpy’ output truncated before terminating
    nul copying 8 bytes from a string of the same length
    [-Wstringop-truncation]
  strncpy(config->governor, "ondemand", 8);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Passing the length of the input argument to strncpy() is almost always
wrong and provides no extra benefit over strcpy(), and since 'ondemand'
fits within 15 bytes" and it null terminates the string its safe to use
strcpy().

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 9ba8a44ad2a7..91b5b768ffd2 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -145,7 +145,7 @@ struct config *prepare_default_config()
 	config->cpu = 0;
 	config->prio = SCHED_HIGH;
 	config->verbose = 0;
-	strncpy(config->governor, "ondemand", 8);
+	strcpy(config->governor, "ondemand");
 
 	config->output = stdout;
 
-- 
2.18.0

