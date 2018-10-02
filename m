Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8131FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358F92089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MY6ZGRst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358F92089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJBOIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:08:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43316 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeJBOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:08:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so904515wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zCOGKkiQ659Kw4o2nk/148y0ablusiiavTsW2zxuHvg=;
        b=MY6ZGRstzq3ZvIWN+cnHXAWUkg408mcmcwrZT71tLjh+xPCmVum1y84+VxfkxzdYxq
         fFvt0ecYNSEx9jkYKDUxufwstqzns23tUxFtTaMSh1upqvkj1q6rW8o7m7hlfrveHQX3
         9BHSaOfiVuSYEjsLY1omepBNUSF7fd/YNGZ2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zCOGKkiQ659Kw4o2nk/148y0ablusiiavTsW2zxuHvg=;
        b=pOwRhXdF6UzlEj6hqt6/Wp882SX3hr7yKztaOWVPwTK61iM/B49zDtgzWkYttydtdQ
         OCZtqrkMpLplX4MbYm4aUl6m+RkGOwB7RJEv8kLqV2+0ZpOgd46qHNSMUwIEazZOeOvL
         NYpxDPZ2837jz8dMVXBpdkyc4pn7qnLgG9SdQQujT+96YofJdzn9Tkrsrc+fnNqDo2fw
         M506qwrcYVo1xLJXSVWa5Kls7dv9Atuvlv4r2uy9cpApS8qEdyXYhyZKhOoebTs+gXdB
         yddEJ2uE2Z1uTxjifZv5qx6ARG9mhgexapEYL6013l5iE2tPNi7wm+x1bjReDfkmdV6b
         Yojg==
X-Gm-Message-State: ABuFfoh0OVsfuO+TrzZuYiEaxMA1LPr8MjldX+L394wDquTtoIqWwRSb
        Kjf82AwrxlfD4zhDbLYPA0riiw==
X-Google-Smtp-Source: ACcGV61LLch9xYXmbasvuB5lz+OrNUPyT2W0VW8kN+Ril7mieho6rBcim2j+TFXd2flo/uR6MdvYcg==
X-Received: by 2002:adf:9b19:: with SMTP id b25-v6mr4354936wrc.35.1538465215458;
        Tue, 02 Oct 2018 00:26:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:99b3:4272:8254:6430])
        by smtp.gmail.com with ESMTPSA id t24-v6sm3550552wra.5.2018.10.02.00.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Oct 2018 00:26:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RESEND PATCH 0/3] sched/fair: some fixes for asym_packing
Date:   Tue,  2 Oct 2018 09:26:36 +0200
Message-Id: <1538465199-20176-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the review of misfit task patchset, Morten and Valentin raised some
problems with the use of SD_ASYM_PACKING flag on asymmetric system like
hikey960 arm64 big/LITTLE platform. The study of the use cases has shown
some problems that can happen for every systems that use the flag.

The 3 patches fixes the problems raised for lmbench and the rt-app UC that
creates 2 tasks that start as small tasks and then become suddenly always
running tasks. (I can provide the rt-app json is needed)

- Rebase on latest tip/sched/core

Vincent Guittot (3):
  sched/fair: fix rounding issue for asym packing
  sched/fair: trigger asym_packing during idle load balance
  sched/fair: fix unnecessary increase of balance interval

 kernel/sched/fair.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

-- 
2.7.4

