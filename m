Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1198C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53470208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53470208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeGLLLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:22 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58334 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeGLLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2BBB7181860FE;
        Thu, 12 Jul 2018 13:02:18 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/5] ubifs: Rework assert code
Date:   Thu, 12 Jul 2018 13:01:55 +0200
Message-Id: <20180712110200.13054-1-richard@nod.at>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series changes the UBIFS assert code such that users can specify what
do to upon a failed assert. The new mount option "assert=" controls these
actions. Currently three actions are supported:
- report: Just report the assertion
- panic: Panic the kernel
- read-only: Switch to read-only mode

From now on the default action is read-only.

Richard Weinberger (5):
  ubifs: Turn two ubifs_assert() into a WARN_ON()
  ubifs: Pass struct ubifs_info to ubifs_assert()
  ubifs: Rework ubifs_assert()
  ubifs: Allow setting assert action as mount parameter
  ubifs: Set default assert action to read-only

 fs/ubifs/budget.c     |  68 ++++++++++++-------------
 fs/ubifs/commit.c     |   8 +--
 fs/ubifs/crypto.c     |   4 +-
 fs/ubifs/debug.c      |  42 ++++++++++++----
 fs/ubifs/debug.h      |  14 +++---
 fs/ubifs/dir.c        |  35 ++++++-------
 fs/ubifs/file.c       |  47 ++++++++++--------
 fs/ubifs/find.c       |  54 ++++++++++----------
 fs/ubifs/gc.c         |  64 ++++++++++++------------
 fs/ubifs/io.c         |  97 ++++++++++++++++++------------------
 fs/ubifs/journal.c    |  52 ++++++++++----------
 fs/ubifs/key.h        |  14 +++---
 fs/ubifs/log.c        |  12 ++---
 fs/ubifs/lprops.c     |  86 ++++++++++++++++----------------
 fs/ubifs/lpt.c        | 112 +++++++++++++++++++++---------------------
 fs/ubifs/lpt_commit.c |  50 ++++++++++---------
 fs/ubifs/master.c     |   2 +-
 fs/ubifs/misc.c       |  11 +++++
 fs/ubifs/misc.h       |  16 +++---
 fs/ubifs/orphan.c     |  26 +++++-----
 fs/ubifs/recovery.c   |  14 +++---
 fs/ubifs/replay.c     |  13 ++---
 fs/ubifs/sb.c         |  12 ++---
 fs/ubifs/scan.c       |   2 +-
 fs/ubifs/shrinker.c   |  10 ++--
 fs/ubifs/super.c      |  74 +++++++++++++++++++---------
 fs/ubifs/tnc.c        | 107 ++++++++++++++++++++--------------------
 fs/ubifs/tnc_commit.c |  28 +++++------
 fs/ubifs/tnc_misc.c   |  38 ++++++++------
 fs/ubifs/ubifs.h      |  31 +++++++++---
 fs/ubifs/xattr.c      |  16 +++---
 31 files changed, 632 insertions(+), 527 deletions(-)

-- 
2.18.0

