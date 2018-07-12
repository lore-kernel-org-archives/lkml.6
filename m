Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC956ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDCB21477
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lv0JcqTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDCB21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeGLU2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:28:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37303 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbeGLU2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:28:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id x10-v6so11367651pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t7abE9UviMGU/6XTg9bc1620YDDswbHSbssJtYgdTB8=;
        b=Lv0JcqTRLtMUWmKHaFvB+8Vf5t4QI+AdzylqWnxRaaa5RHxOB+/synNChiomeDxFAI
         17RisDXEamkBzdPxBMS++groiPAcO58m56kONt2D1wNvEspeNdVqzs5R2qXpo25jdDDm
         3HfPLiJmnpG9BpT3G7xp+37QRPm3/5rJKGETE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t7abE9UviMGU/6XTg9bc1620YDDswbHSbssJtYgdTB8=;
        b=hcUyflFXdfk7tSXByUumKZef8KRI3lWTcLpdRD3P+0FCcSOK1jtn+HSqt35a34hHO7
         08kWn57h2UlZHmtwMRa9VVt8AmHN9k1XgTIFNk/CMiOwBWuxhbTUaNOQv0qSlEBYkJx5
         ZhbHFitxplWa5qRU7Hszri41RmTeOllSFbFBY0ZJSx/qHgdiIJxs32QtFaKugF+tS41W
         ++UGfdtqTHuNf1sXU8WgDPOXIr7yF4EI0pQ5FxANG70eoaWWBbQivUnVUd/aomAvX1Yf
         +2AbxRRg1TK/UrowIiR3jG4Om0QbJU1MUXIB4l5h6jwjUGK9pfq8E14cLNhfd5qyKJql
         rp8A==
X-Gm-Message-State: AOUpUlGFWT3O7dzHiWKZU9rx7RrwFzG/1nqm7vzGonjZM23KEbpuHJth
        OJ15SxOd/BG0NFftQT3wKNkQAAdBmIw=
X-Google-Smtp-Source: AAOMgpfAVaJkBvptWlNFjLnZkVd9nSMMHIvoOtbZn1+ZivjstAOVstnZ+uADT2kKRA34zf6iubgXaw==
X-Received: by 2002:a63:dc17:: with SMTP id s23-v6mr3479912pgg.40.1531426644523;
        Thu, 12 Jul 2018 13:17:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id e7-v6sm22647000pgc.55.2018.07.12.13.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 13:17:23 -0700 (PDT)
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
Subject: [GIT PULL][PATCH 0/2] Few timekeeping items for 4.19
Date:   Thu, 12 Jul 2018 13:17:19 -0700
Message-Id: <1531426641-20076-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,
  I had a few other items in my stack here, but you've already
queued them in -tip, so here's what I have left.

Let me know if you have any objections or feedback for change.

thanks
-john

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  https://git.linaro.org/people/john.stultz/linux.git fortglx/4.19/time

for you to fetch changes up to b061c7a513afe14a68af41cec7c3476befc40e95:

  timekeeping: Update multiplier when NTP frequency is set directly (2018-07-10 12:44:25 -0700)

----------------------------------------------------------------
John Stultz (1):
      selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock adjustments are in progress

Miroslav Lichvar (1):
      timekeeping: Update multiplier when NTP frequency is set directly

 kernel/time/timekeeping.c                 | 36 ++++++++++++++++++++++++++++++------
 tools/testing/selftests/timers/raw_skew.c |  5 +++++
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.7.4

