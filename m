Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE2BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AA82145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeLQNm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:42:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39387 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeLQNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:42:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so10152045oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1g5eJeBlwVNvTxD1JBVHJ79CyCxouofrqstVeCm+q0=;
        b=IEef3tiK+KOXqaCbmmvJhisatcD/p5jTXUdThB7L07FOqjFzK6/A54DPbUjDWGfqte
         4CTKKghOdsQWv0Dm1pLAvUvgijAepkn3uBMld+uLtPN10unVprZbc8UL6Wm4mnZkC0QO
         MNrkLeniuxVCBsX3bI73EB3IVj+mSiyrJetA8bHaxaufZh0lExorPEFhJaKMMoST8+vC
         ytnIUlk9JBu+XskeBJRCp0Cb1f+TIxA8UfcAxpvpWb8oVFYtHvRfwfHMv1YbeUgzVqEQ
         EOsFxsLKPHbJt152+8BV+bISbeTEmq+ORWfefeDBJGwD6DbPx3WGd8HMKsbI1fI5nDpF
         KeDQ==
X-Gm-Message-State: AA+aEWZsxxliGRGNUTqiBjYcV5Ry34tPWTzggBDPeOykuLEDP9D4IflW
        wZplPred0a5qbRRlAKJ/n35xqPUduH6RA8HVON8+6vnqPpQ=
X-Google-Smtp-Source: AFSGD/Welj04BCpl8XJvHRBM9W+gju8ngCH9GZ34woZ9rQ35zpMLa/hkpXO427bNtn1Ujw3JK2vJQE6V5mATZ5Q3iAQ=
X-Received: by 2002:aca:de03:: with SMTP id v3mr5538669oig.152.1545054148008;
 Mon, 17 Dec 2018 05:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20181215101329.16246-1-richard@nod.at>
In-Reply-To: <20181215101329.16246-1-richard@nod.at>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 17 Dec 2018 14:42:16 +0100
Message-ID: <CAHc6FU73Cx=KengB8R=am_d0fGvQjaRrog9tqBC8TJaa+F296g@mail.gmail.com>
Subject: Re: [PATCH] jffs2: Fix retry handling jffs2_listxattr
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        dwmw2@infradead.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Sat, 15 Dec 2018 at 11:22, Richard Weinberger <richard@nod.at> wrote:
> When jffs2 has to retry reading xattrs we need to reset
> the buffer pointer. Otherwise we return old xattrs from the
> previous iteration which leads to a inconsistency between
> the number of bytes we return and the real list size.
>
> Cc: <stable@vger.kernel.org>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Fixes: 764a5c6b1fa4 ("xattr handlers: Simplify list operation")
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> ---
> Andreas,
>
> since you maintain the attr package too, I report it right here. :-)
> This jffs2 bug lead to a crash in attr_list().
>
> for() will loop to crash when there is no trailing \0 in the
> list of xattrs.
>
> for (l = lbuf; l != lbuf + length; l = strchr(l, '\0') + 1) {
>         if (api_unconvert(name, l, flags))
>                 continue;
>
> ...
> }
>
> I suggest changing the loop condition to something like l < lbuf + length.

With that change alone, strchr would still go beyond the buffer. Let's
just append a null character at the end instead.

Thanks,
Andreas

> Thanks,
> //richard
> ---
>  fs/jffs2/xattr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> index da3e18503c65..0cb322eb9516 100644
> --- a/fs/jffs2/xattr.c
> +++ b/fs/jffs2/xattr.c
> @@ -967,6 +967,7 @@ ssize_t jffs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
>         struct jffs2_xattr_ref *ref, **pref;
>         struct jffs2_xattr_datum *xd;
>         const struct xattr_handler *xhandle;
> +       char *orig_buffer = buffer;
>         const char *prefix;
>         ssize_t prefix_len, len, rc;
>         int retry = 0;
> @@ -977,6 +978,7 @@ ssize_t jffs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
>
>         down_read(&c->xattr_sem);
>   retry:
> +       buffer = orig_buffer;
>         len = 0;
>         for (ref=ic->xref, pref=&ic->xref; ref; pref=&ref->next, ref=ref->next) {
>                 BUG_ON(ref->ic != ic);
> --
> 2.20.0
>
