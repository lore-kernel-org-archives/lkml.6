Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeBKBxm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 20:53:42 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36156 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeBKBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 20:53:41 -0500
X-Google-Smtp-Source: AH8x225fLFYq+dPO0flc7IV4kKOyT7v97cUnTSSZoOEmWdMm2e1hXkiFAux3rz2+h/jpTrDDwCY8Ww==
To: linux-kernel@vger.kernel.org
From: Rob Landley <rob@landley.net>
Subject: tmpfs and brickability (size=50% default considered naieve).
Message-ID: <89293703-6e19-f6b6-a0d4-dc3ca90785ed@landley.net>
Date: Sat, 10 Feb 2018 19:53:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you have two default tmpfs instances on your box (hi buildroot!) and
they're world writeable and a normal user goes "cat /dev/zero >
/run/fillit; cat /dev/zero > /tmp/fillit" the system then goes "sh:
can't fork" trying to call rm on those files, because they each default
to 50% of total system memory, no matter how many instances there are.
It only stops writing when memory allocation fails in the kernel.

I'm not quite sure how to fix that. I want to say "change the default to
be 50% of what's _left_" (and if you size= manually you get to keep the
pieces) but define "what's left"? Other things are using some memory
already, the 50% _was_ the amount it's safe for tmpfs to use. (Once upon
a time the logic was that 50% of memory can go to disk cache. I think
that's gotten a bit more complicated since then? No idea what the
current rules are.)

This is related to the guy who wanted initramfs to be ramfs instead of
tmpfs because he had a cpio.gz that extracted to >50% of system memory
so it extracted fine with ramfs but hit the limit and failed with tmpfs.
That sounds like a tmpfs rootfs (I.E. initmpfs) should start with a
limit of 90% and then scale it _down_ to 50% after extracting the cpio.
(I wonder what happens if you -o remount the size= limit to smaller than
the filesystem currently holds? Hmmm...)

Rob

P.S. Yes I need to pipe rootflags= through so you can specify the size
on the command line. I've got 3 or 4 initramfs/tmpfs plates spinning and
haven't had a chance to work on them all merge window. I'll try to get
some patches ready by next weekend, if they miss the release they miss
the release...
