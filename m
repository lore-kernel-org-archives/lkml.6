Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935929AbeE3CDg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:03:36 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45188 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935643AbeE3CDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:03:30 -0400
X-Google-Smtp-Source: ADUXVKJJ0fa17hlWZCkKDx+3JN5VPUhCGHqSBf2eiBnPNB0eBVxrMP5xUUPHkv69PxGxlXazIfYNx5fkZhJIK94JvSI=
MIME-Version: 1.0
In-Reply-To: <20180529163400.GA166256@gmail.com>
References: <1527572683-26098-1-git-send-email-nick.desaulniers@gmail.com> <20180529163400.GA166256@gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 19:03:29 -0700
Message-ID: <CAH7mPvgp9Rs28zXsucdMSn27g=dvVJ+H_djK_nibsZtBKP7uuw@mail.gmail.com>
Subject: Re: [PATCH] crypto: blkcipher: prefer strlcpy to strncpy
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 9:34 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Mon, May 28, 2018 at 10:44:43PM -0700, Nick Desaulniers wrote:
>> Fixes stringop-truncation warnings from gcc-8.
>>
>> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
>> ---
>>  crypto/ablkcipher.c | 8 ++++----
>>  crypto/blkcipher.c  | 4 ++--
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
>> index d880a48..e38867f 100644
>> --- a/crypto/ablkcipher.c
>> +++ b/crypto/ablkcipher.c
>> @@ -370,8 +370,8 @@ static int crypto_ablkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>>  {
>>       struct crypto_report_blkcipher rblkcipher;
>>
>> -     strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
>> -     strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
>> +     strlcpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
>> +     strlcpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
>>               sizeof(rblkcipher.geniv));
>>
>>       rblkcipher.blocksize = alg->cra_blocksize;
>> @@ -444,8 +444,8 @@ static int crypto_givcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>>  {
>>       struct crypto_report_blkcipher rblkcipher;
>>
>> -     strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
>> -     strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
>> +     strlcpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
>> +     strlcpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
>>               sizeof(rblkcipher.geniv));
>>
>>       rblkcipher.blocksize = alg->cra_blocksize;
>> diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
>> index 01c0d4a..ee88e48 100644
>> --- a/crypto/blkcipher.c
>> +++ b/crypto/blkcipher.c
>> @@ -509,8 +509,8 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>>  {
>>       struct crypto_report_blkcipher rblkcipher;
>>
>> -     strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
>> -     strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
>> +     strlcpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
>> +     strlcpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
>>               sizeof(rblkcipher.geniv));
>>
>>       rblkcipher.blocksize = alg->cra_blocksize;
>> --
>> 2.7.4
>>
>
> Hi Nick, this patch is wrong.  The 'struct crypto_report_blkcipher' is being
> copied to userspace via netlink, so all bytes of it must be initialized.
> strncpy() does this but strlcpy() does not.
>
> I noticed that you're sending out some other patches replacing strncpy() with
> strlcpy() too.  Can you please double check them for this same bug?
>
> Thanks,
>
> - Eric


Thanks for pointing out this subtlety, I've retracted the other patches.
