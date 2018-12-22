Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F69EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F033A21928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVhwF7dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404101AbeLVADL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:03:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36432 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLVADK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:03:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so3175271pgm.3;
        Fri, 21 Dec 2018 16:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sutVbmkRcHShCG3l/1vJqsHf/W2WwWTpZmygJ/DciHs=;
        b=gVhwF7dpNHrrapRzS9yIMgz2IprGlO/0UIeyAA0yk45Hx5KkkRLlweg/bTaCjgrJ4/
         lsSFqEK8Q56HZS/YhSukTOkAceSAn8gQ1F2ZMSViZ4sIYUIT38rA5/BVyi/sbY5O3ymB
         hC3vHSvreLagRTCLKLfra/zqN6Nj8kt8yeArYqT97YqzyYZVXHyIkl9hkIVIYkR8I7I3
         pAjdPuGXGG08yZnxwfAQymcLyjOmOkOZ3r+Yrc0Pma1y0s1ohhgkgXpKC9g8qKnbPjYF
         Ped7fzyyKRb51NabBfQUd8gyL7ckRGCMIiXj1egALoHqw6Way4X1LYVa3BpYAWRWSCW6
         KhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sutVbmkRcHShCG3l/1vJqsHf/W2WwWTpZmygJ/DciHs=;
        b=fQoSRZc5KOYVi/HIgT5JuPqHyyltjb3h9Otlo2rCmGsPfl+0h4DvkUnk4RXTUJhZQS
         EXzjKK41ftjeEt6/WeMIrYcxJerprMtkXcManF/xL15AooTqo+wA3xXuuOES9rfmkBVA
         Iq/ZdFszmcylND0SHZN2nOw0woHsMSwmYBa397wbyBl8MJ+MaEMBrwYq2CNogD0ktKkH
         izvQ5dsnkxRmocNnV1pqEoYM++wluWa6vo9pgH/jsGSCc/gyO1dzZz3U51usWLJfeHiR
         tssjh7BTM/wULMeDgMszWEyWAtbn8l8wgrDy1PCpEQ7bENrngh4clRnu9xmLh72FntMp
         73xQ==
X-Gm-Message-State: AJcUukctabfkF0p4ny6C2lCOCfZ+FXz3d+lRlIy7uo+d2v2GbjAXh0fd
        6WUKaJv0/Pb9SI3S0nSz0soKeMDUb3k=
X-Google-Smtp-Source: ALg8bN53+/AUSw6ZvxRzkSlg+TidOkTXY+0kYiemZ3Mbt0lu1Hq52J6+2JHWg5srnvXfFpuEtsTwmA==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr4289357pgs.448.1545436989693;
        Fri, 21 Dec 2018 16:03:09 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:608f])
        by smtp.gmail.com with ESMTPSA id 83sm36659266pgf.57.2018.12.21.16.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 16:03:08 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 0/7] freezer for cgroup v2
Date:   Fri, 21 Dec 2018 16:03:00 -0800
Message-Id: <20181222000307.28231-1-guro@fb.com>
X-Mailer: git-send-email 2.19.2
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
 kernel/cgroup/cgroup.c                        | 145 +++-
 kernel/cgroup/freezer.c                       | 650 ++++++--------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++
 kernel/signal.c                               |  93 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 +-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 821 ++++++++++++++++++
 17 files changed, 1993 insertions(+), 431 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.19.2

