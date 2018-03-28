Return-Path: <kernel-hardening-return-12817-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/KU2mDJkb68D9oFCgZq6UHZw2BgQIhLuN4VxUv0hq95qVdCkzh1CAkVzjnOuiZrDQFsWRG
ARC-Seal: i=1; a=rsa-sha256; t=1522271685; cv=none;
        d=google.com; s=arc-20160816;
        b=Lpwt/jkT9PJCUTSgxkN7qFkH91md550zcBMWakD6ZFLcCHBPUAAZwRdZvtfOCRBURy
         v6uyqunqa2b752FmGmKYmTvEgpKVpDWt7shVLupCt4M8I8/6KAl4IvPckgYXNUhJ/Fab
         X2IQsaYzBgSYx8H7daIFuEYERyPnuDz0UoiIYMbqG+jzKgdrsBmNrq82f8rNW2sRUCuO
         JC5nbXJicKsIkFc2HRk8Pe1ZpvhxQztJzVmcbo75Kgz1Nu5xRE4glg18NW+c2G50ipDr
         W9VP0UbB73gkFnx01XV8mH/v5f7a0CdOH4O9bUzZx+JX0rSWXjlRCE+af6MGvRZ4gI3n
         9WMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=DPsJmnii3dIm5fsEzi398w2cWAR+a5v43vitaLy8y2g=;
        b=dkPls7O3/mBILJiPr7NVJf7powBddabXu0N5sfCJwkZuoY8IIf+CBftlQv8Di9/lME
         C+OMyHQdXv7JshJythLLQLJy1Ujd+iHIFB8QLCdVTO8vA60/B//WfEWeFKno/WyVnQ9Y
         o6dESV3xpoVf+oTcray+krtLrWlJR3nDAp6xp7eLBzLSzdT71bvSCBZ2++9awO5OaEJY
         LakBGfQ9ChW7Oxdfi1vYjR4T44CbCdMmiJrvDoaL7XNCY90L3ZDLV+g3yY2TiLpAOa/t
         wSQb8iO3Uc8ui2YnqMZuD1Nm85mTHTJ/bADJjFC5ygL9S4bsC9l8WmWq+gPaDHanhCaV
         BFKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=crGnrqez;
       dkim=pass header.i=@chromium.org header.s=google header.b=bWkxLwyf;
       spf=pass (google.com: domain of kernel-hardening-return-12817-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12817-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=crGnrqez;
       dkim=pass header.i=@chromium.org header.s=google header.b=bWkxLwyf;
       spf=pass (google.com: domain of kernel-hardening-return-12817-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12817-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180328205554.929111847@linutronix.de>
References: <20180328205138.301218351@linutronix.de> <20180328205554.929111847@linutronix.de>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 14:14:25 -0700
X-Google-Sender-Auth: WR5fgBGBnYX9twzDls7knWAuemE
Message-ID: <CAGXu5j+UUsR8=G93UHktjUSX3N8LsRvARNDRmNTiQGLzAAm=yw@mail.gmail.com>
Subject: Re: [patch 8/8] rslib: Allocate decoder buffers to avoid VLAs
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
X-GMAIL-THRID: =?utf-8?q?1596216563507994008?=
X-GMAIL-MSGID: =?utf-8?q?1596217554305360129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 1:51 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> To get rid of the variable length arrays on stack in the RS decoder it's
> necessary to allocate the decoder buffers per control structure instance.
>
> All usage sites have been checked for potential parallel decoder usage and
> fixed where necessary. Kees confirmed that the pstore decoding is strictly
> single threaded so there should be no surprises.

For posterity: pstore ecc decode happens during probe and during read.
The read (pstore_get_backend_records()) has an explicit read_mutex.

I was pondering, though, since we have a common control structure now,
maybe we should just add a spinlock too to avoid future surprises?

> Allocate them in the rs control structure sized depending on the number of
> roots for the chosen codec and adapt the decoder code to make use of them.
>
> Document the fact that decode operations based on a particular rs control
> instance cannot run in parallel and the caller has to ensure that as it's
> not possible to provide a proper locking construct which fits all use
> cases.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Regardless:

Acked-by: Kees Cook <keescook@chromium.org>

Thanks for doing this!

-Kees

-- 
Kees Cook
Pixel Security
