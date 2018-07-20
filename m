Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424B9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE1620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNDK6PHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE1620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeGTBYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:24:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38424 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTBYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:24:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so5233780pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lN+BQizDiaU/xxsUxNcuZqX2DHX+3x/hV4He9YMUa6A=;
        b=UNDK6PHrDe8ufw/XyW5sfZ9fAOoaC/KbyrJSVamWEGE4p23Kc7J1JOGvRnuiTSqwjd
         zEv0R989yfIWqwfSZ/VYSvMr4duiGisKZxFWIazJyp+jhpG4aBNUPjCJEoqtVTFUCedr
         CaQztW8K4A0+Bzy6ZmG4HJYycdK+9mD6o5aVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lN+BQizDiaU/xxsUxNcuZqX2DHX+3x/hV4He9YMUa6A=;
        b=agvlQQsjsBm0Fa5RwtBbkdff+d4unzXIY7XEAy0+PxFgwSLbe3MrKOiB3i/8jmDg9U
         pzHUzAfMHFYxZT6AyH8B9yJLxfQdUYxWkeWyhRcwCGPQPeFKmcIe6aofQBWeasO2eJlQ
         UwSf+efS7HENg0ZPdrr7ni2sdlhAKVGhoIZtTIl4DJpdGnQGi/y9tJaBOVNj4RFvWf4g
         4VB7hJ4sAtcxHa1CBJt1/GBzDGCh5d52+tKwakNMdweDrduXJYolJGkzhaO71kINsZ7R
         diEFkElmiTtHRInQnqG/Tw5q+/Imx/dFf3Vfu7YGzE1GO9/djqzn3YHxf2WePoNb/5PC
         BcBQ==
X-Gm-Message-State: AOUpUlGIggusLl3Xv59jCMCQdYNKiLGePl/C3hgdYJr0MVnL/tIoKcQc
        UEvSBJR8G42oaDNScqK83gQadKqyIQs=
X-Google-Smtp-Source: AAOMgpfV+2Q4pjp3t8UWh5ery7qNTFbrqQ4PggHDKtJd1beGwySQBtqqa2/aei2zwOPoq0CR6eUX8g==
X-Received: by 2002:a63:cd02:: with SMTP id i2-v6mr11733019pgg.93.1532047132766;
        Thu, 19 Jul 2018 17:38:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id x5-v6sm383881pfh.67.2018.07.19.17.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 17:38:51 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL][PATCH 0/5] A few more timekeeping items for 4.19
Date:   Thu, 19 Jul 2018 17:38:42 -0700
Message-Id: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c6bb11147eb09bd39f316c6062455b88c905ab6e:

  Merge branch 'fortglx/4.19/time' of https://git.linaro.org/people/john.stultz/linux into timers/core (2018-07-12 22:19:58 +0200)

are available in the git repository at:

  https://git.linaro.org/people/john.stultz/linux.git tags/fortglx/4.19/time-part2

for you to fetch changes up to 39232ed5a1793f67b11430c43ed8a9ed6e96c6eb:

  time: Introduce one suspend clocksource to compensate the suspend time (2018-07-19 17:08:52 -0700)

----------------------------------------------------------------
Just a second set of timekeeping things for 4.19

* NTP argument clenaups and constification from Ondrej Mosnacek
* Fix to avoid RTC injecting sleeptime when suspend fails from
  Mukesh Ojha
* Broading suspsend-timing to include non-stop clocksources that
  aren't currently used for timekeeping from Baolin Wang


Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Baolin Wang <baolin.wang@linaro.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
----------------------------------------------------------------
Baolin Wang (1):
      time: Introduce one suspend clocksource to compensate the suspend time

Mukesh Ojha (1):
      time: Fix extra sleeptime injection when suspend fails

Ondrej Mosnacek (3):
      ntp: Remove redundant arguments
      ntp: Use kstrtos64 for s64 variable
      timekeeping/ntp: Constify some function arguments

 include/linux/clocksource.h        |   3 ++
 include/linux/timekeeping.h        |   2 +-
 kernel/time/clocksource.c          | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/time/ntp.c                  |  17 +++++------
 kernel/time/ntp_internal.h         |   4 +--
 kernel/time/timekeeping.c          |  83 +++++++++++++++++++++++++++++++++------------------
 kernel/time/timekeeping_debug.c    |   2 +-
 kernel/time/timekeeping_internal.h |   2 +-
 8 files changed, 218 insertions(+), 44 deletions(-)

-- 
2.7.4

