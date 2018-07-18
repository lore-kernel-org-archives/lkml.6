Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BA3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F1E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F1E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeGRICS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:02:18 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:43845 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbeGRICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:02:18 -0400
Received: by mail-oi0-f53.google.com with SMTP id b15-v6so6916716oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f1L/lL1mmp47ef9w61LKMHQEXbsue3u30ht/gK9GD3I=;
        b=IFpvbNgb8A7a8rm0ES9Wra6S66WetKJf/n8X5Y0Xi2M4Ylscvn59m/ahWgjaFKn9vP
         8mYkDIqUDCdr9LHZW2TqbwPSLD0JWgacG5VHzjREfiXYalI1QNwV7CV2Jvmf7zdgljuK
         mv14njrYS7C2G8/YEKg+uKBt0PYpN1rp3gPS2/P9AiRkkEGV1dHC83f5gASd0ozP2aMP
         H4fGYtxGZz4UoHexda1p0tG0cbW3cwccjEaJSTvo02zOHR/tCvQs/XEhS2S58Jb9/lDJ
         q8sYiCOXAt8b2En80jjmHJYnEXC5EODkWb3+BNrg3j7op5uuTkv63lQJQ2DuugyOFIxl
         /kgw==
X-Gm-Message-State: AOUpUlFVf+JyIhLnMuaqJZYkMGWlUfNU2HGPyKFDZCkRli2my9jv6Tqi
        OpoiVCPY+FynQsaR3odExWGgx69tkXubuzFHgD6sSg==
X-Google-Smtp-Source: AAOMgpej1fU+1mqvzKER4eEc3Oia6MBTMlY+0Ulu3oZZRVBssOaOiR7QwJMbWPggAYfXp7fg3BwnqSw5fiSTTkRe3ks=
X-Received: by 2002:aca:5583:: with SMTP id j125-v6mr5555688oib.2.1531898751699;
 Wed, 18 Jul 2018 00:25:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3407:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 00:25:50
 -0700 (PDT)
In-Reply-To: <20180718132955.2bf185b7@canb.auug.org.au>
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk> <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk> <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk> <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 18 Jul 2018 09:25:50 +0200
Message-ID: <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
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

On Wed, Jul 18, 2018 at 5:29 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Al,
>
> On Wed, 18 Jul 2018 03:56:37 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
>>
>> ... and now it even builds.  Said that, I would really like to hear something
>> from you - I can duplicate the entire overlayfs-next and merge it into
>> my #for-next and ask Steven to use that instead of your tree, but I very
>> much dislike going over your head like that.
>>
>> I realize that you'd been away for a while and probably are digging yourself
>> from under the piles of mail, but it's getting late in the cycle and I want
>> to get #for-next into reasonably sane shape.  Please, look through that
>> thing and respond.
>
> Almost everything has been removed from the overlayfs tree in
> linux-next today.  The only commit there currently is:
>
> 67810693077a ovl: fix wrong use of impure dir cache in ovl_iterate()

Al, thank you very much for taking care of this.   I've already begone
to go through those and will finish up the merge, hopefully today.

Thanks,
Miklos
