Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC12F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeGRMsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:48:11 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:37671 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeGRMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:48:10 -0400
Received: by mail-oi0-f50.google.com with SMTP id k81-v6so8302405oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 05:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3tZjhnMQZ7o4YS1iA0vnYBK/PUaYbzbfs3W4pV/N0E4=;
        b=JcxEft8jzRRV19FSit0OOrc9WHaRCCybblX38oRCndIIJ4QU/LW6x1ze2AnSQ2rS73
         Ws5K6hRV2lZ0wswkIPOQRKLl6ir9oohsa0Ii4mLp9N4Xqj82AQTCt2X8xLrj6BBlRwZv
         /lwbmjVmCFHFqUY+q/iXPSS9TkzqRINHc9tF9ZdwkATODKK2t0YPsp0M/ethCZFxk76y
         rQH4Af+jyUhwKVG64NgVf3IdOFkxu1wsHGUYHVOxp448C54pNX5I8wyQYWAW7C0PCWPm
         I9Raq3wpeK7VGyQLVsnJdKa3Kxh4YzNgcRrYY8YLKigdbH1n0jtFVCcVBkd1TKdK9etZ
         pVlg==
X-Gm-Message-State: AOUpUlH0d5UuItcZ6M3jIL7UQhEzZdVV/QJqrClXqXyjnd67667m5SRj
        PxGcB+4NTr1qZfUHj/hf9ctwQfnFZOlcIXn8lp5kpw==
X-Google-Smtp-Source: AAOMgpcKI5YYYd11/kQXT7h7Rr4UUXVD87QltR8k6mGHLpuvc1L99ZYkblbXc+aj30GnXNXk3RL4FEMT5B0ogYCz0ao=
X-Received: by 2002:aca:e8c9:: with SMTP id f192-v6mr6202075oih.87.1531915833151;
 Wed, 18 Jul 2018 05:10:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3407:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 05:10:32
 -0700 (PDT)
In-Reply-To: <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk> <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk> <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk> <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au> <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 18 Jul 2018 14:10:32 +0200
Message-ID: <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
Subject: Re: vfs / overlayfs conflict resolution for linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 9:25 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> On Wed, Jul 18, 2018 at 5:29 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi Al,
>>
>> On Wed, 18 Jul 2018 03:56:37 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
>>>
>>> ... and now it even builds.  Said that, I would really like to hear something
>>> from you - I can duplicate the entire overlayfs-next and merge it into
>>> my #for-next and ask Steven to use that instead of your tree, but I very
>>> much dislike going over your head like that.
>>>
>>> I realize that you'd been away for a while and probably are digging yourself
>>> from under the piles of mail, but it's getting late in the cycle and I want
>>> to get #for-next into reasonably sane shape.  Please, look through that
>>> thing and respond.

In "ovl: stack file ops" this:

    AV: make it use open_with_fake_path(), don't mess with override_creds

Maybe it's the way to go, but looks broken as is; e.g. NFS does call
current_creds() from its open method to get the credentials to work
with.

Okay, so ->open() is a file op, and file ops should use file->f_cred,
but how are we going to enforce this?

Thanks,
Miklos
