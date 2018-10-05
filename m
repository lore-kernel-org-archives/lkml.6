Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131CCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8992147D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUfVOxll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8992147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeJEXR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:17:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46597 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeJEXRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so14322021qtk.13;
        Fri, 05 Oct 2018 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XojoW7X3XGGnrPVboAoj6uP4rNyi3lSaqAIUw6+is08=;
        b=QUfVOxllEzDtnu7dtdMUv25KT6ihYByUxhZnJEg2dIE6KD+i57lwIn+mvw4qRlJflN
         w82Q7UcTvhIQQzkzuyIxtik0C9bECKe051r1Cq6tH1NO1+fjDFwGrpjIIXG1wwLSFk/2
         Fhs4AvybxBOTmL1ODLD7ZdqB++oVs/BqTKN1hB3Jz49cp2R7Z9Cx7BTaqBROmaOkqN/K
         L1fBBHhdfPXLhfRKNEpE5c6t8+fYeyktMUL7g68kDvG9qhBUebNdnqnBcNxmU27p2wT8
         igF2KgQCovFQAb6S1mULPibZ9r9mKqkY5g2Ft3mi72aQ5Cq46FQwOKsXYJ1VVP4xFaB4
         3RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XojoW7X3XGGnrPVboAoj6uP4rNyi3lSaqAIUw6+is08=;
        b=UMY9BCOehXkaf9E0gwSKwA2l0NrDjeFtuHHkUxRWLZKsPi04mO6OAwAsDUX3NSaC07
         VIbKo4kw2joQ8pYVO5nJKK0CREoyqf/UjtV6Jvh/GUEiog5rptNXhjh4GIz7NcnvOCqa
         fmeZ8hVNvDQFXjc8i0V460Y+kLb2CEywLYJYxbdAqCA1R9umP1c1n8JnZ3ebZ8AEIYIl
         kC2Wdqsgbymh9pEs7lo/H+0rEFTvdFSmUMJC+0tAlDCBpyK4EMuT496NCXwS5C0Gq511
         I1yiyb63zc/e30GaC1TpxEgeqdd+cZRTa65lsb38OpCRmSlxsk0Sn+N0pcPr0cXe8Ypi
         MP0A==
X-Gm-Message-State: ABuFfoj0HEfgmRpKBxI6LyaUHsU4oHlOLaWSdB5C0jT3lrK6XFSn0y/w
        1NKEtN3KuDOr0oWGFO1tXrgsNImB
X-Google-Smtp-Source: ACcGV62B6ejCkpjrEuWLHpYHlG5YqQUBO+XChfshjPNnxQWTIzJpnHwERYZBis5A7+Mki3sedS26PQ==
X-Received: by 2002:a0c:d928:: with SMTP id p37-v6mr9658038qvj.181.1538756311303;
        Fri, 05 Oct 2018 09:18:31 -0700 (PDT)
Received: from gandalf.middle.earth.net (pool-173-48-133-32.bstnma.fios.verizon.net. [173.48.133.32])
        by smtp.gmail.com with ESMTPSA id d89-v6sm4657141qkj.29.2018.10.05.09.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:18:30 -0700 (PDT)
From:   "George G. Davis" <ggdavisiv@gmail.com>
X-Google-Original-From: "George G. Davis" <george_davis@mentor.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     "George G. Davis" <george_davis@mentor.com>
Subject: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Date:   Fri,  5 Oct 2018 12:18:25 -0400
Message-Id: <20181005161826.2455-1-george_davis@mentor.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following smatch error was introduced by commit 7ca5f6be7900 ("i2c:
recovery: add get_bus_free callback"):

drivers/i2c/i2c-core-base.c:228 i2c_generic_scl_recovery() error: uninitialized symbol 'ret'.

Analysis of the code appears to show that the smatch error is a false
positive since 'ret' will in fact be initialized after exiting the
'while()' loop.

Squelch the smatch error since it is a false positive.

Fixes: 7ca5f6be7900 ("i2c: recovery: add get_bus_free callback")
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9ee9a15e7134..7b25ecb6b616 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -185,7 +185,7 @@ static int i2c_generic_bus_free(struct i2c_adapter *adap)
 int i2c_generic_scl_recovery(struct i2c_adapter *adap)
 {
 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
-	int i = 0, scl = 1, ret;
+	int i = 0, scl = 1, uninitialized_var(ret);
 
 	if (bri->prepare_recovery)
 		bri->prepare_recovery(adap);
-- 
2.14.4

