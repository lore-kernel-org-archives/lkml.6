Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D7EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85292080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+wZt8YG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85292080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeJaFs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:48:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34170 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeJaFs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:48:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id f10-v6so6165167plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd+EwWnhdNULWnMyDKWiMFEcBqwQiPE8Kj6FeGusdGw=;
        b=Z+wZt8YGDzwCvs2UOc8+2hBz3Us8cAgDe3BsGibatmowaR+QthmtKWCQLSea36iWFF
         /6c4gzrELEuLQhNHx28xT8SSyImq+0bYeK5zWqc8UdBvKaA0Ar/Y54+5kdJ7pvdQuYLn
         6gkc2TRIS2RvlDH67MyVcsV52nQ1KXKU4juLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd+EwWnhdNULWnMyDKWiMFEcBqwQiPE8Kj6FeGusdGw=;
        b=EuXSWJd09YYzICfqPljewN9wo4I0jAetiSwGCS83Y9qHVXN+UW5FKv5tyPMnaTR2Vz
         FczYwZ6jt9VTmos55Bk4lVpeY0uGazKMtJFKZ8MjAQVaYmt+imgA3j0AF3tJ6kkrncxw
         7sGfT/95HlhBYn+eEw8TSFyYe5UMcPHZi1JmbX1RFqhby716kI8h1rxyv6r+G2/3Gcy1
         v7KFcEfawxGoRSuNdvBABnGYBsxKF8dhSBDAIHTJk1fNGljAuHq8MgoABgv4MbTIicvg
         yy9/aTCXhKiE9HWoa6fyfydFiIhGL/EfFvjbtWboPZaiEZQyJEt5jLBS2XFYXshmNWdt
         AaIg==
X-Gm-Message-State: AGRZ1gLdXDYiie/QoNmU0I9K/SDX7dM1/zVYiI3zfLvlfTC2yfdyv83Y
        eTVmc4OSJOpF1wIrco8QuHoQSA==
X-Google-Smtp-Source: AJdET5eKasgVlYekwuuuIRktUuxlM7INTbCZbW2jK8crIJBfmtKQxNDFY6DG5AK4mIuv66xMxqaVfQ==
X-Received: by 2002:a17:902:be0f:: with SMTP id r15-v6mr286670pls.170.1540932832888;
        Tue, 30 Oct 2018 13:53:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id n2-v6sm18560753pgg.86.2018.10.30.13.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 13:53:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, joe@perches.com,
        Douglas Anderson <dianders@chromium.org>,
        stable@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Fix btc (backtrace on each cpu) crash
Date:   Tue, 30 Oct 2018 13:53:34 -0700
Message-Id: <20181030205334.148162-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typing 'btc' on kdb doing all sorts of fail.  Sometimes it would
crash, sometimes display nothing, and sometimes hang.

Bisect tracked this down to the commit ad67b74d2469 ("printk: hash
addresses printed with %p"), suggesting an obvious fix.  The pointer
used internally in kdb shouldn't be hashed, so switch it to %px.

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_bt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 6ad4a9fcbd6f..7921ae4fca8d 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
 				kdb_printf("no process for cpu %ld\n", cpu);
 				return 0;
 			}
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			return 0;
 		}
 		kdb_printf("btc: cpu status: ");
 		kdb_parse("cpu\n");
 		for_each_online_cpu(cpu) {
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			touch_nmi_watchdog();
 		}
-- 
2.19.1.568.g152ad8e336-goog

