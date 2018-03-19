Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeCSI24 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:28:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34646 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932696AbeCSI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:28:48 -0400
Subject: Re: [PATCH] jffs2: remove fd from the f->dents list immediately.
To: David Woodhouse <dwmw2@infradead.org>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
References: <20180316110522.1120-1-yuyufen@huawei.com>
 <1521203963.4790.208.camel@infinera.com>
 <1521204767.20126.123.camel@infradead.org>
From: yuyufen <yuyufen@huawei.com>
Message-ID: <8bce38ca-aa2e-1928-4807-5571f91ae1c8@huawei.com>
Date: Mon, 19 Mar 2018 16:27:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1521204767.20126.123.camel@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David

On 2018/3/16 20:52, David Woodhouse wrote:
> On Fri, 2018-03-16 at 12:39 +0000, Joakim Tjernlund wrote:
>>> After reverting the commit, we test 'rm -r', which can remove all
>>> files, and all seems OK!
>> UHH, this is mine (and Davids work from 2007)!
>> I cannot remember  any details this long afterwards but I guess you cannot just
>> revert that part as it triggers some other bug, David?
> Right, the issue was with f_pos in the directory.
>
> The 'rm' we were testing with at the time would delete a bunch of
> directory entries, then continue with its readdir() to work out what
> else to delete. But when we were handling f_pos on directories merely
> as the position on the list, and when we were *deleting* things from
> that list as we went, some dirents ended up moving so that they were
> *before* the position that 'rm' had got to with its readdir().
Thanks a for explaining in detail. And you are right.

We have a directory, including 2000 files. After getdents and unlink as 
follow:
     for ( ; ; ) {
         nread = syscall(SYS_getdents, fd, buf, BUF_SIZE); //BUF_SIZE=1024
         for (bpos = 0; bpos < nread;) {
             unlink(d->d_name);
         }
     }
we found there is still 990 files!
> But... the list we're traversing is *already* ordered by CRC, and that
> could be a much saner thing to use as f_pos. We just have to make sure
That's true. Our experiments also show that  it can quicken traverse.
However, when the list is very long (e.g. 1000000), the number of traverse
times can reach thousands.

What's more, a lot of memory space is occupying and will be more and more.
I have no idea how to improve this. Do you have some good idea?

Thanks,
yufen
> we cope with hash collisions. Shifting left by 4 bits and using the low
> 4 bits would allow us to cope with 16 names with the same hash... but
> I'm not sure that's good enough.
