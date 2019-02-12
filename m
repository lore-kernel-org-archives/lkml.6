Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76378C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BD3222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn+M+rKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfBLSsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:48:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38091 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbfBLSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:48:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so1657282pgc.5;
        Tue, 12 Feb 2019 10:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWGHS0HB/IdFaeAQoniHbSqiZouP2ij0+nadyVRJHuw=;
        b=hn+M+rKHk/B9riCjbQvrkhq0jX9PZXMaiK9rn5hF9JTDEe7plBrbjjIB3ozawNdSoG
         j93xpSazF1a1TAKMqeH2Jk+VS7kIdVd0ymKdXShpe7gT4Plu+VW8CPMtcYvHx/GY0GFp
         xqr/OYwnPmhHpdV6VVTelE5DjrFgpe2tOdduSvnlVbDtQz/UzpT3cvNeBz90E+qYJLoz
         tWQIucQt0WSMmsUJCakyAmhcyQD7F/e7obDaYJuGI3RYL7uyl9jzyrFcVapWiB8WrnSi
         wtzHlG5t0rpa1QnvVQ6GrcS2QtL7HEwGQOd0FqrBD350P9isBt1E4uiKUhc957BbOqMX
         ygRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWGHS0HB/IdFaeAQoniHbSqiZouP2ij0+nadyVRJHuw=;
        b=lDU+hVBCpYO/Y0yiKaeb9jq/PBvrrjcYL9xRAtk/jkhw6rrH6UcbxDHSZYvfdvhzY1
         4AO7+emnF4dEa4+bN438jm9TTGvyC9Bus+3tfXIDCBCJZRzHePGhwcgEKNwLeb8WPFvA
         bewwvxt8b/u6fyrE9he4VatdSnmMIXSSE3+mfxcK76hft4SlmXlWFyHHytleAej12n9r
         q7epa3ghO5TXPN594fUJxvsu9SEuhEoHbc1SsC9FGoPOtZyjXrf8/GPzOKFYBakH9Z9F
         xExgSlbkQPtyAirwtjfZGd/bZ/lB1TZpb4fQETBY5lBWUk8b2Q4qPmst1sHlPl8myqur
         jn7w==
X-Gm-Message-State: AHQUAubzpTpjw8k3pQtG1bSLuxf+6o4ijiNdAfL8O82rG61+pW0/fVZq
        ISAbNBHfU8O+eiEfl176Zra/i6RXhd8=
X-Google-Smtp-Source: AHgI3IaRVf7VbpW8cAxPZ/FksyU98cQW6+DlUKahlb/B8sggBQ4RZe5igTZR9EcuM6lYiu6Unn2LKA==
X-Received: by 2002:aa7:854d:: with SMTP id y13mr5272107pfn.175.1549997296357;
        Tue, 12 Feb 2019 10:48:16 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id f67sm25480102pfc.141.2019.02.12.10.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:48:15 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 0/7] freezer for cgroup v2
Date:   Tue, 12 Feb 2019 10:48:00 -0800
Message-Id: <20190212184807.20304-1-guro@fb.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements freezer for cgroup v2.

It provides similar functionality as v1 freezer, but the interface
conforms to the cgroup v2 interface design principles, and it
provides a better user experience: tasks can be killed, ptrace works,
there is no separate controller, which has to be enabled, etc.

Patches (1), (2) and (3) are some preparational work, patch (4) contains
the implementation, patch (5) is a small cgroup kselftest fix,
patch (6) covers freezer adds 6 new kselftests to cover the freezer
functionality. Patch (7) adds corresponding docs.

v7->v6:
  - handle properly the case, when a task is both stopped and frozen
  - check for CGRP_FREEZE instead of CGRP_FROZEN in cgroup_exit()
  - minor cosmetic changes and rebase

v6->v5:
  - reverted to clear TIF_SIGPENDING with additional checks before schedule(),
  as proposed by Oleg Nesterov
  - made cgroup v2 freezer working with the system freezer (by using
  freezable_schedule())
  - make freezer working with SIGSTOPped and PTRACEd tasks
  - added tests to cover freezing a cgroup with SIGSTOPped and PTRACEd tasks

v5->v4:
  - rewored cgroup state transition code (suggested by Tejun Heo)
  - look at JOBCTL_TRAP_FREEZE instead of task->frozen in
    recalc_sigpending(), check for task->frozen and JOBCTL_TRAP_FREEZE
    in signal_pending_state() (suggested by Oleg Nesterov)
  - some cosmetic changes in signal.c (suggested by Oleg Nesterov)
  - cleaned up comments

v4->v3:
  - reading nr_descendants doesn't require taking css_set_lock anymore
  - fixed docs based on Mike Rapoport's feedback
  - fixed double irq lock found by Dan Carpenter

v3->v2:
  - dropped TASK_FROZEN for now, frozen tasks are put into TASK_INTERRUPTIBLE
  state; it's probably not the final version, but the API question can be
  discussed separately
  - don't clear TIF_SIGPENDING before going to sleep, instead add
  task->frozen check in signal_pending_state() and recalc_sigpending()
  - cgroup-level counter are now synchronized using css_set_lock,
  which simplified the whole code (e.g. per-cgroup works were removed)
  - the amount of comments increased significantly
  - many other improvements incorporating feedback from Tejun and Oleg

v2->v1:
  - fixed locking aroung calling cgroup_freezer_leave()
  - added docs

Roman Gushchin (7):
  cgroup: rename freezer.c into legacy_freezer.c
  cgroup: implement __cgroup_task_count() helper
  cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
  cgroup: cgroup v2 freezer
  kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
  kselftests: cgroup: add freezer controller self-tests
  cgroup: document cgroup v2 freezer interface

 Documentation/admin-guide/cgroup-v2.rst       |  27 +
 include/linux/cgroup-defs.h                   |  39 +
 include/linux/cgroup.h                        |  46 +
 include/linux/sched.h                         |   4 +
 include/linux/sched/jobctl.h                  |   2 +
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   1 +
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 145 ++-
 kernel/cgroup/freezer.c                       | 652 ++++++--------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++
 kernel/signal.c                               |  93 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 +-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 842 ++++++++++++++++++
 17 files changed, 2016 insertions(+), 431 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.20.1

