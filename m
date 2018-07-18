Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1356C20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1356C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeGRRLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:11:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:59895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbeGRRLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:11:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 09:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="246779970"
Received: from sandybridge-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2018 09:32:35 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Eric Biggers <ebiggers@google.com>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, "Theodore Ts o" <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation encryption
Date:   Thu, 19 Jul 2018 00:38:06 +0800
Message-Id: <cover.1531924968.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As security becomes more and more important, we add the in-kernel
encryption support for hibernation.

This prototype is a trial version to implement the hibernation
encryption in the kernel. This patch set is divided
into two parts:
1. The hibernation snapshot encryption in kernel space.
2. The key derivation implementation in user space.

The whole process is illustrated below:
1. install the kernel module:
   modprobe crypto_hibernation
2. run the tool to generate the key from
   user provided passphrase (salt has been read
   from kernel).
3. launch the hibernation process, the kernel
   uses the key in step 2 to encrypt the
   hibernation snapshot.
4. resume the system and the initrd will
   launch cryto_hibernate to read previous salt
   from kernel and probe the user passphrase
   and generate the same key.
5. kernel uses this key to decrypt the hibernation
   snapshot and restore to previous system.

Chen Yu (4):
  PM / Hibernate: Add helper functions for hibernation encryption
  PM / hibernate: Install crypto hooks for hibernation encryption
  PM / Hibernate: Encrypt the snapshot pages before submitted to the
    block device
  tools: create power/crypto utility

 include/linux/suspend.h               |  40 +++
 kernel/power/Kconfig                  |  14 ++
 kernel/power/Makefile                 |   1 +
 kernel/power/crypto_hibernation.c     | 421 +++++++++++++++++++++++++++++++
 kernel/power/hibernate.c              |  67 +++++
 kernel/power/power.h                  |  67 +++++
 kernel/power/swap.c                   | 182 +++++++++++++-
 tools/power/crypto/Makefile           |  24 ++
 tools/power/crypto/crypto_hibernate.c | 462 ++++++++++++++++++++++++++++++++++
 9 files changed, 1270 insertions(+), 8 deletions(-)
 create mode 100644 kernel/power/crypto_hibernation.c
 create mode 100644 tools/power/crypto/Makefile
 create mode 100644 tools/power/crypto/crypto_hibernate.c

-- 
2.7.4

