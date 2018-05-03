Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeECUr3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:47:29 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:56086 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeECUr2 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 3 May 2018 16:47:28 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, aarcange@redhat.com
Cc: joe.lawrence@redhat.com, gareth.evans@contextis.co.uk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, dave@stgolabs.net,
        stable@kernel.org
Subject: [PATCH -next 0/2] ipc/shm: shmat() fixes around nil-page
Date: Thu,  3 May 2018 13:32:41 -0700
Message-Id: <20180503203243.15045-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches fix two issues reported[1] a while back by Joe and Andrea
around how shmat(2) behaves with nil-page.

The first reverts a commit that it was incorrectly thought that mapping
nil-page (address=0) was a no no with MAP_FIXED. This is not the case,
with the exception of SHM_REMAP; which is address in the second patch.

I chose two patches because it is easier to backport and it explicitly
reverts bogus behaviour. Both patches ought to be in -stable and ltp
testcases need updated (the added testcase around the cve can be modified
to just test for SHM_RND|SHM_REMAP).

[1] lkml.kernel.org/r/20180430172152.nfa564pvgpk3ut7p@linux-n805

Thanks! 

Davidlohr Bueso (2):
  Revert "ipc/shm: Fix shmat mmap nil-page protection"
  ipc/shm: fix shmat() nil address after round-down when remapping

 ipc/shm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.13.6
