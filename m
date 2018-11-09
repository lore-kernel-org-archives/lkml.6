Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E6C20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTwqaPx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E6C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeKJCCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:02:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44715 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJCCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:02:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so2476222wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZqlLsfgmEvuq/LnRN/D1OpMmiH4ixxwkmF58HlpPpX4=;
        b=QTwqaPx2ZE3v0HnmOEHedXU9HomomcxdFfBA9sc+Ug3AUwpt3XQk88/+RPt0IMiwFK
         j2HmaGHZNVniIGCgspyP3nt5y5wgjNAPepEYiz7jYVJF8xGUlG6bdwfQUeAXwmpAM88q
         eeJ7NOLxWiahehFtW3QHL/KO7ZLj61pLLX6Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZqlLsfgmEvuq/LnRN/D1OpMmiH4ixxwkmF58HlpPpX4=;
        b=pav9FiLNCX6m5TWx9BanDBFNZcjbH8WgKHVtJjwSfxWyaZJEj4G93RzdLJydCxzp6k
         sm1XHnRzMP+fyVx6FldBWAtrDhAs1SwJ38Ll2FYYl/s4T9Bn11gfHYFTpn7d8oA5TCIu
         jnYFuaY7uxgR8GYYp8suoLgavUkDQOeIx54UPK3LNHfG5a1oaUE3vkoo/8EZd51n57CV
         cYbALTlZkTv3Eqv1AA+fadUgahivIppLisMKtTiBJVtguNG8P7ruXBZO2edGOUpWhGhr
         jmOqMuAaYLknps9XfX0YfT0QmeoEL4YuLEoBVpz3GXWuL2/ULuKdHxqfLuEm4b4NZcxy
         +HPw==
X-Gm-Message-State: AGRZ1gIuOnjcSR/BP4Y6GSi1GQSq9vlHz5cjoRCk4kaCNyeQwf5NgOaq
        bShrdeB0Pk8DSeNEu38u8d75Lw==
X-Google-Smtp-Source: AJdET5e+YILJrGOZtmVWFnQEd32j5An22JPOXn91vv2wGqV0o03o5m3GpGpZZdDgXhJ0ouoJCDaxvw==
X-Received: by 2002:adf:eb0b:: with SMTP id s11-v6mr8385726wrn.102.1541780466845;
        Fri, 09 Nov 2018 08:21:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:30de:f495:80da:cbe6])
        by smtp.gmail.com with ESMTPSA id y195-v6sm1970509wme.22.2018.11.09.08.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 08:21:06 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 0/2] sched/fair: update scale invariance of PELT
Date:   Fri,  9 Nov 2018 17:20:52 +0100
Message-Id: <1541780454-9934-1-git-send-email-vincent.guittot@linaro.org>
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
maintain per sched_avg's stolen_idle_time anymore. This also ensures that
all pelt signals will be always synced for a rq.

The 1st patch makes available rq_of() helper function for pelt.c file and
the 2nd patch implements the new scaling algorithm

Changes since v5:
- Fix running_sum scaling in update_tg_cfs_runnable() raised by Dietmar
- Remove unused cpu parameters raised by Dietmar

Vincent Guittot (2):
  sched/fair: move rq_of helper function
  sched/fair: update scale invariance of PELT

 kernel/sched/core.c     |   1 +
 kernel/sched/deadline.c |   6 +--
 kernel/sched/fair.c     |  56 ++++++++++-------------
 kernel/sched/pelt.c     |  45 ++++++++++---------
 kernel/sched/pelt.h     | 115 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c       |   6 +--
 kernel/sched/sched.h    |  21 ++++++++-
 7 files changed, 187 insertions(+), 63 deletions(-)

-- 
2.7.4

