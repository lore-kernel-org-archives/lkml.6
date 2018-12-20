Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7510221773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TduCIAKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbeLTHzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:55:53 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36815 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeLTHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:55:52 -0500
Received: by mail-wm1-f43.google.com with SMTP id p6so992284wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1AQGE4UXxute9PxJ6pwH0vfYZA8UlC32hwf0ljvwbyw=;
        b=TduCIAKZxxrMdvqGrAqIPug07DKYudCBtPMCLe7vVjF2G/9G5Llmr9UPw065VFt3Sm
         5MZLx8MaGbURNCrTjQkrOVxDfOy7ohW6LQlgKehXWY2I9aD17e++WPN6vLezuPcKGIc+
         sb0ergNA+EqLYtSZlX8XILvQKo2pBBRB4k8s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1AQGE4UXxute9PxJ6pwH0vfYZA8UlC32hwf0ljvwbyw=;
        b=YgA/CraaY7ZkUxA5TLnLeUJXCCUm90RgPaxf0SV90DPLgsCIQ9v2Gvy9p98OM0vl2z
         xvrEjSTeRnXSkLf+WVbCyynZDEXUK9EF1kvxz6P8uJj5pUFH4lBcb+WSucSlyQIH0JCQ
         mTAyFlJfdWWZVhfrKhLrL4a0G0PhCsunamFRMgKbrWQ3ZV5es/qs9H0IEvJiqbyYwwGX
         Q24gr6dOrx4kQcEeqEOIrTKfc0bbBCTQxlz/EbMIsVE+tb5ipNBkrOIrF95pTfp+3cd6
         To+yem036stzOWjcEIONmKBLYY3uAreikxUZFRYY1jGRFtk44MyTU9bpWFLdTUzTn8CB
         g+wg==
X-Gm-Message-State: AA+aEWZ7JEwRMW6p/vTGG/9fH1sH/1oxIP3yamT+V1pjqUa+vaorpII2
        V2UcabFSzGjbK2rHcYkTJDCApg==
X-Google-Smtp-Source: AFSGD/V3F25yN6cxonfMluxHKZPDA8MON05bOEnbbUPI1Satk+xqNDaUsbSBMgfHlvFXc5YF7/4+AA==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr9922765wmc.5.1545292550852;
        Wed, 19 Dec 2018 23:55:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id c10sm8773299wrw.49.2018.12.19.23.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 23:55:50 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/3] sched/fair: some fixes for asym_packing
Date:   Thu, 20 Dec 2018 08:55:44 +0100
Message-Id: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
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

