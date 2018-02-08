Return-Path: <kernel-hardening-return-11660-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226NNJi2seo+JU+304pknBTOIsCItZOjpqiOGs8vfT3VJfPJNgXgvB5yuZ3NuEXEcVATYLIo
ARC-Seal: i=1; a=rsa-sha256; t=1518118461; cv=none;
        d=google.com; s=arc-20160816;
        b=Vz9vOEzJcv9zwp3nMMlguIwXrxt+KjM9vzrsFgwygAXg1rtmNJk+2HczFD6rXr6Spi
         7Zi0w9e0QTGbf/sZITOMk5CZRSuraERPjV5+5rptssXxZZIdg0UnmaFhNtUQrsG82H3k
         YX9/VF1lr4jaNM5W4cNi2o22e+fbMJsN7OVIvwVQpSoC+Spot6WyC6xMLep+7/ZWp/OZ
         zN9KQlpuEK+z69LwELkli9Vzpmm6dtdcVWujNxaYA7TtXEd1cHZ+kg6E63LSd+LWqtgu
         jFs56KbhWTMdtISweGNyIHq+MAYIzG4rEf4UjiUUma3Ikh7H+yLPDmlHD13JzDzWhUwq
         FSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=kzvNZJcjVkULnnF/2mhALaLSqWk0TxSshPejqYTm1FY=;
        b=M2x4zldFPmzVrTfV8LuFkwYmETOovKG63QPJNDSIkAWrs/xV07C7FyoFgslCXtNAo5
         IN/GmwatVpANQeolT9fz1vf+eSqNMzdN4qjasmvadLbnoZhsFkD56Vpgi8gPhWPE0fJe
         tgJBbixw/oGhSfXCRPlrXC+EIoKDlQUz9twhlE0qWLCQiw48T4D5Vgkyjn9NgEVphGPd
         mUXostN9MBFsXMn6hcrxp6YYmdqdzxqOwkcGnKgjEYQEbxKZd3gviBZPQCZRvfUH8w09
         v5KWNNovN/grR0ZCzFRBY5a2AFTnSAQGRXNoAoNg5nqMt1vCbpwtatuHQlulIU45mILy
         NdaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EJr72hlH;
       spf=pass (google.com: domain of kernel-hardening-return-11660-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11660-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EJr72hlH;
       spf=pass (google.com: domain of kernel-hardening-return-11660-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11660-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180208185648.GB9524@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com> <20180208185648.GB9524@bombadil.infradead.org>
From: Daniel Micay <danielmicay@gmail.com>
Date: Thu, 8 Feb 2018 14:33:58 -0500
Message-ID: <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
To: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591862584138637399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I don't think the kernel can get away with the current approach.
Object sizes and counts on 64-bit should be 64-bit unless there's a
verifiable reason they can get away with 32-bit. Having it use leak
memory isn't okay, just much less bad than vulnerabilities exploitable
beyond just denial of service.

Every 32-bit reference count should probably have a short comment
explaining why it can't overflow on 64-bit... if that can't be written
or it's too complicated to demonstrate, it probably needs to be
64-bit. It's one of many pervasive forms of integer overflows in the
kernel... :(
