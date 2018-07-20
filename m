Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66171ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3B720652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CDszI3Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3B720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeGTJTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:19:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42064 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbeGTJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:19:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so19930554oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=heThlG4C9X6OTYLVo+SUq17JBfMcruPUn1/qWAwnhA0=;
        b=CDszI3Q+/9qupKCNS/a5m3ABBhfVdLxbGvwtfTfAZkalrNQge4skOKO+QFEJpUcdcD
         XvO4g0aM4jdiMGAcyd8c+whKXrbxL2ZtRAcMZy8aCyvpl8RB46RsC6pxnrPE0oqeZmmz
         RNuCorkTFAIrFOGDiq7i7QkJe47I/+VZAd48Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=heThlG4C9X6OTYLVo+SUq17JBfMcruPUn1/qWAwnhA0=;
        b=epERb1r8jqdcMdkeylsQRNxqKVjR9x9rnAJGPCU5ow2+deecwKjDkI3rMD7Ro1BXqI
         rjK+5W1d740kF/F0r2Kbw1kWNrLZ8rBCDsstCxrevUdRn48WwqOHLIxoZmeinSq503hv
         x1bzJmhZvHJyV8l69SBQ8tVVfulZmEqv7S0w1OqwP6uyRE9J7+uMhFV/Cnps6z1nO/DH
         WJkoePWj4mJUcMuUutHd9dCVOzGWC1igKohAxqMsLaLehPx+hesCwqIEO/jFtUdrZefU
         FHKAvQwi7f1iimE3ddkTf0dkcQHYDpUjBvyA9aebyPPdVTDb3l2+CAB/WgfTRENQt+nL
         tkzQ==
X-Gm-Message-State: AOUpUlG+Ly/3aQ088LCbwXYuuAHYOviiRPTs1v+rliTj1GBSoLH60G4t
        VQi5r+/mf/SFbExutpSxezHu98+KoWxCnFTq0OM4QQ==
X-Google-Smtp-Source: AAOMgpfVAd+Yz+G0qwPPpQ3Ng2YWNb0imW/qRIvgaq+nzcQ5zwleSPogUulFU+iHRyx8Afav489NBnbAsv5uvqD+LPE=
X-Received: by 2002:aca:a64d:: with SMTP id p74-v6mr1015740oie.149.1532075558431;
 Fri, 20 Jul 2018 01:32:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 01:32:37
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180719214519.GA23379@ZenIV.linux.org.uk>
References: <20180706204521.29654-1-mszeredi@redhat.com> <CAJfpeguFaaE8i+fAg3HhQm6MPcFzMciY3WLfQUPdnY4xnmC7kg@mail.gmail.com>
 <20180718121833.GR30522@ZenIV.linux.org.uk> <20180719214519.GA23379@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 20 Jul 2018 10:32:37 +0200
Message-ID: <CAJfpegtNMrFfwXjP8tMb0NvO=paDpESRBfueBit6mW2e7djhZg@mail.gmail.com>
Subject: Re: [PATCH v2 (v4.18 regression fix)] vfs: don't evict uninitialized inode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:45 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Jul 18, 2018 at 01:18:33PM +0100, Al Viro wrote:
>
>> BTW, why have you left generic_readlink() sitting around?  AFAICS,
>> it could've been folded into the only remaining caller just as
>> you've made it static in late 2016...  I'll fold it in;
>> just curious what was the reason for not doing that back then...
>
> BTW^2:
> const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
> {
>         const char *res = ERR_PTR(-EINVAL);
>         struct inode *inode = d_inode(dentry);
>
>         if (d_is_symlink(dentry)) {
>                 res = ERR_PTR(security_inode_readlink(dentry));
>                 if (!res)
>                         res = inode->i_op->get_link(dentry, inode, done);
>         }
>         return res;
> }
> hits a method call that is not needed in the majority of cases.  Is there
> any subtle reason why it shouldn't be
>
> const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
> {
>         const char *res = ERR_PTR(-EINVAL);
>         struct inode *inode = d_inode(dentry);
>
>         if (d_is_symlink(dentry)) {
>                 res = ERR_PTR(security_inode_readlink(dentry));
>                 if (!res)
>                         res = inode->i_link;
>                 if (!res)
>                         res = inode->i_op->get_link(dentry, inode, done);
>         }
>         return res;
> }
> instead?

Can't see any issues.  But I also don't think any of the callers are
seriously performance sensitive, so I guess it basically doesn't
matter.

Thanks,
Miklos
