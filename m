Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D976C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298AF21905
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0c2zK1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfBMDlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:41:04 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:46887 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfBMDlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:41:04 -0500
Received: by mail-yw1-f73.google.com with SMTP id 201so657334ywp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H8VWqK0/t0TuXLPVjLMEmQZc5d0Pj3Z1HvvTA0WvRH8=;
        b=J0c2zK1KOY19FQXT4b0LZAJm00/7ijjGmwCkz2XGYq/y6EeAcs1bwnGiFTWT88SpvD
         4Rkk2f472ZvM3c3Xpp6UBVyM9Jg6T0YxDcxe/1kxG77woMwK7nnebvnfNjInRdT2TCwQ
         N8azKrx6lv92UB/S3vN+BRgiyaRrdoNYTVyj43ogHTKZjx0gFgrGKWDDzWLvP0GXwtfc
         2G7ZBl82sA8X2Wo2XUCVcfLNWQdyjU0so290Kjc/SaxWhuLag4T5FO+anXzDQYHvbP9/
         3nNi1s3XFd86cx9a9yLzNyp1Oli9xRAss8xTXTHwbpW18LeCC3i/5vOonhxSRKZ+pbxM
         bRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H8VWqK0/t0TuXLPVjLMEmQZc5d0Pj3Z1HvvTA0WvRH8=;
        b=TSMyTSgM0AVlSDpD/gmaxdLgx1gdfg6oIoPGWo7p2a6HEJfCDKSzOccEAHQorQJ3u2
         932Sl+y0UgkpDNgKxUJ/0SiofnaZkmk8Lc88oL0MvietrQ0Su4DPYcmT67zdpJ8tAQ1f
         5JL8TDUG/CU7avgIkWGmuLGF78yXI+g6OjgwQrA0dKdITpmPpf4/UUl+6llxonN6Ut4m
         Jz8wJUz+IaVwC8E7xzXRdaoEkAHRPr8iTDpHfDFFlYpz+gPoCr97oqkSuKxFuQjx/Nzs
         SgQvFXmN6Z9nmgmB1nqd/GilsD6PzjFp3QP/AlzhCnMnYWIRMnEHkdKq+Tz7NLsIMs0+
         TCig==
X-Gm-Message-State: AHQUAuYOHp/eepkHtJvzDYOjQh7r7lD9IWNfzdqTnhh+hT70fs1kmypy
        So5XI9Z6jdvy7u4I8NJzAbl/DDICvEd2HbM=
X-Google-Smtp-Source: AHgI3IZBeb/Sk4NuhJ1KndOjGyMJvhKnfdu/CjWdfU1tL/Ks1+50GAuaa2CbH9vavhd6n1mdYVodifMplQ8CP7E=
X-Received: by 2002:a25:b985:: with SMTP id r5mr3469352ybg.100.1550029263268;
 Tue, 12 Feb 2019 19:41:03 -0800 (PST)
Date:   Tue, 12 Feb 2019 19:40:57 -0800
Message-Id: <20190213034057.244716-1-jsperbeck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3] i2c: core-smbus: don't trace smbus_reply data on errors
From:   John Sperbeck <jsperbeck@google.com>
To:     wsa@the-dreams.de
Cc:     jsperbeck@google.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an smbus transfer fails, there's no guarantee that the output
buffer was written.  So, avoid trying to show the output buffer when
tracing after an error.  This was 'mostly harmless', but would trip
up kasan checking if left-over cruft in byte 0 is a large length,
causing us to read from unwritten memory.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 drivers/i2c/i2c-core-smbus.c | 2 +-
 include/trace/events/smbus.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 9cd66cabb84f..132119112596 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 trace:
 	/* If enabled, the reply tracepoint is conditional on read_write. */
 	trace_smbus_reply(adapter, addr, flags, read_write,
-			  command, protocol, data);
+			  command, protocol, data, res);
 	trace_smbus_result(adapter, addr, flags, read_write,
 			   command, protocol, res);
 
diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
index d2fb6e1d3e10..a4892a187842 100644
--- a/include/trace/events/smbus.h
+++ b/include/trace/events/smbus.h
@@ -138,9 +138,9 @@ TRACE_EVENT_CONDITION(smbus_reply,
 	TP_PROTO(const struct i2c_adapter *adap,
 		 u16 addr, unsigned short flags,
 		 char read_write, u8 command, int protocol,
-		 const union i2c_smbus_data *data),
-	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
-	TP_CONDITION(read_write == I2C_SMBUS_READ),
+		 const union i2c_smbus_data *data, int res),
+	TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
+	TP_CONDITION(res >= 0 && read_write == I2C_SMBUS_READ),
 	TP_STRUCT__entry(
 		__field(int,	adapter_nr		)
 		__field(__u16,	addr			)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

