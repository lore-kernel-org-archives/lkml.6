Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28588ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77E52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p9zkIAGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77E52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGRMRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:17:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43534 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeGRMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:17:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so8121645oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dJjank5GqsmR+19QSp279e4bVLfbOQNfqDky+4+4KB0=;
        b=p9zkIAGjguEV/anciWyO73Vk1KvJSvZgsogr+wL8haj3FjtCI7RcmnQG493vatPvOl
         RMj8nQoL8McO1SguxTPdBjxCpyAd1rrdxBzUm2vNbsnB496BYIWwePQm302OZOPpAwxL
         sYOglJNugQ5dM0t+jDtdqvevXQ14TpeckLLBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dJjank5GqsmR+19QSp279e4bVLfbOQNfqDky+4+4KB0=;
        b=T1KW3BZv4FMUIFP8Kc1I+wa87fzIDO1i5bCgOTbXOnvC4ZusJQe75zR2C3BL61XzhY
         EjU+YmkfCPrk1khUhAOcRH/1UCLFnBW4ACYD0Cz+A9p9e0CgzDqdUeon9UCmzoK8o961
         DInRFNwS6PbXRMBLCigsj3f2je5ySej+jinKe0TevN9noHjH4I2zerVk0GkPH9ce9OrY
         Fu72mXTvUZs61DUHJcVOI9gdpfPAw75nnan7afbDZNEA1Pxr1W0cQRZZVcfLeqKfGjmm
         oTWLUddGF/2OyRsmXPacJPCiTqq/d3F3rzBYt1fzRgncWndEmewtVderJB8KtSM6foLt
         y6AA==
X-Gm-Message-State: AOUpUlG32aTUptClqwbfDRKYpXX1+xNkfrB/x0B4u/vcIW9RjzrRuoDl
        JgGLjeHR1CcSWZaPKa+X/NR9G8HBXilwS1X4fercbA==
X-Google-Smtp-Source: AAOMgpcVDaziWMpRYqMk0DvhNtP8yCeppsgo6iYE0lEFgmW1npsO3obouYpp8+UwOlvGql8fOB64QaXA2hu6vpTXWtU=
X-Received: by 2002:aca:d04b:: with SMTP id h72-v6mr4106796oig.17.1531914009053;
 Wed, 18 Jul 2018 04:40:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:40:08
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180706204521.29654-1-mszeredi@redhat.com>
References: <20180706204521.29654-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Jul 2018 13:40:08 +0200
Message-ID: <CAJfpeguFaaE8i+fAg3HhQm6MPcFzMciY3WLfQUPdnY4xnmC7kg@mail.gmail.com>
Subject: Re: [PATCH v2 (v4.18 regression fix)] vfs: don't evict uninitialized inode
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

This (or some variant) needs to go into 4.18.

Thanks,
Miklos

On Fri, Jul 6, 2018 at 10:45 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> iput() ends up calling ->evict() on new inode, which is not yet initialized
> by owning fs.  So use destroy_inode() instead.
>
> Add to sb->s_inodes list only if inode is not in I_CREATING state (meaning
> that it wasn't allocated with new_inode(), which already does the
> insertion).
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")
> ---
>  fs/inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 04dd7e0d5142..e7de38c1d9d8 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1050,6 +1050,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  {
>         struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
>         struct inode *old;
> +       bool creating = inode->i_state & I_CREATING;
>
>  again:
>         spin_lock(&inode_hash_lock);
> @@ -1083,6 +1084,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>         inode->i_state |= I_NEW;
>         hlist_add_head(&inode->i_hash, head);
>         spin_unlock(&inode->i_lock);
> +       if (!creating)
> +               inode_sb_list_add(inode);
>  unlock:
>         spin_unlock(&inode_hash_lock);
>
> @@ -1117,12 +1120,12 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>         struct inode *inode = ilookup5(sb, hashval, test, data);
>
>         if (!inode) {
> -               struct inode *new = new_inode(sb);
> +               struct inode *new = alloc_inode(sb);
>
>                 if (new) {
>                         inode = inode_insert5(new, hashval, test, set, data);
>                         if (unlikely(inode != new))
> -                               iput(new);
> +                               destroy_inode(new);
>                 }
>         }
>         return inode;
> --
> 2.14.3
>
