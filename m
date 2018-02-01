Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBAKj2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:39:28 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43411 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeBAKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:39:26 -0500
X-Google-Smtp-Source: AH8x227lnt33V88oqwffjBIUWpew0K6q30cCQCNR7fDnLevEcdfHk5JyZfHf8I+pEDzKuAd/Y4v5D8nM7YJ4bIdzZXM=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a1DEqBWSXvVC+=pV_J_aMnof3Ky5W5t1FpwiCHZUTqJA@mail.gmail.com>
References: <001a1148251a36716f0564148ba9@google.com> <20180201083418.rfarzrodccdy54xx@gauss3.secunet.de>
 <CACT4Y+a1DEqBWSXvVC+=pV_J_aMnof3Ky5W5t1FpwiCHZUTqJA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Feb 2018 11:39:05 +0100
Message-ID: <CACT4Y+Z9A-q5nAB5DF0hs3z7UMWa0ZGmmEfEgZt0A0ZGTktGrg@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in xfrm_state_find (4)
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: syzbot <syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 11:30 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Feb 1, 2018 at 9:34 AM, Steffen Klassert
> <steffen.klassert@secunet.com> wrote:
>> On Wed, Jan 31, 2018 at 07:58:01AM -0800, syzbot wrote:
>>> Hello,
>>>
>>> syzbot hit the following crash on upstream commit
>>> 72906f38934a49faf4d2d38ea9ae32adcf7d5d0c (Tue Jan 30 21:04:50 2018 +0000)
>>> Merge branch 'x86-hyperv-for-linus' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>
>>> So far this crash happened 4 times on net-next, upstream.
>>> C reproducer is attached.
>>> syzkaller reproducer is attached.
>>> Raw console output is attached.
>>> compiler: gcc (GCC) 7.1.1 20170620
>>> .config is attached.
>>> user-space arch: i386
>>
>> Looks like we forgot to refuse to insert socket policies
>> when userspace is 32 bit and kernel is 64 bit. We do this
>> already for policies inserted with netlink because we don't
>> have a compat layer for xfrm. This means that userspace
>> and kernel structues don't match, leading to broken
>> configurations.
>>
>> I don't have 32 bit userspace on 64 bit machines, so I
>> can't test this myself. Can you please test this patch:
>
>
> Hi Steffen,
>
> Please see the email footer:
>
>> If you want to test a patch for this bug, please reply with:
>> #syz test: git://repo/address.git branch
>> and provide the patch inline or as an attachment.

And please add the Reported-by tag as syzbot asked:
Reported-by: syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com
This is really important for overall process. In particular, syzbot
will never report bugs in xfrm_state_find again as it will think that
it's still the old bug not fixed. This is 4-th out-of-bounds in
xfrm_state_find, so you can see this is important. I guess syzbot
actually found this more than a month ago, but did not report, because
nobody told it that the previous one is fixed. It reported it now
because Eric updated the old bug with the fix yesterday.




>> Subject: [PATCH RFC] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
>>
>> We don't have compat layer for xfrm, so userspace and kernel
>> structures have different sizes in this case. This results in
>> a broken confuguration, so refuse to configure socket policies
>> when trying to insert from 32 bit userspace as we do it already
>> with policies inserted via netlink.
>>
>> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
>> ---
>>  net/xfrm/xfrm_state.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
>> index a3785f538018..25861a4ef872 100644
>> --- a/net/xfrm/xfrm_state.c
>> +++ b/net/xfrm/xfrm_state.c
>> @@ -2056,6 +2056,11 @@ int xfrm_user_policy(struct sock *sk, int optname, u8 __user *optval, int optlen
>>         struct xfrm_mgr *km;
>>         struct xfrm_policy *pol = NULL;
>>
>> +#ifdef CONFIG_COMPAT
>> +       if (in_compat_syscall())
>> +               return -EOPNOTSUPP;
>> +#endif
>> +
>>         if (optlen <= 0 || optlen > PAGE_SIZE)
>>                 return -EMSGSIZE;
>>
>> --
>> 2.14.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180201083418.rfarzrodccdy54xx%40gauss3.secunet.de.
>> For more options, visit https://groups.google.com/d/optout.
