Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7193ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCD1214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="DvZNQKEj";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="DvZNQKEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCD1214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeIROpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:45:44 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:44179 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728467AbeIROpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:45:44 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id C4A3521AD2;
        Tue, 18 Sep 2018 12:13:57 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id YUHFzafJYK-DvLWvlNd;
        Tue, 18 Sep 2018 12:13:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1537262037; bh=wQ/t5tRoEd4kb2YyubbQ9/Wp3GysYOCg95jBPa5eIp4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=DvZNQKEjdAlr8Bo5Mfblm7efFQE5YHOJiKUWaYW9bPy9ve/Cuf8/Dl9G0Vmi9j4Zi
         BVsMZXb3WVI/XNFdN5ffbsMPJ1IVEmba245a2L0SHVpakhOJZF9K7mVxHdqWyGzR1W
         3Q75ZChPgBiezShvR06+/rWWCrtCAq4g6fKPbzfg=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d4f7:39a2:d2c1:78d7])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hhu0eujl8W-DvLSFgRw;
        Tue, 18 Sep 2018 12:13:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1537262037; bh=wQ/t5tRoEd4kb2YyubbQ9/Wp3GysYOCg95jBPa5eIp4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=DvZNQKEjdAlr8Bo5Mfblm7efFQE5YHOJiKUWaYW9bPy9ve/Cuf8/Dl9G0Vmi9j4Zi
         BVsMZXb3WVI/XNFdN5ffbsMPJ1IVEmba245a2L0SHVpakhOJZF9K7mVxHdqWyGzR1W
         3Q75ZChPgBiezShvR06+/rWWCrtCAq4g6fKPbzfg=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [BUG] mm: direct I/O (using GUP) can write to COW anonymous pages
To:     Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, sqazi@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>, jack@suse.cz,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com>
 <alpine.LSU.2.11.1809171628190.2225@eggly.anvils>
 <CAG48ez1hk5evqQpyvticPzLFOcESfo2NoWnqrLZk6N4PXwdsOw@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5f794be8-f6f1-57f1-cb61-43e34cd6c4ed@yandex-team.ru>
Date:   Tue, 18 Sep 2018 12:13:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1hk5evqQpyvticPzLFOcESfo2NoWnqrLZk6N4PXwdsOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.2018 03:35, Jann Horn wrote:
> On Tue, Sep 18, 2018 at 2:05 AM Hugh Dickins <hughd@google.com> wrote:
>>
>> Hi Jann,
>>
>> On Mon, 17 Sep 2018, Jann Horn wrote:
>>
>>> [I'm not sure who the best people to ask about this are, I hope the
>>> recipient list resembles something reasonable...]
>>>
>>> I have noticed that the dup_mmap() logic on fork() doesn't handle
>>> pages with active direct I/O properly: dup_mmap() seems to assume that
>>> making the PTE referencing a page readonly will always prevent future
>>> writes to the page, but if the kernel has acquired a direct reference
>>> to the page before (e.g. via get_user_pages_fast()), writes can still
>>> happen that way.
>>>
>>> The worst-case effect of this - as far as I can tell - is that when a
>>> multithreaded process forks while one thread is in the middle of
>>> sys_read() on a file that uses direct I/O with get_user_pages_fast(),
>>> the read data can become visible in the child while the parent's
>>> buffer stays uninitialized if the parent writes to a relevant page
>>> post-fork before either the I/O completes or the child writes to it.
>>
>> Yes: you're understandably more worried by the one seeing the other's
>> data;
> 
> Actually, I was mostly just trying to find a scenario in which the
> parent doesn't get the data it's asking for, and this is the simplest
> I could come up with. :)

This might happens even in single-threaded process:

io_submit()
fork()
<CoW same page>
io_getevents()
<no new data in page>

For example if buffer is only 512 bytes and share page with something else.

THP opens wider race window.

> 
> I was also vaguely worried about whether some other part of the mm
> subsystem might assume that COW pages are immutable, but I haven't
> found anything like that so far, so that might've been unwarranted
> paranoia.
> 
>> we've tended in the past to be more worried about the one getting
>> corruption, and the other not seeing the data it asked for (and usually
>> in the context of RDMA, rather than filesystem direct I/O).
>>
>> I've added some Cc's: I might be misremembering, but I think both
>> Andrea and Konstantin have offered approaches to this in the past,
>> and I believe Salman is taking a look at it currently.
>>
>> But my own interest ended when Michael added MADV_DONTFORK: beyond
>> that, we've rated it a "Patient: It hurts when I do this. Doctor:
>> Don't do that then" - more complexity and overhead to solve, than
>> we have had appetite to get into.
> 
> Makes sense, I guess.
> 
> I wonder whether there's a concise way to express this in the fork.2
> manpage, or something like that. Maybe I'll take a stab at writing
> something. The biggest issue I see with documenting this edgecase is
> that, as an application developer, if you don't know whether some file
> might be coming from a FUSE filesystem that has opted out of using the
> disk cache, the "don't do that" essentially becomes "don't read() into
> heap buffers while fork()ing in another thread", since with FUSE,
> direct I/O can happen even if you don't open files as O_DIRECT as long
> as the filesystem requests direct I/O, and get_user_pages_fast() will
> AFAIU be used for non-page-aligned buffers, meaning that an adjacent
> heap memory access could trigger CoW page duplication. But then, FUSE
> filesystems that opt out of the disk cache are probably so rare that
> it's not a concern in practice...

fork() from multithreaded process is almost always broken
because child gets locks held by other threads.
For example glibc localtime_r() is unsafe after such fork().

Unless child calls execve() right away it cannot do much.
But in this case vfork() works way much better and faster.

> 
>> But not a shiningly satisfactory
>> situation, I'll agree.
>>
>> Hugh
>>
>>>
>>> Reproducer code:
>>>
>>> ====== START hello.c ======
>>> #define FUSE_USE_VERSION 26
>>>
>>> #include <fuse.h>
>>> #include <stdio.h>
>>> #include <string.h>
>>> #include <errno.h>
>>> #include <fcntl.h>
>>> #include <unistd.h>
>>> #include <err.h>
>>> #include <sys/uio.h>
>>>
>>> static const char *hello_path = "/hello";
>>>
>>> static int hello_getattr(const char *path, struct stat *stbuf)
>>> {
>>>          int res = 0;
>>>          memset(stbuf, 0, sizeof(struct stat));
>>>          if (strcmp(path, "/") == 0) {
>>>                  stbuf->st_mode = S_IFDIR | 0755;
>>>                  stbuf->st_nlink = 2;
>>>          } else if (strcmp(path, hello_path) == 0) {
>>>                  stbuf->st_mode = S_IFREG | 0666;
>>>                  stbuf->st_nlink = 1;
>>>                  stbuf->st_size = 0x1000;
>>>                  stbuf->st_blocks = 0;
>>>          } else
>>>                  res = -ENOENT;
>>>          return res;
>>> }
>>>
>>> static int hello_readdir(const char *path, void *buf, fuse_fill_dir_t
>>> filler, off_t offset, struct fuse_file_info *fi) {
>>>          filler(buf, ".", NULL, 0);
>>>          filler(buf, "..", NULL, 0);
>>>          filler(buf, hello_path + 1, NULL, 0);
>>>          return 0;
>>> }
>>>
>>> static int hello_open(const char *path, struct fuse_file_info *fi) {
>>>          return 0;
>>> }
>>>
>>> static int hello_read(const char *path, char *buf, size_t size, off_t
>>> offset, struct fuse_file_info *fi) {
>>>          sleep(3);
>>>          size_t len = 0x1000;
>>>          if (offset < len) {
>>>                  if (offset + size > len)
>>>                          size = len - offset;
>>>                  memset(buf, 0, size);
>>>          } else
>>>                  size = 0;
>>>          return size;
>>> }
>>>
>>> static int hello_write(const char *path, const char *buf, size_t size,
>>> off_t offset, struct fuse_file_info *fi) {
>>>          while(1) pause();
>>> }
>>>
>>> static struct fuse_operations hello_oper = {
>>>          .getattr        = hello_getattr,
>>>          .readdir        = hello_readdir,
>>>          .open           = hello_open,
>>>          .read           = hello_read,
>>>          .write          = hello_write,
>>> };
>>>
>>> int main(int argc, char *argv[]) {
>>>          return fuse_main(argc, argv, &hello_oper, NULL);
>>> }
>>> ====== END hello.c ======
>>>
>>> ====== START simple_mmap.c ======
>>> #define _GNU_SOURCE
>>> #include <pthread.h>
>>> #include <sys/mman.h>
>>> #include <err.h>
>>> #include <unistd.h>
>>> #include <fcntl.h>
>>> #include <stdio.h>
>>> #include <signal.h>
>>> #include <sys/prctl.h>
>>> #include <sys/wait.h>
>>>
>>> __attribute__((aligned(0x1000))) char data_buffer_[0x10000];
>>> #define data_buffer (data_buffer_ + 0x8000)
>>>
>>> void *fuse_thread(void *dummy) {
>>>          /* step 2: start direct I/O on data_buffer */
>>>          int fuse_fd = open("mount/hello", O_RDWR);
>>>          if (fuse_fd == -1)
>>>                  err(1, "unable to open FUSE fd");
>>>          printf("char in parent (before): %hhd\n", data_buffer[0]);
>>>          int res = read(fuse_fd, data_buffer, 0x1000);
>>>          /* step 6: read completes, show post-read state */
>>>          printf("fuse read result: %d\n", res);
>>>          printf("char in parent (after): %hhd\n", data_buffer[0]);
>>> }
>>>
>>> int main(void) {
>>>          /* step 1: make data_buffer dirty */
>>>          data_buffer[0] = 1;
>>>
>>>          pthread_t thread;
>>>          if (pthread_create(&thread, NULL, fuse_thread, NULL))
>>>                  errx(1, "pthread_create");
>>>
>>>          sleep(1);
>>>          /* step 3: fork a child */
>>>          pid_t child = fork();
>>>          if (child == -1)
>>>                  err(1, "fork");
>>>          if (child == 0) {
>>>                  prctl(PR_SET_PDEATHSIG, SIGKILL);
>>>                  sleep(1);
>>>
>>>                  /* step 5: show pre-read state in the child */
>>>                  printf("char in child (before): %hhd\n", data_buffer[0]);
>>>                  sleep(3);
>>>                  /* step 7: read is complete, show post-read state in child */
>>>                  printf("char in child (after): %hhd\n", data_buffer[0]);
>>>                  return 0;
>>>          }
>>>
>>>          /* step 4: de-CoW data_buffer in the parent */
>>>          data_buffer[0x800] = 2;
>>>
>>>          int status;
>>>          if (wait(&status) != child)
>>>                  err(1, "wait");
>>> }
>>> ====== END simple_mmap.c ======
>>>
>>> Repro steps:
>>>
>>> In one terminal:
>>> $ mkdir mount
>>> $ gcc -o hello hello.c -Wall -std=gnu99 `pkg-config fuse --cflags --libs`
>>> hello.c: In function ‘hello_write’:
>>> hello.c:67:1: warning: no return statement in function returning
>>> non-void [-Wreturn-type]
>>>   }
>>>   ^
>>> $ ./hello -d -o direct_io mount
>>> FUSE library version: 2.9.7
>>> [...]
>>>
>>> In a second terminal:
>>> $ gcc -pthread -o simple_mmap simple_mmap.c
>>> $ ./simple_mmap
>>> char in parent (before): 1
>>> char in child (before): 1
>>> fuse read result: 4096
>>> char in parent (after): 1
>>> char in child (after): 0
>>>
>>> I have tested that this still works on 4.19.0-rc3+.
>>>
>>> As far as I can tell, the fix would be to immediately copy pages with
>>> `refcount - mapcount > N` in dup_mmap(), or something like that?
>>>
