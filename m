Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94DAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5EA20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LU0yXyv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfAQRoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:44:17 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39766 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfAQRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:44:17 -0500
Received: by mail-wm1-f49.google.com with SMTP id y8so1960750wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kl5l1MDdpHP48KcUt76Pg8NpjsG1Gyf5PCi5NuzIyHQ=;
        b=LU0yXyv9Cgq313aAR8iFtilaL/zXEiKSVbZwNLYwofp4O8RlfQOWN9JuTyVcNtpXRL
         oPuziimXq6hz2ZgfdgVNtOILNIF1oEqlJHsSAQmcJ0LeDwXupDmeg0pidVytI/UiphyS
         S3ILLGh69TD3PM9ofShy6n4o278X9sPACWDkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kl5l1MDdpHP48KcUt76Pg8NpjsG1Gyf5PCi5NuzIyHQ=;
        b=CjhXuxWFi398mVN2uvNlmXVieXUyljL6ILV/HC7ThzxCGo3j2nfMNJvszlgOQDCrzG
         H9LXj1SSYmg483kgFElnAz8zFBUhgd5ay4aIrzFX6QlIbcuuxHjxqDHXB31RpiABYeIl
         veIFAiL4hvhdJyuC+mb1HKOPZC6r/acncx7oJVDyijGy/7WNk1fE/ldAkrx6xl9iAjj1
         KoW/WU9MAs+PTfNI69yJNmV04HPBIyXDXmZeIkiMhnRAxuGBVEbc4xTlAXijUvj0SUE9
         aRPVQfkX6HAcSXhDE1q67Ot0RgkHzZEWGuZKXnYxJFg9g1VerYRMXtv2wa12HwdhUYaE
         ChdA==
X-Gm-Message-State: AJcUuke5q+izpz0cJ1tpynctjqcVT5kN3SA0ZAwNOGYojryFhQP6Ktag
        PbgSVxipV2yXxFl+/2YuSQqa2g==
X-Google-Smtp-Source: ALg8bN6Z52BH9mOueA2lSMtyaWAspuU/FcxaUyy3Pdnt3dMouiLX3ZkDYArTPrxFVTnzcuDrMeGEcA==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr11994617wmd.29.1547747054831;
        Thu, 17 Jan 2019 09:44:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:8435:96d6:e03:9e78])
        by smtp.gmail.com with ESMTPSA id i186sm47583622wmd.19.2019.01.17.09.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 09:44:14 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/3]  sched/fair: some fixes for asym_packing
Date:   Thu, 17 Jan 2019 18:44:06 +0100
Message-Id: <1547747049-6320-1-git-send-email-vincent.guittot@linaro.org>
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
running tasks. (I can provide the rt-app json if needed)

Changes since v3:
- simplify imbalance computation 

Changes since v2:
- include other active balance reasons
- set imbalance to avg_load as suggested by Valentin

Changes since v1:
- rebase on tip/sched/core
- changes asym_active_balance() as suggested by Peter

Vincent Guittot (3):
  sched/fair: fix rounding issue for asym packing
  sched/fair: trigger asym_packing during idle load balance
  sched/fair: fix unnecessary increase of balance interval

 kernel/sched/fair.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

-- 
2.7.4

