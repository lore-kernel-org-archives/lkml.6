Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeCaRau (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 13:30:50 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:44001 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeCaRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 13:30:48 -0400
X-Google-Smtp-Source: AIpwx4/flSa47/DRzqLd6ZWUE6J7zjj4DetIU9ypTnHCTHH0YmVL85xmLIikMOw4VXE4JeOppOLYNdsDgr7ronRd0c8=
MIME-Version: 1.0
X-Originating-IP: [62.219.136.235]
In-Reply-To: <20180330172616.GB28120@gondor.apana.org.au>
References: <1522049540-10042-1-git-send-email-gilad@benyossef.com>
 <1522049540-10042-3-git-send-email-gilad@benyossef.com> <20180330172616.GB28120@gondor.apana.org.au>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Sat, 31 Mar 2018 20:30:46 +0300
Message-ID: <CAOtvUMd6MMyQBHU4E=5DKXndhZw90=K1V1apD0uRRaMLyp-0Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: ccree: enable support for hardware keys
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 8:26 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Mar 26, 2018 at 08:32:19AM +0100, Gilad Ben-Yossef wrote:
>> Enable CryptoCell support for hardware keys.
>>
>> Hardware keys are regular AES keys loaded into CryptoCell internal memory
>> via firmware, often from secure boot ROM or hardware fuses at boot time.
>>
>> As such, they can be used for enc/dec purposes like any other key but
>> cannot (read: extremely hard to) be extracted since since they are not
>> available anywhere in RAM during runtime.
>>
>> The mechanism has some similarities to s390 secure keys although the keys
>> are not wrapped or sealed, but simply loaded offline. The interface was
>> therefore modeled based on the s390 secure keys support.
>>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> ...
>
>>  static const struct cc_alg_template skcipher_algs[] = {
>>       {
>> +             .name = "xts(haes)",
>> +             .driver_name = "xts-haes-ccree",
>> +             .blocksize = AES_BLOCK_SIZE,
>> +             .template_skcipher = {
>> +                     .setkey = cc_cipher_sethkey,
>> +                     .encrypt = cc_cipher_encrypt,
>> +                     .decrypt = cc_cipher_decrypt,
>> +                     .min_keysize = CC_HW_KEY_SIZE,
>> +                     .max_keysize = CC_HW_KEY_SIZE,
>> +                     .ivsize = AES_BLOCK_SIZE,
>> +                     },
>> +             .cipher_mode = DRV_CIPHER_XTS,
>> +             .flow_mode = S_DIN_to_AES,
>> +             .min_hw_rev = CC_HW_REV_630,
>> +     },
>
> How can this possibly pass the self-test?

Indeed, I could not figure a way to test the mechanism directly.

However, as it uses the exact same mechanism of the regular xts-aes-ccree
but takes the key from another source, I've marked it with a test of
alg_test_null() on the premise that if the xts-aes-ccree works, so must this.

>
> If we want to add hardware keys we will need to figure out how
> to deal with it in the top-level API first.
>

> Are there other crypto drivers doing this?

I thought the exact same thing until I ran into a presentation about the s390
secure keys implementation. I basically imitated their use (or abuse?)
of the Crypto API
assuming it is the way to go.

Take a look at arch/s390/crypto/paes_s390.c

The slide for the presentation describing this is here:
http://schd.ws/hosted_files/ossna2017/89/LC2017SecKeyDmCryptV5.pdf

And they seem to even have support for it in the DM-Crypt tools, which at
the time they claimed to be in the process of getting it up-streamed.

Anyway, if this is not the way to go I'd be more than happy to do whatever
work is needed to create the right interface.

PS. I'd be out of the office and away from email access to the coming week, so
kindly excuse any delay in response.

Thanks!
Gilad



-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
