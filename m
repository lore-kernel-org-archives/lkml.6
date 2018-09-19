Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23525ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B85208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mIhavQ2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B85208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeISGHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:07:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33176 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeISGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:07:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id b97-v6so1782174plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14dgsRRLlEATe8zMJ34ql9WvSaknTJg5eCMF5I+hobs=;
        b=mIhavQ2gP7BCZwYF9DOP7wtUHVBe6KdVrSAbrY2h37FFSMA+voxi3//5zN8JHqSkVk
         8iiE+V2r97TKNik+fyfG6mCwo1IuHyhtTqJEpHiuWtRTG0lJYPXth+3BCp4BcsZ7L4SI
         iterpb4ysGmGhWbJ3WwZDMuIp1QpENXAJVbEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14dgsRRLlEATe8zMJ34ql9WvSaknTJg5eCMF5I+hobs=;
        b=oe18m/43pxGTnwRF4ZQN76I9HGADt2ZuuuuAiM15oHbTdSX3DEQqVud02ZU/Iuglpn
         tL0O5RS4yqrbvDzV3MohOtaZZHLqILJptG7nA/Kb4Yu5DNktt5ZqHIVHS111uCzq4JZl
         wvQyEg0ooGXgRqiqMNTSV+U3mF86bfcHQdMqxN/4M9Hz3tg3xO0un+eW6Mmhi/3UpZ3A
         Uw3a9qeoWTLLOVqp2TBcojkGEe2kt3up4z3O3YacmlybNDPN1oF2f0qJrkrLT+mM0yMP
         wWkfQ0P7IFDSS1KEECy+NarYRwd9nAs4mpooQehpRzAPIqG2O5DTumJLn3RZit44Ne1/
         iNxA==
X-Gm-Message-State: APzg51Bf4pCduOfCnwGt2YsQOfrHdjwIJAx4upvV0pm/DEpZypFy5ICY
        CldlxgnE4fkGRaIk1U8bctpcyg==
X-Google-Smtp-Source: ANB0VdY7r2q0SXdUO7KVx6/R9Qvx8bcbuJuU3C9LHgAhFi+HOLH4kHH7HJqun7p+opxQDXo5yX4bOA==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr31467235plb.322.1537317123428;
        Tue, 18 Sep 2018 17:32:03 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g7-v6sm25224845pfi.175.2018.09.18.17.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 17:32:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ani Sinha <ani@arista.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] sysrq: Use panic() to force a crash
Date:   Tue, 18 Sep 2018 17:31:47 -0700
Message-Id: <20180919003147.55692-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq_handle_crash() currently forces a crash by dereferencing a
NULL pointer, which is undefined behavior in C. Just call panic()
instead, which is simpler and doesn't depend on compiler specific
handling of the undefined behavior.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Not sure if it is strictly needed to release the RCU read lock now
that panic() is invoked directly (I couldn't repro the warning
without rcu_read_unlock()), but since this is a forced crash it
seems good practice to keep doing it.

The commit that added rcu_read_unlock() and the comment is:

commit 984cf355aeaa8f2eda3861b50d0e8d3e3f77e83b
Author: Ani Sinha <ani@arista.com>
Date:   Thu Dec 17 17:15:10 2015 -0800

    sysrq: Fix warning in sysrq generated crash.

    Commit 984d74a72076a1 ("sysrq: rcu-ify __handle_sysrq") replaced
    spin_lock_irqsave() calls with rcu_read_lock() calls in sysrq. Since
    rcu_read_lock() does not disable preemption, faulthandler_disabled() in
    __do_page_fault() in x86/fault.c returns false. When the code later calls
    might_sleep() in the pagefault handler, we get the following warning:

    BUG: sleeping function called from invalid context at ../arch/x86/mm/fault.c:1187
    in_atomic(): 0, irqs_disabled(): 0, pid: 4706, name: bash
    Preemption disabled at:[<ffffffff81484339>] printk+0x48/0x4a

    To fix this, we release the RCU read lock before we crash.

    Tested this patch on linux 3.18 by booting off one of our boards.
---
 drivers/tty/sysrq.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 06ed20dd01ba..d779a51499a0 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -134,17 +134,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
 
 static void sysrq_handle_crash(int key)
 {
-	char *killer = NULL;
-
-	/* we need to release the RCU read lock here,
-	 * otherwise we get an annoying
-	 * 'BUG: sleeping function called from invalid context'
-	 * complaint from the kernel before the panic.
-	 */
+	/* release the RCU read lock before crashing */
 	rcu_read_unlock();
-	panic_on_oops = 1;	/* force panic */
-	wmb();
-	*killer = 1;
+
+	panic("sysrq triggered crash\n");
 }
 static struct sysrq_key_op sysrq_crash_op = {
 	.handler	= sysrq_handle_crash,
-- 
2.19.0.397.gdd90340f6a-goog

