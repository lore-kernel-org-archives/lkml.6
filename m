Return-Path: <kernel-hardening-return-12627-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs6JL6qgSaSrs4Trsr+WwAbF8IudBAhB6EpriFBp+JM2c8xm4Qn9+A2WW+KlKmadEl6ctL2
ARC-Seal: i=1; a=rsa-sha256; t=1521110583; cv=none;
        d=google.com; s=arc-20160816;
        b=rIvo3YlJKXfXsUwpqADG4L90NtK2PE1Ed0Aj02jrspxKMlud9sArleVwV7HHCHDSjj
         xjcmz5ln0GIUDVRf2qdBVmxs88moCjYdd7eaaCUqeVjkNUEq2/DIAnQPDlpvdTFxh168
         KTg3BT0ee5scHLna4SQZDz6+G/Z2oWIgBhLraz0rDmndNNtczH1381JcuFIGthqebSzc
         K8N8OX2CUedoFkCjWNexOojb91cV+HkHYAaKI8NuOCSptQYBOBQlDtRW8koP2nH+6XcZ
         2Q8ef7D32gzp+RGmRxQOVtfXGag+El4Zz9UM3jIv9kwsS9hNAix3BeyBR0qx0YFZasaY
         Fmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=S1Jx8Sw1BPMeIwEbS5j5S/txELvbhCY4jF/5loUMDMA=;
        b=bBdYKp5OjSJ0fFSiGNq0J8L65GhCCnzhj++KsHhrPZ+mVx3QeE2yQ0WrdayFPE9GVT
         mBRX8j8roIeRsHEICccpgEU19Le0IHXXVZt0IwFXug+jfiXrb3rz3hkC/lS4jxRTNtRE
         l3vyjTeV09z2B/8nNWLrW5d9l9pw6N0FGR38uz6ohu2k8T3juyR+3EmN620P9QHKWVuj
         XmdNmcoHOVolk2VULGumuu8cqxJR729cmIUfn4dFpDHipZWd9ZHMH2cNEtT1ZGDJNajU
         RtOD28XAgKqmPYR4NBm47CP6MUkBOzeaMB0c1ZgK8g0jx99MS445r/xSQ2Ag6DJtUNGi
         Ds+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WI/NZgW4;
       spf=pass (google.com: domain of kernel-hardening-return-12627-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12627-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WI/NZgW4;
       spf=pass (google.com: domain of kernel-hardening-return-12627-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12627-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180315095428.GA31069@gondor.apana.org.au>
References: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com> <20180315095428.GA31069@gondor.apana.org.au>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Thu, 15 Mar 2018 11:42:25 +0100
Message-ID: <CAJHCu1+hKPTijqMO-bz5iB7fdmdxbh+xcpzW96tLYvOUBqhemg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ctr: avoid VLA use
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1595000051511568596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-15 10:54 GMT+01:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Wed, Mar 14, 2018 at 02:17:30PM +0100, Salvatore Mesoraca wrote:
>> All ciphers implemented in Linux have a block size less than or
>> equal to 16 bytes and the most demanding hw require 16 bits
>> alignment for the block buffer.
>> We avoid 2 VLAs[1] by always allocating 16 bytes with 16 bits
>> alignment, unless the architecture support efficient unaligned
>> accesses.
>> We also check, at runtime, that our assumptions still stand,
>> possibly dynamically allocating a new buffer, just in case
>> something changes in the future.
>
> Please move the check to ctr instance creation time.  That is,
> if the underlying blocksize is greater than 16 bytes than simply
> fail the creation.

Good, I'll send a v2.
Thank you for your help,

Salvatore
