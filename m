Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1ADC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7479921508
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sehro.org header.i=@sehro.org header.b="MU0uR8+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7479921508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sehro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeIYWas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:30:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40610 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbeIYWar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:30:47 -0400
Received: by mail-it1-f194.google.com with SMTP id h23-v6so16031325ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sehro.org; s=dotorg;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUtN+OY5Ru1b60t1M0/aketqjN8jLR+urvCU2HJwlXQ=;
        b=MU0uR8+VCXx/SqgK36aGgVCkvfXLRBdok/qJmpeB2sNkKMo1ENSdcl+KVWTAXC8g8p
         TzDuPtANBL1WKot6fAZtdx59P0WpIEQ8lH4KMYGoeoYNI+G4euy4Q7lBiVpeDUN9Cu+A
         Ac1PveAUkst1CCWmT4ua0BDOiDMKeIKrtI/5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUtN+OY5Ru1b60t1M0/aketqjN8jLR+urvCU2HJwlXQ=;
        b=AG3yfAU4xVlCJ0ZPlK2J8vBp97OJx/6xwxlhr4v+7Pey4LJXDz37tC4MewWs9bm6KP
         NLnlMJwvbraPT+1BbJe0XNzPMLEHXb4Pvr4xJHnGSn01pj1oXpoHHxDdYRApwzYm8Q7W
         5qMdhu4mDTUeyYQ4QXwVqyzd3SyLXkNptftsdZ4TRN2WZBjxXwaeA7c3xNgctgUzHR8I
         2cXtd26oTykLiiKjoOJaMJRwzu836xrzTdy1opyKL6TgTTGiRHuiW1sBDtFQdXgdrbWT
         4btjT7V6IQAayyBlUw11QzpscOTdKv5pap0G/0CnXd+yWuRC9UO2naAASlHgZTvut1rH
         hZJA==
X-Gm-Message-State: ABuFfohmiC7pWNnVhIFGBAVooIDafi4PlFsXy9TrGRceTxmbIjmHxQtF
        3nLyKAvxZmaoX6unUJ7UMWGsow==
X-Google-Smtp-Source: ACcGV61FHlUnS39TjeSx1rhwiozKGfpcxB0h2H1cZyN0CQRUdbaND2e+cTnJ2NKJXzm3fEiD5+0gOw==
X-Received: by 2002:a24:3b0e:: with SMTP id c14-v6mr1401181ita.42.1537892553408;
        Tue, 25 Sep 2018 09:22:33 -0700 (PDT)
Received: from goro.horizons.sehro.org ([2601:280:4400:56c:731e:1a85:7df8:2d5b])
        by smtp.gmail.com with ESMTPSA id b130-v6sm1100182itc.34.2018.09.25.09.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 09:22:32 -0700 (PDT)
From:   sehro rautenkranz <sehro@sehro.org>
Cc:     sehro rautenkranz <sehro@sehro.org>,
        Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: dgnc: Fix Kconfig help header and text
Date:   Tue, 25 Sep 2018 10:22:24 -0600
Message-Id: <20180925162225.19227-1-sehro@sehro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <a62c2d41-5ae6-26a1-3c0e-01893a8ca8a0@infradead.org>
References: <a62c2d41-5ae6-26a1-3c0e-01893a8ca8a0@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace Kconfig help header and text to match other modules. Issue found
my checkpatch.

Spacing adjusted to match Documentation/process/coding-style.rst. Issue
reported by rdunlap@infradead.org. (try 2)

Signed-off-by: sehro rautenkranz <sehro@sehro.org>
---
 drivers/staging/dgnc/Kconfig | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/dgnc/Kconfig b/drivers/staging/dgnc/Kconfig
index 032c2a795238..0f7537eb27d8 100644
--- a/drivers/staging/dgnc/Kconfig
+++ b/drivers/staging/dgnc/Kconfig
@@ -1,6 +1,10 @@
 config DGNC
-       tristate "Digi Neo and Classic PCI Products"
-       default n
-       depends on TTY && PCI
-       ---help---
-       Driver for the Digi International Neo and Classic PCI based product line.
+	tristate "Digi Neo and Classic PCI Products"
+	default n
+	depends on TTY && PCI
+	help
+         Say Y here to enable support for the Digi International Neo and
+         Classic PCI based product line.
+
+         To compile this driver as a module, say M here: the module will be
+         called dgnc
-- 
2.19.0

