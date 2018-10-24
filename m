Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB43C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF2A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF2A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeJXWQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:16:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:56350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbeJXWQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:16:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B34BAAF6A;
        Wed, 24 Oct 2018 13:48:26 +0000 (UTC)
Date:   Wed, 24 Oct 2018 15:48:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.20
Message-ID: <20181024134825.yx3mnbmvydrnlvhm@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.20

==================

- Fix two more locations where printf formatting leaked pointers.
- Better log_buf_len parameter handling.
- Add prefix to messages from printk code.
- Do not miss messages on other consoles when the log is replayed
  on a new one.
- Reduce race between console registration and panic() when the log
  might get replayed on all consoles.
- Some cont buffer code clean up.
- Call console only when there is something to do (log vs. cont buffer).

----------------------------------------------------------------
Geert Uytterhoeven (4):
      lib/vsprintf: Make ptr argument conts in ptr_to_id()
      lib/vsprintf: Prepare for more general use of ptr_to_id()
      lib/vsprintf: Hash legacy clock addresses
      lib/vsprintf: Hash printed address for netdev bits fallback

He Zhe (4):
      printk: Fix panic caused by passing log_buf_len to command line
      printk: Correct wrong casting
      printk: Add KBUILD_MODNAME and remove a redundant print prefix
      printk: Give error on attempt to set log buffer length to over 2G

Petr Mladek (2):
      printk: Do not miss new messages when replaying the log
      Merge branch 'for-4.20-vsprintf-hash-fixes' into for-linus

Sergey Senozhatsky (5):
      printk: CON_PRINTBUFFER console registration is a bit racy
      printk: keep kernel cont support always enabled
      printk: lock/unlock console only for new logbuf entries
      printk: do not preliminary split up cont buffer
      printk: fix integer overflow in setup_log_buf()

 Documentation/core-api/printk-formats.rst |   5 +-
 kernel/printk/printk.c                    |  86 ++++++------
 lib/vsprintf.c                            | 216 +++++++++++++++---------------
 3 files changed, 158 insertions(+), 149 deletions(-)
