Return-Path: <kernel-hardening-return-11835-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226uR725WYny5p+4J0P2Sbc2fWe2se/wiHod0WzC2M1G7c/9x9xOvks4r7oW22ZwRPmt73zq
ARC-Seal: i=1; a=rsa-sha256; t=1519160110; cv=none;
        d=google.com; s=arc-20160816;
        b=UQhBVxKWAkHybRjHSkaeZE1+Bo4mJYwJN+V8RU5EPzAwfAcJ5VEYQE32UKnEMGF3VW
         zff5nvVv/TOr+b6SqE67ZMGRVI0aFcv02KfcZGl2368WMDeaJWl2cU35WkpOjkI9eB2R
         w0N1qUkd9sA94l6eOMMcwjt9HSp19q+0AN3n61yqN6bd4LK51l9wUJ105ccqX/KkZCoT
         Av4Qw3I+pB7c30oFWx7FL06wtb5LF6ekRIa1/+OJf6sMHSK0s/uh2cSGG6Xc0TADTaoh
         ukBWKBYD4kzu/+Fz6Mr2+4/agnpWDSklRHcbQGVgIZvmc7ARGUJGf1pxPeKcQS3KYt8U
         YZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=UAY3MVuU9RbvgUL4++A0GOVSQmjzCY52mYYDtGVoGQ4=;
        b=mN6B5bN3PjczNpeqTR/eR4Wz8askO5577JjkCnaTOB3Gii+LP4OiVzWr13m0lsR6Vl
         wyfgbkd6pyu0PQLhDMR4l1B27VMimSRNdjJsCX14Wl3oytfqAkeKDCm8N2nsNhvcsgDP
         etlLaB5oNMzwTDNoVKXv4JbFMDOTQEEM5x6mudd+fjcQ4KwVlt04A/4w9+jVlsMNv5KN
         Ct0ojtQuj+r8RgUw39AHimAT7Bjv2RTxSLGRUX5iVaxV3AEK727PS0xIXfMFRBJH8Oxd
         H4yK/rlmEOIJisEEm+MVyTM2A7XbKdfBGKHwmftM2FP5xTGM4PgCD8QgNwPbjihh3urD
         HB0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=d9s2+xnY;
       spf=pass (google.com: domain of kernel-hardening-return-11835-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11835-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=d9s2+xnY;
       spf=pass (google.com: domain of kernel-hardening-return-11835-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11835-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Feb 2018 12:54:42 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: rdunlap@infradead.org, corbet@lwn.net, keescook@chromium.org,
	mhocko@kernel.org, labbott@redhat.com, jglisse@redhat.com,
	hch@infradead.org, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
Message-ID: <20180220205442.GA15973@bombadil.infradead.org>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-4-igor.stoppa@huawei.com>
 <20180211211646.GC4680@bombadil.infradead.org>
 <cef01110-dc23-4442-f277-88d1d3662e00@huawei.com>
 <b59546a4-5a5b-ca48-3b51-09440b6a5493@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b59546a4-5a5b-ca48-3b51-09440b6a5493@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073184128407406?=
X-GMAIL-MSGID: =?utf-8?q?1592954831981655037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 09:53:30PM +0200, Igor Stoppa wrote:
> The patch relies on the function vmalloc_to_page ... which will return
> NULL when applied to huge mappings, while the original implementation
> will still work.

Huh?  vmalloc_to_page() should work for huge mappings...

> It was found while testing on a configuration with framebuffer.

... ah.  You tried to use vmalloc_to_page() on something which wasn't
backed by a struct page.  That's *supposed* to return NULL, but my
guess is that after this patch it returned garbage.
