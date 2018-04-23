Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeDWVjJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:39:09 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33892 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbeDWVjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:39:05 -0400
X-Google-Smtp-Source: AIpwx49zEygDZ8F+D8/eh6zLne1jtUN5KDY4aoPc3g23jQwWuu9btrdRKlNTn1D3QN7V/j2pgzaW0XZxGtowPZewqkE=
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JR1Bg1FLat41Uua9vi1-ALyuQttChAWyWz0Yx6_01_BA@mail.gmail.com>
References: <CAG5TwLMyYtN19OFh=hxJ6bE_GRtoy-SkpK4K5jbfmQJV587mRw@mail.gmail.com>
 <CAG5TwLORDZPmfF7P0S2y9_7PscjvcuQd4WYnZTsBwCi+y47dOQ@mail.gmail.com>
 <CAM_iQpVtaP=NNpMTyS9vwEtS3QSN_ksYDenS4gy8zzPC3V8Xww@mail.gmail.com>
 <CAF=yD-Lyu8YYiquNNat_RZ53Ydniivz59C8dek6RsWuy0YE8Cw@mail.gmail.com>
 <CACsK=jeTu1mhOXXAFAkp5nGVG6WbcV+dJZmTavdjWerHhDQfVg@mail.gmail.com>
 <CACsK=jcgPLMydKfRkKKXXUVqAWXwszbvkr=5jYXXPAmigTtszQ@mail.gmail.com> <CAF=yD-JR1Bg1FLat41Uua9vi1-ALyuQttChAWyWz0Yx6_01_BA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 23 Apr 2018 17:38:24 -0400
Message-ID: <CAF=yD-JJeWSLJytyj+j_e+r2JRoCq=jpWsDC7psdft-QjM=20Q@mail.gmail.com>
Subject: Re: WARNING in refcount_dec
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        Byoungyoung Lee <byoungyoung@purdue.edu>,
        LKML <linux-kernel@vger.kernel.org>, Kyungtae Kim <kt0755@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 2:55 PM, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Thu, Apr 19, 2018 at 2:32 AM, DaeRyong Jeong <threeearcat@gmail.com> wrote:
>> Hello.
>> We have analyzed the cause of the crash in v4.16-rc3, WARNING in refcount_dec,
>> which is found by RaceFuzzer (a modified version of Syzkaller).
>>
>> Since struct packet_sock's member variables, running, has_vnet_hdr, origdev
>> and auxdata are declared as bitfields, accessing these variables can race if
>> there is no synchronization mechanism.
>
> Great catch.
>
> These fields po->{running, auxdata, origdev, has_vnet_hdr} are
> accessed without a uniform locking strategy.
>
> po->running is always accessed with po->bind_lock held (with the
> exception of reading in packet_seq_show, but that is best effort).
>
> That is the only field written to outside setsockopt. If it is moved to
> a separate word, it will no longer interfere with the others.
>
> The other fields are read lockless in the various recv and send
> functions, but only set in setsockopt. We've had enough
> locking bugs around setsockopt that I suggest we wrap all of
> those in lock_sock, like the example I gave before for
> has_vnet_hdr.

Sent http://patchwork.ozlabs.org/patch/903190/
