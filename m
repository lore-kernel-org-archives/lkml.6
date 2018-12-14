Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5790E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5RiXlt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeLNQCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:02:06 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46996 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLNQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:02:06 -0500
Received: by mail-wr1-f44.google.com with SMTP id l9so5887785wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e530nD7gwvUnOppPhQyUEPqE/LtJtCijcR/KUXEQhpc=;
        b=H5RiXlt/iHuhYtBKqye/p4f/ISScuUKtr26h5XlFMa+eRaFjbCYQc1yx455DN7U6k+
         /dw2pBmmQWHIphwfMJn+wWQawuKkuE502cw7qqPUpgrQIoXek6SkhiUZTJ2ULXuepPx9
         RNSrkq0VlU68EvbL0wH0kKe842N9l+mwDL3NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e530nD7gwvUnOppPhQyUEPqE/LtJtCijcR/KUXEQhpc=;
        b=bnVl5uMjIx8MoeCalrdztUWS3RC1Fn6cVg3Xsy+QGa0JRBBY4YY29l8PDoOVI1HCqC
         E7owqe2NxiIYDl7y/BNHcrNG6yDkvqbMW4KskR+CDVPXrMrri8gTCd+0HtbYl8DDcj18
         hb9+UCxaYvRHygJ4bxoKVsbT8GKTtZVYjFPxiD7xqnU4pUz3I0H/Ddl7Txna/QBSGcMy
         o4CwkAm3eMU7cIGHTr/GRqQQmwKXmhARayGdO8wZKjdqLOJHCJVRKQnLysaIT3k43MSR
         qcVwE0qSHfEtF9BFi7qmTUmy/iSOP9BlXZyKYaLXzykMm4ZmQlU2eb7hjhOm7FaKPqoq
         xCdQ==
X-Gm-Message-State: AA+aEWb/XTexWMS1mvwOSbbt2jATBRSAmADReicBRNYNYAKZJCqSWPtb
        u64SHztk3Yq4lh+1TKH2kfMC+Q==
X-Google-Smtp-Source: AFSGD/VyO7BL0ts3aaBmsCHgHWp0sjb2vCc0dRvU+pBmYqw3PNIkxnyND47WoAOPaP/24x3SfQ0bSQ==
X-Received: by 2002:adf:94e4:: with SMTP id 91mr3264651wrr.322.1544803324102;
        Fri, 14 Dec 2018 08:02:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ed2e:a6ad:f6ef:ff8e])
        by smtp.gmail.com with ESMTPSA id e17sm7888738wri.36.2018.12.14.08.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 08:02:03 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/3] sched/fair: some fixes for asym_packing
Date:   Fri, 14 Dec 2018 17:01:54 +0100
Message-Id: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the review of misfit task patchset, Morten and Valentin raised some
problems with the use of SD_ASYM_PACKING flag on asymetric system like
hikey960 arm64 big/LITTLE platform. The study of the use cases has shown
some problems that can happen for every systems that use the flag.

The 3 patches fixes the problems raised for lmbench and the rt-app UC that
creates 2 tasks that start as small tasks and then become suddenly always
running tasks. (I can provide the rt-app json if needed)

Changes since v1:
- rebase on tip/sched/core
- changes asym_active_balance() as suggested by Peter

Vincent Guittot (3):
  sched/fair: fix rounding issue for asym packing
  sched/fair: trigger asym_packing during idle load balance
  sched/fair: fix unnecessary increase of balance interval

 kernel/sched/fair.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

-- 
2.7.4

