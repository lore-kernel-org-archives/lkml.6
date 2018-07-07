Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45BFC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D46B21D63
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB56Jr4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D46B21D63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbeGGFnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:43:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44839 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeGGFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:43:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so9983207pfh.11;
        Fri, 06 Jul 2018 22:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lU8l19jbAB1FXk8mEaIUz+/z2fNgoF/kyMSqYlK2r28=;
        b=bB56Jr4G/hvn+xx8TPs9Neqr/0Efq6FDIti0xSZOUvO8UJq1HdbDvYaFH8ltd7U+GF
         2+wfQlsZ3oB31M/iQuPxhDOqAZD3dQBnHSi+7AJP2T2ldExRzBLhMAGp6J5cJMSe5FTw
         Yn72xW6Ub536N8Mx2w87yxkiHV3WOousPwQZR4Oah+AcBf/SOxE7xQPDAHHhe/Bq9hhP
         h4EWJ1Kri8JHnWSTH5fDWVSqyraujg+GUeaePeZyQfljmmKaZRx4CBhQVHwr/0z4CbcQ
         kqjk3s7UidzWkKkxEoViDnh0TlX6rJoN5Wo8EXPSJfRf8sgeO1XHfRR5XLh4jwR39uh0
         Myyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lU8l19jbAB1FXk8mEaIUz+/z2fNgoF/kyMSqYlK2r28=;
        b=oeP1N8rPXzCEF6mNUCu4h0qJCLD2iyqTAiwoq118NqR0DPQ+2SNndqg0AcgMO2BR93
         8obo+DnN4mkNmj8j+9n80Y9SmDwp81nswU8XiYAsSyT9Bm8FgiRU48lko+yXKy86yz+g
         6gsEMWUAijSsUTjrNJJlG55p09ORe4947lb4THUDXaoy06RjlFJMKxKnrbtwnUTpJkR1
         xxjHHIeUzAgbe7hO8mZFjRtVTw671gEEC5KpiolGCehNN9bHZ9+qc1/jCmnxq6SXrUJ4
         vXVYXmNBmXUlhnks0tM/7difISgi2Ab50/c8ZGDYmn51hf6BDuSsVPCShG1KMgQbnmv+
         N3Xg==
X-Gm-Message-State: APt69E2uBikZ0oVGFf8ibqlSMShN32S6YCM+jzqF0XEznCkbD4ZKLtS6
        Hv4kZT0irzpUHSZS2LiNyHY=
X-Google-Smtp-Source: AAOMgpd7wzzB4a5YgZgvT98CX1OeDRRQe0K56ts3/cVkwqFvBIyFc+l1LjGUXskkb2UcdK185QSv+Q==
X-Received: by 2002:a62:d444:: with SMTP id u4-v6mr13244040pfl.142.1530942200554;
        Fri, 06 Jul 2018 22:43:20 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id t192-v6sm16505083pgc.74.2018.07.06.22.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 22:43:19 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, catalin.marinas@arm.com,
        davem@davemloft.net, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        palmer@sifive.com
Subject: [PATCH v3 0/7] Introduce struct __kernel_timex
Date:   Fri,  6 Jul 2018 22:42:40 -0700
Message-Id: <20180707054247.19802-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series introduces struct __kernel_timex as a substitute for
the non y2038 safe struct timex.

The series is based on the original series posted by Arnd Bergmann
in [1].

The overview of the series is as below:
1. Prepare for the compat timex interfaces to be used unconditionally.
2. Introduce struct __kernel_timex.
3. Use struct __kernel_timex in place of struct timex.
4. Switch syscalls to use struct __kernel_timex.

[1] https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html

Changes since v2:
* Use only generic compat.h for riscv
Changes since v1:
* Fix riscv asm/compat.h to pick up generic compat types

Deepa Dinamani (7):
  arm64: Make basic compat_* types always available
  sparc: Make thread_info.h available directly
  riscv: Delete asm/compat.h
  timex: prepare compat helpers for y2038 changes
  time: Add struct __kernel_timex
  timex: use __kernel_timex internally
  timex: change syscalls to use struct __kernel_timex

 arch/alpha/kernel/osf_sys.c     |  2 +-
 arch/arm64/include/asm/compat.h | 22 ++++-----
 arch/riscv/include/asm/Kbuild   |  1 +
 arch/riscv/include/asm/compat.h | 29 ------------
 arch/sparc/include/asm/compat.h |  2 +
 drivers/ptp/ptp_clock.c         |  2 +-
 include/asm-generic/compat.h    |  8 +++-
 include/linux/compat.h          | 33 --------------
 include/linux/compat_time.h     | 34 ++++++++++++++
 include/linux/posix-clock.h     |  2 +-
 include/linux/syscalls.h        |  5 +--
 include/linux/timex.h           |  9 +++-
 include/uapi/linux/timex.h      | 41 +++++++++++++++++
 kernel/compat.c                 | 63 --------------------------
 kernel/time/ntp.c               | 12 ++---
 kernel/time/ntp_internal.h      |  2 +-
 kernel/time/posix-clock.c       |  2 +-
 kernel/time/posix-timers.c      | 14 ++----
 kernel/time/posix-timers.h      |  2 +-
 kernel/time/time.c              | 80 ++++++++++++++++++++++++++++++---
 kernel/time/timekeeping.c       |  4 +-
 21 files changed, 199 insertions(+), 170 deletions(-)
 delete mode 100644 arch/riscv/include/asm/compat.h


base-commit: 526674536360a4c508e84f67314c2028e45e1bf2
-- 
2.17.1

Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: netdev@vger.kernel.org
Cc: palmer@sifive.com
