Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0059ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A5621480
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOsn/rV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A5621480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbeGLU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:28:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41895 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732526AbeGLU2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:28:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id c21-v6so16625361pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dAwq1mkAVXiY0/cfgYJalGRPhrDv9DLxOQ4uYGDmhxI=;
        b=jOsn/rV269hQMYahSiYnGT0KhcbsEoeFGeTe9e1CA1Z7T7K9amJ4xyA3/4wDXr4YjN
         YJbM2THUiDBHdGyZureu1f5z3XWdnM9asZhCWrKOzY1TZQuZzxPGA1zLsatvGBE3McNU
         KbXWA6SF0W09rwSf78pD9JMUD8lt+IfJTlyvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dAwq1mkAVXiY0/cfgYJalGRPhrDv9DLxOQ4uYGDmhxI=;
        b=iFGqTWaiqjMNUjD6dzdmdYY4MW/I5ynHFceQ7Nz83OXxb8d65P4WKcEnqUwpUOK3k2
         qv50dv1BUO+LNslz+YARxEpiJ1f0a0ZVVlGaluBHgEPEfvScEKM6+PtW/D3Xb18nzRD4
         PzHnaIcrsXgMZQCjSOr74+R9U2wYl/76zBZC/c28q4a3BfS6jEHm99yimGxGsrfLEWcl
         4kGm2b1kGZrUiv4Ko/k6xwlpTbDjrqSxAVI2RHmvSKiX8oIX7Z2uXMlDiSAbVbqibYZE
         lF575pArt6AplXAES/g9JGYulAH99OoSQDiN4/U5aBBt78i/38gPKc/sESDIFRBAxyKl
         tLfg==
X-Gm-Message-State: AOUpUlGJEtFyxu3s2ijBPY0uDSrwM6cZjECKNpL//Ze2cdu167QSN9Mq
        cuY4UaZLnJWXfodHy+8Thla33OYPJOo=
X-Google-Smtp-Source: AAOMgpcxXG8zppfEzhP4X7Dd4URpMRKbWeb5IjdvmXArLCfXaO9YnvcfjBkG6Eekx6+xGOlyyW6BOQ==
X-Received: by 2002:a63:c742:: with SMTP id v2-v6mr3351953pgg.331.1531426646491;
        Thu, 12 Jul 2018 13:17:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id e7-v6sm22647000pgc.55.2018.07.12.13.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 13:17:25 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock adjustments are in progress
Date:   Thu, 12 Jul 2018 13:17:20 -0700
Message-Id: <1531426641-20076-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531426641-20076-1-git-send-email-john.stultz@linaro.org>
References: <1531426641-20076-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past we've warned when ADJ_OFFSET was in progress, usually
caused by ntpd or some other time adjusting daemon running in non
steady sate, which can cause the skew calculations to be
incorrect.

Thus, this patch checks to see if the clock was being adjusted
when we fail so that we don't cause false negatives.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Suggested-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Widened the checks to look for other clock adjustments that
    could happen, as suggested by Miroslav
v3: Fixed up commit message
---
 tools/testing/selftests/timers/raw_skew.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index ca6cd14..dcf73c5 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -134,6 +134,11 @@ int main(int argv, char **argc)
 	printf(" %lld.%i(act)", ppm/1000, abs((int)(ppm%1000)));
 
 	if (llabs(eppm - ppm) > 1000) {
+		if (tx1.offset || tx2.offset ||
+		    tx1.freq != tx2.freq || tx1.tick != tx2.tick) {
+			printf("	[SKIP]\n");
+			return ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
+		}
 		printf("	[FAILED]\n");
 		return ksft_exit_fail();
 	}
-- 
2.7.4

