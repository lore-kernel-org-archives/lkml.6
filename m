Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeAaJjS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:39:18 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44972 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbeAaJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:39:10 -0500
X-Google-Smtp-Source: AH8x224Q2VTaCMEn54WzaNlNcuVHvbjlswXeakG6V7t8oDzJkmUTQWTzHO8q/UdGEc9ha07+mynbObOEPYbFINLFTvA=
MIME-Version: 1.0
In-Reply-To: <20180131052948.GA16419@embeddedgus>
References: <20180131052948.GA16419@embeddedgus>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 31 Jan 2018 10:39:09 +0100
Message-ID: <CAOi1vP_weac6BzPbpcqAiaC1Mfxr-83=3XKLpv8+aZCsPGObAw@mail.gmail.com>
Subject: Re: [PATCH] libceph: use 64-bit arithmetic instead of 32-bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 6:29 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Cast objsetno to u64 in order to give the compiler complete
> information about the proper arithmetic to use. Notice
> that this variable is used in a context that expects an
> expression of type u64 (64 bits, unsigned).
>
> The expression objsetno * sc + stripepos is currently
> being evaluated using 32-bit arithmetic.
>
> In general, the use of incorrect arithmetic has security
> implications.
>
> Addresses-Coverity-ID: 200686
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  net/ceph/osdmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 0da27c6..58dc965 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -2183,7 +2183,7 @@ int ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
>         stripepos = bl % sc;
>         objsetno = stripeno / su_per_object;
>
> -       *ono = objsetno * sc + stripepos;
> +       *ono = (u64)objsetno * sc + stripepos;
>         dout("objset %u * sc %u = ono %u\n", objsetno, sc, (unsigned int)*ono);
>
>         /* *oxoff = *off % layout->fl_stripe_unit;  # offset in su */

Hi Gustavo,

This (and other u32/u64 issues in this function, is this the only
warning?) is fixed in my striping v2 work branch.  I wasn't going to
push that patch separately, but I guess I should post it.

Thanks,

                Ilya
