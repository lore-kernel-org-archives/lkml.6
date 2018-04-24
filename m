Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757510AbeDXMhT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:37:19 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40652 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeDXMhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:37:15 -0400
X-Google-Smtp-Source: AIpwx49X6YvocAsYSybzxkWj5Lcr+83m5DG9FNqNHZcY4EQeK+y+HfESPhHSy3zLfGtSVzrknhFlgw==
Subject: Re: [PATCH net-next] net: init sk_cookie for inet socket
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1524405004-10960-1-git-send-email-laoar.shao@gmail.com>
 <20180423.115821.640630949143585629.davem@davemloft.net>
 <788ce3f1-6534-5c2e-1870-5ebd8ea4ae7f@gmail.com>
 <CALOAHbDpgOckQhW7_Ysi-F2HCoZW4RKSdUuvTquELJZsaMj6Lg@mail.gmail.com>
 <67a158d9-cd33-8c28-39c3-9cead4107205@gmail.com>
 <CALOAHbDajHPN9Z3TTWFBwpd1H16RVRRYYiUMrUELE3JxeZo+qw@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <45bfd7ce-ecfa-8a4d-b1ed-8914a6b90093@gmail.com>
Date: Tue, 24 Apr 2018 05:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbDajHPN9Z3TTWFBwpd1H16RVRRYYiUMrUELE3JxeZo+qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 04:47 AM, Yafang Shao wrote:

> 
> Could you pls. explain the issue to me ?

Just run a synflood test on your host, it will definitely show the atomic
consuming most cpu cycles in inet_reqsk_alloc(), because of huge contention
on a cache line shared by all cpus.

Performance is reduced from ~5 Mpps to ~3.8 Mpps with 16 RX queues on my host.

atomic64_inc_return(&sock_net(sk)->cookie_gen) was not meant to be used in the
normal case (when a socket cookie is not ever requested/needed)
