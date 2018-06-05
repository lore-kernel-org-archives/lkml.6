Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeFETOh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:14:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43452 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeFETOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:14:36 -0400
X-Google-Smtp-Source: ADUXVKI68rPhTXTYcOGN4RvUIEPMAVFQB8WHK5Hti9vncnsjcOYkTA/Q4xeaZTDH7cPeuU3Iyr6lDtrYoHku3B1RZvA=
MIME-Version: 1.0
In-Reply-To: <CAB+yDabFuBpT5UU1Hy0s4kY5UKJzA84=6fNieNcdTjjZNq5SHQ@mail.gmail.com>
References: <CAB+yDabFuBpT5UU1Hy0s4kY5UKJzA84=6fNieNcdTjjZNq5SHQ@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 5 Jun 2018 12:14:15 -0700
Message-ID: <CAM_iQpUaK1xaZAKmPY0JnyAmebBJQ5GPJsiG8HgvXLrxNqphZg@mail.gmail.com>
Subject: Re: general protection fault in sockfs_setattr
To: shankarapailoor <shankarapailoor@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 9:53 PM, shankarapailoor
<shankarapailoor@gmail.com> wrote:
> Hi,
>
> I have been fuzzing Linux 4.17-rc7 with Syzkaller and found the
> following crash: https://pastebin.com/ixX3RB9j
>
> Syzkaller isolated the cause of the bug to the following program:
>
> socketpair$unix(0x1, 0x1, 0x0,
> &(0x7f0000000000)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
> getresuid(&(0x7f0000000080)=<r2=>0x0, &(0x7f00000000c0),
> &(0x7f0000000700))r3 = getegid()
> fchownat(r0, &(0x7f0000000040)='\x00', r2, r3, 0x1000)
> dup3(r1, r0, 0x80000)
>
>
> The problematic area appears to be here:
>
> static int sockfs_setattr(struct dentry *dentry, struct iattr *iattr)
> {
>     int err = simple_setattr(dentry, iattr);
>
>     if (!err && (iattr->ia_valid & ATTR_UID)) {
>          struct socket *sock = SOCKET_I(d_inode(dentry));
>
>          sock->sk->sk_uid = iattr->ia_uid; //KASAN GPF
>     }
>     return err;
> }
>
> If dup3 is called concurrently with fchownat then can sock->sk be NULL?

Although dup3() implies a close(), fd is refcnt'ted, if dup3() runs
concurrently with fchownat() it should not be closed until whoever
the last closes it.

Or maybe fchownat() doesn't even hold refcnt of fd, since it aims
to change the file backed.


Not sure if the following is sufficient, inode might need to be protected
with some lock...

diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..6294b4b3132e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -537,7 +537,10 @@ static int sockfs_setattr(struct dentry *dentry,
struct iattr *iattr)
        if (!err && (iattr->ia_valid & ATTR_UID)) {
                struct socket *sock = SOCKET_I(d_inode(dentry));

-               sock->sk->sk_uid = iattr->ia_uid;
+               if (sock->sk)
+                       sock->sk->sk_uid = iattr->ia_uid;
+               else
+                       err = -ENOENT;
        }

        return err;
