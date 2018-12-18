Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F90AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1869021841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeLRIjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:39:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:45120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbeLRIjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:39:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC58DAFC5;
        Tue, 18 Dec 2018 08:39:12 +0000 (UTC)
Date:   Tue, 18 Dec 2018 09:39:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz>
References: <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
 <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-18 06:05:04, Tetsuo Handa wrote:
> >From 91f85d2bd494df2f73c605d8b4747e8cc0a61ae2 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 18 Dec 2018 05:53:04 +0900
> Subject: [PATCH] printk: Add caller information to printk() output.
> 
> Sometimes we want to print a series of printk() messages to consoles
> without being disturbed by concurrent printk() from interrupts and/or
> other threads. But we can't enforce printk() callers to use their local
> buffers because we need to ask them to make too much changes. Also, even
> buffering up to one line inside printk() might cause failing to emit
> an important clue under critical situation.
> 
> Therefore, instead of trying to help buffering, let's try to help
> reconstructing messages by saving caller information as of calling
> log_store() and adding it as "[T$thread_id]" or "[C$processor_id]"
> upon printing to consoles.
> 
> Some examples for console output:
> 
>   [    1.222773][    T1] x86: Booting SMP configuration:
>   [    2.779635][    T1] pci 0000:00:01.0: PCI bridge to [bus 01]
>   [    5.069193][  T268] Fusion MPT base driver 3.04.20
>   [    9.316504][    C2] random: fast init done
>   [   13.413336][ T3355] Initialized host personality
> 
> Some examples for /dev/kmsg output:
> 
>   6,496,1222773,-,caller=T1;x86: Booting SMP configuration:
>   6,968,2779635,-,caller=T1;pci 0000:00:01.0: PCI bridge to [bus 01]
>    SUBSYSTEM=pci
>    DEVICE=+pci:0000:00:01.0
>   6,1353,5069193,-,caller=T268;Fusion MPT base driver 3.04.20
>   5,1526,9316504,-,caller=C2;random: fast init done
>   6,1575,13413336,-,caller=T3355;Initialized host personality
> 
> Note that this patch changes max length of messages which can be printed
> by printk() or written to /dev/kmsg interface from 992 bytes to 976 bytes,
> based on an assumption that userspace won't try to write messages hitting
> that border line to /dev/kmsg interface.
> 
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Sergey, are you okay with this squashed patch, please?

Best Regards,
Petr
