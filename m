Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeC0EnI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:43:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42548 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbeC0EnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:43:04 -0400
X-Google-Smtp-Source: AG47ELsvSkZpR8LryflaVe7pfMiabHziAi8B0VY6lsgKDFUxk92e/Q0U7kgwFXyH+X7VoxYzwOk5IrU7GEVB8xxVqNk=
MIME-Version: 1.0
In-Reply-To: <20180326215522.GA409@bombadil.infradead.org>
References: <1513172572-16724-1-git-send-email-thunder.leizhen@huawei.com>
 <20171213141112.GA11217@bombadil.infradead.org> <x49y3m6a90r.fsf@segfault.boston.devel.redhat.com>
 <20171213193100.GA19700@bombadil.infradead.org> <5A31ED86.5000800@huawei.com>
 <20180102145155.GD8222@bombadil.infradead.org> <x49tvvqdfhu.fsf@segfault.boston.devel.redhat.com>
 <CAK8P3a3jb1cJEiyHA-G_HgmMFoN4Lb3YVnXzLkX+tUysd_YZgw@mail.gmail.com> <20180326215522.GA409@bombadil.infradead.org>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Mon, 26 Mar 2018 21:43:03 -0700
Message-ID: <CABeXuvqk1npq6ROEyF6O-uedkM1OV-zyfeAUcj3yeS-WP6GMQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] aio: make sure the input "timeout" value is valid
To: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tianhong Ding <dingtianhong@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 2:55 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Mar 26, 2018 at 10:01:30PM +0200, Arnd Bergmann wrote:
>> I had suggested a more complete helper function at some point,
>> to take care of all combinations of checking/non-checking, 32/64
>> bit, microsecond/nanosecond, and zeroing/checking the upper 32 bits
>> of nanoseconds before comparing against 1 billion, but Deepa
>> thought that was overkill, so I didn't continue that.
>
> Yeah, that sounds like a nightmare to use ;-)
>
>> For all I can tell, the get_timespec64() helper should almost always
>> include the check, the one exception I know is utimensat() and related
>> functions that may encode the special UTIME_NOW and UTIME_OMIT
>> constants in the nanoseconds.
>
> So do you endorse the get_valid_timespec64() patch I posted up-thread?
> We can't just make get_timespec64 return an errno directly because it'll
> require changing all the users.

I missed this thread earlier.

I had leaned away from this idea before, because of the special cases
which don't need it. I was also trying to keep the syntax close to
copy_from_user(), which is what was there before.

We could probably just change all the
get_timespec64()/compat_get_timespec64() to do the check using a
simple coccinelle script.
I can own this.

But, this would not be needed if Arnd is posting the other helper function.
Arnd, let me know what you prefer here.

-Deepa
