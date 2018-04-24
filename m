Return-Path: <kernel-hardening-return-13118-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrkLvkQPScz4TIn9OooRERFVeQ5GPnKYkASwNCO7ikCuVNQD+OesgKsu+ssCgEIsJBx1zpL
ARC-Seal: i=1; a=rsa-sha256; t=1524588162; cv=none;
        d=google.com; s=arc-20160816;
        b=ugNaeqRoul93qHa5fPH8iTVrVHJ7u/9lhpWye5VLNwBe7vI0k683PKoqtM+vq9ndiO
         1hOBKKOIUPgLA+zekeTy6AW0JDYAfaEeLejcQtLhgC1LFc1rsys0r52/gtt8RRGa0zy6
         9kM6VaqAyl/cch5QO1ezLwQmeM7/oqYLN6yuP7kfQ8i5kpYAVu7uD0V3Jlhr7B5DlL+O
         OQw/EjIeHa6EjEhqf4hMoFIPGKQ+G9ZG+fhNTWJK4MMFoMawC5sQJ/uomH2LbtPyoC5W
         vb9zabxjtiCFce2LScf4z3TiwDOeeBntbt/KGpjEbxQLXbQpZ+7vsx97QPZkFdFnZmNW
         oEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=fnzqGo3DxyQP5odxNvOUV6yomOP0po3YkEdAuKvDTJk=;
        b=ewHemGe2PtnU9fyQmEOXC3UsvU9gJBGrvvdA6GIRceejf6Bq1ok9DWhYiaAL/4sHLg
         Oqqg9YPWF4ivd1KBwFm0JC+bOZirWf65Ai/cKLSgid+k1kI6CJwGswPUCUdGVC9Se2+M
         yh1aOIMcvT8BBfnaYsHx2qq96Qn1rFPe6wv2Ev15FdaZ3BhAcUO9bUBI31sKiN6J3kzt
         qbz6SEAlzwT85zl3j53ZMSmEn33ImXXLgtHGQnTZAFaG98xJQwmJJabT4s3g4rVMHMuk
         4luX2x+6/cmNiY+Ns0N4PGF3NG0bDlH5SUZY8uXQiRKP4yYHZgxAuF+AeZz+K5LgpZGK
         Ey0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mSSIG2bM;
       dkim=pass header.i=@chromium.org header.s=google header.b=G80BcPyU;
       spf=pass (google.com: domain of kernel-hardening-return-13118-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13118-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mSSIG2bM;
       dkim=pass header.i=@chromium.org header.s=google header.b=G80BcPyU;
       spf=pass (google.com: domain of kernel-hardening-return-13118-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13118-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180422162345.004292133@linutronix.de>
References: <20180422162345.004292133@linutronix.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 24 Apr 2018 09:42:22 -0700
X-Google-Sender-Auth: XWbhRIojs_Vfq324O8ClxsftQdw
Message-ID: <CAGXu5jKjV16r3RnrtgTv53xY6tyQmaJ5UQWDLpgk5irr6Mp15A@mail.gmail.com>
Subject: Re: [patch V3 00/10] rslib: Cleanup and VLA removal
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
X-GMAIL-THRID: =?utf-8?q?1598464722856567628?=
X-GMAIL-MSGID: =?utf-8?q?1598646557543847309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 9:23 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
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
> Changes since V2:
>
>    Provide a gfp aware variant of init_rs and use it in the alloc callback
>    of the dm/verity_fec rs_pool mempool allocations
>
>    Picked up Reviewed/Acked-by tags and fixed the subject line for the MTD
>    specific patch.

Excellent, thanks!

> Changes since V1:
>
>    Simplify error path in the diskonchip code and use the proper
>    function to free the decoder.
>
> As this spawns multiple subsystems it should either go through Andrews tree
> or Kees can route it with his other hardening stuff.

I'll create a VLA sub-tree to my KSPP stuff and start collecting this
and other VLA fixes that maintainers haven't taken yet. Once
build-testing finishes, I'll push it out for -next.

-Kees

-- 
Kees Cook
Pixel Security
