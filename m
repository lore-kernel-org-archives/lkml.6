Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1767B20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1767B20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeGQH22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:28:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:49390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbeGQH22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:28:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B8FEACFA;
        Tue, 17 Jul 2018 06:57:21 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 0/4] add crc64 calculation as kernel library 
Date:   Tue, 17 Jul 2018 14:57:08 +0800
Message-Id: <20180717065711.28281-1-colyli@suse.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds basic implementation of crc64 calculation as Linux
kernel library. Since bcache already does crc64 by itself, this patch
set also modifies bcache code to use the new crc64 library routine.

bcache uses crc64 as storage checksum, if a change of crc lib routines
results an inconsistent result, the unmatched checksum may make bcache
'think' the on-disk is corrupted, such change should be avoided or
detected as early as possible. Therefore the last patch in this series
adds a crc test framework, to check consistency of different calculations.

Changelog:
v2: combine first two patches into one
    fixes all review commennts of v1
v1: initial version.

Coly Li

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Lyle <mlyle@lyle.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
---
Andy Shevchenko (1):
  lib/crc64: add crc64 option to lib/Kconfig

Coly Li (3):
  lib: add crc64 calculation routines
  bcache: use routines from lib/crc64.c for CRC64 calculation
  lib/test_crc: Add test cases for crc calculation

 drivers/md/bcache/bcache.h  |   7 +-
 drivers/md/bcache/btree.c   |   2 +-
 drivers/md/bcache/request.c |   2 +-
 drivers/md/bcache/super.c   |   5 +-
 drivers/md/bcache/util.c    | 131 ----------------------------------
 drivers/md/bcache/util.h    |   5 +-
 include/linux/crc64.h       |  15 ++++
 lib/.gitignore              |   2 +
 lib/Kconfig                 |   8 +++
 lib/Kconfig.debug           |  11 +++
 lib/Makefile                |  12 ++++
 lib/crc64.c                 |  71 +++++++++++++++++++
 lib/gen_crc64table.c        |  76 ++++++++++++++++++++
 lib/test_crc.c              | 136 ++++++++++++++++++++++++++++++++++++
 14 files changed, 341 insertions(+), 142 deletions(-)
 create mode 100644 include/linux/crc64.h
 create mode 100644 lib/crc64.c
 create mode 100644 lib/gen_crc64table.c
 create mode 100644 lib/test_crc.c

-- 
2.17.1

