Return-Path: <kernel-hardening-return-12268-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELviVuBx886jaHXJCdY1FyEv7Xfsfc6/HxjHVi8njZt5jZlI7UgIZ8WjRVh2ohTF2KFACmtJ
ARC-Seal: i=1; a=rsa-sha256; t=1520546141; cv=none;
        d=google.com; s=arc-20160816;
        b=1B7Bryns7F+sej27pKmCd3La7z1NdQUncsBz77szFI1jRXnV2wNXYHfXlbeAdKitdz
         bvf6OdUo1Pixys1i9T135+6MBC4vuxX7ImmOYrmpeTXiMLolBEcmJT8FWZjkP2okHveY
         0eWrGrSBvxb/CqqrDhEubg/sDAudL+EQV7gJzzr8uF8TPG6BU3bo3nnFccgFg+/NYEWY
         u/ULszLvoVrssk2jaI51dJihBH9qPo/pXHIuGqNjoh81xIgpd6PGrUfYu4NuCpV6QSG6
         w37jLNKmkWY/CYzJM1vZqQOKRhufbDRwuqwPT5mn7XgrHCssyW6BZRS0Ay6LTR82d+T1
         RebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=XMDT7rB7Rc3N8AhmauWVh3eTQJnlZVopWo27MCkSHtg=;
        b=OHaTxx4T9HCdM/Pymzg8OhGkwvWgoa3r8CvHM9tcLOZu84aHWdRX/KgUNLDa0zRbYc
         HaK17v6YBX3SiNqsCU6PyLtTjq+ZuAImGnPCxm9nfjYQUhYp9S8yeC1gWL/qMC8QuPxY
         VV8g3fcstBouseMlmlVqQ25DdVtHCYjU6AtYamLc49+P+7ftZUE4EallsImE0azXNXb4
         +O2b/2M3zW1/dUVkgoePg77ZihFjR2HReWxjG9ViEZxMfIppMAIPfLR/Om+G3rinMOvA
         qeJlqytS7otb8+9NmbYxJIHdNBuMvBBbJS7z54Gg3Yu5Gl8qIhk8m5Q0FWTZX0z+zXwU
         TClg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=oQhDEOYp;
       dkim=pass header.i=@chromium.org header.s=google header.b=SI+TuBhW;
       spf=pass (google.com: domain of kernel-hardening-return-12268-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12268-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=oQhDEOYp;
       dkim=pass header.i=@chromium.org header.s=google header.b=SI+TuBhW;
       spf=pass (google.com: domain of kernel-hardening-return-12268-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12268-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <4fbe11f1-c92e-a4d5-616d-01e983f5405f@microchip.com>
References: <20180307215615.GA18928@beast> <4fbe11f1-c92e-a4d5-616d-01e983f5405f@microchip.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 13:55:22 -0800
X-Google-Sender-Auth: 4radffChvQz07e4NMhITaxFx3tw
Message-ID: <CAGXu5jKEM8ot_YQ8Jt=npGrVWSwj=ROse4YOyQb9QmpEQkx=sg@mail.gmail.com>
Subject: Re: [PATCH] crypto/ecc: Remove stack VLA usage
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, linux-crypto <linux-crypto@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1594408191430911948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 1:43 AM, Tudor Ambarus
<tudor.ambarus@microchip.com> wrote:
> Hi, Kees,
>
>
> On 03/07/2018 11:56 PM, Kees Cook wrote:
>>
>> On the quest to remove all VLAs from the kernel[1], this switches to
>> a pair of kmalloc regions instead of using the stack. This also moves
>> the get_random_bytes() after all allocations (and drops the needless
>> "nbytes" variable).
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   crypto/ecc.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/crypto/ecc.c b/crypto/ecc.c
>> index 18f32f2a5e1c..5bfa63603da0 100644
>> --- a/crypto/ecc.c
>> +++ b/crypto/ecc.c
>> @@ -1025,9 +1025,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id,
>> unsigned int ndigits,
>>   {
>>         int ret = 0;
>>         struct ecc_point *product, *pk;
>> -       u64 priv[ndigits];
>> -       u64 rand_z[ndigits];
>> -       unsigned int nbytes;
>> +       u64 *priv, *rand_z;
>>         const struct ecc_curve *curve = ecc_get_curve(curve_id);
>>         if (!private_key || !public_key || !curve) {
>> @@ -1035,14 +1033,22 @@ int crypto_ecdh_shared_secret(unsigned int
>> curve_id, unsigned int ndigits,
>>                 goto out;
>>         }
>>   -     nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
>> +       priv = kmalloc_array(ndigits, sizeof(*priv), GFP_KERNEL);
>> +       if (!priv) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>>   -     get_random_bytes(rand_z, nbytes);
>> +       rand_z = kmalloc_array(ndigits, sizeof(*rand_z), GFP_KERNEL);
>> +       if (!rand_z) {
>> +               ret = -ENOMEM;
>> +               goto kfree_out;
>> +       }
>>         pk = ecc_alloc_point(ndigits);
>>         if (!pk) {
>>                 ret = -ENOMEM;
>> -               goto out;
>> +               goto kfree_out;
>>         }
>>         product = ecc_alloc_point(ndigits);
>> @@ -1051,6 +1057,8 @@ int crypto_ecdh_shared_secret(unsigned int curve_id,
>> unsigned int ndigits,
>>                 goto err_alloc_product;
>>         }
>>   +     get_random_bytes(rand_z, ndigits << ECC_DIGITS_TO_BYTES_SHIFT);
>> +
>>         ecc_swap_digits(public_key, pk->x, ndigits);
>>         ecc_swap_digits(&public_key[ndigits], pk->y, ndigits);
>>         ecc_swap_digits(private_key, priv, ndigits);
>> @@ -1065,6 +1073,9 @@ int crypto_ecdh_shared_secret(unsigned int curve_id,
>> unsigned int ndigits,
>>         ecc_free_point(product);
>>   err_alloc_product:
>>         ecc_free_point(pk);
>> +kfree_out:
>> +       kfree(priv);
>
>
> I think we should use kzfree here.
>
>> +       kfree(rand_z);
>
>
> Probably here too.

Ah yeah, good idea. I'll send a v2.

> Looks like there are few intermediate buffers in ecc
> that should be zeroized as well.

Can you send a patch for those?

Thanks!

-Kees

>
> Best,
> ta
>>
>>   out:
>>         return ret;
>>   }
>>
>



-- 
Kees Cook
Pixel Security
