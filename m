Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeDLV1f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:27:35 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34964 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDLV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:27:33 -0400
X-Google-Smtp-Source: AIpwx4+xkHQYxXfuZ/QUcDUK1H4E2va6ZP1Lpkyxeq+5+VeAFsYoEFTMYzjf/R/1/C2ja+KXv0M1YJwBhYB8d/oOobo=
MIME-Version: 1.0
In-Reply-To: <20180412212203.GD18364@bombadil.infradead.org>
References: <20180313132639.17387-1-willy@infradead.org> <20180313132639.17387-8-willy@infradead.org>
 <CAOxpaSXDX1fyrOnnsehEoRgQz2_K1OmOn9TikZzJcXmwMLEfnA@mail.gmail.com>
 <20180412211036.GB18364@bombadil.infradead.org> <CAOxpaSV5L_O9zO_+JLXk9e3SMjm0Gc90ZxSEHaJmvN5YsYpjMA@mail.gmail.com>
 <20180412212203.GD18364@bombadil.infradead.org>
From: Ross Zwisler <zwisler@gmail.com>
Date: Thu, 12 Apr 2018 15:27:32 -0600
Message-ID: <CAOxpaSWbgoNYOW81ves7Ry+Qyu1-WDPci4dLy1b2p+LjEDwQnA@mail.gmail.com>
Subject: Re: [PATCH v9 07/61] xarray: Add the xa_lock to the radix_tree_root
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3CLRfQg016096

On Thu, Apr 12, 2018 at 3:22 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Apr 12, 2018 at 03:16:23PM -0600, Ross Zwisler wrote:
>> On Thu, Apr 12, 2018 at 3:10 PM, Matthew Wilcox <willy@infradead.org> wrote:
>> > On Thu, Apr 12, 2018 at 02:59:32PM -0600, Ross Zwisler wrote:
>> >> This is causing build breakage in the radix tree test suite in the
>> >> current linux/master:
>> >>
>> >> ./linux/../../../../include/linux/idr.h: In function ‘idr_init_base’:
>> >> ./linux/../../../../include/linux/radix-tree.h:129:2: warning:
>> >> implicit declaration of function ‘spin_lock_init’; did you mean
>> >> ‘spinlock_t’? [-Wimplicit-function-declaration]
>> >
>> > Argh.  That was added two patches later in
>> > "xarray: Add definition of struct xarray":
>> >
>> > diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
>> > index b21b586b9854..4ec4d2cbe27a 100644
>> > --- a/tools/include/linux/spinlock.h
>> > +++ b/tools/include/linux/spinlock.h
>> > @@ -6,8 +6,9 @@
>> >  #include <stdbool.h>
>> >
>> >  #define spinlock_t             pthread_mutex_t
>> > -#define DEFINE_SPINLOCK(x)     pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER;
>> > +#define DEFINE_SPINLOCK(x)     pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER
>> >  #define __SPIN_LOCK_UNLOCKED(x)        (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER
>> > +#define spin_lock_init(x)      pthread_mutex_init(x, NULL)
>> >
>> >  #define spin_lock_irqsave(x, f)                (void)f, pthread_mutex_lock(x)
>> >  #define spin_unlock_irqrestore(x, f)   (void)f, pthread_mutex_unlock(x)
>> >
>> > I didn't pick up that it was needed this early on in the patch series.
>>
>> Hmmm..I don't know if it's a patch ordering issue, because this
>> happens with the current linux/master where presumably all the patches
>> are present?
>
> No, Andrew only merged the first 8 or so because of lack of review of
> the remaining patches.  Even though I cc'd people as hard as I could.
> Including you.  :-P
>
> You could, for example, review the DAX patches ...

Fair enough.  Let's get the radix tree working, and in the mean time
I'll throw it into my xfstests testing setup & take a look at the DAX
patches.
