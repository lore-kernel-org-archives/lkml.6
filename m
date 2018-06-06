Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtPvDQf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 884D2601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeFFCTL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 22:19:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40378 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeFFCTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 22:19:10 -0400
X-Google-Smtp-Source: ADUXVKLAH8YJHqaBVXIlQ7NJazBkGNNLYTjnJro0XbXIncvAUhKlCvSDoZt9x39zxtaGOO0+3Azcqz91p/oqmmxU+ok=
MIME-Version: 1.0
In-Reply-To: <CAM_iQpUaK1xaZAKmPY0JnyAmebBJQ5GPJsiG8HgvXLrxNqphZg@mail.gmail.com>
References: <CAB+yDabFuBpT5UU1Hy0s4kY5UKJzA84=6fNieNcdTjjZNq5SHQ@mail.gmail.com>
 <CAM_iQpUaK1xaZAKmPY0JnyAmebBJQ5GPJsiG8HgvXLrxNqphZg@mail.gmail.com>
From: shankarapailoor <shankarapailoor@gmail.com>
Date: Tue, 5 Jun 2018 19:19:08 -0700
Message-ID: <CAB+yDaahHYeWE1kS=4GEAC3GKyrAenaSat9Wi_iKQbt1yTp_zg@mail.gmail.com>
Subject: Re: general protection fault in sockfs_setattr
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cong,

I added that check and it seems to stop the crash. Like you said, I
don't see where the reference count for the file is increased. The
inode lock also seems to be held during this call.

Regards,
Shankara



On Tue, Jun 5, 2018 at 12:14 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Mon, Jun 4, 2018 at 9:53 PM, shankarapailoor
> <shankarapailoor@gmail.com> wrote:
>> Hi,
>>
>> I have been fuzzing Linux 4.17-rc7 with Syzkaller and found the
>> following crash: https://pastebin.com/ixX3RB9j
>>
>> Syzkaller isolated the cause of the bug to the following program:
>>
>> socketpair$unix(0x1, 0x1, 0x0,
>> &(0x7f0000000000)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
>> getresuid(&(0x7f0000000080)=<r2=>0x0, &(0x7f00000000c0),
>> &(0x7f0000000700))r3 = getegid()
>> fchownat(r0, &(0x7f0000000040)='\x00', r2, r3, 0x1000)
>> dup3(r1, r0, 0x80000)
>>
>>
>> The problematic area appears to be here:
>>
>> static int sockfs_setattr(struct dentry *dentry, struct iattr *iattr)
>> {
>>     int err = simple_setattr(dentry, iattr);
>>
>>     if (!err && (iattr->ia_valid & ATTR_UID)) {
>>          struct socket *sock = SOCKET_I(d_inode(dentry));
>>
>>          sock->sk->sk_uid = iattr->ia_uid; //KASAN GPF
>>     }
>>     return err;
>> }
>>
>> If dup3 is called concurrently with fchownat then can sock->sk be NULL?
>
> Although dup3() implies a close(), fd is refcnt'ted, if dup3() runs
> concurrently with fchownat() it should not be closed until whoever
> the last closes it.
>
> Or maybe fchownat() doesn't even hold refcnt of fd, since it aims
> to change the file backed.
>
>
> Not sure if the following is sufficient, inode might need to be protected
> with some lock...
>
> diff --git a/net/socket.c b/net/socket.c
> index f10f1d947c78..6294b4b3132e 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -537,7 +537,10 @@ static int sockfs_setattr(struct dentry *dentry,
> struct iattr *iattr)
>         if (!err && (iattr->ia_valid & ATTR_UID)) {
>                 struct socket *sock = SOCKET_I(d_inode(dentry));
>
> -               sock->sk->sk_uid = iattr->ia_uid;
> +               if (sock->sk)
> +                       sock->sk->sk_uid = iattr->ia_uid;
> +               else
> +                       err = -ENOENT;
>         }
>
>         return err;



-- 
Regards,
Shankara Pailoor
