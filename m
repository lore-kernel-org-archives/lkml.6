Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755771AbeEAQHC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:07:02 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:45678 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:06:59 -0400
X-Google-Smtp-Source: AB8JxZrId8ddkAYPs+9e25GOsNQHGamtSg/7aLjGQyOnklHCcaOlkXCez/oOLcycAFE6rCAEufEofocYNa04s5yRzEk=
MIME-Version: 1.0
References: <94eb2c05b2d83650030568cc8bd9@google.com> <e56c1600-8923-dd6b-d065-c2fd2a720404@I-love.SAKURA.ne.jp>
 <43302799-1c50-4cab-b974-9fe1ca584813@I-love.SAKURA.ne.jp>
In-Reply-To: <43302799-1c50-4cab-b974-9fe1ca584813@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 May 2018 16:06:48 +0000
Message-ID: <CA+55aFxaa_+uZ=bOVdevcUwG7ncue7O+i06q4Kb=bWACGwCBjQ@mail.gmail.com>
Subject: Re: INFO: task hung in wb_shutdown (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Tejun Heo <tj@kernel.org>,
        syzbot+c0cf869505e03bdf1a24@syzkaller.appspotmail.com,
        christophe.jaillet@wanadoo.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        zhangweiping@didichuxing.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 3:27 AM Tetsuo Handa <
penguin-kernel@i-love.sakura.ne.jp> wrote:

> Can you review this patch? syzbot has hit this bug for nearly 4000 times
but
> is still unable to find a reproducer. Therefore, the only way to test
would be
> to apply this patch upstream and test whether the problem is solved.

Looks ok to me, except:

> >       smp_wmb();
> >       clear_bit(WB_shutting_down, &wb->state);
> > +     smp_mb(); /* advised by wake_up_bit() */
> > +     wake_up_bit(&wb->state, WB_shutting_down);

This whole sequence really should just be a pattern with a helper function.

And honestly, the pattern probably *should* be

     clear_bit_unlock(bit, &mem);
     smp_mb__after_atomic()
     wake_up_bit(&mem, bit);

which looks like it is a bit cleaner wrt memory ordering rules.

             Linus
