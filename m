Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCZUBe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:01:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38202 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeCZUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:01:32 -0400
X-Google-Smtp-Source: AG47ELtAblKA643YLddw2Zucrx1oZwKx8m3v8t7BK91zp41rsrHmYFnbVRw2idU0nHw3JaY3cvm/1ojQGwwNqin+xSE=
MIME-Version: 1.0
In-Reply-To: <x49tvvqdfhu.fsf@segfault.boston.devel.redhat.com>
References: <1513172572-16724-1-git-send-email-thunder.leizhen@huawei.com>
 <20171213141112.GA11217@bombadil.infradead.org> <x49y3m6a90r.fsf@segfault.boston.devel.redhat.com>
 <20171213193100.GA19700@bombadil.infradead.org> <5A31ED86.5000800@huawei.com>
 <20180102145155.GD8222@bombadil.infradead.org> <x49tvvqdfhu.fsf@segfault.boston.devel.redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 22:01:30 +0200
X-Google-Sender-Auth: NQv3E5eP9DAs8CGmglaH_oeOg-4
Message-ID: <CAK8P3a3jb1cJEiyHA-G_HgmMFoN4Lb3YVnXzLkX+tUysd_YZgw@mail.gmail.com>
Subject: Re: [PATCH 1/1] aio: make sure the input "timeout" value is valid
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2018 at 8:49 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Thu, Dec 14, 2017 at 11:18:30AM +0800, Leizhen (ThunderTown) wrote:
>>> On 2017/12/14 3:31, Matthew Wilcox wrote:
>>> > On Wed, Dec 13, 2017 at 11:27:00AM -0500, Jeff Moyer wrote:
>>> >> Matthew Wilcox <willy@infradead.org> writes:
>>> >>
>>> >>> On Wed, Dec 13, 2017 at 09:42:52PM +0800, Zhen Lei wrote:
>>> >>>> Below information is reported by a lower kernel version, and I saw the
>>> >>>> problem still exist in current version.
>>> >>>
>>> >>> I think you're right, but what an awful interface we have here!
>>> >>> The user must not only fetch it, they must validate it separately?
>>> >>> And if they forget, then userspace is provoking undefined behaviour?  Ugh.
>>> >>> Why not this:
>>> >>
>>> >> Why not go a step further and have get_timespec64 check for validity?
>>> >> I wonder what caller doesn't want that to happen...
>>> I tried this before. But I found some places call get_timespec64 in the following function.
>>> If we do the check in get_timespec64, the check will be duplicated.
>>>
>>> For example:
>>> static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
>>> ....
>>>      if (get_timespec64(&ts, tsp))
>>>              return -EFAULT;
>>>
>>>      to = &end_time;
>>>      if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
>>>
>>> int poll_select_set_timeout(struct timespec64 *to, time64_t sec, long nsec)
>>> {
>>>      struct timespec64 ts = {.tv_sec = sec, .tv_nsec = nsec};
>>>
>>>      if (!timespec64_valid(&ts))
>>>              return -EINVAL;
>>
>> The check is only two comparisons!  Why do we have an interface that can
>> cause bugs for the sake of saving *two comparisons*?!  Can we talk about
>> the cost of a cache miss versus the cost of executing these comparisons?
>
> Any update on this?  Willy, I'd be okay with your get_valid_timespec64
> patch if you wanted to formally submit that.

I had suggested a more complete helper function at some point,
to take care of all combinations of checking/non-checking, 32/64
bit, microsecond/nanosecond, and zeroing/checking the upper 32 bits
of nanoseconds before comparing against 1 billion, but Deepa
thought that was overkill, so I didn't continue that.

For all I can tell, the get_timespec64() helper should almost always
include the check, the one exception I know is utimensat() and related
functions that may encode the special UTIME_NOW and UTIME_OMIT
constants in the nanoseconds.

        Arnd
