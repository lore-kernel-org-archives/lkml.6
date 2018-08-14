Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24A6C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C506216FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C506216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbeHNRwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:52:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728880AbeHNRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:52:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DF65AD86;
        Tue, 14 Aug 2018 15:05:11 +0000 (UTC)
Date:   Tue, 14 Aug 2018 17:05:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.19
Message-ID: <20180814150510.abnmjjqpateyasbk@pathway.suse.cz>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.19

================

- Different vendors have a different expectation about a console quietness.
  Make it configurable to reduce bike-shedding about the upstream default.

- Decide about the message visibility when the message is stored. It avoids
  races caused by a delayed console handling.

- Always store printk() messages into the per-CPU buffers again in NMI.
  The only exception is when flushing trace log in panic(). There
  the risk of loosing messages is worth an eventual reordering.

- Handle invalid %pO printf modifiers correctly.

- Better handle %p printf modifier tests before crng is initialized.

- Some clean up.


----------------------------------------------------------------
Bart Van Assche (1):
      lib/vsprintf: Do not handle %pO[^F] as %px

Hans de Goede (1):
      printk: Make CONSOLE_LOGLEVEL_QUIET configurable

Maninder Singh (1):
      printk: make sure to print log on console.

Namit Gupta (1):
      printk: Remove unnecessary kmalloc() from syslog during clear

Petr Mladek (6):
      printk: Clean up syslog_print_all()
      printk: Split the code for storing a message into the log buffer
      printk: Create helper function to queue deferred console handling
      printk/nmi: Prevent deadlock when accessing the main log buffer in NMI
      printk: Fix warning about unused suppress_message_printing
      Merge branch 'for-4.19-nmi' into for-linus

Thierry Escande (1):
      lib/test_printf.c: accept "ptrval" as valid result for plain 'p' tests

 include/linux/printk.h      |  10 ++-
 kernel/printk/internal.h    |   9 ++-
 kernel/printk/printk.c      | 181 ++++++++++++++++++++++++--------------------
 kernel/printk/printk_safe.c |  58 +++++++++-----
 kernel/trace/trace.c        |   4 +-
 lib/Kconfig.debug           |  11 +++
 lib/nmi_backtrace.c         |   3 -
 lib/test_printf.c           |  24 +++++-
 lib/vsprintf.c              |   1 +
 9 files changed, 189 insertions(+), 112 deletions(-)
