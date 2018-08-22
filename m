Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB244C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45210214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="S/3hU7WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45210214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeHVOYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:24:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43556 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbeHVOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:24:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id f135-v6so1066834lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSKHvq/hcUkIZigbX8gwSDpZqJ2SeooKPIBEQs38bKo=;
        b=S/3hU7WNbg0F78Jysi07ODSPZ+q56wcMgylKKo6cPE4LBVLqMdh9hx+Jo3X5Gyi0wt
         LsN4ez9G2EyvNK2HAVyFpF5A8CSShS+u5OjdAnk0PCjiHlTXcbxkcgBygTFXhdFKnW2H
         OkbB0w1CgF6Dy4YIHmDHkqrEWWL+OTvFmff/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YSKHvq/hcUkIZigbX8gwSDpZqJ2SeooKPIBEQs38bKo=;
        b=I26kEhs+midu1x/wjVZFYn+u9GArD52fmUGP1pJElP/kDnRWRWr4d0FEl7bPDZBmKv
         F/zhXa1WTxK7EccWMCFCj6ahA/GUZPx7HX7fLtbyrh5aUmk5kkOoKL6jX0yhF6nmrQgE
         WYfjgySV6NabvgtodoSbaiBSNHcZ/fF1DsxFY1anQ44+gf5g/peDktSM6sjBQPWyKOSF
         JLXgUgrw28uykbyXKB1oZ/AVk5cORhf1s1ROgweVSpfdYxA6sctGMwDzxC6gmJ8XJ7Ai
         dhq5/4trFqkFhrDQb6+H4MrbIEoum7xj3IefKvZv8fdmv0GrCEO4j6HIxCh/M5ZHR4wj
         3DSA==
X-Gm-Message-State: AOUpUlEeUWG0fAHz71/84tM+7k7WWkybXmr4tYgmIY7m6u7eKX1ltDjS
        sy/Nl7+1L02vsjF624s36K/qvjcyEK+x/YIT
X-Google-Smtp-Source: AA+uWPw9ReDPhENhY0o2lV9x/zgU4ZE6DORxA+LEyAp+LEwyUNHbCsdrwftOruH6uqW3Rf2HQgYMIg==
X-Received: by 2002:a19:d105:: with SMTP id i5-v6mr14650341lfg.31.1534935615732;
        Wed, 22 Aug 2018 04:00:15 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y5-v6sm234273ljj.75.2018.08.22.04.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 04:00:15 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/4] drivers/base/devtmpfs.c: don't pretend path is const in delete_path
Date:   Wed, 22 Aug 2018 13:00:07 +0200
Message-Id: <20180822110009.17583-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
References: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

path is the result of kstrdup, and we repeatedly call strrchr on it,
modifying it through the returned pointer. So there's no reason to
pretend path is const.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index f7768077e817..b93fc862d365 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -252,7 +252,7 @@ static int dev_rmdir(const char *name)
 
 static int delete_path(const char *nodepath)
 {
-	const char *path;
+	char *path;
 	int err = 0;
 
 	path = kstrdup(nodepath, GFP_KERNEL);
-- 
2.16.4

