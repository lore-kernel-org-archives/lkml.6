Return-Path: <kernel-hardening-return-11662-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227ev9NZiM5sazxJf6LL9pGvLNjca61u1E0is/lpworbpqauLqfEpMLMI4odUI/5HZt8xtsu
ARC-Seal: i=1; a=rsa-sha256; t=1518119350; cv=none;
        d=google.com; s=arc-20160816;
        b=Oa9yJeWb8fHU/Mwtj/82fkAqbKsTMsYGFUGO+Yraxfe7QqG8grNrUHEfQzrPolVa2W
         Z8H0vBH4Mc9nzPQDNMzfvENjLlI2inbWp4LewTsCx+PyGcROqDwXGX5do+F5Ma257QAo
         OWke/o5SEIIfCqT8R+meRByxVTIEXZbjSAa7WChi4P99wltNCRup4ioDPBfzT5xCqzqN
         ixkj+gxgXHxaeODZQgLU5MUatz6Iw8KJR/cq1F1fn8VneuXZPKZDfCIFnVuS9zN5R8/h
         MgxxPGi2ZVTuIWsGUHijh5duasQiBS6X0PCozcFnDzlQ0yxTlG7wRt0TNrkWlprJ1pU6
         TXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=N87gWHO8k70aJKthVtETyV6A+k6fUOLBXESmNII6ULc=;
        b=DOJT1vrsmoLOAYq2IgBFNywCcBuKKyXoy1fn3rvuz2u+SV7qk29DFPZniQF0mR2QZF
         YnpoWiqigE7ALEthkDsiSI+snssqmC3xMvxAsdsXv6a8w/pY84hyAu3uIVCnJX7iRU1J
         zufPfzXJLLzWhkArpbfjBn8rw1ywgj0eTmQwJ6nXccZw7DtYEvfFWEil59VAa4aTidPc
         N9muPEPl/pWYUCAl5zeIJxVXbbBtWp9dLTdf1SqWxTEufQhoy5iscMcnHz+4jq36hHe4
         Fx85VXXBjfKFXzq4MbsEvcH0HehiuDlIqwu/eT+mHzOCreaQDR+dJUARzaB0Uf5cP91I
         0Rug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iiZuNtlU;
       spf=pass (google.com: domain of kernel-hardening-return-11662-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11662-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iiZuNtlU;
       spf=pass (google.com: domain of kernel-hardening-return-11662-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11662-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180208194235.GA3424@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org> <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
 <20180208194235.GA3424@bombadil.infradead.org>
From: Daniel Micay <danielmicay@gmail.com>
Date: Thu, 8 Feb 2018 14:48:52 -0500
Message-ID: <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
To: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591863515358550442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I guess it could saturate and then switch to tracking the count via an
object pointer -> count mapping with a global lock? Whatever the
solution is should probably be a generic one since it's a recurring
issue.
