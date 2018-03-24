Return-Path: <kernel-hardening-return-12726-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuuHFEM0hislljDs8OmO3aLmBbP3DJKLKmv/hLrpAiiYcX0DeEfYjcDG0iMy1wnlCCqd48K
ARC-Seal: i=1; a=rsa-sha256; t=1521897752; cv=none;
        d=google.com; s=arc-20160816;
        b=0srUbOUArB3s7S5NvmwS7fa/Rwv9L/AXw3j+uUBOh8FGmN/CDkCPc62NgOb5xmk5Z+
         8oRg4l1d1dKdgnlex6jtdzRfkZTw9UQGEFw+KflpsAPhRMkifYMIMlqOI1FdMZXMTCfU
         PjwhORdNikfJn4q+zyQVku1ckEYISu7OP+YG27yvKJwkpxSgJ5GaVaq3T0vyCt5TYDHn
         w6wbmyuFCvmpcr5jO8HV09hbSPrcIAyN/0MEj8lfesz6p0zqEDcE3ZlIhd7hcW2Z2A1b
         WThBcMa+wLPI6kZbivwhuUn2cnhxkDGyUnG7d88kOvsHo3HbDz+pW1WagqMQ0xapJjhv
         NFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Cd7iKtbNcuPvapAx/357fv4gU89YZ1X0Mfj6OLfuaAU=;
        b=zEY/ONBbMQkr6gB6AGJnF37soQElF1HhTl2FJm/iLGLWHrm7GXBeh6ZRlRdiwmT9kd
         POfwCEGT6jST1XkJ+lSfVhKPfHEYiwVUcwdHnM+OCA/hCGM/0rn4lm9cHdPJ/vpZV/ZS
         7colpixcA0+FwJKSuiQ6RJa2viqowdqZ+Td7fk+06Pd9ExhAqGv48tTnTeNtgrDjAx2O
         mmVC+eDGPpPGoW3S23gSgz8MTHNjmIIXUkalu4PeNPmBOyJgCeo0oUOfg9OWiwdvx+tW
         3/Vc6d5aEBNJ9krdPW+zXsPQQfRwNCceqQYly5NJvwaW8MCJMKNt+EN2C4UHiIdD0GWW
         8Tsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VmomHk7m;
       spf=pass (google.com: domain of kernel-hardening-return-12726-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12726-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VmomHk7m;
       spf=pass (google.com: domain of kernel-hardening-return-12726-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12726-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180323153652.GA1760@gondor.apana.org.au>
References: <1521112738-13250-1-git-send-email-s.mesoraca16@gmail.com> <20180323153652.GA1760@gondor.apana.org.au>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sat, 24 Mar 2018 14:21:53 +0100
Message-ID: <CAJHCu1K-gFnt2mR6LkP=BH-eB-cHUoPyWWGCgPNe7B1B4no8Sg@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: ctr - avoid VLA use
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595002335438491834?=
X-GMAIL-MSGID: =?utf-8?q?1595825458050662350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-23 16:36 GMT+01:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Thu, Mar 15, 2018 at 12:18:58PM +0100, Salvatore Mesoraca wrote:
>>
>> +#define MAX_BLOCKSIZE 16
>> +
>> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> +#define MAX_ALIGNMASK 15
>> +#else
>> +#define MAX_ALIGNMASK 0
>> +#endif
>> +
>
> Hmm, this won't work.  Just because you have efficient unaligned
> access in general doesn't mean that every implementation can live
> with unaligned access.  In particular, on x86 there are quite a
> few implementations that require alignment or they will fault.
>
> So please just make it 15 unconditionally.

Oh, thank you for pointing it out. I'll fix this in v3.

Salvatore
