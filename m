Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0D4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4083822B63
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4083822B63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeGFWzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:55:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeGFWzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:55:17 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2CE5D1F;
        Fri,  6 Jul 2018 22:55:16 +0000 (UTC)
Date:   Fri, 6 Jul 2018 15:55:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     osalvador@techadventures.net,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] fs, elf: Make sure to page align bss in
 load_elf_library
Message-Id: <20180706155515.f86d8394f8aae8bb841e2572@linux-foundation.org>
In-Reply-To: <CAGXu5jL4O_qwwAHmW1C8q77Jv1fe_1JCq6iFxC73VySBkvHSQw@mail.gmail.com>
References: <20180705145539.9627-1-osalvador@techadventures.net>
        <CAGXu5jL4O_qwwAHmW1C8q77Jv1fe_1JCq6iFxC73VySBkvHSQw@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 08:44:18 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Thu, Jul 5, 2018 at 7:55 AM,  <osalvador@techadventures.net> wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> >
> > The current code does not make sure to page align bss before calling
> > vm_brk(), and this can lead to a VM_BUG_ON() in __mm_populate()
> > due to the requested lenght not being correctly aligned.
> >
> > Let us make sure to align it properly.
> >
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Reported-by: syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com
> 
> Wow. CONFIG_USELIB? I'm surprised distros are still using this. 32-bit
> only, and libc5 and earlier only.

Presumably doesn't happen much, but people who *are* enabling this will
want the fix, so I added the cc:stable.

