Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEFECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C52720838
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GozLqqNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C52720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeJTAYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:24:44 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40205 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJTAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:24:44 -0400
Received: by mail-wm1-f45.google.com with SMTP id z204-v6so4234309wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NhdG7YCb6qRIRdvFuCcHZhGJGJjotp0H8yUCWfxRlJI=;
        b=GozLqqNv/9z1uK/CnkBbtTNO+IlSH5Sn4vJKaHwi7XZ87iAdZbKokpM1MiwM+BqLDO
         QTpQ+Ymb9hLQQXQTuBdfG3tAuOfplbjZL73sQmNZXYmvbU7aRQ//6vxUh0UPL0lQrE5N
         yPz7RkoZCxzn80hCylbWpmXkbbQsKceRTVCpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NhdG7YCb6qRIRdvFuCcHZhGJGJjotp0H8yUCWfxRlJI=;
        b=BI+oSdKyueKduvXSZv/PulUztMP67mFNju0iy7yh2OeqqeTKCZfH/IDORL1LVLhrzD
         C8tM/qslG9l+ONEeyh5UaiMUDayiMhzGNpM1GpI9Z9sxrgqMlaFVSIXzOCgXE8L1BA16
         8CEiOb5Krv8RqgM3nrxhsRP1jc7rI+wkHTs6qQIJ7lA3Z1URUMjmXJVVkEssVqGP1lr/
         kYpEa+r+N4uTujnb5y3sojETueJwOVIs9TEZOuHyJtJfzL0Ziv+eKtcBkILiWZiDUEBn
         30sRQuZBDGacm2wAr4vGJB15iyKxpMnRSHeDnfGwKESDF8npxEMqCbDe4nmvRoYE2qQG
         Wefg==
X-Gm-Message-State: ABuFfojN0Dsf2CBVHRzs7j+aOJk6gD1/FC5RfuYoIOHdzhD7MPROWgMx
        sOQWRmyj6VdvqHiYDnWTUTdY8K+nwwQ=
X-Google-Smtp-Source: ACcGV61ycZaxSCtfUJm0rY+ttmxRAvt7fY8t6I1EVj9aS5VcMO7HgvurzeEhLQu4VJ5lXuyE5jNZzA==
X-Received: by 2002:a1c:e102:: with SMTP id y2-v6mr5396190wmg.141.1539965875535;
        Fri, 19 Oct 2018 09:17:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9024:3180:921a:1e27])
        by smtp.gmail.com with ESMTPSA id n11-v6sm17009460wrx.17.2018.10.19.09.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 09:17:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/2]  sched/fair: update scale invariance of PELT
Date:   Fri, 19 Oct 2018 18:17:49 +0200
Message-Id: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 4th version of the scale invariance patchset adds an important change
compare to previous ones. It still scales the time to reflect the
amount of work that has been done during the elapsed running time but this is
now done at rq level instead of per entity and rt/dl/cfs_rq. The main
advantage is that it is done once per clock update and we don't need to
maintain per sched_avg's stolen_idle_time anymore. This also ensure that
all the pelt signal will be always synced for a rq.

The 1st patch makes available rq_of() helper function for pelt.c file and
the 2nd patch implements the new scaling algorithm

Vincent Guittot (2):
  sched/fair: move rq_of helper function
  sched/fair: update scale invariance of PELT

 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  6 ++--
 kernel/sched/fair.c     | 29 +++++-----------
 kernel/sched/pelt.c     | 88 ++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/pelt.h     | 27 +++++++++++++++
 kernel/sched/rt.c       |  6 ++--
 kernel/sched/sched.h    | 18 ++++++++++
 7 files changed, 139 insertions(+), 37 deletions(-)

-- 
2.7.4

