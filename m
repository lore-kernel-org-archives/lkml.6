Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACEFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B278220838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B278220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJYQzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:55:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34200 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeJYQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:55:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so7626361eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r80qbszvU6jBT+csI7xjz9erJcqYEzjVONob5JYS1M=;
        b=QvBBBbtIfh4oYtMiT3pCQkPfHIdb4bNRCupA07zbFr0DK2N5eIQqCkuKR8e8HBTCLD
         NVCdEfnXC+JYK7y7X3+w97U1CymP9i5UwYCWytZdbjnD3DLPll/ejM01aXMJqn6mjCpZ
         HdRttASlp+BdvMDu6ClMuVbkFAPxRujZyfPEsAfl/wVz0QMyIj869TfFGrd9Xdb34ifp
         Q6hdqXhm7yOHlR+wj3Cdg49Bb/6ZUYVqh9v/cGOAd8mCNzD+WT70+fpGE2sm4m1lciCD
         b4J0b2B6c5X+mAtRYSFRCjGWKTgbar3TLM7EUqqK3amQfqZs5UAcOYeg63rSlktGuaB6
         POsw==
X-Gm-Message-State: AGRZ1gI/DnjjP2wkgw+eLdTLqJ1mhj+zVm//BK5y5QAz5qgWKsP9gr0m
        jW3lDEWYkXILmPtibyMiBrWSzz/B
X-Google-Smtp-Source: AJdET5fGcYKyZv8ex2yrOwj4TS8MCBfyJLYB62vWBp5fl5xOFbqzY28fUJCZStZa0CZ+iC8c1ECYdQ==
X-Received: by 2002:a17:906:66cd:: with SMTP id k13-v6mr628496ejp.152.1540455851270;
        Thu, 25 Oct 2018 01:24:11 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m24-v6sm2628277edd.31.2018.10.25.01.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 01:24:10 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/3] oom: rework oom_reaper vs. exit_mmap handoff
Date:   Thu, 25 Oct 2018 10:24:00 +0200
Message-Id: <20181025082403.3806-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of this RFC has been posted here [1]. I have fixed
few issues spotted during the review and by 0day bot. I have also reworked
patch 2 to be ratio rather than an absolute number based.

With this series applied the locking protocol between the oom_reaper and
the exit path is as follows.

All parts which cannot race should use the exclusive lock on the exit
path. Once the exit path has passed the moment when no blocking locks
are taken then it clears mm->mmap under the exclusive lock. oom_reaper
checks for this and sets MMF_OOM_SKIP only if the exit path is not guaranteed
to finish the job. This is patch 3 so see the changelog for all the details.

I would really appreciate if David could give this a try and see how
this behaves in workloads where the oom_reaper falls flat now. I have
been playing with sparsely allocated memory with a high pte/real memory
ratio and large mlocked processes and it worked reasonably well.

There is still some room for tuning here of course. We can change the
number of retries for the oom_reaper as well as the threshold when the
keep retrying.

Michal Hocko (3):
      mm, oom: rework mmap_exit vs. oom_reaper synchronization
      mm, oom: keep retrying the oom_reap operation as long as there is substantial memory left
      mm, oom: hand over MMF_OOM_SKIP to exit path if it is guranteed to finish

Diffstat:
 include/linux/oom.h |  2 --
 mm/internal.h       |  3 +++
 mm/memory.c         | 28 ++++++++++++++--------
 mm/mmap.c           | 69 +++++++++++++++++++++++++++++++++--------------------
 mm/oom_kill.c       | 45 ++++++++++++++++++++++++----------
 5 files changed, 97 insertions(+), 50 deletions(-)

[1] http://lkml.kernel.org/r/20180910125513.311-1-mhocko@kernel.org


