Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbeEIPP6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:15:58 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:55414 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935265AbeEIPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:15:56 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:69:355:379:541:960:968:973:988:989:1260:1345:1437:1534:1542:1711:1730:1747:1777:1792:1801:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3871:3872:3874:4250:4605:5007:6119:6261:8660:9038:10004:10848:11026:11658:11914:12043:12296:12679:12683:12895:13095:13148:13161:13229:13230:14096:14394:14721:21080:21433:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: hole64_8af1f0ebe0c0b
X-Filterd-Recvd-Size: 2680
From: Joe Perches <joe@perches.com>
To: openipmi-developer@lists.sourceforge.net, linux-rdma@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] treewide: Add and use dev_fmt similar to pr_fmt
Date: Wed,  9 May 2018 08:15:44 -0700
Message-Id: <cover.1525878372.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_fmt mechanism exists for pr_<level> logging message prefixing,
but no similar capability exists for dev_<level> message prefixing.

Many uses of dev_<level> have an embedded prefix for logging output.

So add a similar dev_fmt macro that can automatically prefix the
dev_<level> logging output.

Rename the existing dev_<level> functions to _dev_<level> and add new
macros that call _dev_<level> with the desired prefix if defined.

The new default #define for dev_fmt is blank.

Convert ipmi and infiniband to use this mechanism.

Miscellanea:

o x86/early-quirks uses an internal macro for #define dev_err which conflicts
 with the existing dev_err macro, so rename it.

Joe Perches (6):
  x86/early-quirks: Rename duplicate define of dev_err
  device: Add #define dev_fmt similar to #define pr_fmt
  ipmi: msghandler: Add and use pr_fmt and dev_fmt, remove PFX
  ipmi: Use more common logging styles
  ipmi: Convert printk(KERN_<level> to pr_<level>(
  infiniband: qplib_fp: Use dev_fmt

 arch/x86/kernel/early-quirks.c           |   8 +-
 drivers/base/core.c                      |  12 +--
 drivers/char/ipmi/ipmi_bt_sm.c           |  64 ++++++++--------
 drivers/char/ipmi/ipmi_devintf.c         |  11 ++-
 drivers/char/ipmi/ipmi_kcs_sm.c          |   4 +-
 drivers/char/ipmi/ipmi_msghandler.c      |  53 +++++++------
 drivers/char/ipmi/ipmi_poweroff.c        |  67 ++++++++---------
 drivers/char/ipmi/ipmi_si_hardcode.c     |   9 ++-
 drivers/char/ipmi/ipmi_si_hotmod.c       |  17 +++--
 drivers/char/ipmi/ipmi_si_intf.c         |  22 +++---
 drivers/char/ipmi/ipmi_si_pci.c          |  12 +--
 drivers/char/ipmi/ipmi_si_platform.c     |  20 ++---
 drivers/char/ipmi/ipmi_smic_sm.c         |  26 +++----
 drivers/char/ipmi/ipmi_ssif.c            |  73 +++++++++---------
 drivers/char/ipmi/ipmi_watchdog.c        |  52 +++++++------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 125 ++++++++++++++-----------------
 include/linux/device.h                   | 103 ++++++++++++++-----------
 17 files changed, 330 insertions(+), 348 deletions(-)

-- 
2.15.0
