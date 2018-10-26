Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73084ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355872085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/X9RT3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355872085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJ0At1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:49:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45298 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeJ0At0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:49:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id n5-v6so1892488wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xZLGzItrNY60hRMRPsxMSW2P9j1uarxjBp9l3h8QUOc=;
        b=a/X9RT3J1PQGNgGNpx3ULDGjLpR9uvVqsMWOxIGl286KTq68eN+CExiIvIwsJnT7D8
         ZnWMJpbEuA6k220KyKoztV2+Vd3eHPlzay353xPmUng1LIx/uD/WewLJTwB0Ze6VKN6C
         YgumiXhEtzNIJAi02akhFhD9E/GnWjwnwdcMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xZLGzItrNY60hRMRPsxMSW2P9j1uarxjBp9l3h8QUOc=;
        b=Hip7fzMWN3ltLkIOOaUW9UWVhZEbuo6g0rGQc8I24cWQg7tIp7p0I/zCGjzqiwT+ze
         JHb2277OnE8i7lznzhJvvn8hCqtasYYdoKuLiE+xeHceNLJ4U5/tmjig86MaotWj+LMK
         YCLBET+oSP08WGr8zbo/GXEAvJ0GRPeMT46ZIj0vSarovoaR9Wlil+ktxd2JBC8uyzM2
         8tDwCy9pGmWRn1reFwWl/0vttKWp0MiO0x8+Ybre0j3gOA5SlZedyBEdSqlDQLQFlioZ
         TXl7lxz6AcyDRzVCM5dfAn9+PHHUjY4t+jHdkSv7Kr9b/GmFTQnSIzjkhU8MLQluGiz1
         o/hw==
X-Gm-Message-State: AGRZ1gLzNEt+yjZ2gFv2PoC6aNc/ceTjwzAIKS94onWmqL4lZJbdE9Rx
        Y6PwFEWyW2wxZRYT+ZGTIGWoDg==
X-Google-Smtp-Source: AJdET5dYOhH2WHK2xBXBP0Xh5wKciH5Y52Li0ZQXfQ8ANwcao4oJsO2DyvIZVh86pMEGrpgsfr+bZg==
X-Received: by 2002:adf:c650:: with SMTP id u16-v6mr6790713wrg.177.1540570307221;
        Fri, 26 Oct 2018 09:11:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d30:71a0:24b4:1c25])
        by smtp.gmail.com with ESMTPSA id y16-v6sm11807209wru.18.2018.10.26.09.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 09:11:46 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 0/2] sched/fair: update scale invariance of PELT
Date:   Fri, 26 Oct 2018 18:11:41 +0200
Message-Id: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version of the scale invariance patchset adds an important change
compare to v3 and before. It still scales the time to reflect the
amount of work that has been done during the elapsed running time but this is
now done at rq level instead of per entity and rt/dl/cfs_rq. The main
advantage is that it is done once per clock update and we don't need to
maintain per sched_avg's stolen_idle_time anymore. This also ensure that
all pelt signals will be always synced for a rq.

The 1st patch makes available rq_of() helper function for pelt.c file and
the 2nd patch implements the new scaling algorithm

Changes since v4:
- Fix compile issue for !SMP raised by kbuild test robot
- Fix lost_idle_time update raised by Pavan

Vincent Guittot (2):
  sched/fair: move rq_of helper function
  sched/fair: update scale invariance of PELT

 kernel/sched/core.c     |   1 +
 kernel/sched/deadline.c |   6 +--
 kernel/sched/fair.c     |  38 +++++++----------
 kernel/sched/pelt.c     |  23 +++++-----
 kernel/sched/pelt.h     | 109 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/rt.c       |   6 +--
 kernel/sched/sched.h    |  21 +++++++++-
 7 files changed, 164 insertions(+), 40 deletions(-)

-- 
2.7.4

