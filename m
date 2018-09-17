Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE911ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7013820867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e7X6CXrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7013820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeIRDCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:02:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44725 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIRDCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:02:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so8151548pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPtvVXtWJR5yxplizL+btwPaiPB5tKwzwBQrmUc7nac=;
        b=e7X6CXrP5guhehTRZIGWZxNSTVtVamra3WWkwKcGfi6nT0RTtNEiasCKZHtrJKpb5U
         6IQy+DNIS+ifdMfHp51EOyXpOjHmcZjThaobLP+KkrtlkQ2aLZaI80QxVwo/sWsD116H
         8qFFd/NfGUmfel8HkFBHDU2jD/i5t9idXsKEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPtvVXtWJR5yxplizL+btwPaiPB5tKwzwBQrmUc7nac=;
        b=Y+lK+cdOykBIrvDLptEinxtbYfG7luHHITE8tg+vVUHM9S2IVP9aStbd4lCUOoIytU
         mvcP8XdAiOrkpta8vRbE+QbbU+7lIY6et4VAeMxzHDHOQQ+pJ9ZtvVdnCyEDOyrKWB7S
         Yj6+nF7MSitcjqtvW18v9q6k8W0Z+jfWt4vw3QxT4qqRtnVDhwJl9LNdeIxlH8jJhL8Z
         9DqIbn0nlkrV/tCbNjWI4dGqCpecbk5XTv8oJbc1YqTzH5BaWKZxPH0+h3Jqb+GdMf13
         JkjgwPjU6sVIQCmMnq6phAuhtNP7uLMLYfmIMps5Pia7AynOeynx22lL5Sa5hef9mRx+
         mbtQ==
X-Gm-Message-State: APzg51A40baJiQNQ3wvq/GEdz2Uvplgu/0QB8dxiNdIbG3h/21VTiNVK
        er9LiqXzS2j0mGGfDZusnOYIgg==
X-Google-Smtp-Source: ANB0VdZfiUGA/Nb7j2brgAQTMhAoPSQpDGjw4uV1zsL4MmHKxqVk+G/RzDQ8hFx1dzlTyj68hLxcoA==
X-Received: by 2002:a63:e056:: with SMTP id n22-v6mr24476248pgj.205.1537219991359;
        Mon, 17 Sep 2018 14:33:11 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id e14-v6sm20331043pff.128.2018.09.17.14.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 14:33:10 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] tty/sysrq: Make local variable 'killer' in sysrq_handle_crash() global
Date:   Mon, 17 Sep 2018 14:33:04 -0700
Message-Id: <20180917213304.44476-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq_handle_crash() dereferences a NULL pointer on purpose to force
an exception, the local variable 'killer' is assigned to NULL and
dereferenced later. Clang detects the NULL pointer dereference at compile
time and emits a BRK instruction (on arm64) instead of the expected NULL
pointer exception. Change 'killer' to a global variable (and rename it
to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
detecting the condition. By default global variables are initialized
with zero/NULL in C, therefore an explicit initialization is not needed.

Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Suggested-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/tty/sysrq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 06ed20dd01ba..49fa8e758690 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -132,10 +132,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
 #define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
 #endif /* CONFIG_VT */
 
+char *sysrq_killer;
+
 static void sysrq_handle_crash(int key)
 {
-	char *killer = NULL;
-
 	/* we need to release the RCU read lock here,
 	 * otherwise we get an annoying
 	 * 'BUG: sleeping function called from invalid context'
@@ -144,7 +144,7 @@ static void sysrq_handle_crash(int key)
 	rcu_read_unlock();
 	panic_on_oops = 1;	/* force panic */
 	wmb();
-	*killer = 1;
+	*sysrq_killer = 1;
 }
 static struct sysrq_key_op sysrq_crash_op = {
 	.handler	= sysrq_handle_crash,
-- 
2.19.0.397.gdd90340f6a-goog

