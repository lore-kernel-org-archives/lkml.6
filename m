Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425567AbeBOQIw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:08:52 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33253 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424477AbeBOQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:08:45 -0500
X-Google-Smtp-Source: AH8x226Nzodyt/G5VN2Bl1HrCdrZsyDl4D1ZHtMYyS8LeT+y4KtCJs4OICMeYjz+/7DuDNNU/Siv3A==
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennisszhou@gmail.com>
Subject: [PATCH 0/3] percpu: introduce no retry semantics and gfp passthrough
Date: Thu, 15 Feb 2018 10:08:13 -0600
Message-Id: <cover.1518668149.git.dennisszhou@gmail.com>
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

The percpu memory using the valloc area based chunk allocator lazily
populates chunks by first requesting the full virtual address space
required for the chunk and subsequently adding pages as allocations come
through. To ensure atomic allocations can succeed, a workqueue item is
used to maintain a minimum number of empty pages. In certain scenarios,
such as reported in [1], it is possible that physical memory becomes
quite scarce which can result in either a rather long time spent trying
to find free pages or worse, a kernel panic.

This patchset introduces no retry semantics to percpu memory by allowing
users to pass through certain flags controlled by a whitelist. In this
case, only __GFP_NORETRY and __GFP_NOWARN are initially allowed. This
should prevent the eventual kernel panic due to the workqueue item and
now give flexibility to users to decide how they want to fail when the
percpu allocator fails if they use the additional flags. This does not
prevent the allocator from panicking should an allocation without the
additional flags cause an underlying allocator to trigger out of memory.

I tested this by running basic allocations with and without passing
the additional flags. Allocations are able to proceed / fail as
expected without triggering the out of memory kernel panic. I still
saw OOM killer activate, but I attribute that to other programs faulting
in the background. Without the flags, the kernel panics pretty quickly
with the expected out of memory panic.

[1] https://lkml.org/lkml/2018/2/12/551

This patchset contains the following 3 patches:
  0001-percpu-match-chunk-allocator-declarations-with-defin.patch
  0002-percpu-add-__GFP_NORETRY-semantics-to-the-percpu-bal.patch
  0003-percpu-allow-select-gfp-to-be-passed-to-underlying-a.patch

0001 fixes out of sync declaration and definiton variable names. 0002 adds
no retry semantics to the workqueue balance path. 0003 enables users to
pass through flags to the underlying percpu memory allocators. This also
cleans up the semantics surrounding how the flags are managed.

This patchset is ontop of percpu#master 7928b2cbe5.

diffstats below:

Dennis Zhou (3):
  percpu: match chunk allocator declarations with definitions
  percpu: add __GFP_NORETRY semantics to the percpu balancing path
  percpu: allow select gfp to be passed to underlying allocators

 mm/percpu-km.c |  8 ++++----
 mm/percpu-vm.c | 18 +++++++++++-------
 mm/percpu.c    | 52 ++++++++++++++++++++++++++++++++++------------------
 3 files changed, 49 insertions(+), 29 deletions(-)

Thanks,
Dennis
