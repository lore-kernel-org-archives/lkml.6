Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeBAQYm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:24:42 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:36075 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBAQYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:24:35 -0500
X-Google-Smtp-Source: AH8x227e0F/4B2TZkbJLtsqm0auuI4tGFNyygegwFeSREUTX1CX++ox+7c7HIzwrRR8krZM2rUp9lkle7gSlTAAxG1Y=
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xwrXTsgKpXKbJJXeneXeh2eLhYegdPbJYEJH3sD6Ld5A@mail.gmail.com>
References: <001a114292fa7f761c0560ad62e1@google.com> <001a113f542aed9c4e0560b66f3b@google.com>
 <20180131072750.GF2736@zzz.localdomain> <CAAeHK+xwrXTsgKpXKbJJXeneXeh2eLhYegdPbJYEJH3sD6Ld5A@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Feb 2018 17:24:14 +0100
Message-ID: <CACT4Y+boQD_-JpFU9BbeuHQMrBLt9YnCVvTqnOWgX9JqTkboiA@mail.gmail.com>
Subject: Re: WARNING in refcount_inc (2)
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Eric Biggers <ebiggers3@gmail.com>,
        syzbot
        <bot+944a064dbc165044476317df06ebfb218415e951@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>, luc.vanoostenryck@gmail.com,
        Ingo Molnar <mingo@kernel.org>, netdev <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 3:34 PM, 'Andrey Konovalov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
> On Wed, Jan 31, 2018 at 8:27 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
>>
>> Also Dmitry, syzbot seems to be grouping together unrelated bugs under the
>> refcount_t WARNINGs; maybe those should be on a blacklist?
>
> Not a blacklist, we need a proper way of extracting the offending
> caller like it's done for reports from __this_cpu_* [1].
>
> [1] https://github.com/google/syzkaller/blob/master/pkg/report/linux.go#L579

Thanks, I've added this as a test case:
https://github.com/google/syzkaller/commit/e525e980eaed440e278614b9e887270ca67d2dde

We mishandle __this_cpu_* as well:
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/136
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/137
It does not seem that regexps can sustain this anymore (we also
mishandle rcu stalls and some other cases), I guess we need manual
parsing of stack traces that can handle all these cases.
