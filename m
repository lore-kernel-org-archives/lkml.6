Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbeDFPHQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:07:16 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:39821 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754793AbeDFPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:07:13 -0400
X-Google-Smtp-Source: AIpwx499/PSbwaUCW4NuZax6sCrnygJD/JzzepYL7G8DfrqjlSwXxRIS0wM9R/DauafEjAI+VGmLkEEn+Cr8Auiet60=
MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 6 Apr 2018 20:37:11 +0530
Message-ID: <CAOuPNLjoNFa4sAhT4B_Xx7YfLwOMOF9VsK-O_dwWhhw2GGdMMQ@mail.gmail.com>
Subject: [HELP] CPU Hard LOCKUP during boot up with HPET clock source
To: open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First the few details:
Kernel: 4.9.20
Machine: x86_64 (AMD)
Model: Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz
Cores: 8
Available clock source:
# cat /sys/devices/system/clocksource/clocksource0/available_clocksource
tsc hpet acpi_pm

Problem:
[   28.027409] NMI watchdog: Watchdog detected hard LOCKUP on cpu
1dModules linked in:c
[   28.136317] RIP: 0010:[<ffffffff98058c43>] c [<ffffffff98058c43>]
read_hpet+0xb3/0x120
[...]

------------------
This lockup happens during boot when the cpu is stuck for about ~28 seconds.
This is because of our internal code changes.
During our init function we are running some calibrate loops
10,000,000 (10MHz) times twice.
The LOCKUP is coming because of this loop.

But, we observed that the main issue is the clock source that is
available at that time.
At the time this loop is executed, the available clock source is HPET (not TSC).
With HPET the loop runs slower. It takes almost 28 seconds to complete
with HPET clock source. Hence the boot time also increase by 28
seconds.
Where as with TSC the loop completes in less than 4 seconds. So, with
TSC we dont get the LOCKUP.

Thus, the lockup is happening only because the loop executes with HPET
clock source.

To fix the problem, I tried the following approach:
1) Use late_initcall for our driver init to delay the call until TSC
clock source is ready.
    => With this there is no LOCKUP trace and no impact on boot time.
    This is because the loop executes with TSC.

2) We have 2 loops. So I split the local_irq_save/restore part for
each loops separately.
     => With this also there is no backtrace seen.
     => But boot time is increased.

3) I used delayed_workqueue to delay the execution of the loop by 5
seconds, until TSC is ready.
    => With this there is no back trace and also boot time is normal.
    => But if we disable TSC then we still get the back trace.

4) Disabled HPET from kernel command line using : hpet=disable
    => This also works as the loop executes with the next available
clock source: acpi_pm
    => But changing boot args is not recommended in our case.

5) Disable HPET related configs in kernel
    => CONFIG_HPET=n
    => CONFIG_HPET_TIMER=n
    => This method does not work as we were not able to disable
HPET_TIMER on x86_64.

6) Use hpet_disable() from our code.
    => This method also does not work. It actually does not disable
HPET clock source.


-----------------------------
Thus we wanted to know your opinion which is the right solution to fix
this lockup during boot time.

Is there a way to purposefully fallback to next available clock source
(acpi_pm) instead of hpet, from the source code, before executing our
loop ?


Please let me know if there are alternate options.



Thanks,
Pintu
