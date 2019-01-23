Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7F0C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4297821019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kGIVrMb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfAWJhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:37:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52257 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfAWJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:37:30 -0500
Received: by mail-it1-f195.google.com with SMTP id d11so959944itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJ57WwJycFJH6Ahi8elr/glYZQZNbjb1BJu+zgLwiL8=;
        b=kGIVrMb1rjKlzXU4GEGYEjRUiOronkf8bCdgp1BidOqoNkOz6clY0AG+TT2iWUPsu8
         oUoJ7kju0gO+qs8ZFi7ci5cRm80uHS++7swrWpU2p+2UthTf21GuVUwGLaDwhkfWOtCY
         BKpErWfTvRCXpv2Jy/ZK5tugWdLYqt44v4qM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJ57WwJycFJH6Ahi8elr/glYZQZNbjb1BJu+zgLwiL8=;
        b=HB9CJdAT1/By1YNjT3xa3ws+yyx3q4c05UqRGNb5UuXaOS5/jPWAo1eVq8rZNf1Xs6
         dZWM/awDXUVIa8GaezqY/dQLY35Wttz7M8gA8OpxXB0VSLoB+TJ6zWI17rINa8+pyV5K
         8a6Lp/dBrOPEH3ledzJ778zy0ufMwTv7RuEwNACLvYZvNFUjHENuKrreTba+2x+GgUSZ
         l/GOsiz5ercBzpg9klKYRkbKJz96iY0lyrWfTRFMY+JRZLZHPKvxlkuoiHukX90kbTdh
         emdyyw5a/RMXPqF9nZo5eiVQgx4qMSLNhE5s6gJc+Tg+AYkqacEoyzfVCopQRIsutsJt
         0TaA==
X-Gm-Message-State: AJcUukdWxmmVp99S2bUDW8uqgSgm6Z42/y6uWNqb3RRVqxNH0g8jgm80
        VV7BrQhR3TIdX/4+Gt7Bj/lsXrVrzBNM+r5HvrYm+K7i
X-Google-Smtp-Source: ALg8bN6U/pi0W9tjlH2RAXLCAHsG/+63M5On5uj33pv0ETilNul3R91XYstahk2rYmqCItVF5ZW5TtmnkecUOBL45aE=
X-Received: by 2002:a02:8904:: with SMTP id o4mr827157jaj.35.1548236249864;
 Wed, 23 Jan 2019 01:37:29 -0800 (PST)
MIME-Version: 1.0
References: <154151286725.17550.12307253489084032792.stgit@localhost.localdomain>
In-Reply-To: <154151286725.17550.12307253489084032792.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Jan 2019 10:37:18 +0100
Message-ID: <CAJfpegvaRGD3qT0qjAW76_MFNOUDTMgBJR+H+WeVWBivAppzrQ@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: Prevent background write requests increase
 inode size
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 3:03 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Hi, Miklos,
>
> this is not a well-tested patch, this is a concept,
> showing the places, where it looks we have a problem.
>
> Commit 7879c4e58b7c made io->async careless about inode size,
> and this is wrong. Asyncronuos background requests may be sent
> to userspace after inode becomes unlocked, when background
> queue is throttled. In this case we execute a write request
> extending inode size without any protection, and this ruines
> everything. Fix that.
>
> Also, some write background requests do not increment fi->writectr,
> e.g.:
>         fuse_direct_IO()
>           fuse_direct_io()
>             fuse_send_write()
>               fuse_async_req_send()
>                 fuse_request_send_background()

inode_lock should prevent mischief for sync DIO.  For AIO DIO the
order of operations is not deterministic, so it's fine if truncate and
an extending AIO write race, as far as I understand.

Thanks,
Miklos
