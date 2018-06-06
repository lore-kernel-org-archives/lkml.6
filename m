Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp4Lh6ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC9F4601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeFFNaJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:30:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36971 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeFFNaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:30:07 -0400
X-Google-Smtp-Source: ADUXVKL3jykzbblnhV5H8Gfh2GohZ1s1rT+lMmKN1ywgHgxYpe5RBAlhJBkwW1EQgMSOHnnizdWaM8mOqb2TlUtdj2Y=
MIME-Version: 1.0
In-Reply-To: <23d3edb6-a9cd-0295-5433-1b2a13ecbf21@I-love.SAKURA.ne.jp>
References: <CAB+yDabFuBpT5UU1Hy0s4kY5UKJzA84=6fNieNcdTjjZNq5SHQ@mail.gmail.com>
 <CAM_iQpUaK1xaZAKmPY0JnyAmebBJQ5GPJsiG8HgvXLrxNqphZg@mail.gmail.com>
 <CAB+yDaahHYeWE1kS=4GEAC3GKyrAenaSat9Wi_iKQbt1yTp_zg@mail.gmail.com> <23d3edb6-a9cd-0295-5433-1b2a13ecbf21@I-love.SAKURA.ne.jp>
From: shankarapailoor <shankarapailoor@gmail.com>
Date: Wed, 6 Jun 2018 06:30:05 -0700
Message-ID: <CAB+yDaZYZ5a5zusTE3V+AN_7uCOxGejDH=h7yEJjw0RB_gfOWQ@mail.gmail.com>
Subject: Re: general protection fault in sockfs_setattr
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        viro@zeniv.linux.org.uk
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++Al Viro

>Pastebin says that it was 4.17.0-rc4+ rather than 4.17-rc7.
Oops. Apologies Tetsuo. I confirmed the bug still happens with
linux.git. Here are the Syzkaller logs around the crash along with my
kernel configs.

Syzkaller Logs: https://pastebin.com/qqQyX0Ms
Config: https://pastebin.com/aEDARPDJ

Regards,
Shankara

On Wed, Jun 6, 2018 at 3:17 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Pastebin says that it was 4.17.0-rc4+ rather than 4.17-rc7.
> I suggest reporting to Al Viro and linux-fsdevel ML after
> confirming that this bug still happens with linux.git , in
> case this is a dentry related bug (e.g. someone is by error
> calling dput() without getting a refcount).
>
> Also, please don't eliminate kernel messages prior to the
> crash. Sometimes previous kernel messages (e.g. memory
> allocation fault injection) as-is indicate the cause.
>
> On 2018/06/06 11:19, shankarapailoor wrote:
>> Hi Cong,
>>
>> I added that check and it seems to stop the crash. Like you said, I
>> don't see where the reference count for the file is increased. The
>> inode lock also seems to be held during this call.
>>
>> Regards,
>> Shankara
>>
>>
>>
>> On Tue, Jun 5, 2018 at 12:14 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>> On Mon, Jun 4, 2018 at 9:53 PM, shankarapailoor
>>> <shankarapailoor@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I have been fuzzing Linux 4.17-rc7 with Syzkaller and found the
>>>> following crash: https://pastebin.com/ixX3RB9j
>>>>
>>>> Syzkaller isolated the cause of the bug to the following program:
>>>>
>>>> socketpair$unix(0x1, 0x1, 0x0,
>>>> &(0x7f0000000000)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
>>>> getresuid(&(0x7f0000000080)=<r2=>0x0, &(0x7f00000000c0),
>>>> &(0x7f0000000700))r3 = getegid()
>>>> fchownat(r0, &(0x7f0000000040)='\x00', r2, r3, 0x1000)
>>>> dup3(r1, r0, 0x80000)
>>>>
>>>>
>>>> The problematic area appears to be here:
>>>>
>>>> static int sockfs_setattr(struct dentry *dentry, struct iattr *iattr)
>>>> {
>>>>     int err = simple_setattr(dentry, iattr);
>>>>
>>>>     if (!err && (iattr->ia_valid & ATTR_UID)) {
>>>>          struct socket *sock = SOCKET_I(d_inode(dentry));
>>>>
>>>>          sock->sk->sk_uid = iattr->ia_uid; //KASAN GPF
>>>>     }
>>>>     return err;
>>>> }
>>>>
>>>> If dup3 is called concurrently with fchownat then can sock->sk be NULL?
>>>
>>> Although dup3() implies a close(), fd is refcnt'ted, if dup3() runs
>>> concurrently with fchownat() it should not be closed until whoever
>>> the last closes it.
>>>
>>> Or maybe fchownat() doesn't even hold refcnt of fd, since it aims
>>> to change the file backed.
>>>
>>>
>>> Not sure if the following is sufficient, inode might need to be protected
>>> with some lock...
>>>
>>> diff --git a/net/socket.c b/net/socket.c
>>> index f10f1d947c78..6294b4b3132e 100644
>>> --- a/net/socket.c
>>> +++ b/net/socket.c
>>> @@ -537,7 +537,10 @@ static int sockfs_setattr(struct dentry *dentry,
>>> struct iattr *iattr)
>>>         if (!err && (iattr->ia_valid & ATTR_UID)) {
>>>                 struct socket *sock = SOCKET_I(d_inode(dentry));
>>>
>>> -               sock->sk->sk_uid = iattr->ia_uid;
>>> +               if (sock->sk)
>>> +                       sock->sk->sk_uid = iattr->ia_uid;
>>> +               else
>>> +                       err = -ENOENT;
>>>         }
>>>
>>>         return err;
>>
>>
>>
>



-- 
Regards,
Shankara Pailoor
