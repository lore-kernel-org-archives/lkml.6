Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0889A21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0889A21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeHTPyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:54:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52464 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeHTPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:54:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so14063491wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SVkHq9VR9hc1OdQdOmdz5cFUDDthkVfmANrWwQ22oag=;
        b=ICrX0/jl5hG3ME6iphPd1n58lfFTJ7JaYebwymyFurcybaUGusN4N+N1IcD6+C3ELc
         TO/lIn3NQv85Ik4uVq3N7slrfBebHVay0jMszvk1RjqVV3Rf9ShOq3wYRaf89cJEgjrk
         J5pAtQOh2VIqpk65lR8smXw6D3QGmZKevGvLPaQx/PF3bkxD/Z1VAm2oXUjeLlWSzpF8
         TFUBpIWEsHehM/s0eMb0R+M9RtV4hEDB8TS8grr87ob6u9QbtDnxouGDMZJsoqAhWnla
         U5MUpl3piNYCjp/L3jPhtOKbh6n9k1759dlTZ/UsIslA6MpQyScICwCMlqdRLZfDxCrO
         j6vQ==
X-Gm-Message-State: APzg51DGJyv2lc4lTY5SMD/MaeebeKS0LxsGxsvwSfV/sQNZZBSY4+kr
        bdDDH3AlkzR660TF1gdpOkLGUA==
X-Google-Smtp-Source: AA+uWPxWIiwUw2x3EZVn7JZncS9HLqGT13GCbN9Nxeu3MweFWKCKj2Xw/6qnOQg1Vfq6iB4yVZRi6A==
X-Received: by 2002:a1c:a5c9:: with SMTP id o192-v6mr971506wme.3.1534768718813;
        Mon, 20 Aug 2018 05:38:38 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v2-v6sm496917wme.36.2018.08.20.05.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 05:38:38 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
Date:   Mon, 20 Aug 2018 14:38:16 +0200
Message-Id: <20180820123818.27547-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patchset implements more detailed auditing of the adjtimex(2)
syscall in order to make it possible to:
  a) distinguish modifying vs. read-only calls in the audit log
  b) reconstruct from the audit log what changes were made and how they
     have influenced the system clock

The main motivation is to be able to detect an adversary that tries to
confuse the audit timestamps by changing system time via adjtimex(2),
but at the same time avoid flooding the audit log with records of benign
read-only adjtimex(2) calls.

@John or other timekeeping/NTP folks: We had a discussion on the audit
ML on which of the internal timekeeping/NTP variables we should actually
log changes for. We are only interested in variables that can (directly
or indirectly) cause noticeable changes to the system clock, but since we
have only limited understanding of the NTP code, we would like to ask
you for advice on which variables are security relevant.

Right now, the patchset is conservative and logs all changes that can be
done via adjtimex(2):
  - direct injection of timekeeping offset (obviously relevant)
  - adjustment of timekeeping's TAI offset
  - NTP value adjustments:
    - time_offset (probably important)
    - time_freq (maybe not important?)
    - time_status (likely important, can cause leap second injection)
    - time_maxerror (maybe not important?)
    - time_esterror (maybe not important?)
    - time_constant (???)
    - time_adjust (sounds important)
    - tick_usec (???)

Could you please give us some hints on the effect of changing these
variables and whether you think that it is important to log their
changes?

Thanks a lot!


GitHub issue: https://github.com/linux-audit/audit-kernel/issues/10

Changes in v4:
  - Squashed first two patches into one
  - Rename ADJNTPVAL's "type" field to "op" to align with audit record
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

 include/linux/audit.h      | 21 ++++++++++++++++
 include/uapi/linux/audit.h |  2 ++
 kernel/auditsc.c           | 15 ++++++++++++
 kernel/time/ntp.c          | 50 ++++++++++++++++++++++++++++++--------
 kernel/time/timekeeping.c  |  3 +++
 5 files changed, 81 insertions(+), 10 deletions(-)

-- 
2.17.1

