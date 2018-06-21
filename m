Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397ACC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF082243F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF082243F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934075AbeFUVgZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:36:25 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:57759 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933731AbeFUV27 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 21 Jun 2018 17:28:59 -0400
Received: from linux-r8p5.suse.cz (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 21 Jun 2018 15:28:48 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -next v3 0/4] rhashtable: guarantee initial allocation
Date:   Thu, 21 Jun 2018 14:28:21 -0700
Message-Id: <20180621212825.3059-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2:
lkml.kernel.org/r/20180601160125.30031-1-dave@stgolabs.net

- Dropped original patch 1 (which removed the EINVAL returns
  for WARN_ON) as well as patch 5.
- Added a new patch 1, which simplifies the alloc after mhocko's
  changes (originally suggested by Linus).
- Use max_t instead of min_t for the resize.

Changes from v1
lkml.kernel.org/r/20180524211135.27760-1-dave@stgolabs.net

- patch 2 is reworked a bit based on the commments from Herbert Xu.
  o upon failure, retry immediately with GFP_NOFAIL (simpler)
  o the caller now passes the needed semantics, not bucket_table_alloc().
  o we consider min_size when resizing, not just HASH_MIN_SIZE.

- removed patch 3; not need after Michal's patch.

Hi,

This series is the result of the discussion with Linus around ipc
subsystem initialization and how it behaves with error return when
calling rhashtable_init()[1]. Instead of caring about the error
or calling the infamous BUG_ON, Linus suggested we guarantee the
rhashtable allocation.

First two patches deal with the rhashtable_init() changes, while the
patches 3+4 remove some ipc hacks we no longer need.

Please consider for v4.19.

[0] https://lkml.org/lkml/2018/5/23/758

Thanks!

Davidlohr Bueso (4):
  lib/rhashtable: simplify bucket_table_alloc()
  lib/rhashtable: guarantee initial hashtable allocation
  ipc: get rid of ids->tables_initialized hack
  ipc: simplify ipc initialization

 include/linux/ipc_namespace.h |  1 -
 ipc/msg.c                     |  9 ++++-----
 ipc/namespace.c               | 20 ++++----------------
 ipc/sem.c                     | 10 ++++------
 ipc/shm.c                     |  9 ++++-----
 ipc/util.c                    | 41 +++++++++++++----------------------------
 ipc/util.h                    | 18 +++++++++---------
 lib/rhashtable.c              | 19 ++++++++++++-------
 8 files changed, 50 insertions(+), 77 deletions(-)

-- 
2.16.4

