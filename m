Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59995ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0002420846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0002420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbeGWMUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:20:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387882AbeGWMUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:20:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C10B4AEB1;
        Mon, 23 Jul 2018 11:19:49 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-api@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/4] cleanups and refactor of /proc/pid/smaps*
Date:   Mon, 23 Jul 2018 13:19:29 +0200
Message-Id: <20180723111933.15443-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent regression in /proc/pid/smaps made me look more into the code.
Especially the issues with smaps_rollup reported in [1] as explained in
Patch 4, which fixes them by refactoring the code. Patches 2 and 3 are
preparations for that. Patch 1 is me realizing that there's a lot of
boilerplate left from times where we tried (unsuccessfuly) to mark thread
stacks in the output.

Originally I had also plans to rework the translation from /proc/pid/*maps*
file offsets to the internal structures. Now the offset means "vma number",
which is not really stable (vma's can come and go between read() calls) and
there's an extra caching of last vma's address. My idea was that offsets would
be interpreted directly as addresses, which would also allow meaningful seeks
(see the ugly seek_to_smaps_entry() in tools/testing/selftests/vm/mlock2.h).
However loff_t is (signed) long long so that might be insufficient somewhere
for the unsigned long addresses.

So the result is fixed issues with skewed /proc/pid/smaps_rollup results,
simpler smaps code, and a lot of unused code removed.

[1] https://marc.info/?l=linux-mm&m=151927723128134&w=2

Vlastimil Babka (4):
  mm: /proc/pid/*maps remove is_pid and related wrappers
  mm: proc/pid/smaps: factor out mem stats gathering
  mm: proc/pid/smaps: factor out common stats printing
  mm: proc/pid/smaps_rollup: convert to single value seq_file

 fs/proc/base.c       |   6 +-
 fs/proc/internal.h   |   3 -
 fs/proc/task_mmu.c   | 294 +++++++++++++++++++------------------------
 fs/proc/task_nommu.c |  39 +-----
 4 files changed, 133 insertions(+), 209 deletions(-)

-- 
2.18.0

