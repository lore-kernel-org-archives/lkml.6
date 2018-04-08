Return-Path: <kernel-hardening-return-12892-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+R1Kqf4fXg2n7wWAvTcnu1XPnkR1FZfe1uElTSquR0cun828V4OJS6sHyoOir22hPMqnhN
ARC-Seal: i=1; a=rsa-sha256; t=1523178470; cv=none;
        d=google.com; s=arc-20160816;
        b=qhMoE+aVrTe8ynPKz66DVMxmeilBcNcIoqMbYxLxnde/IyjGZnNVPC1ncVpQ1YKaGW
         gJYjg5jis+ZXHNKXus61W5ZjFh1Jh7LuT6r39yK23cMags1Al/n0MJlKYv0CoZNeKydl
         vaCYu5mN6Pp26NYTuFP98JEfjwUji+yzQJtLOaT4GPpeyMS7ftiCskgTyJi9NZZPIGIA
         iA4vxlLmcDzRv6DTUkXXwdhUuRCusG3Sxbg1tbWOry2Hlk93wzePStLUPUYdedOZZx2c
         Mn4WYujNDJRsD+513y00fQqOUjQD9WoB+nKYiu3zc2Zn0z4npKuSCaJCch155jWkh8sp
         mSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=D0eDRCQfIk+LRBmLR9NC0w/WCgJkrRftTWL0vGmO5jQ=;
        b=CuWKHNLsm25sik8UgipwLF1/WLChk2YmIBGrvHgRL2egNtKchA8M/JRK0a0jtvEcZr
         JqmN1cFnMrDvrRMeqoSSEgtlBrv1UetdrfC3p8Hl26vmjUxy8OcbEkmqrHTYKzRzze8I
         SEO5IqZgIWpG+GYeOkr3oAhvH31BXEkdkwd4W/z++iExwQfnoobV8abTDIdyCXgMHdmd
         nPyINIoS7tK7OOP5g8pOspukQyeihjHmnjIX+2opgEorxFfYxr0zCGfAciDZ3x5M0/I2
         33jERERN6T5NjlTyc54eNCTvbPdVj1J43ja81EXvzWPOmPTOES0F+5/rDjn/Ok5Liw4u
         AcxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b0NdvCJ6;
       spf=pass (google.com: domain of kernel-hardening-return-12892-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12892-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b0NdvCJ6;
       spf=pass (google.com: domain of kernel-hardening-return-12892-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12892-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180408031619.GB25197@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-4-git-send-email-s.mesoraca16@gmail.com> <20180408031619.GB25197@gondor.apana.org.au>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 8 Apr 2018 11:07:12 +0200
Message-ID: <CAJHCu1LiPkDzL8rQMDdope=di+TZxz6gXuMKFQi_YpkSNquJ_g@mail.gmail.com>
Subject: Re: [PATCH 3/6] crypto: api - avoid VLA use
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113773763364977?=
X-GMAIL-MSGID: =?utf-8?q?1597168388132151796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-08 5:16 GMT+02:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Sat, Apr 07, 2018 at 08:38:20PM +0200, Salvatore Mesoraca wrote:
>>
>>  int crypto_init_cipher_ops(struct crypto_tfm *tfm)
>>  {
>> +     const unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
>> +     const unsigned int size = crypto_tfm_alg_blocksize(tfm);
>>       struct cipher_tfm *ops = &tfm->crt_cipher;
>>       struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
>>
>> +     if (size > MAX_BLOCKSIZE || alignmask > MAX_ALIGNMASK)
>> +             return -EINVAL;
>> +
>
> This check should be done when the algorithm is registered.  Perhaps
> crypto_check_alg.

Please correct me if I'm wrong:
isn't crypto_check_alg invoked also during hashing algorithm registration?
In this patch-set I'm dealing only with ciphers, because the maximum
block size (16)
is relatively small and it's also the most common block size with
ciphers (maybe I should
have explicitly referenced ciphers in the macro names, my bad).
I don't think that it would be OK to use a similar approach for hashes
too, because some
of them have block size >= 1024 bytes.

Thank you for your time,

Salvatore
