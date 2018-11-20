Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669EB20671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP9PgvIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669EB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeKTVXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:23:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36180 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeKTVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:23:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so1727108wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Awk9OeOCPWoy9xhc10bEldU/6swpjap+mlgEmdjB+l8=;
        b=SP9PgvIsJ69Mfqp4OLZLecWO8R84PkDHghLJuMRFX2Hkvwvu9Ya7jIOXqcvUOmzXHJ
         ASBRQOAkYXIOX2B3UaQdceRCK7hBqGDw/kAvmaY4Ii1K2rCtrx3deJbaT9yFdy9PLgDc
         vpOh5EJYquo8+nYab5Mw7IdrWmlcI8SHyTSJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Awk9OeOCPWoy9xhc10bEldU/6swpjap+mlgEmdjB+l8=;
        b=jOI+HjpSjBjsC0kDdKyWHI18Na29Q/u+/F7KraIpdM3+tv5uDcJ7glu0NDgspmYqGa
         4BElVl8WHzv1w3fDudvzPQqsQu9Fm6vto0cR+yPYC0r9pPIRkxzxQkLGSIJ+GIOWdZuG
         A/HLwoaPr0wt5gATKbgd8btfmDEaHfLBJ4blU365WK5g++ocMw0ROQyiHRkKOwolZ9Dw
         3phcJeoefu91B0m9795irVdN9aeCXGDyuWaEYt7zvNcwxMEFFcVuzd539lcTEfRgnZiL
         VeZLDguB6w05xRQvKhTTXTSZUfqLKQMrPfSo2vXm0Ly5dMJetFkkL1SMwywd/nc7/aVI
         GiRg==
X-Gm-Message-State: AGRZ1gLp9xuwoohmoZ91H4iE8Xj9xe4OUN2+flwYM8yH6BYOfmbEd32V
        +a3YmaD5Q/jZ+LPuxs8CrIJmrg==
X-Google-Smtp-Source: AJdET5dAiT3rrQsFD4Js7nN8w577gVxURk75oqtPzgD5bc51rn1YKx7VVhh/QY1G0pqi2N+Dj/RkyA==
X-Received: by 2002:a1c:930d:: with SMTP id v13-v6mr1769676wmd.26.1542711317617;
        Tue, 20 Nov 2018 02:55:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c511:7193:974b:48e6])
        by smtp.gmail.com with ESMTPSA id f192sm12170831wmd.12.2018.11.20.02.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 02:55:16 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 0/2] sched/fair: update scale invariance of PELT
Date:   Tue, 20 Nov 2018 11:55:06 +0100
Message-Id: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
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
- Fix niptick raised by Dietmar
- Upodated some comments
- Remove some unused variables
- No functional change

Vincent Guittot (2):
  sched/fair: move rq_of helper function
  sched/fair: update scale invariance of PELT

 include/linux/sched.h   |  23 +++-------
 kernel/sched/core.c     |   1 +
 kernel/sched/deadline.c |   6 +--
 kernel/sched/fair.c     |  58 +++++++++++--------------
 kernel/sched/pelt.c     |  45 +++++++++++---------
 kernel/sched/pelt.h     | 111 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c       |   6 +--
 kernel/sched/sched.h    |  21 ++++++++-
 8 files changed, 190 insertions(+), 81 deletions(-)

-- 
2.7.4

