Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeFEM5D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:57:03 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40810 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeFEM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:56:58 -0400
X-Google-Smtp-Source: ADUXVKKa+np8Yxt15+om1gXUyAs7C+1Hqp9ez6P2Vt/tv+RMIHW7+nNDSrvjmkEK2/5Wy5iB9Rn/hQ==
Reply-To: minyard@acm.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net"
        <openipmi-developer@lists.sourceforge.net>
From: Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] IPMI updates for 4.18
Message-ID: <368f4f3b-a422-59ca-0a2e-8484cf7313d0@acm.org>
Date: Tue, 5 Jun 2018 07:56:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a27fc14219f2e3c4a46ba9177b04d9b52c875532:

   Merge branch 'parisc-4.17-3' of 
git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux 
(2018-04-16 14:07:39 -0700)

are available in the git repository at:

   https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.18

for you to fetch changes up to 048f7c3e352eeef50ed2c14dd89683f8a3af2f9b:

   ipmi: Properly release srcu locks on error conditions (2018-05-24 
15:08:30 -0500)

----------------------------------------------------------------
It's been a busy release for the IPMI driver.  Some notable changes:

A user was running into timeout issues doing maintenance commands over
the IPMB network behind an IPMI controller.  Extend the maintenance
mode concept to messages over IPMB and allow the timeouts to be tuned.

Lots of cleanup, style fixing, some bugfixes, and such.

At least one user was having trouble with the way the IPMI driver would
lock the i2c driver module it used.  The IPMI driver was not designed
for hotplug.  However, hotplug is a reality now, so the IPMI driver
was modified to support hotplug.

The proc interface code is now completely removed.  Long live sysfs!

----------------------------------------------------------------
Avi Fishman (1):
       ipmi: NPCM7xx KCS BMC: enable interrupt to the host

Corey Minyard (32):
       ipmi: Add a way to tune some timeouts
       ipmi: Add a maintenance mode for IPMB messages
       ipmi:watchdog: Rework locking and handling
       ipmi:watchdog: Replace printk() with pr_xxx()
       ipmi: Add a panic handler for IPMI users
       ipmi:watchdog: Use the IPMI panic handler instead of the system one
       ipmi: Clean up some debug code
       ipmi:devintf: Clean up some coding style issues
       ipmi: Clean up comments in include files.
       ipmi: Break up i_ipmi_request
       ipmi: Clean up some style issues in the message handler
       ipmi_devintf: Small lock rework
       ipmi: Add shutdown functions for users and interfaces
       ipmi: Rename ipmi_user_t to struct ipmi_user *
       ipmi: Change ipmi_smi_t to struct ipmi_smi *
       ipmi: Fix some counter issues
       ipmi: Rework locking and shutdown for hot remove
       ipmi_si: Convert over to a shutdown handler
       ipmi_ssif: Convert over to a shutdown handler
       ipmi: Remove condition on interface shutdown
       ipmi_ssif: Remove usecount handling
       ipmi: Remove usecount function from interfaces
       ipmi_devintf: Add an error return on invalid ioctls
       ipmi: ipmi_unregister_smi() cannot fail, have it return void
       ipmi: Get rid of ipmi_user_t and ipmi_smi_t in include files
       ipmi_ssif: Get rid of unused intf_num
       ipmi: Remove smi->intf checks
       ipmi_si: Rename intf_num to si_num
       ipmi_si: Clean up shutdown a bit
       ipmi: Remove the proc interface
       ipmi:bt: Set the timeout before doing a capabilities check
       ipmi: Properly release srcu locks on error conditions

Gustavo A. R. Silva (1):
       ipmi_ssif: Fix uninitialized variable issue

Haiyue Wang (1):
       ipmi: add an NPCM7xx KCS BMC driver

  .../devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt   |   39 +
  drivers/char/ipmi/Kconfig                          |   23 +-
  drivers/char/ipmi/Makefile                         |    1 +
  drivers/char/ipmi/ipmi_bt_sm.c                     |    3 +-
  drivers/char/ipmi/ipmi_devintf.c                   |  129 +-
  drivers/char/ipmi/ipmi_msghandler.c                | 2123 
+++++++++-----------
  drivers/char/ipmi/ipmi_poweroff.c                  |   32 +-
  drivers/char/ipmi/ipmi_si_intf.c                   |  198 +-
  drivers/char/ipmi/ipmi_ssif.c                      |  183 +-
  drivers/char/ipmi/ipmi_watchdog.c                  |  407 ++--
  drivers/char/ipmi/kcs_bmc_npcm7xx.c                |  215 ++
  include/linux/ipmi.h                               |  153 +-
  include/linux/ipmi_smi.h                           |  129 +-
  13 files changed, 1752 insertions(+), 1883 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
  create mode 100644 drivers/char/ipmi/kcs_bmc_npcm7xx.c
