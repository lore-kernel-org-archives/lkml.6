Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5288C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AEB20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AEB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeKUADB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:03:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35710 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeKUADA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:03:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so2822944qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRRfFhQYsufkek91ut1rCbs1nKF3pGlQqRjtcE+djQM=;
        b=o9GPmUd+Gp9HqGy8WOZCbsUJ6jqLhLn52jj3iIPDpAYQyqcMIpYU6lB3MCmT4Sz992
         1UXVcfeJd7qKDtIbMUqwlExMebxKqA7fpKnCTNuy9VwKdEemoJzBdCKwBE9/1mD8C+k4
         jDYCGiPNwl5mT5nPhrfJvg39xxuFFluh294vwT73gGEoOoGlHRTZLqppdCXtMyK/SXMQ
         O51G08jiPgsbE1ojg7mwHApXYK+jxX0AOB4LWz0MA0Y7ABD0cIqIMs5HvCskuDAlSNoy
         VKfNEcZOBeAKlW3cJrikoARq+qS/qziKka2rlZDwPQ3K5tDdkShKY85+NomYg96nK5xc
         ErHQ==
X-Gm-Message-State: AGRZ1gLEB69Q/NcZesj4GhAKSNurKvkNEVujWIZSIPpg2rBo+SFk2LBh
        Xjl5s00CIVZgKCUmAShKgHoVnCDHvbyAPCyoXMWfCSib
X-Google-Smtp-Source: AFSGD/XP/DUvAtrdrz2WiSTxItDJYVb7eNb2RdUnCgjEaxggbdKVQgFDjMlOqlexvH/dki27ZtqDpohSy3/Q+Ig4rik=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr1817989qtm.96.1542720829050;
 Tue, 20 Nov 2018 05:33:49 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamud-6uX8EmOZy7s6ubWNg=0E1YQZSGK2-SnfsomK8VnGw@mail.gmail.com>
In-Reply-To: <CAEAjamud-6uX8EmOZy7s6ubWNg=0E1YQZSGK2-SnfsomK8VnGw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 20 Nov 2018 14:33:32 +0100
Message-ID: <CAK8P3a2SnRF9198W4W81WwzEX6yCKFjBLTtTo+97Qcym=99Akg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in write_port
To:     kt0755@gmail.com
Cc:     gregkh <gregkh@linuxfoundation.org>, lifeasageek@gmail.com,
        threeearcat@gmail.com, syzkaller@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 9:24 AM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> We report a bug in v4.19-rc8 (4.20-rc1 as well):
>
> kernel config: https://kt0755.github.io/etc/config-4.19-rc2.kmsan
> repro: https://kt0755.github.io/etc/repro.e3752.c
>
> This happens during data transition from user-supplied buffer to port
> (using outb) pointed by ppos. (driver/mem/char.c:640)
> Although there is a strict bound 65536 (driver/mem/char.c:632), user
> buffer copy still causes crashes within the strict bound.
> (In the experiment, the crash arose when loop count is beyond 0x7f )
> To stop it, it probably needs a little tight bound check.
>
> I think this is a little bit related to the crash I reported before
> (https://lkml.org/lkml/2018/5/12/91)
>
> Crash log
> =========================================
> BUG: unable to handle kernel NULL pointer dereference at 00000000000000af

The first thing that comes to mind is that this would be qemu specific.
Note that writing arbitrary data into arbitrary I/O ports is likely to crash
any x86 PC, but it's possible that qemu reports a different set of
exceptions.

Looking in /proc/ioports for a real PC, I find

    0080-008f : dma page reg
    00a0-00a1 : pic2
    00c0-00df : dma2
    00f0-00ff : fpu

so it appears that you have just written into the interrupt
controller here.

       Arnd
