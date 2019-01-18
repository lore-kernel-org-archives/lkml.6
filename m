Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB6C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8A62087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VM1GlNME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfARTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:09:35 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:43273 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfARTJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:09:34 -0500
Received: by mail-oi1-f181.google.com with SMTP id u18so9766037oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vdhZQF3Fgnjc42DW844YSt5cmBXIBDuDCgG4Gq6CWIU=;
        b=VM1GlNME1aGk4Dz0mdEnkr8qNSJ2Pl7ZK2Y4v5M06t/bdI0zESvJqEhSx3e1CvoEif
         tki5+0jINXsu9Bv05Mi3Jn5FNnfn7MBsi79TRTxcHELAOQxbYci8RU8MShYeegvqvZ+C
         MVWlmuwalap+Z9l/tlFCD7FDzmBzY8SlZKV3iO0cgcAN+GDCEr7FIRZg30o0Bqy9HpKs
         R03WvIcSY219dJCphbydbH48iNF7RICGve0to9mLEFIE50M1qqdCd2gXxN9IE4hmVXkp
         3XMooVbxiuDzcHpcuL4WVlQ4hcUPvGNqT2RxEgZV47nCPHk2T3WXkJODYZa1bQ8H9ny9
         JCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vdhZQF3Fgnjc42DW844YSt5cmBXIBDuDCgG4Gq6CWIU=;
        b=itaGwYjxWHDPW45Y47VCekfp4K+aysLRXu0z6S+7buSnuKqSalhvbAi1H1DgXGNwZY
         JED4uBlIRWbddaAErkEEN0R9V0D3FHs0ZmFbmU+/tWHvhvo8iF1jOdGwXFMLH8VVcyuW
         UUJ+6KqYr804k/OebQHsSazUR1YTaJmmMFi8leSh7iQjrTJzK91+0Cf7LtPqh/yRDwMn
         YLPme6gom0Bp1+wYZ2+b5E022QdEzn6KnMZQiy3aQdhW7u4RLKyd+o+4poqnvz15MOas
         pfFKlRICfD+5FFDKQMe+nPYLAVuJAmtCASKXcY6pJYaxPK+PpIItw5oomGkGl6LebNjP
         PzRg==
X-Gm-Message-State: AJcUukcMl9HovjHHEwbH2ddchTRHJBLmqAo6nc7c8JspeWKRZa1M8zNR
        arZGMHyqWHypH8fw0x+E4uTJy29yJU49t6NQPIBsSQ==
X-Google-Smtp-Source: ALg8bN4dGdM1d/rKk0vQ88mH7a5iFS975akx5rjFqlkpLdSscRDAfWHScdDbIJkb1ZgKenxBWcoZlOAXKG4XeLi9aUo=
X-Received: by 2002:aca:bcc6:: with SMTP id m189mr1461800oif.337.1547838573326;
 Fri, 18 Jan 2019 11:09:33 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Jan 2019 20:09:07 +0100
Message-ID: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
Subject: [BUG] tiocsti() NULL dereference if ld->ops->receive_buf==NULL
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When a line discipline doesn't have a ->receive_buf handler, tiocsti()
attempts to call a NULL pointer. Both tty_n_tracesink and
spk_ttyio_ldisc_ops don't have such a handler.

To reproduce, build a kernel with CONFIG_SPEAKUP=y and
CONFIG_SPEAKUP_SYNTH_SOFT=y, set speakup.synth=soft in the kernel
command line, and run the following code as root:

=================
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <err.h>

void do_ioctl(int fd, unsigned long cmd, void *arg) {
  int res = ioctl(fd, cmd, arg);
  if (res < 0) {
    perror("ioctl");
  } else {
    printf("result %d\n", res);
  }
}

int main(void) {
  int fd = open("/dev/tty1", O_RDWR);
  if (fd == -1) err(1, "open");

  int disc = 26/*N_SPEAKUP*/;
  do_ioctl(fd, TIOCSETD, &disc);

  char c = 'A';
  do_ioctl(fd, TIOCSTI, &c);

  return 0;
}
=================

You should get this splat:
=================
[  124.609859] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000000
[  124.613510] #PF error: [INSTR]
[  124.614545] PGD 0 P4D 0
[  124.615249] Oops: 0010 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[...]
[  124.620994] RIP: 0010:          (null)
[  124.622016] Code: Bad RIP value.
[  124.622884] RSP: 0018:ffff8881d6c37ae0 EFLAGS: 00010246
[...]
[  124.643743] Call Trace:
[  124.644428]  ? tty_ioctl+0x5ec/0xbd0
[  124.645404]  ? tty_vhangup+0x20/0x20
[  124.646380]  ? preempt_count_add+0x8d/0xe0
[  124.647476]  ? _raw_spin_lock_irqsave+0x9a/0xf0
[  124.648702]  ? _raw_read_lock_irqsave+0x60/0x60
[  124.649966]  ? __wake_up_common+0x4b/0x1d0
[  124.651075]  ? preempt_count_sub+0x14/0xc0
[  124.652180]  ? _raw_spin_unlock_irqrestore+0x20/0x40
[  124.653508]  ? __wake_up_common_lock+0xd7/0x130
[  124.654740]  ? __wake_up_common+0x1d0/0x1d0
[  124.655870]  ? mutex_trylock+0x5f/0x90
[  124.656897]  ? ldsem_up_read+0x13/0x40
[  124.657940]  ? tty_write+0x2c7/0x450
[  124.658902]  ? n_tty_open+0xd0/0xd0
[  124.659868]  ? __vfs_write+0xc9/0x3b0
[  124.660876]  ? __anon_vma_prepare+0x159/0x240
[  124.662057]  ? preempt_count_add+0x8d/0xe0
[  124.663170]  ? do_vfs_ioctl+0x134/0x8f0
[  124.664220]  ? fsnotify+0x5ba/0x5e0
[  124.665169]  ? __lru_cache_add+0xc4/0x100
[  124.666255]  ? ioctl_preallocate+0x140/0x140
[  124.667383]  ? __fsnotify_inode_delete+0x20/0x20
[  124.668640]  ? vfs_write+0x120/0x230
[  124.669613]  ? ksys_ioctl+0x70/0x80
[  124.670570]  ? __x64_sys_ioctl+0x3d/0x50
[  124.671634]  ? do_syscall_64+0x73/0x160
[  124.672690]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  124.674099] Modules linked in: btrfs xor zstd_compress raid6_pq
[  124.676617] CR2: 0000000000000000
[  124.677523] ---[ end trace c5f555a92fe90edc ]---
[  124.678753] RIP: 0010:          (null)
[  124.679762] Code: Bad RIP value.
[...]
=================

I'm not familiar with the details of the TTY subsystem, so I'm not
sure how this should be fixed.
