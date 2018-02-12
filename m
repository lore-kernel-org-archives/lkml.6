Return-Path: <kernel-hardening-return-11738-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227jFlM1GpZJy7OOt841Y8PueQHIzSNO+wi04+n84BTrXE/1VAKZt3wloYI1fxDrPnot8S73
ARC-Seal: i=1; a=rsa-sha256; t=1518479595; cv=none;
        d=google.com; s=arc-20160816;
        b=bDnZIcML1HacQ717+QFU7rVPB+fPhoQ4pC0TPgurTZSjoNcwk5Qhe0KTpNh5u1Y6z3
         gim0eOpEfT/ZFCM4mqPq2xozv0exSftSg+CCgTJWwMbuMr6SgJNvgGY7d1GQBvaVNRjG
         JqiVkXYLkawauhLnBCvmJLijJQQXPdx7LON18PnXKi3Q11wJ6ca0Se9zMlRavC1E7Kgw
         ehl5yk0h/s+v+PZYWHCkgBF9Iz5GY4/MPlnoXCdWuLVBbXOPjV5jkmqFR5Ab1g8Pa44/
         GDWRpQr5p3KpkTUkAHLAT0IANiW9Zhl2gCmVNDddiWNr38+fOpPqhvGLvfT9G26HR/rE
         y2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=NnWDcVvDDLKm5RQvyoJmTR2xPbQqECb87E1euKYodxU=;
        b=YxhwNccijW8SuLrd+Kbi59sqIvbzLYzYJqLR1AKZyThyhlRC/QvZBmGckgnbn52oOI
         UTRMiWqRiF/jxP1sMio0gJU1mYKlxuCUz1EA1QBOxsSKPzzSdiF/SFLjNHXURjtowR1z
         CkFDj4bEOvUMm9/rXrPoNkQpXCukbgwr7dmEUETKKzoD/CRMt3qW/miqyX/do+FnlOnq
         eMK+ha0vmbfDzQfTZQOfguP8MF7Qhi4w32/HFGPNtNQHuIvF2vwehxl53u4I0BT0/Msz
         pQPYyNF79KtECvr4fSgPn4uu70y0S6Dq4FIzCygVS4ezonnVQxe7JnczX824MHLBOZ1T
         9oig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aiboCv1R;
       dkim=pass header.i=@chromium.org header.s=google header.b=RlfBjq0/;
       spf=pass (google.com: domain of kernel-hardening-return-11738-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11738-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aiboCv1R;
       dkim=pass header.i=@chromium.org header.s=google header.b=RlfBjq0/;
       spf=pass (google.com: domain of kernel-hardening-return-11738-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11738-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180212165301.17933-2-igor.stoppa@huawei.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com> <20180212165301.17933-2-igor.stoppa@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 15:52:53 -0800
X-Google-Sender-Auth: EEhZnS07whD--2F2gJLkq0chKzw
Message-ID: <CAGXu5jJWLdsBr-6mXiFQprT-=h2qhhXAWRLQ+EaKKiubKOQOfw@mail.gmail.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214925267848300?=
X-GMAIL-MSGID: =?utf-8?q?1592241260429819824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> @@ -738,14 +1031,16 @@ EXPORT_SYMBOL(devm_gen_pool_create);
>
>  #ifdef CONFIG_OF
>  /**
> - * of_gen_pool_get - find a pool by phandle property
> + * of_gen_pool_get() - find a pool by phandle property
>   * @np: device node
>   * @propname: property name containing phandle(s)
>   * @index: index into the phandle array
>   *
> - * Returns the pool that contains the chunk starting at the physical
> - * address of the device tree node pointed at by the phandle property,
> - * or NULL if not found.
> + * Return:
> + * * pool address      - it contains the chunk starting at the physical
> + *                       address of the device tree node pointed at by
> + *                       the phandle property
> + * * NULL              - otherwise
>   */
>  struct gen_pool *of_gen_pool_get(struct device_node *np,
>         const char *propname, int index)

I wonder if this might be more readable by splitting the kernel-doc
changes from the bitmap changes? I.e. fix all the kernel-doc in one
patch, and in the following, make the bitmap changes. Maybe it's such
a small part that it doesn't matter, though?

-Kees

-- 
Kees Cook
Pixel Security
