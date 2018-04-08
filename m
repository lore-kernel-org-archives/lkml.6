Return-Path: <kernel-hardening-return-12890-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48OKqeoOSxt78W5yPGe3zqr3yOjZdIhlHdniXau6OAzyYT6ox9VLn6GRPRVxStZkPmNem9O
ARC-Seal: i=1; a=rsa-sha256; t=1523177816; cv=none;
        d=google.com; s=arc-20160816;
        b=aQQy1VOq9Q0+seYWTcJ2wy8EbWs7oMToK2MKMuJqYEnkvGUYVYIdAXlIYraC5LcGar
         YJNmI2YtjHDs0entxv5/XBwLaLcnZYN2kaFjShRv9Ee76gi/8lAn24E16Pyuc3ubTu6k
         goMhY/+0mDSjXd+WnSx6x6hG2SyUKN3jc4Ng4Rt72EL+vp39NXwSQYj5OL9nU2fCRuYx
         l+sgSfub5SvaO2824Qq8kkTn3316ii0X9aSG0tbBR8o4K3BqxfMfkx6kPeDcWni7QzWM
         AahRYvg8WifY7r6a3i0fY75b4uuFBfsu8RJS0WLXJxkhG8zBgjATDokgN4C+nw2Kk8do
         9fRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ECGTPJxg1ajhgn8+V60/GNnPpIREL/f3KT9SYeLeVQo=;
        b=LmhX5gKXL14411/S63D36+erCiLmuarnalOShInUm8HXi/udvIDh+ZGQz+eQDiAzac
         6PSDqTB7d5rxvdYac2pHNC3mMD0mAT5/M9xMZPglu30R+pZ7N4e6hq/qK8CgLeuGYLLz
         Uvdu5MOo2uvkLfncXaicm1NO41M7F+Er45qVcUuhgN1a9nW8xgRHvq14pfZJGGcRgJDG
         hsRWqmvoWwhe7vmSvvaagBdWMHAfRVj5cWxOoqK/3U4QwppvXcKD+R4alDCcuYC126eA
         0+xXiT1VtM7J4RJm4j7V4jTWfkeIznCfej5N9/HOLN6fE/iLVD7R3Q5mvUNI1HbK6RdR
         eFAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pl9Jc837;
       spf=pass (google.com: domain of kernel-hardening-return-12890-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12890-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pl9Jc837;
       spf=pass (google.com: domain of kernel-hardening-return-12890-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12890-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180408031500.GA25197@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-2-git-send-email-s.mesoraca16@gmail.com> <20180408031500.GA25197@gondor.apana.org.au>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 8 Apr 2018 10:56:17 +0200
Message-ID: <CAJHCu1KkNgiFR1cZ+T6-+t5-41theqVsLU8umgqLi8JWhs2nxw@mail.gmail.com>
Subject: Re: [PATCH 1/6] crypto: api - laying macros for statically allocated buffers
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113752919288094?=
X-GMAIL-MSGID: =?utf-8?q?1597167701385559462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-08 5:15 GMT+02:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Sat, Apr 07, 2018 at 08:38:18PM +0200, Salvatore Mesoraca wrote:
>> Creating 2 new compile-time constants for internal use,
>> in preparation for the removal of VLAs[1] from crypto code.
>> All ciphers implemented in Linux have a block size less than or
>> equal to 16 bytes and the most demanding hw require 16 bytes
>> alignment for the block buffer.
>>
>> [1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> ---
>>  crypto/internal.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/crypto/internal.h b/crypto/internal.h
>> index 9a3f399..89ae41e 100644
>> --- a/crypto/internal.h
>> +++ b/crypto/internal.h
>> @@ -26,6 +26,14 @@
>>  #include <linux/rwsem.h>
>>  #include <linux/slab.h>
>>
>> +/*
>> + * Maximum values for blocksize and alignmask, used to allocate
>> + * static buffers that are big enough for any combination of
>> + * ciphers and architectures.
>> + */
>> +#define MAX_BLOCKSIZE                        16
>> +#define MAX_ALIGNMASK                        15
>
> No please don't put this here if you intend on using it everywhere.
> This file is reserved for truly internal bits.
>
> Perhaps include/crypto/algapi.h would be a better place.

OK, thank you for the suggestion :)

Salvatore
