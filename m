Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E08C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DA720866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LjkJdbcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfAOPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:37:31 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35204 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfAOPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:37:31 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so4934954itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpdrG0i57yuDT9qTk0D6p76/Wl9yF9FTWSbWNHqAs7g=;
        b=LjkJdbcgSyht9WcoOtUblG6fRdILlV47wPoBUqdU++yvlZfUQQfHDzQl5OTIYpRByp
         EcMfYZIQUNQumYa1Hhkd29AwqayzMhEAVjf831Z85JwIXtXQQfDdHlQTHiy996A0IzXP
         g8qcJnPIi97qKJL6pPkDUX1RPLm56qpmPgTCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpdrG0i57yuDT9qTk0D6p76/Wl9yF9FTWSbWNHqAs7g=;
        b=SmS2gYsCSkhAleaAwRkWyPZuRSyrPn5TxejD6KDNBLEBoggUWWfiUPwHHLS3vxdlpt
         NTkGGLBeyrGr8SsHsdqfcA9DQhb2UjaqPosbtNuBVFwBcR+cvAuu6J0T2vpNkBf9gBXu
         2A7TkHeeek9Mz9jzWGohDmAlUDHjyzffx02PBgzCVziUxoCkAuur0berMfyml7d5NtrI
         27V93ffZAMxkw3U+02PhfRL0YrOMvL47y0xbxoWgy2hbNIPOK3cI48qsGxGjKU0ESpCe
         eSG8C+oUhZmOnMmv/uneY6Bgsd+6aoEMoMwlo/IS1/s57CtSb9lvNH6Pj3CQRjOVp410
         ysXA==
X-Gm-Message-State: AJcUukeeskogPHnskT4DAz0hdrYFr8kuSlwrU0xEuQPzCfBlPbBuzOGX
        tW+IdQmTa4vmFXrS5OhXYMK85SCOT7ypK+Uv7BMp5xEm
X-Google-Smtp-Source: ALg8bN5dB8yiLN48n7RwBBaFWCsXvBbhdwuvbhs0niKVyphSL+8+SM0WL7IfNpTX1cAUJtAspphlwjNpIk04LKivxt8=
X-Received: by 2002:a24:e38f:: with SMTP id d137mr2675247ith.69.1547566650426;
 Tue, 15 Jan 2019 07:37:30 -0800 (PST)
MIME-Version: 1.0
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
 <00b1782a-5c5c-5bc8-7ea9-4f8450679fa1@virtuozzo.com> <CAJfpeguokUoCPEnK7Q_Rp9cmyBCMfm51=7TmbbS-QiEy2BxxAQ@mail.gmail.com>
 <a45d54a3-b275-9c95-3c9d-a19566e447dc@virtuozzo.com>
In-Reply-To: <a45d54a3-b275-9c95-3c9d-a19566e447dc@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 15 Jan 2019 16:37:18 +0100
Message-ID: <CAJfpegvOgA+Wd3vTRqYQP7p_SJ11YCffquP_R=WRHwqYD4b=Ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Fix race in fuse_writepage_in_flight()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:03 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 10.01.2019 14:00, Miklos Szeredi wrote:
> > On Thu, Jan 10, 2019 at 11:48 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> Hi, Miklos,
> >>
> >> any comments about this?
> >
> > Is there a reproducer?  ISTR that fsx-linux with mmaps enabled was
> > good for stressing the writeback_cache code.
>
> There is no a reproducer, since I found that by eyes during preparation of another patchset.

That's good.  It would even better to have a reproducer, but it
doesn't look easy...

Completely redid this and reordered the patchset so this change is
made before the locking changes actually introduce the bug.  See
fuse.git#for-next.

Thanks,
Miklos
