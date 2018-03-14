Return-Path: <kernel-hardening-return-12598-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv7gmt5iiWz+9rOY1t7AdUgQJPQQRIgzJXanlFSXpwyyymNcj4zVxgJW5LdxA71CsC05n5N
ARC-Seal: i=1; a=rsa-sha256; t=1521035229; cv=none;
        d=google.com; s=arc-20160816;
        b=BleBLPZ4GC5hPnb6lRD8RG6rn1afj7UoPYS29cFdie+EBaiDMb45ZFmQNNDGoak8Bs
         WkZZzbuaUWC1/9Ne+NCylC/nl/bGQarM9KcGFVI7cunsu9wfNhkIwDRFJp01Nw9kvPFE
         +D9BqTM3W49TRJkALoQ10wZGX3JX04pl3RnKQ8GzrJfpn8oNBEZvfOUosyR6Bm8Q+ysB
         4sU10wBvInUtSJZ9OTb6OM31mMBe8g0uAk8hK5Xtz/4eBVvBfW6yxQkqvNsmpJVCHTbs
         qQKVhBAOMKkl77bcO2dxAFfi6cUKyeZ71X9LTtYly73b0aulG5zwA2Wn6nyCk5lZIOai
         DAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=rO5KMC68I+ev16H0c6J/HdmNHyrlcFYRBfcIMZpsWEk=;
        b=xdUlOQaOBs9RQufvP7jMGrYS5kOMdxXey1763UR4q3ETWV150JNyXoSKellSCirQHc
         7OifaRnz+SEqmD8UWd+lGj7R1gnYMLlpVO6iAJyIbcI4YaHE3P2nVb+ZLtEfxy2eUv9+
         EKrcRmUCwRIpaUQWKZTbZgun4W1S0RwPsUNporLXjKUBYmuE1wx3EiQlKwSJiqdwWysw
         5lcTT80MH/idpfqhCbmRMexeMDJFWFcuhjkfepILewUKSA9b/t3bTHB5ZujaIWnJ3yTt
         SCuxrqujnMGyB7yf1IBsHEH+ggoNHskWH5Ap3woa2TWQzopVwFjrVCQ4YaDDOPqyv4bO
         Xw2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TzFwg4+X;
       spf=pass (google.com: domain of kernel-hardening-return-12598-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12598-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TzFwg4+X;
       spf=pass (google.com: domain of kernel-hardening-return-12598-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12598-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <4726635.XOh0VtZf4O@tauon.chronox.de>
References: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com> <4726635.XOh0VtZf4O@tauon.chronox.de>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 14 Mar 2018 14:46:29 +0100
Message-ID: <CAJHCu1LOhCcCcYqbKWFi1ac+raxoHGm75Y_njGHQD=S+9ZE1Xg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ctr: avoid VLA use
To: Stephan Mueller <smueller@chronox.de>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1594921035979758111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 14:31 GMT+01:00 Stephan Mueller <smueller@chronox.de>:
> Am Mittwoch, 14. M=C3=A4rz 2018, 14:17:30 CET schrieb Salvatore Mesoraca:
>
> Hi Salvatore,
>
>>       if (walk.nbytes) {
>> -             crypto_ctr_crypt_final(&walk, child);
>> -             err =3D blkcipher_walk_done(desc, &walk, 0);
>> +             err =3D crypto_ctr_crypt_final(&walk, child);
>> +             err =3D blkcipher_walk_done(desc, &walk, err);
>
> I guess you either want to handle the error from crypto_ctr_crypt_final o=
r do
> an err |=3D blkcipher_walk_done.

I think that blkcipher_walk_done handles and returns the error for me.
Am I wrong?

Best regards,

Salvatore
