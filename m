Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736FDC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C432084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4/BqEEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfASCIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 21:08:12 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46290 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfASCIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 21:08:12 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so5298570uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 18:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=e37RX7c2yvU7uBxeM/Qe25/S/2VaJKqBuy2XSeG777c=;
        b=L4/BqEEIeWIUag8hxhbbY41u6miSNYJesHEtGW1mhrd+lQwSq5osczuS7UkVtha7nC
         ksQmlzR5VqB8c3ka96VuCHNSi1br6bryNCkTrrF4wQgyuRESNWVYY5hRDoJPrZFNn3So
         yR/FnuHV62X1KVmY6sIlyK6K4lpXWFW2PoZHjzOe2ONXbTChMTPfj9A/KJG6v2MwvTnH
         opY1rZCvRC26pkJw2qryxB6PIkoJeqcsuhd7et9qvFixYA+qHGTTqlVXwfhTkcpyghQz
         QSMXOOiBONcgMwxXvHPVdbN6HfPrAlfyKXKV9b4PGQf9JGUCY4LBzEArrnUdWs4kIqSc
         2UPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=e37RX7c2yvU7uBxeM/Qe25/S/2VaJKqBuy2XSeG777c=;
        b=lCvE570JjIIOwQrW2nWwadO7mvuMgYzFMystRbrR5OrLmkKAaIXSQE7/8h8EcT9pL0
         tIbjcgXIYWre8x1eIadhyQB6B1CGLqCgZopLusc1ppROCQVS0SXauJQcYhH1FL4Ca31U
         r/zErv4Zzm43tjMzrd9zz9kk+uqjIZ45J//IFMuP8w1INgMN7tggTXVGE6Dir9Hdmw7+
         fyQG3ec7SjqbVcNvFL0RIsx76s6d0RRnoxLOsrOmDzoWg2Irs1u0k2nNIEUFLvJ/m9i8
         ZAtth/kOE5KFzOSbFD0dAFjbIkiQ7RwDfWFLkw0UuZJnGKubqaQ71dUoKvzdVer1QkBi
         PFQA==
X-Gm-Message-State: AJcUukdyq1XQFtTDxp+SYQMaPMNKA4YdnCDDYJgKO/p/7zZIxOUnjgHw
        M9AU+Mat7fXS3wvcjK/38/6RSrLUYqvvXClH/DKdGfg=
X-Google-Smtp-Source: ALg8bN67DKO1oJO30wvFDtSFaQ4tQ2MNLEdHNHYMJLWMckGN1uD8VUF/HK0nzIszZs/0PDPYKOpEGTcY+w2G5tEOtyE=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr8227084uad.78.1547863690819;
 Fri, 18 Jan 2019 18:08:10 -0800 (PST)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Fri, 18 Jan 2019 21:07:59 -0500
Message-ID: <CAP8WD_ai+KHkaEoOj7iPAZO0qRPj7FspUOv0JtbG2-_DtmpeyQ@mail.gmail.com>
Subject: [REGRESSION 3.16.61] x86/vdso: Fix asm constraints on vDSO syscall fallbacks
To:     Andy Lutomirski <luto@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I bisected a bug than manifests itself on 32-bit i386 architectures to
commit 4f9007359bcd28bc83c63cb9af38d8b2c8c1670d for long term kernel
3.16.61. It appears as one of two cases, varying by cpu architecture.

All of them fail with an error message variation of "systemd[1]:
Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' ". The
difference is whether it freezes systemd or causes a kernel panic.

I do not see this problem with the upstream kernel, so 3.16 probably
needs a missing upstream patch.

Below are two representative failure messages.

# AMD K5
[    3.063769] systemd[1]: Assertion
'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at
../systemd-238/src/basic/time-util.c:69, function now(). Aborting.
[    3.083821] systemd[1]: Caught <ABRT>, core dump failed (child 40,
code=killed, status=6/ABRT).
[    3.086399] systemd[1]: Freezing execution.

# Pentium Pro
Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at
../systemd-238/src/basic/time-util.c:69, function now(). Aborting.
[   29.573184] traps: systemd[1] general protection ip:b7153bb7
sp:bfb43d40 error:0 in libc-2.25.so[b7123000+1bc000]
[   29.590392] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[   29.590392]
[   29.592863] CPU: 1 PID: 1 Comm: systemd Not tainted
3.16.61.bisect-14.pentiumpro-server #221
[   29.592863]  00000000 00000086 f683be28 c1310eb1 f682c860 f682c860
f683be40 c130fa0d
[   29.592863]  f682c860 f682c860 f682c860 c14eafd0 f683be88 c1026058
c144b48d 0000000b
[   29.592863]  f682cc1e f683be60 c102e537 f682cc1c 00000001 f682c860
c102e896 f682cbc8
[   29.592863] Call Trace:
[   29.592863]  [<c1310eb1>] dump_stack+0x47/0x5b
[   29.592863]  [<c130fa0d>] panic+0x81/0x190
[   29.592863]  [<c1026058>] do_exit+0x3b2/0x72a
[   29.592863]  [<c102e537>] ? __sigqueue_free+0x32/0x35
[   29.592863]  [<c102e896>] ? recalc_sigpending_tsk+0xa/0x61
[   29.592863]  [<c1026ef9>] do_group_exit+0x37/0x84
[   29.592863]  [<c1030ce0>] get_signal_to_deliver+0x48c/0x4c6
[   29.592863]  [<c1001797>] do_signal+0x35/0x57d
[   29.592863]  [<c10afdc2>] ? slob_alloc.isra.11+0xb6/0x178
[   29.592863]  [<c1044ab7>] ? try_to_wake_up+0x194/0x19e
[   29.592863]  [<c102f677>] ? __send_signal.constprop.26+0x24c/0x256
[   29.592863]  [<c102fc60>] ? force_sig_info+0x96/0xa0
[   29.592863]  [<c1002549>] ? do_alignment_check+0x1a/0x1a
[   29.592863]  [<c1001cf4>] do_notify_resume+0x15/0x3f
[   29.592863]  [<c1314c6d>] work_notifysig+0x1a/0x21
[   29.592863]  [<c1002549>] ? do_alignment_check+0x1a/0x1a
[   29.592863] Kernel Offset: 0x0 from 0xc1000000 (relocation range:
0xc0000000-0xf7ffdfff)
[   29.592863] Rebooting in 45 seconds..

- Matthew
