Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6C0C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE8A240E8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfjY5yFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE8A240E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeGERui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:50:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43121 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeGERug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:50:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so1594503plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DkMcqAFaeEJxjYoWVDK4vidf6ScNNCBtbd/QZR2sM7g=;
        b=ZfjY5yFmf56PfUY5i6emE8zGLjNobk93Mc6KvOTjNACuizCqvNa744Ze/ue6aHGUB9
         7IL0b5pnC1pKqsVmmyhj3gUz5mu5jJCGf+zqZnBHw55YPWB+ju877etyWEHqANvP3sWs
         bDEfrOzFtGuviRXjpa9dkONpZruqvY+uT1a+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DkMcqAFaeEJxjYoWVDK4vidf6ScNNCBtbd/QZR2sM7g=;
        b=llbgfjVW0Sh236GrP2U/nHy9toYDITFM/1iVxVoZJUHmU7zSPoyXx/c9lisI1j0jeL
         jNFNx2YQNavvFOdpc0Ep66XAY1E2QrCTvX7csVTXWimuNJQ+io88IUjr9Ktg3BJMFRIZ
         Ln9H5+ZLgXTIU7pbpiRGuGW4hkUT5ZKJcmWXBDxLZeL5cux11dp+NBkzHz91KiWsa9Zz
         +2hl2+CpGEpH3YKkk0WTxps8AFS0uy5p8/EcI4+Dym+Ejy0+6UA2vAWTyWdAhARZPUMx
         gq6Nc6GfS06GEcyhgI09B7y7JT+br2wyUiUplk5Eoes85o+BoHduBSF46Ltskc74qv/e
         7yWA==
X-Gm-Message-State: APt69E3wwWgudJvoQkc9m448ZGQChpZ9beFuCh8M/5RUYkfSjloYOtHJ
        Zvw2L9V0Op3bCa2vU3qZFkxf6zY3oNU=
X-Google-Smtp-Source: AAOMgpc9noROr0YWrf+EAJvAGOyZeHURgVubBrlLQA2XEFwa/67WquJvWxdqfNbdBvHXzfWofcViyw==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2-v6mr6998911plb.119.1530813035699;
        Thu, 05 Jul 2018 10:50:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id b123-v6sm11922633pfb.156.2018.07.05.10.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 10:50:34 -0700 (PDT)
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
Subject: [RFC][PATCH v2] selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock adjustments are in progress
Date:   Thu,  5 Jul 2018 10:50:31 -0700
Message-Id: <1530813031-19243-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past we've warned when ADJ_OFFSET was in progress, usually
caused by ntpd or some other time adjusting daemon running in non
steady sate, which can cause the skew calculations to be incorrect

Thus, this patch sets a flag which we check if the clock was being
adjusted when we fail so that we don't cause false negatives.

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

