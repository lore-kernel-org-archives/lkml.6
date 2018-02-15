Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427303AbeBORYm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:24:42 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54018 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427286AbeBORYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:24:39 -0500
X-Google-Smtp-Source: AH8x227xkkzerjqRpczeeY4sCswiLnRejbkvole3oyIQXZ8jNuSv4oTqhQiAq0Cn+LnX/kuzxD7QzheiP2nO570neUo=
MIME-Version: 1.0
In-Reply-To: <CANn89iK-7v=sR3oD3uwkC6qac=GrSDUfMGmvKo=DS6tQ6C1ZJQ@mail.gmail.com>
References: <20180215170432.e4wue4osyv3vmdla@lakrids.cambridge.arm.com> <CANn89iK-7v=sR3oD3uwkC6qac=GrSDUfMGmvKo=DS6tQ6C1ZJQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Feb 2018 09:24:36 -0800
Message-ID: <CANn89iLvNjvUsjsqVN=3ZTPQvp6xChqYEu+cUASFXtTSQnA1aA@mail.gmail.com>
Subject: Re: v4.16-rc1 misaligned atomics in skb__clone / __napi_alloc_skb
To: Mark Rutland <mark.rutland@arm.com>
Cc: netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 9:20 AM, Eric Dumazet <edumazet@google.com> wrote:
>
> Yes, it seems tun.c breaks the assumptions.
>
> If it really wants to provide arbitrary fragments and alignments, it
> should use a separate

Sorry, I have sent the message to soon.

tun.c should use a private 'struct page_frag_cache' to deliver
arbitrary frags/alignments,
so that syzkaller might catch interesting bugs in the stack.


>
> Please try :
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 81e6cc951e7fc7c983919365c34842c34bcaedcf..92c6b6d02f7c18b63c42ffe1d9cb7286975e1263
> 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1500,7 +1500,7 @@ static struct sk_buff
> *tun_napi_alloc_frags(struct tun_file *tfile,
>                 }
>
>                 local_bh_disable();
> -               data = napi_alloc_frag(fragsz);
> +               data = napi_alloc_frag(SKB_DATA_ALIGN(fragsz));
>                 local_bh_enable();
>                 if (!data) {
>                         err = -ENOMEM;

This patch should solve your immediate problem, but would lower fuzzer
abilities to find bugs.

I will send something more suited to original intent of these commits :

90e33d45940793def6f773b2d528e9f3c84ffdc7 tun: enable napi_gro_frags()
for TUN/TAP driver
943170998b200190f99d3fe7e771437e2c51f319 tun: enable NAPI for TUN/TAP driver
