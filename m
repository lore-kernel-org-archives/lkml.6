Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2805C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9A0206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GvQMLivU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9A0206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeIJXJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:09:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33431 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:09:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so42055907oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nr03am6QHgfX8f7Sz/7N3Thw4Y5UGcO2yrMwa4bFQaw=;
        b=GvQMLivU/gUjAAXMbww7POc6Zbvp5D/aP7dG/BbLuuI8NPTIlpawOoWBlY1dU0VBqD
         /smtIg076gY257Yq0tUX9vdr3stT+3IZOfS4M8XQXdk7N+GtG1uxh1Fg6fk++MYAXiSX
         Xqb0dsorxyLSVoWjyo33M77JcbCXhu5PupEL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nr03am6QHgfX8f7Sz/7N3Thw4Y5UGcO2yrMwa4bFQaw=;
        b=YaVERS11WeFjYNul1O0alfsRnTw9Ua456hpQ1EamC42Eih5yNQV/PUlbKN9qy5/3it
         g+gqe7Jqe+SpdkRRMhING7RjZ6ScnmLHCt6LX0O3Jh91luFTaELj6htdMTa0PnNRAVWj
         PqbdLFfd2Xjy3WddmqyU+ozRwdnappjx4YPQAOzo6jtwYS0/X5fX/Af/wCrLgva3hbIs
         NzZKT0hR8oVI7ysF/2Hy38bUcQYZmOekYuzGO84Dk4Tk0eyAzKYDMkBowyG4HrrtbVPP
         qOCjD3R/IhnXlV5xK3FMMWzpWBTDkBHoLJFmcC+uhM+xows+TTQwq+imFqfp69ZF6sl0
         SPKg==
X-Gm-Message-State: APzg51CGdBGrLOg9r9yoVAschdFaKeypJEYTmuwRuDwd++j8klg/fRBE
        qV42St561Gwi2pM7iQV5uq0bT1DR6bzOPmCVHGYO/w==
X-Google-Smtp-Source: ANB0VdYboOtlLEopcTE+DKyJL8iRFbS2U1pnUPwMEbOwSjJs4X8xdpf9SgMM2peUUe6+yRBWMDgd4NLVtSaxs9RigWI=
X-Received: by 2002:aca:aa8d:: with SMTP id t135-v6mr21029423oie.218.1536603261249;
 Mon, 10 Sep 2018 11:14:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:24a3:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 11:14:20
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180910165317.GA3237@infradead.org>
References: <000000000000cbb35d05757f7a3a@google.com> <20180910165317.GA3237@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 Sep 2018 20:14:20 +0200
Message-ID: <CAJfpeguWqJgU8EfjvOtsBYRbbY2J7Ck2oNUcLNS8my9g2eNZfA@mail.gmail.com>
Subject: Re: possible deadlock in aio_poll
To:     Christoph Hellwig <hch@infradead.org>
Cc:     syzbot <syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com>,
        bcrl <bcrl@kvack.org>, linux-aio <linux-aio@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 6:53 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 12:41:05AM -0700, syzbot wrote:
>> =====================================================
>> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
>> 4.19.0-rc2+ #229 Not tainted
>> -----------------------------------------------------
>> syz-executor2/9399 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>> 00000000126506e0 (&ctx->fd_wqh){+.+.}, at: spin_lock
>> include/linux/spinlock.h:329 [inline]
>> 00000000126506e0 (&ctx->fd_wqh){+.+.}, at: aio_poll+0x760/0x1420
>> fs/aio.c:1747
>>
>> and this task is already holding:
>> 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
>> include/linux/spinlock.h:354 [inline]
>> 000000002bed6bf6 (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll+0x738/0x1420
>> fs/aio.c:1746
>> which would create a new lock dependency:
>>  (&(&ctx->ctx_lock)->rlock){..-.} -> (&ctx->fd_wqh){+.+.}
>
> ctx->fd_wqh seems to only exist in userfaultfd, which indeed seems
> to do strange open coded waitqueue locking, and seems to fail to disable
> irqs.  Something like this should fix it:

Why do pollable waitqueues need to disable interrupts generally?

I don't see anything fundamental in the poll interface to force this
requirement on users of that interface.

Thanks,
Miklos
