Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEVFIm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 01:08:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:34599 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeEVFIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 01:08:40 -0400
Message-ID: <8c7ac8af210606f2e4be4bfbb0b2506be53b60e3.camel@kernel.crashing.org>
Subject: set_fs(KERNEL_DS) vs iovec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 15:08:35 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys !

I was helping with a small driver when I stumbled upon a comment from a
reviwer pointing to an old lwn article talking about deprecating set_fs
due to security concerns:

https://lwn.net/Articles/722267/

Now, this is a very simple driver running on a small/slow ARM SoC,
which reads from a FIFO and writes into a destination buffer.

It provides 2 interfaces, a userspace one (read syscall) and an in-
kernel one since some other kernel drivers use it as a transport.

My existing implementation uses the good old construct of doing
put_user() in the low level FIFO pumping code, and have the in-kernel
API do:

     old_fs = get_fs();
     set_fs(KERNEL_DS);
     rc = __sbefifo_submit(sbefifo, command, cmd_len,
                           response, resp_len);
     set_fs(old_fs);

Which is simple, turns into fairly efficient code on that simple
device, and doesn't seem to have security issues...

That said, following the advice in that article, I tried to look at the
iovec stuff and noticed:

 - The APIs are almost entirely undocumented (or did I look in the
wrong place ?)

 - The code in lib/iov_iter.c is rather ... unreadable

 - It's also significantly more complex, thus would probably result in
a slower driver (remember: small SoC). It's quite overkill for my
simple use case.

 - There are very few users, set_fs(KERNEL_DS) is still the most common
method used by drivers.

Hence my question: Is is still acceptable these days to use
set_fs(KERNEL_DS) for simple cases like this ? Or is it really
deprecated and all new users should use the iovec's ?

Cheers,
Ben.
