Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeFEEx4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:53:56 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:41735 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbeFEExz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:53:55 -0400
X-Google-Smtp-Source: ADUXVKKpFqixvgXhESuukkI6u7YavjZydrhjs/BmmFuj3hNKaZUF9DXUcBFQlcouQ2qItTBnJFbcPV7auoYk30151S4=
MIME-Version: 1.0
From: shankarapailoor <shankarapailoor@gmail.com>
Date: Mon, 4 Jun 2018 21:53:53 -0700
Message-ID: <CAB+yDabFuBpT5UU1Hy0s4kY5UKJzA84=6fNieNcdTjjZNq5SHQ@mail.gmail.com>
Subject: general protection fault in sockfs_setattr
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been fuzzing Linux 4.17-rc7 with Syzkaller and found the
following crash: https://pastebin.com/ixX3RB9j

Syzkaller isolated the cause of the bug to the following program:

socketpair$unix(0x1, 0x1, 0x0,
&(0x7f0000000000)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
getresuid(&(0x7f0000000080)=<r2=>0x0, &(0x7f00000000c0),
&(0x7f0000000700))r3 = getegid()
fchownat(r0, &(0x7f0000000040)='\x00', r2, r3, 0x1000)
dup3(r1, r0, 0x80000)


The problematic area appears to be here:

static int sockfs_setattr(struct dentry *dentry, struct iattr *iattr)
{
    int err = simple_setattr(dentry, iattr);

    if (!err && (iattr->ia_valid & ATTR_UID)) {
         struct socket *sock = SOCKET_I(d_inode(dentry));

         sock->sk->sk_uid = iattr->ia_uid; //KASAN GPF
    }
    return err;
}

If dup3 is called concurrently with fchownat then can sock->sk be NULL?

-- 
Regards,
Shankara Pailoor
