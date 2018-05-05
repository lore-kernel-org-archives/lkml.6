Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeEEPkj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 11:40:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35842 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeEEPkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 11:40:37 -0400
X-Google-Smtp-Source: AB8JxZoxNvnYQS7OmzXyDSevkzQ+vz7PORirMFYmYV6MPChA5Db8M3swzMfw6o9E7G/t7xO3GzP0Wulb/NoMwAONvcw=
MIME-Version: 1.0
In-Reply-To: <20180505094324.wwjtl76oofgrtpg4@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605441.18473.4087381584733882012.stgit@noble> <20180505094324.wwjtl76oofgrtpg4@gondor.apana.org.au>
From: Tom Herbert <tom@quantonium.net>
Date: Sat, 5 May 2018 08:40:35 -0700
Message-ID: <CAPDqMeoPjypXCioHwy9CPiT_XZfWZk8_A6cErQuxVMAJqkQEqQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] rhashtable: add rhashtable_walk_prev()
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 5, 2018 at 2:43 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
>> rhashtable_walk_prev() returns the object returned by
>> the previous rhashtable_walk_next(), providing it is still in the
>> table (or was during this grace period).
>> This works even if rhashtable_walk_stop() and rhashtable_talk_start()
>> have been called since the last rhashtable_walk_next().
>>
>> If there have been no calls to rhashtable_walk_next(), or if the
>> object is gone from the table, then NULL is returned.
>>
>> This can usefully be used in a seq_file ->start() function.
>> If the pos is the same as was returned by the last ->next() call,
>> then rhashtable_walk_prev() can be used to re-establish the
>> current location in the table.  If it returns NULL, then
>> rhashtable_walk_next() should be used.
>>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> I will ack this if Tom is OK with replacing peek with it.
>
I'm not following why this is any better than peek. The point of
having rhashtable_walk_peek is to to allow the caller to get then
current element not the next one. This is needed when table is read in
multiple parts and we need to pick up with what was returned from the
last call to rhashtable_walk_next (which apparently is what this patch
is also trying to do).

There is one significant difference in that peek will return the
element in the table regardless of where the iterator is at (this is
why peek can move the iterator) and only returns NULL at end of table.
As mentioned above rhashtable_walk_prev can return NULL so then caller
needs and so rhashtable_walk_next "should be used" to get the previous
element. Doing a peek is a lot cleaner and more straightforward API in
this regard.

Tom

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
