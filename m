Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A11F2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6/eRKgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A11F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJDGUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:20:07 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43319 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeJDGUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:20:07 -0400
Received: by mail-vs1-f66.google.com with SMTP id w85so4292722vsa.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1xKyCTqkGodrMXwT4FNRd452xuOJpzcrw2xtPBbAG3E=;
        b=l6/eRKgUe8nSFJYdeh1UpSJM5Y/LjSb0K+GRMQzMogFTVUEqtm0fNpbcPATMWMLhGC
         8i0Dtg43zKcNtyrmDD+w4A0Sr8MBJknYDKKeR+zqaQWwLJ85RWevAK32TZsdht7I/e1A
         f/tiCqllibzMmtygeiNLOihyhKffYKT+YDKSIbZkWFgPro97wpLpvJP31e7E26MZlB9y
         KLvuaopJqRrkwrgdP1dFVMOYJnGob89k33vyJgF4RlR1092XuYqHn3T3XAI19dLri2mg
         3u6UzkjrbXuUwscoADa22GTIhvDILjBOz2wZuS5wIvXrTJbmcy4shDW8nrrbEbcqunP3
         5UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1xKyCTqkGodrMXwT4FNRd452xuOJpzcrw2xtPBbAG3E=;
        b=WsplokGu1B7T2kWIhGQ8fP148KsvficBU8ShlttwlEOy98xEpmzEchUZKut2FtWjfE
         9j+4oVO7hwFcfI48/byGH21eoPXUAxYlJ51ssV2sl3teQFHsRceV53eqwowQ5aJoenrX
         BlBa11HERbgquKYIUlWRGkTj0dRY1BB897QUwYsplDXYk3Vg76oAeCwSjsVHHOunD69w
         iWAGaWJHP56LhpV3qGu1+LmoZ1oSwZHwBR+YDN7Ct+07xwlTOfSXau60gb949P/MdKAl
         5znWoOH8HTOrLM4hRba9lcst0OuTTTsb/68x6xOai8tf0zxPwVU5D6opJnMBnWJqdYOt
         SK5w==
X-Gm-Message-State: ABuFfogBAnqINx4zYU9RXfmrm9IENxURGi2/TBKSUc3YEmeG+GAqmElE
        tph8JzEbgArc8t6Kt4vLd1poxJ2MQBVN+W+03YShWVLN
X-Google-Smtp-Source: ACcGV61NtaswqI+zaFNBSpvBMAKzPsPogwAlZuWeXuheRxU8h97gkIwy3AtczKeJC1JHpHfLBLfvezLYoYRsFrOFoVk=
X-Received: by 2002:a67:dc15:: with SMTP id x21mr1249761vsj.111.1538609374785;
 Wed, 03 Oct 2018 16:29:34 -0700 (PDT)
MIME-Version: 1.0
From:   Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Date:   Wed, 3 Oct 2018 17:29:23 -0600
Message-ID: <CAOTh5U3srTK_-OeESDL_-=M8petsorTDfzr6Ycte9f7p+5ZLCQ@mail.gmail.com>
Subject: hung task in 4.14 (syzbot bug from 2018 April 17)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think i've run into the bug described here:

https://lkml.org/lkml/2018/4/18/188

I've got a binder-free system that reports a hung task with this backtrace:

[76800.726654] INFO: task systemd:1 blocked for more than 60 seconds.
[76800.726657]       Tainted: G           OE   4.14.67-solidfire1 #1
[76800.726657] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[76800.726659] systemd         D    0     1      0 0x00000000
[76800.726662] Call Trace:
[76800.726673]  ? __schedule+0x27f/0x870
[76800.726676]  schedule+0x28/0x80
[76800.726679]  schedule_timeout+0x1e7/0x340
[76800.726685]  ? check_preempt_wakeup+0x102/0x230
[76800.726687]  ? wait_for_completion+0xb0/0x120
[76800.726689]  wait_for_completion+0xb0/0x120
[76800.726693]  ? wake_up_q+0x70/0x70
[76800.726698]  flush_work+0x10d/0x1c0
[76800.726700]  ? worker_detach_from_pool+0xa0/0xa0
[76800.726706]  fsnotify_destroy_group+0x34/0xa0
[76800.726708]  ? SyS_epoll_ctl+0x1d4/0xe50
[76800.726710]  inotify_release+0x1a/0x50
[76800.726714]  __fput+0xd8/0x220
[76800.726717]  task_work_run+0x8a/0xb0
[76800.726721]  exit_to_usermode_loop+0xb9/0xc0
[76800.726723]  do_syscall_64+0x10b/0x120
[76800.726727]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[76800.726730] RIP: 0033:0x7fb6957ff900
[76800.726731] RSP: 002b:00007ffc685fdd60 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[76800.726733] RAX: 0000000000000000 RBX: 0000000000000012 RCX: 00007fb6957ff900
[76800.726735] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000012
[76800.726736] RBP: 00007fb697167088 R08: 000055ae6c9224c0 R09: 000055ae6ace92ad
[76800.726737] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[76800.726738] R13: 0000000000000000 R14: 0000000000079de4 R15: 0000000000000000
[76800.727130] INFO: task kworker/u113:1:29214 blocked for more than 60 seconds.
[76800.727132]       Tainted: G           OE   4.14.67-solidfire1 #1
[76800.727132] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[76800.727134] kworker/u113:1  D    0 29214      2 0x80000000
[76800.727139] Workqueue: events_unbound fsnotify_mark_destroy_workfn
[76800.727141] Call Trace:
[76800.727144]  ? __schedule+0x27f/0x870
[76800.727146]  schedule+0x28/0x80
[76800.727148]  schedule_timeout+0x1e7/0x340
[76800.727151]  ? __switch_to_asm+0x40/0x70
[76800.727153]  ? update_curr+0xe1/0x1a0
[76800.727156]  ? wait_for_completion+0xb0/0x120
[76800.727157]  wait_for_completion+0xb0/0x120
[76800.727160]  ? wake_up_q+0x70/0x70
[76800.727164]  __synchronize_srcu.part.13+0x76/0x90
[76800.727167]  ? trace_raw_output_rcu_utilization+0x40/0x40
[76800.727169]  ? try_to_wake_up+0x44/0x460
[76800.727172]  ? fsnotify_mark_destroy_workfn+0x67/0xb0
[76800.727174]  fsnotify_mark_destroy_workfn+0x67/0xb0
[76800.727177]  process_one_work+0x1da/0x3d0
[76800.727179]  worker_thread+0x21f/0x3f0
[76800.727181]  ? process_one_work+0x3d0/0x3d0
[76800.727184]  kthread+0x119/0x130
[76800.727186]  ? kthread_create_on_node+0x40/0x40
[76800.727188]  ret_from_fork+0x35/0x40

The kernel is a stock 4.14.67, plus some minor local patches mostly
related to fibre channel, which i believe is not implicated here.

I have a crash dump of this failure, the reaper_work struct has these contents:

        crash> print reaper_work
        $2 = {
          work = {
            data = {
              counter = -108686497013755
            },
            entry = {
              next = 0xffff9d2671a395f0,
              prev = 0xffffb2624006fdf8
            },
            func = 0xffffffffb5249df0
          },
          timer = {
            entry = {
              next = 0xdead000000000200,
              pprev = 0x0
            },
            expires = 4302608557,
            function = 0xffffffffb50778c0,
            data = 18446744072468618080,
            flags = 195035137
          },
          wq = 0xffff9d2680411400,
          cpu = 128
        }

I'd appreciate help or pointers on how to debug and fix this problem.


-- 
Sebastian Kuzminsky
