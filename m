Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C05120657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="f9T54lAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfAOPjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:39:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34548 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbfAOPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:39:51 -0500
Received: by mail-io1-f65.google.com with SMTP id b16so2417335ior.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VYGv0zcinQWLC8/2xFKWOHQPYAxKxQoqlf+Tcy5xLg=;
        b=f9T54lAaCgMusLCN0rvX3cYPXlVIEkBPcgQVF3Bqu5jK/Yz5buPpJiCbPA4R0OgTit
         WV2HYsAlebKSf3Voft7a3AdwS9RjR8MzUrTktCss3ZQHRj1CCv/FaDz6x5FDzdboSQoq
         5OehGzBExc9aGuux+oEDkaAEMLx/KdR79L+/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VYGv0zcinQWLC8/2xFKWOHQPYAxKxQoqlf+Tcy5xLg=;
        b=LpEh4RCbzZN2BdGY3gnGEq9uM5jQoWIqel/oMvXN0bEFK6vCovA/xPCEmnnr2HqLYt
         SL993np5gZMnBZFmAPvRrmyF64+f+JvsUt3sROtK/gi80PQgfpZOyhblnQgnzb00M/oH
         3dVGnqlhrUL5LXbl+uk8twV2MIpDIO8AsSppm4+4DKq6hJTTK9uozI2KK7MuiZcKmlsv
         xX6boo6t45nMZC4kMkvuPEmSJdaO1ooJqhmhHoJ4WJoQBq++U5XBF/qdUZ5K38Yw3apv
         KNAu+zi78HGIUzNgrtAxSEkK3Dbpg42idDQKMDwYsdeppMtdPBjs0v5oARvSvUDxEgcM
         MVgg==
X-Gm-Message-State: AJcUukfOfRACjrlXnKWRMncaQJ3mYRKlU/WuXSmltJoOA//J8t6iUSag
        leZn5YG2vG3RXK3CHffl/4RbQkt7paC4Jt8NN38wDg==
X-Google-Smtp-Source: ALg8bN62/iMYTRbu1dRWFiHhtjxzCjqS7R1qLBH//6BdQ9+BALLNeW6bTRE1wH1ru+eYsuY+r3Yq+tZZxPzUBeY5jfM=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr1444369ioh.294.1547566790742;
 Tue, 15 Jan 2019 07:39:50 -0800 (PST)
MIME-Version: 1.0
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
 <154322557765.18737.14337090699283695815.stgit@localhost.localdomain>
In-Reply-To: <154322557765.18737.14337090699283695815.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 15 Jan 2019 16:39:39 +0100
Message-ID: <CAJfpegvKxJ06hfXR5yxWkdz0GzTw7vR2x8E5bjdO1df1J1C54w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Replace page without copying in fuse_writepage_in_flight()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:46 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> It looks like we can optimize old_req page replacement
> and avoid copying by simple updating the request's page.
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/file.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c6650c68b31a..83b54b082c86 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1778,7 +1778,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
>         if (old_req->num_pages == 1 && old_req != first_req) {
>                 struct backing_dev_info *bdi = inode_to_bdi(page->mapping->host);
>
> -               copy_highpage(old_req->pages[0], page);
> +               swap(old_req->pages[0], page);

This would mess up refcounting for all pages involved.   need to swap
with the temp page in new_req.    Fixed version in #for-next.

Thanks,
Miklos
