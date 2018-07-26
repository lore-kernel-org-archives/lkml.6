Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E530CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877D620891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877D620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeGZGtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:49:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728652AbeGZGtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:49:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88BEFACEF;
        Thu, 26 Jul 2018 05:34:07 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     colyli@suse.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v5 0/2] add crc64 calculation as kernel library 
Date:   Thu, 26 Jul 2018 13:33:50 +0800
Message-Id: <20180726053352.2781-1-colyli@suse.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds basic implementation of crc64 calculation as Linux
kernel library. Since bcache already does crc64 by itself, this patch
set also modifies bcache code to use the new crc64 library routine.

Currently bcache is the only user of crc64 calculation, another potential
user is bcachefs which is on the way to be in mainline kernel. Therefore
it makes sense to make crc64 calculation to be a public library.

CRC calculation consistency testing is not trvial, it will be another
separated patch set and not in this series any more.

Coly Li

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Lyle <mlyle@lyle.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Biggers <ebiggers3@gmail.com>
---
Changelog:
v5: Remove test_crc patch from this series, it will be another separated
    patch set. Fixes review comments from v4.
v4: Only keep crc64_be() in lib/crc64.c, tested bcache specific stuffs 
    moved back to bcache code.
    Fixes all review comments of v3.
v3: Remove little endian restriction and remove 'le' from function names.
    Fixes all review comments of v2
v2: Combine first two patches into one
    Fixes all review comments of v1
v1: Initial version.

Coly Li (2):
  lib: add crc64 calculation routines
  bcache: use routines from lib/crc64.c for CRC64 calculation

 drivers/md/bcache/Kconfig |   1 +
 drivers/md/bcache/util.c  | 131 --------------------------------------
 drivers/md/bcache/util.h  |  21 ++++--
 include/linux/crc64.h     |  11 ++++
 lib/.gitignore            |   2 +
 lib/Kconfig               |   8 +++
 lib/Makefile              |  11 ++++
 lib/crc64.c               |  56 ++++++++++++++++
 lib/gen_crc64table.c      |  68 ++++++++++++++++++++
 9 files changed, 174 insertions(+), 135 deletions(-)
 create mode 100644 include/linux/crc64.h
 create mode 100644 lib/crc64.c
 create mode 100644 lib/gen_crc64table.c

-- 
2.17.1

