Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05948C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF63420BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF63420BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeHVNE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:04:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33740 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeHVNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:04:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so2161277oip.0;
        Wed, 22 Aug 2018 02:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Figs1O36lReWQVhDI6MPlqOJ/kNI7E45WbZrV310vg0=;
        b=F3lIfXejvu/O6P1apxCfxAe/3Qj820YFl5jNy67bVrt0l4qBOWmySkmlNKoAi0bKO0
         ch+1gxKfmV7GunnySyqr7WrWqToaqYeAcgrhEGeYcEa4hwpk+SBm39Dp2LRlRh3r9mkZ
         OwDTka+66mIx+xWR+X8IihGV7R11L17dSZQQPYlhpP46ucO3/Yk5yjvY9dxdbhr/NCO/
         3791OipT1d0AufjSRkBidNEZGgFme+C5DLlj8DgeAMACnfpX1muQTQKH4e22egETMRNu
         bEo3HzPmZkw2/s7Deqk1QPn9MqKFwPwp417LDH55qNjX2ASbY6zA0Jr4NHcwsSvTZ+OJ
         G9tg==
X-Gm-Message-State: APzg51CGd98R6dtZmsQ8TBInO+JlIAjHfZFz7k+PYQpvXAelmtTFs3FW
        s6hl8Izeb0iv25ZtARDt7IgMxEAkYzIo32LX+U+aSWjv
X-Google-Smtp-Source: ANB0VdZcMtmbrGPQmZ03lXYVOqPaMqViEZD0w4zWJgT8TnoJJvJ5WxRRRbcadcmj9XWrKZ3cxT5NNFTKPgi52YNob9w=
X-Received: by 2002:aca:d098:: with SMTP id j24-v6mr910484oiy.72.1534930819523;
 Wed, 22 Aug 2018 02:40:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Aug 2018 11:40:07 +0200
Message-ID: <CAJZ5v0ifNDOGwtMo7mQvv2eJYmUjDk=GUiQYeG4scNxrP2MsKg@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc1-2

with top-most commit 01ac7c4c2e035bc8d0d47dc880bbc25bf562a648

 Merge branches 'pm-cpufreq', 'pm-pci' and 'pm-sleep'

on top of commit b018fc9800557bd14a40d69501e19c340eb2c521

 Merge tag 'pm-4.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 4.19-rc1.

These fix the main idle loop and the menu cpuidle governor, clean up
the latter, fix a mistake in the PCI bus type's support for system
suspend and resume, fix the ondemand and conservative cpufreq
governors, address a build issue in the system wakeup framework and
make the ACPI C-states desciptions less confusing.

Specifics:

 - Make the idle loop handle stopped scheduler tick correctly (Rafael
   Wysocki).

 - Prevent the menu cpuidle governor from letting CPUs spend too much
   time in shallow idle states when it is invoked with scheduler tick
   stopped and clean it up somewhat (Rafael Wysocki).

 - Avoid invoking the platform firmware to make the platform enter
   the ACPI S3 sleep state with suspended PCIe root ports which may
   confuse the firmware and cause it to crash (Rafael Wysocki).

 - Fix sysfs-related race in the ondemand and conservative cpufreq
   governors which may cause the system to crash if the governor
   module is removed during an update of CPU frequency limits (Henry
   Willard).

 - Select SRCU when building the system wakeup framework to avoid a
   build issue in it (zhangyi).

 - Make the descriptions of ACPI C-states vendor-neutral to avoid
   confusion (Prarit Bhargava).

Thanks!


---------------

Henry Willard (1):
      cpufreq: governor: Avoid accessing invalid governor_data

Prarit Bhargava (1):
      x86/ACPI/cstate: Make APCI C1 FFH MWAIT C-state description vendor-neutral

Rafael J. Wysocki (5):
      cpuidle: menu: Fix white space
      cpuidle: menu: Update stale polling override comment
      PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
      sched: idle: Avoid retaining the tick when it has been stopped
      cpuidle: menu: Handle stopped tick more aggressively

zhangyi (F) (1):
      PM / sleep: wakeup: Fix build error caused by missing SRCU support

---------------

 arch/x86/kernel/acpi/cstate.c      |  2 +-
 drivers/cpufreq/cpufreq_governor.c | 12 ++++++++--
 drivers/cpuidle/governors/menu.c   | 45 ++++++++++++++++++++++++--------------
 drivers/pci/pci-acpi.c             |  6 ++---
 kernel/power/Kconfig               |  1 +
 kernel/sched/idle.c                |  2 +-
 6 files changed, 43 insertions(+), 25 deletions(-)
