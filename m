Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEDC20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eR9TqU3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEDC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeLACGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:06:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43465 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeLACGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:06:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so5231432ljf.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNjyw4WFe5aCEBs5R6p8ET74qSu0suisVeGiZgd56AY=;
        b=eR9TqU3o7I/HzhmBxn2lfwA+RtwRJ0j+V4KkxsfqYKrVijwRU1WNyrq4c62Ugs6Hdo
         5c4XmaWZZkjKMH9PP6ol+N9M2wuLW5Yt5IOiKt9cDd2Hc9uyhH27NrrQqSWyCD9h3/wa
         seQL9aeRH1qmG8lhyqkwB/MFU/z4/EJ0JcvoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pNjyw4WFe5aCEBs5R6p8ET74qSu0suisVeGiZgd56AY=;
        b=DVpGa7V62r7ezGEo1LL8Zw37ZKHnERNesiB2md6+bbPBhJUVCJrwDuef9YAtz8vOAe
         vRijKEzGlUlz1U2IMZtA3sY8B9lPvkMNPRXuEZrxu3LL/EYWDh2x1e2eBwhKTGoetcvv
         ikuTIRqbk3TbJOjKVABgtKcWxCw7a8XhI41YN3nCyCvohqvVP1RsVX6pIntJ1fs8KpqH
         HiVAg9dn/t6d3TEWck/MAXahuHik9PuYzwfbAqDTgK/pyvVhSCHcBYFzKOcmSLLZ73jL
         jpwIixZCgzx4W/T/e6uB50TR7sp+l5H0JKABrD2d+/Bld0vTazziWlV+w09II3f9DzJa
         sjTQ==
X-Gm-Message-State: AA+aEWZj5oecIKDw/7oshKUk+X6hfe5nCR0Y+gwOgmMRRoTp9EckER1K
        3n2qkdm2dMD9qSHb/Pg7qULfmw==
X-Google-Smtp-Source: AFSGD/XR9Z4izbAQIMFggT+bBF513IxA5VG+EOc9iQvxsR0jLjmC2Xq2Nob0XTjAn3LO75b6s+oHww==
X-Received: by 2002:a2e:5747:: with SMTP id r7-v6mr4007885ljd.141.1543589788537;
        Fri, 30 Nov 2018 06:56:28 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id d2sm850849lfg.16.2018.11.30.06.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 06:56:27 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] kernel/trace: fix watchdog soft lockup
Date:   Fri, 30 Nov 2018 15:56:22 +0100
Message-Id: <20181130145622.26334-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a allmodconfig kernel for arm64 and boot that in qemu,
CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
watchdog expires and prints out a message like this:
'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
Depending on what the what test gets called from init_trace_selftests()
it stays minutes in the loop.
Rework so that function cond_resched() gets called in the
init_trace_selftests loop.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5706599ed534..109becbc81ca 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1547,6 +1547,10 @@ static __init int init_trace_selftests(void)
 	pr_info("Running postponed tracer tests:\n");
 
 	list_for_each_entry_safe(p, n, &postponed_selftests, list) {
+		/* This loop can take minutes when sanitizers are enabled, so
+		 * lets make sure we allow RCU processing.
+		 */
+		cond_resched();
 		ret = run_tracer_selftest(p->type);
 		/* If the test fails, then warn and remove from available_tracers */
 		if (ret < 0) {
-- 
2.19.2

