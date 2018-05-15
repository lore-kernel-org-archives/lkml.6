Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeEOI6a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:58:30 -0400
Received: from exmail.andestech.com ([59.124.169.137]:34540 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeEOI61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:58:27 -0400
From: Vincent Chen <vincentc@andestech.com>
To: <linux-kernel@vger.kernel.org>, <green.hu@gmail.com>,
        <greentime@andestech.com>, <arnd@arndb.de>
CC: <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH 0/3]nds32: Correct the cache operation for catch aliasing case
Date: Tue, 15 May 2018 16:46:00 +0800
Message-ID: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w4F8mke4015355
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following 3 issues are fixed in this patchset

1. In function flush_dacache_page and copy_user_highpage, the local irq is
enabled when the cache of the page at address page_address(page) is written
back to memory. It possibly causes data corruption. To fix this problem,
the local irq is disabled before executing d-cache write-back and
invalidate in this patchset.

2. According to Documentation/cachetlb.txt, the cache of the page at vmaddr
shall be flushed in flush_anon_page instead of the cache of the page at
page_address(page). We correct it and add the modification to this
patchset.

3. Removing unneeded cache invalidation in copy_user_highpage function.


Vincent Chen (3):
  nds32: Correct flush_dcache_page function
  nds32: Flush the cache of the page at vmaddr instead of kaddr in
    flush_anon_page
  nds32: Disable local irq before calling cpu_dcache_wb_page in
    copy_user_highpage

 arch/nds32/mm/cacheflush.c |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)
