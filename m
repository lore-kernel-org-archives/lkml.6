Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F8C20831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F8C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJ3RUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:20:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45941 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeJ3RUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:20:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id q25so10253068otn.12;
        Tue, 30 Oct 2018 01:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P798P3HQ9dxfDOICSjE6Oua23MaXe2I6mwiTxcy7bYY=;
        b=eekkxtywvKaujo2NhwaHZ5iK8j0GOR6q3V+kRxU5mQpPHobBTupsa/qd2mtZ21HACj
         WtIYjDdzNziMvEZGLtudO7LLcI3p1uqcT9t3uHayBH1bzzxRaXMngNxz4BSqfyEQqb5F
         UkXXSsufHkIdb4HX+kRMEq7mtBdUf1ArI+bfPZzgwwmbhmxbbTRAsjeZUkMQtRAE0gEH
         i3osoi2+2A7SxSZHaY7ZbgOdRBQHuZYqtshYHOmX2cquicKoXLEGAp9I6XMOIN/IDu9c
         ukugafovzggGhlfTGRI9stCPSDrEQ0O36zFxJZ3heRxyppZ0fa99M8PEUNdTOL+4VX5p
         Kuxg==
X-Gm-Message-State: AGRZ1gKs5uT8IqjpUOYOh4K2v+3ecaHQ8yjjAcCuOoPLGGwbkBHSIvW/
        y9QvWEE0YXpnbBVbpunTM9SVhy8db+a16du4LaGu2sjt
X-Google-Smtp-Source: AJdET5dciriIghG820JdaIbolZCa0TXo0T4fFzobQeewAyE4Uxapk1oimopcfVbAqejI77SRcfnYv6RAiAhJYi1oaMI=
X-Received: by 2002:a9d:64ce:: with SMTP id n14mr11410382otl.343.1540888093114;
 Tue, 30 Oct 2018 01:28:13 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Oct 2018 09:28:01 +0100
Message-ID: <CAJZ5v0g7iRUA2=fi3+rkJcsx38YTE6fx26bnnpjeMHwv_CSMVw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v4.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc1-2

with top-most commit c4ac6889930d027ffa5cf77e0c202e7e97a4be06

 Merge branches 'pm-cpuidle' and 'pm-cpufreq'

on top of commit bd6bf7c10484f026505814b690104cdef27ed460

 Merge tag 'pci-v4.20-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci

to receive additional power management updates for 4.20-rc1.

These remove a questionable heuristic from the menu cpuidle governor,
fix a recent build regression in the intel_pstate driver, clean up
ARM big-Little support in cpufreq and fix up hung task watchdog's
interaction with system-wide power management transitions.

Specifics:

 - Fix build regression in the intel_pstate driver that doesn't
   build without CONFIG_ACPI after recent changes (Dominik Brodowski).

 - One of the heuristics in the menu cpuidle governor is based on a
   function returning 0 most of the time, so drop it and clean up
   the scheduler code related to it (Daniel Lezcano).

 - Prevent the arm_big_little cpufreq driver from being used on ARM64
   which is not suitable for it and drop the arm_big_little_dt driver
   that is not used any more (Sudeep Holla).

 - Prevent the hung task watchdog from triggering during resume from
   system-wide sleep states by disabling it before freezing tasks and
   enabling it again after they have been thawed (Vitaly Kuznetsov).

There is a merge conflict between the menu governor changes included
here and the (already merged) material from Andrew, but it should be
straightforward to resolve [1].

Thanks!

[1] https://lore.kernel.org/lkml/20181029130124.290346e9@canb.auug.org.au/

---------------

Daniel Lezcano (2):
      sched: Factor out nr_iowait and nr_iowait_cpu
      cpuidle: menu: Remove get_loadavg() from the performance multiplier

Dominik Brodowski (1):
      cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI

Sudeep Holla (2):
      cpufreq: drop ARM_BIG_LITTLE_CPUFREQ support for ARM64
      cpufreq: remove unused arm_big_little_dt driver

Vitaly Kuznetsov (1):
      kernel: hung_task.c: disable on suspend

---------------

 MAINTAINERS                         |   1 -
 drivers/cpufreq/Kconfig.arm         |   9 +---
 drivers/cpufreq/Makefile            |   3 --
 drivers/cpufreq/arm_big_little_dt.c | 100 ------------------------------------
 drivers/cpufreq/intel_pstate.c      |  20 ++++----
 drivers/cpuidle/governors/menu.c    |  25 +++------
 include/linux/sched/stat.h          |   1 -
 kernel/hung_task.c                  |  30 ++++++++++-
 kernel/sched/core.c                 |  34 +++++-------
 9 files changed, 60 insertions(+), 163 deletions(-)
