Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB651C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF1120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeIKEwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:52:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36092 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKEwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:52:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fzW22-0002GJ-UQ; Mon, 10 Sep 2018 23:55:51 +0000
Date:   Tue, 11 Sep 2018 00:55:50 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [WTF?] extremely old dead code
Message-ID: <20180910235550.GN19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, please tell me that I'm misreading the history
here...

0.97:
kernel/chr_dev/tty_ioctl.c:tty_ioctl():
+               case FIONBIO:
+                       if (arg)
+                               file->f_flags |= O_NONBLOCK;
+                       else
+                               file->f_flags &= ~O_NONBLOCK;
+                       return 0;

0.98.2:
fs/ioctl.c:sys_ioctl():
+               case FIONBIO:
+                       on = get_fs_long((unsigned long *) arg);
+                       if (on)
+                               filp->f_flags |= O_NONBLOCK;
+                       else
+                               filp->f_flags &= ~O_NONBLOCK;
+                       return 0;

Note that the call of ->f_op->ioctl() is in default: in the same switch,
i.e. unreachable with cmd == FIONBIO.

0.98.3:
kernel/chr_dev/tty_ioctl.c:tty_ioctl():
                case FIONBIO:
+                       arg = get_fs_long((unsigned long *) arg);
                        if (arg)
                                file->f_flags |= O_NONBLOCK;
                        else
wasn't that dead code by that point?

0.99.13k: kernel/chr_dev/tty_ioctl.c moves to drivers/char/tty_ioctl.c,
tty_ioctl() essentially unchanged.

1.1.13: tty_ioctl() moves from drivers/char/tty_ioctl.c to
drivers/char/tty_io.c, leaving some bits behind (as n_tty_ioctl()).
FIONBIO handling is among the moved parts.

1.3.4: in tty_ioctl()
                case FIONBIO:
-                       retval = verify_area(VERIFY_READ, (void *) arg, sizeof(long));
+                       retval = verify_area(VERIFY_READ, (void *) arg, sizeof(int));

1.3.28: same change happens in sys_ioctl().

2.1.4: handling moved to helper (fionbio())

In 2006: Alan writes a nice description of fionbio()
+/**
+ *     fionbio         -       non blocking ioctl
+ *     @file: file to set blocking value
+ *     @p: user parameter
+ *
+ *     Historical tty interfaces had a blocking control ioctl before
+ *     the generic functionality existed. This piece of history is preserved
+ *     in the expected tty API of posix OS's.
+ *
+ *     Locking: none, the open fle handle ensures it won't go away.
+ */
"generic functionality" bit refers to fcntl(2) (F_SETFL)

In 2010: the whole thing is moved to drivers/tty/tty_io.c

Hadn't that sucker been dead code since 0.98.2?  What am I missing here?
Note that this thing had quite a few functionality changes over those
years; had they even been tested?

Confused and hoping to be told "Al, you're an idiot, here's an obvious way
for that thing to be reached"...
