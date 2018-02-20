Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBTWIv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:08:51 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41313 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeBTWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:08:49 -0500
X-Google-Smtp-Source: AG47ELvG7pTPC54SZ2AHxPhJAUm29qojX8tNnH6d+PMOQHlEuG6pN4sSQNz6vrsHobem9xy/iVr+wEUZ5UgY+se9KYc=
MIME-Version: 1.0
In-Reply-To: <824bfc29-d6e8-9d7d-9307-79bf0097ce8e@iogearbox.net>
References: <20180220211658.2653840-1-arnd@arndb.de> <824bfc29-d6e8-9d7d-9307-79bf0097ce8e@iogearbox.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Feb 2018 23:08:48 +0100
X-Google-Sender-Auth: uJDMlymk1Sbg9zW-2c3G-bj9Ws8
Message-ID: <CAK8P3a11Fkgx-dYXQszOewMacMy9k-SDm9Epu1A6XWE98FcUgQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: hide a possibly unused variable
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 10:44 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> Hi Arnd,
>
> On 02/20/2018 10:16 PM, Arnd Bergmann wrote:
>> The only user of this variable is inside of an #ifdef, causing
>> a warning without CONFIG_INET:
>>
>> net/core/filter.c: In function '____bpf_sock_ops_cb_flags_set':
>> net/core/filter.c:3382:6: error: unused variable 'val' [-Werror=unused-variable]
>>   int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
>>
>> This adds the same #ifdef around the declaration.
>>
>> Fixes: b13d88072172 ("bpf: Adds field bpf_sock_ops_cb_flags to tcp_sock")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  net/core/filter.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 08ab4c65a998..c3dc6d60b4bb 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3379,7 +3379,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
>>          int, argval)
>>  {
>>       struct sock *sk = bpf_sock->sk;
>> +#ifdef CONFIG_INET
>>       int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
>> +#endif
>
> Looks good, thanks for the fix!
>
> Could you move the existing '#ifdef CONFIG_INET' to the beginning of
> the function given the only error in case of !CONFIG_INET is -EINVAL
> anyway? That would at least not increase the ifdef ugliness further.

Sure, sent a new version now. I decided to clean up that #ifdef
check as well, since a IS_ENABLED() check is nicer anway.

       Arnd
