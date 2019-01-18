Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EC8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EB720652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdrdLCFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfARODy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:03:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfARODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so15211677wrw.5;
        Fri, 18 Jan 2019 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2UWdEyGVqVyvqUQDZYk9f7eNmmGxd41TJ57on6Onws=;
        b=CdrdLCFs59tIk6shFskgU3fq/ZOkzyqz8UdY3d2jlho/svBXcx0oyfoja5LsYTisFs
         kdK3n7+mb9xhLjEWFyPGShjHJxS2fCw4ZJD+wGh7Lub5A2RunIXitqwp8hpcw8/3PSPN
         cYgb8WUS2HeOflTiG9uVYdRj66FBLVBBrEI+98MgEhNEJuQSSlqawH/FgrK4H4CbFcrz
         KM//nenqpZNAR3ObsPYTdmyFymD7+fupMZ5f0qYIOjhXNrL6yxJo2DBDnsiqxYhsczFj
         f1JIoTPATVIM7V87nw/tlhXvFNIWPOvpjP9LNjXKYuGtwsA07A9V4xHIsGnO5Wd5vJTl
         Fj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2UWdEyGVqVyvqUQDZYk9f7eNmmGxd41TJ57on6Onws=;
        b=eDbVKhCeHDoNN6lBMNGkRVJzLJuHxFR4FReFUVmh8gf0aL9Ydd8Z+/j9VY3VpKpRNN
         Pioex8eqzU2FGnwJnQE/QP0k8yqPrQHlNsKtjxl5EU08zefANxZ0t0JKYIiPsRTuGkzu
         z2WdynC4+7cZBWKC46FLPjSV4xC9lHUrC8akNLK4W71E9J1ofUyxUEDhLhB2q2yNurhT
         IJ6UrM6OYYjiUCsNRFIDDjEdWj6u+wBX3QlFdKF4OuidAoS1veVhe7WdjKAww0qlvqts
         QmfRxJknGzKCyvd4WVVor2GunbQP7m9V/TKd04rPR/XhJQ+Dihp2/Y6MSLznqJM3HsaO
         LhlA==
X-Gm-Message-State: AJcUukc1LfgZHXJB21gqYUkrym8KuPPGZZezquVeSEJhzAy2ooIwpRnC
        ddH1H1qvyBqUFjyV8v28oZE=
X-Google-Smtp-Source: ALg8bN7XJCF11PJwLQRA1J01hPvVewwFu+RcGUTSTv0rDKFm86Fm8nokV7AMqHmFnv+g/5ofV21knQ==
X-Received: by 2002:adf:b307:: with SMTP id j7mr17625353wrd.46.1547820223662;
        Fri, 18 Jan 2019 06:03:43 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:43 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 7/7] hwmon: adm1029: Add a comment for locking mutex
Date:   Fri, 18 Jan 2019 15:03:29 +0100
Message-Id: <20190118140329.18970-8-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch complains that mutex does not have any comment.
This patch fix that.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index e9fe4fc3489e..e561279aea21 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -108,7 +108,7 @@ static const u8 ADM1029_REG_FAN_DIV[] = {
 
 struct adm1029_data {
 	struct i2c_client *client;
-	struct mutex update_lock;
+	struct mutex update_lock; /* protect register access */
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
 
-- 
2.19.2

