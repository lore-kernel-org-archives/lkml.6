Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AE720817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZB5v6DO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AE720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeKGWqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:46:54 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54030 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:46:54 -0500
Received: by mail-it1-f194.google.com with SMTP id r12-v6so19953340ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 05:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TfpKNjDM3NE/OHRhe9KKo+nM/qluXKAp76DgMlGkpRQ=;
        b=ZB5v6DO55lInLQvTQo/BnyLAEIiH81CYOd6tTn7OxFf1wtaZ9wzWu9yUjNgUKdTrlx
         So3EKlt/ayP9UqNN0YmSnCfXct28YAootX5PFKXRAd2rhyJNYJtV89hbTbwYssOAS7lR
         OK1wunMt8ThXBr8BHH8DJD5Q/pBvbZVJVsdNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TfpKNjDM3NE/OHRhe9KKo+nM/qluXKAp76DgMlGkpRQ=;
        b=H0EKwjQrIZnhh3N+GMtgu7x0rmHRWPwyPEf9aMQtAXd2PWSfIMAepeN1hsEZeSHiSL
         mPUlnXRMkZxxe9/y6OhYQcBxbE0e3wPh+ylNgJKS+qHeOm+gc2Ms/XK0Vgi0dySL9BFN
         9ktpqxMPBb7EGUriYlI1C0/vyrsySfnBrr55pApbO9TwLnv6qBzUBhWPksHYtkdeWXDP
         GijZ6IAX1SQ0rr90Yo5nRPRO+YiJHQCprpGx9OJ2ZkGwH2j1O6LakesYGKtwEJcpF+IJ
         FjReQQUtS4OwqwJMHTTevrX5GVbj/EIuZIarwLFl162iiyzhv4VIepXA5QVWiFIngnY5
         mL/Q==
X-Gm-Message-State: AGRZ1gKC8izapGgjEabkVCWoU1J8Bj2ZuXqLHpb8DMuLKbxSo5Qbyxq/
        e1l92mvojDP09sGZ0+dXhPVDu8Mtjurk9KhZOqKdFw==
X-Google-Smtp-Source: AJdET5fGhsCBLXPY6kfhTWtbwyjpdCyBDjWTHUeY9aihiumTd3qdLtyTMj+Go+IGhe9hct0DtXEpixAbad+9R24lysk=
X-Received: by 2002:a24:7d8d:: with SMTP id b135-v6mr111765itc.121.1541596593187;
 Wed, 07 Nov 2018 05:16:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 05:16:30 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <154149664975.17764.16537105755726576371.stgit@localhost.localdomain>
References: <154149586524.17764.5252013294539109287.stgit@localhost.localdomain>
 <154149664975.17764.16537105755726576371.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 14:16:30 +0100
Message-ID: <CAJfpegttTpU0=yF_7QNx_PCOELetG0eGoEtmRyv0m4czK9EGNQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] fuse: Check for FR_SENT bit in fuse_dev_do_write()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:30 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> It's not possible to have answer to a request,
> before the request is actually sent. Add sanity
> check for that.

It's checking for the impossible.  That sometimes makes sense as a
WARN_ON() or in special cases a BUG_ON().


>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 739968ee8b0c..c603f1ebf0fd 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1947,7 +1947,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>                 goto err_unlock_pq;
>
>         req = request_find(fpq, oh.unique & ~FUSE_INT_REQ_BIT);
> -       if (!req)
> +       if (!req || !test_bit(FR_SENT, &req->flags))
>                 goto err_unlock_pq;
>
>         /* Is it an interrupt reply ID? */
>
