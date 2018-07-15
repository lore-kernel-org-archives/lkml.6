Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD93ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334E72087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334E72087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeGPADV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:03:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeGPADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:03:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNcKQw922737
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:38:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNcKi1922734;
        Sun, 15 Jul 2018 16:38:20 -0700
Date:   Sun, 15 Jul 2018 16:38:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-7bb497092a34a2bbb16bad5385a0487dee18a769@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, ard.biesheuvel@linaro.org, arnd@arndb.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, mingo@kernel.org,
          ard.biesheuvel@linaro.org, arnd@arndb.de, peterz@infradead.org
In-Reply-To: <20180711094040.12506-5-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-5-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/cper: Avoid using get_seconds()
Git-Commit-ID: 7bb497092a34a2bbb16bad5385a0487dee18a769
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7bb497092a34a2bbb16bad5385a0487dee18a769
Gitweb:     https://git.kernel.org/tip/7bb497092a34a2bbb16bad5385a0487dee18a769
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Wed, 11 Jul 2018 11:40:36 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:43:12 +0200

efi/cper: Avoid using get_seconds()

get_seconds() is deprecated because of the 32-bit time overflow
in y2038/y2106 on 32-bit architectures. The way it is used in
cper_next_record_id() causes an overflow in 2106 when unsigned UTC
seconds overflow, even on 64-bit architectures.

This starts using ktime_get_real_seconds() to give us more than 32 bits
of timestamp on all architectures, and then changes the algorithm to use
39 bits for the timestamp after the y2038 wrap date, plus an always-1
bit at the top. This gives us another 127 epochs of 136 years, with
strictly monotonically increasing sequence numbers across boots.

This is almost certainly overkill, but seems better than just extending
the deadline from 2038 to 2106.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180711094040.12506-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/cper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 3bf0dca378a6..b73fc4cab083 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -48,8 +48,21 @@ u64 cper_next_record_id(void)
 {
 	static atomic64_t seq;
 
-	if (!atomic64_read(&seq))
-		atomic64_set(&seq, ((u64)get_seconds()) << 32);
+	if (!atomic64_read(&seq)) {
+		time64_t time = ktime_get_real_seconds();
+
+		/*
+		 * This code is unlikely to still be needed in year 2106,
+		 * but just in case, let's use a few more bits for timestamps
+		 * after y2038 to be sure they keep increasing monotonically
+		 * for the next few hundred years...
+		 */
+		if (time < 0x80000000)
+			atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
+		else
+			atomic64_set(&seq, 0x8000000000000000ull |
+					   ktime_get_real_seconds() << 24);
+	}
 
 	return atomic64_inc_return(&seq);
 }
