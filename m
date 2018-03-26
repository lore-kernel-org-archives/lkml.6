Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeCZVzb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:55:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeCZVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:55:30 -0400
Date: Mon, 26 Mar 2018 14:55:22 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Moyer <jmoyer@redhat.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tianhong Ding <dingtianhong@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 1/1] aio: make sure the input "timeout" value is valid
Message-ID: <20180326215522.GA409@bombadil.infradead.org>
References: <1513172572-16724-1-git-send-email-thunder.leizhen@huawei.com>
 <20171213141112.GA11217@bombadil.infradead.org>
 <x49y3m6a90r.fsf@segfault.boston.devel.redhat.com>
 <20171213193100.GA19700@bombadil.infradead.org>
 <5A31ED86.5000800@huawei.com>
 <20180102145155.GD8222@bombadil.infradead.org>
 <x49tvvqdfhu.fsf@segfault.boston.devel.redhat.com>
 <CAK8P3a3jb1cJEiyHA-G_HgmMFoN4Lb3YVnXzLkX+tUysd_YZgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3jb1cJEiyHA-G_HgmMFoN4Lb3YVnXzLkX+tUysd_YZgw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:01:30PM +0200, Arnd Bergmann wrote:
> I had suggested a more complete helper function at some point,
> to take care of all combinations of checking/non-checking, 32/64
> bit, microsecond/nanosecond, and zeroing/checking the upper 32 bits
> of nanoseconds before comparing against 1 billion, but Deepa
> thought that was overkill, so I didn't continue that.

Yeah, that sounds like a nightmare to use ;-)

> For all I can tell, the get_timespec64() helper should almost always
> include the check, the one exception I know is utimensat() and related
> functions that may encode the special UTIME_NOW and UTIME_OMIT
> constants in the nanoseconds.

So do you endorse the get_valid_timespec64() patch I posted up-thread?
We can't just make get_timespec64 return an errno directly because it'll
require changing all the users.
