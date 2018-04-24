Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDXR6I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:58:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40324 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:58:05 -0400
X-Google-Smtp-Source: AB8JxZrTGALMszxw8m9M4gJEh5fbKxmCWD78DBmRwcZrFd7epyeir92uDAPpZGlliTx1YeNOxZQM5TgEiAvHJ/iuusw=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180424.135651.492329246141701047.davem@davemloft.net>
References: <20180423133015.5455-1-dh.herrmann@gmail.com> <20180423133015.5455-3-dh.herrmann@gmail.com>
 <CAHC9VhSv6tacFb+nEs1cCUOj52Vu+wXD6ZPZ1r1W4pYXo0VJMQ@mail.gmail.com> <20180424.135651.492329246141701047.davem@davemloft.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Apr 2018 13:58:02 -0400
Message-ID: <CAHC9VhQ1-QxRiS=wutRH4TCu-ZizxLEYF9HOqMsYWKuKXwNs+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] net/unix: hook unix_socketpair() into LSM
To: David Miller <davem@davemloft.net>
Cc: dh.herrmann@gmail.com, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>, teg@jklm.no,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 1:56 PM, David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Tue, 24 Apr 2018 13:55:31 -0400
>
>> On Mon, Apr 23, 2018 at 9:30 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>>> Use the newly created LSM-hook for unix_socketpair(). The default hook
>>> return-value is 0, so behavior stays the same unless LSMs start using
>>> this hook.
>>>
>>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>>> ---
>>>  net/unix/af_unix.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>> index 68bb70a62afe..bc9705ace9b1 100644
>>> --- a/net/unix/af_unix.c
>>> +++ b/net/unix/af_unix.c
>>> @@ -1371,6 +1371,11 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>>>  static int unix_socketpair(struct socket *socka, struct socket *sockb)
>>>  {
>>>         struct sock *ska = socka->sk, *skb = sockb->sk;
>>> +       int err;
>>> +
>>> +       err = security_unix_stream_socketpair(ska, skb);
>>> +       if (err)
>>> +               return err;
>>
>> I recognize that AF_UNIX is really the only protocol that supports
>> socketpair(2) at the moment, but I like to avoid protocol specific LSM
>> hooks whenever possible.  Unless someone can think of a good
>> objection, I would prefer to see the hook placed in __sys_socketpair()
>> instead (and obviously drop the "unix_stream" portion from the hook
>> name).
>
> The counterargument is that after 30 years no other protocol has grown
> usage of this operation. :-)

Call me a an optimist ;)

-- 
paul moore
www.paul-moore.com
