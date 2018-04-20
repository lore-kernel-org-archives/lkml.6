Return-Path: <kernel-hardening-return-13071-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrMDJvFTXVhH03qpEZwPrMjVgMbgfSqfoxTH3cy38RJjLD4yulJXXhQf7GCRqR8IsAi5s0J
ARC-Seal: i=1; a=rsa-sha256; t=1524265364; cv=none;
        d=google.com; s=arc-20160816;
        b=Z7uMUKdPwBOFBlKhAVgtxkPPVJQ1m6smmN08FXLOseVjxJ6fRFzgRUHa0RTYcJxy6V
         IY4Az5ug8rS76B5p89LHQ6qOkeXXY869BnS4yqHTXtz4+Y6zY+eYzpv751QKZMR6cUa3
         qpttgi4lMh81iVKPbWURBWzUhwUvZEnn5B4bD+R4nh3T8mswH8VNrovUUnPbpYJegO0P
         ZQFBYwIBRGID8ijCFsEFZh7lEd+qfmm5DBUI4RW7tmZoLFgub6Vv7r2+rMexQ+ZxGDNA
         nVq+5lxpXThS3C6VnMUO3pR1GiybcFKOkZMNISjGezlnhj0TSjxI59J5JaV0I4exKGDy
         O5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=f36b3S68UGE2ELMJ/4gx+1P8nKeu7OJTKZnKYv2xhKw=;
        b=ZQs/fIetDnllQk7ztDQ+HR/w+K2MU6rCDB/guTvyrweQCoodfkWa61naZ+zFQfi76R
         UHPp+7SE8Co1Crie9LPw7L8+Iu4KDSPxcfpL4e1K9MjsFT9SQLm6aY3tsqiRqBlymD7h
         ZsanDVAnH/4u2Su7F/p4ooRHh9ZBGho+t6Hd0aKkAlvZAwaaouwcSpV+1K5JvBImptN2
         OotDUJGa3/F2d/JAYxrebrr1VjfGxPLFJV62F0BK/z9WILsxW3fXhJitbRXB/yEyQ9/F
         vnun6xq2PXe+Nd9hiY5rsxA5FAQXBu/duy6O2PnUXjHmeLsRtCSxiQRbz3V8kieOe/7s
         1a5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hRvKC+BQ;
       dkim=pass header.i=@chromium.org header.s=google header.b=BzFY6vey;
       spf=pass (google.com: domain of kernel-hardening-return-13071-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13071-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hRvKC+BQ;
       dkim=pass header.i=@chromium.org header.s=google header.b=BzFY6vey;
       spf=pass (google.com: domain of kernel-hardening-return-13071-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13071-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180419100441.548834519@linutronix.de>
References: <20180419100441.548834519@linutronix.de>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 20 Apr 2018 16:02:23 -0700
X-Google-Sender-Auth: x1-kAjkSXt0hm8jVAByFLCIhZJk
Message-ID: <CAGXu5jLs43nUASmLPrKf-eycoYZR3K_vuWi8Q+RaruFfodB0oQ@mail.gmail.com>
Subject: Re: [patch V2 0/8] rslib: Cleanup and VLA removal
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
	Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168914949440380?=
X-GMAIL-MSGID: =?utf-8?q?1598308078574338650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 3:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Kees tried to get rid of the Variable Length Arrays in the Reed-Solomon
> library by replacing them with fixed length arrays on stack. Though they
> are rather large and Andrew did not fall in love with that solution.
>
> This series addresses that in a different way by splitting the rs control
> structure up, so that each invocation of rs_init() returns a new instance
> in which the decoder buffers are allocated. The polynom tables which build
> the base for the RS codecs are still shareable between the instances to
> avoid large allocations and initializations of the same data over and over.
>
> The usage sites have been audited and fixed up where necessary to
> accomodate the decoder change which forbids parallel decoder invocation for
> a particular rs control instance to prevent buffer corruption.
>
> While at it the patch set tidies up the code and converts the related files
> over to use SPDX license identifiers.
>
> Changes since V1:
>
>    Simplify error path in the diskonchip code and use the proper
>    function to free the decoder.
>
> As this spawns multiple subsystems it should either go through Andrews tree
> or Kees can route it with his other hardening stuff.

I can start collecting ignored VLA patches. I haven't done that yet as
most maintainers have been taking them. There are only a handful
unapplied. Should I start the tree with rslib? :)

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
