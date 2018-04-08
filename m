Return-Path: <kernel-hardening-return-12891-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/FrKcIjX2qLi7kHeuKplT0hjG4tr7VLyafGiWVffpJ7qsTmY0NpgIapza8JDYAmqQoJAuu
ARC-Seal: i=1; a=rsa-sha256; t=1523177966; cv=none;
        d=google.com; s=arc-20160816;
        b=GtMn9NaDaSQz6IOpWFB/sFFYIQsUG4PckdJvhk9Z6GsmVho/UHopxD1TSv9Oid9vSN
         vIJTehqN7IO8MUe5uPewBDjyRkhcdarkvOdbUXhzbAFUvwn3zsqg6Q27/lGoKgGkrPwN
         9zbL1WiMXW8DBR6kyhzNi9He8eBgWLbWb7IU8BkfPHwD3MaJCEpnWxQWoFdvCc0Ni7TL
         ITFcmn6yoNkjlN1ZBxqatnfRe0OXGNvZr3VOlwh3p8NPwTs/wFAZiWNJYSZj+8Hw3CHy
         CxHn8C6rx5BPl2onqU6tFVDZ+4bbJjCbHzD44jO/jIyFuMghqpOe70GQ9jBo6zZU0pL2
         xHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=kGjzDJpnHEu4U/ZnYuasmd2evtUBy8zSWfjxwlzLlJU=;
        b=oAusnp5C3LsmCiTwDC2ZbG724iQqt+mpKKHPf1dPgBV7dJSJWzkG5JjyH+L1cgR8Il
         qojj1kxpehXUktUHr+pNijL1+8pvxj/4vL6F2jQQ+Y9os7y8mE5oHaSdITWfsqmyq+Wa
         YAlPNlOVgL4fNCAV2MYiq417gvisYXfoTbAcKrqX4lEZ2rxHCnKPGQTCO0CO+qUTUwch
         GWvHq8QpbZIH2xUGu3TTvPTfu9Tfb6tikNvGRr0zzSllKV0fgYN1LYdKTHaBucuS+qE+
         HGIMJACnc/eLtb85gRVOlvwV5kU+wWS4tk2Tm4QPZVOZ/WpJ0Su/Ws7Qmtvkm4fMYqO8
         2O1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qhbyn5GZ;
       spf=pass (google.com: domain of kernel-hardening-return-12891-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12891-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qhbyn5GZ;
       spf=pass (google.com: domain of kernel-hardening-return-12891-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12891-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180408031935.GC25197@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-3-git-send-email-s.mesoraca16@gmail.com> <20180408031935.GC25197@gondor.apana.org.au>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 8 Apr 2018 10:58:48 +0200
Message-ID: <CAJHCu1LQuvcxsfTYddN5o3=pMzj6mtnBKvTG9O378pv3w_Q24Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] crypto: ctr - avoid VLA use
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113761628441569?=
X-GMAIL-MSGID: =?utf-8?q?1597167859511204427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

018-04-08 5:19 GMT+02:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Sat, Apr 07, 2018 at 08:38:19PM +0200, Salvatore Mesoraca wrote:
>>
>> @@ -206,6 +207,14 @@ static struct crypto_instance *crypto_ctr_alloc(struct rtattr **tb)
>>       if (alg->cra_blocksize < 4)
>>               goto out_put_alg;
>>
>> +     /* Block size must be <= MAX_BLOCKSIZE. */
>> +     if (alg->cra_blocksize > MAX_BLOCKSIZE)
>> +             goto out_put_alg;
>> +
>> +     /* Alignmask must be <= MAX_ALIGNMASK. */
>> +     if (alg->cra_alignmask > MAX_ALIGNMASK)
>> +             goto out_put_alg;
>> +
>
> Since you're also adding a check to cipher algorithms in general,
> none of these individual checks are needed anymore.

Fair enough.
After removing the individual checks the modification to the single files
will be just a couple of lines, is it OK for you if I collapse all of them in
just a single commit?

Thank you,

Salvatore
