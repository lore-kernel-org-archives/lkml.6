Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DBAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B02C2152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B02C2152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeHXPes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:34:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:34:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so7266538wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 05:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rn00d9pSBTeNospuZdDtkSkJmPixbEgdcpQRmMD9WGI=;
        b=CMiRL1Anuhr59hj5rYanUxP1OQEnXczb77rWBvfC/gGfioBanuGzLnZIRNFuoFEjPS
         iZsmMNrviuEzSmC+MQQmMlP1fxV55WJ6Gd/j97cQNf4L5xPbLGwOgzBOOkJSbLFweEhr
         K1xswArBZ3jHvOSXntje2jLUKxVYs7qS5JPvMVBc69vAu7+75OpNuGOkxJ6BUd8u1dgz
         6Bg28oPJW9E6MeN/Uo2jLab6DMWVjPt+S8wf1orDWPt0JhS7euQGhM9AVb7hU4AEz4/9
         70navZ7+Tik4imFCiwLdIRkGZrBLnzQZn66TsqS4eBQ0rz8JyVFiAD7HGWZcE5jZV8Ph
         cAEA==
X-Gm-Message-State: APzg51DWx0LHD063Il4BrkhKnmCQpnWT5roBkqV2mCR7WS38D5C9pLnN
        rhx1oghVlx2EQkJDDJCmS5qRCA==
X-Google-Smtp-Source: ANB0VdZxplvKbTdInXbqSGVmQzw3xYrCgZFMBf1cFACi3NeI3Ork+4HilO5j7Q74hRIhwvCAdsLSHg==
X-Received: by 2002:a5d:6984:: with SMTP id g4-v6mr983875wru.232.1535112026055;
        Fri, 24 Aug 2018 05:00:26 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r30-v6sm12318999wrc.90.2018.08.24.05.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 05:00:25 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH ghak10 v5 0/2] audit: Log modifying adjtimex(2) calls
Date:   Fri, 24 Aug 2018 13:59:59 +0200
Message-Id: <20180824120001.20771-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements more detailed auditing of the adjtimex(2)
syscall in order to make it possible to:
  a) distinguish modifying vs. read-only calls in the audit log
  b) reconstruct from the audit log what changes were made and how they
     have influenced the system clock

The main motivation is to be able to detect an adversary that tries to
confuse the audit timestamps by changing system time via adjtimex(2),
but at the same time avoid flooding the audit log with records of benign
read-only adjtimex(2) calls.

The current version of the patchset logs the following changes:
  - direct injection of timekeeping offset
  - adjustment of timekeeping's TAI offset
  - NTP value adjustments:
    - time_offset
    - time_freq
    - time_status
    - time_adjust
    - tick_usec

Changes to the following NTP values are not logged, as they are not
important for security:
  - time_maxerror
  - time_esterror
  - time_constant

Audit kernel GitHub issue: https://github.com/linux-audit/audit-kernel/issues/10

Changes in v5:
  - Dropped logging of some less important changes and update commit messages
  - No longer mark the patchset as RFC

v4: https://www.redhat.com/archives/linux-audit/2018-August/msg00023.html
Changes in v4:
  - Squashed first two patches into one
  - Renamed ADJNTPVAL's "type" field to "op" to align with audit record
    conventions
  - Minor commit message editing
  - Cc timekeeping/NTP people for feedback

v3: https://www.redhat.com/archives/linux-audit/2018-July/msg00001.html
Changes in v3:
  - Switched to separate records for each variable
  - Both old and new value is now reported for each change
  - Injecting offset is reported via a separate record (since this
    offset consists of two values and is added directly to the clock,
    i.e. it doesn't make sense to log old and new value)
  - Added example records produced by chronyd -q (see the commit message
    of the last patch)

v2: https://www.redhat.com/archives/linux-audit/2018-June/msg00114.html
Changes in v2:
  - The audit_adjtime() function has been modified to only log those
    fields that contain values that are actually used, resulting in more
    compact records.
  - The audit_adjtime() call has been moved to do_adjtimex() in
    timekeeping.c
  - Added an additional patch (for review) that simplifies the detection
    if the syscall is read-only.

v1: https://www.redhat.com/archives/linux-audit/2018-June/msg00095.html

Ondrej Mosnacek (2):
  audit: Add functions to log time adjustments
  timekeeping/ntp: Audit clock/NTP params adjustments

 include/linux/audit.h      | 21 +++++++++++++++++++++
 include/uapi/linux/audit.h |  2 ++
 kernel/auditsc.c           | 15 +++++++++++++++
 kernel/time/ntp.c          | 38 ++++++++++++++++++++++++++++++--------
 kernel/time/timekeeping.c  |  3 +++
 5 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.17.1

