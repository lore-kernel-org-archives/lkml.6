Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2972CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987BC208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NXRMswSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987BC208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbeFMJVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:21:33 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38356 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754479AbeFMJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:21:31 -0400
Received: by mail-ot0-f196.google.com with SMTP id p95-v6so2172009ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9CN2g1jd/+sD/yB1G7/vdyAMX/msJKlWeMJq3zF/z44=;
        b=NXRMswSBTNBSYfbI1yWwOFrxbDsygs60xxOXKQgZ7ZNuMwmZCumOnykLOQHLYcT2PH
         QPqKAMaaUrSp0VHjQSdvpZ1GgU42XsBRrbKNuNVXIn2s/TE4ET9EpNU8PKO9pWZEJnSq
         zyWrxCV5KkyPmchpKGxov6JGRcIi+teybM3gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9CN2g1jd/+sD/yB1G7/vdyAMX/msJKlWeMJq3zF/z44=;
        b=ZRwp4Rjtls1TyIc6HTcA7PDl7mwl5hS8Zk1ubpyQ8ZuYaE0Pw2qF0ETHquZCDlx1m9
         Tc4AHTINUVIkgJFW8oTxsriFKh+Lc7FwLrvCklbjTvrSB9WEJYu3i2WCI65k9l8MkCMF
         kY4tzeCld8ddPgQXn4bEfReO8yCSVn1p+/3zkfju4Pwn5gyzkjm///QwIM5X//PpxEjb
         a5z+K6sQ9Aqmpzwm8OKRltt6bjdCAq6hTVo9YEF7Q0rF7p3l+qvh4td+EHzver83b9HB
         wodD3lElExsXHUSeHAd5Ohw0DA/JcRRPqIml6hgXPYQUjqd5jIh7qxMEtgOSs9RIcACK
         +a+w==
X-Gm-Message-State: APt69E2t5QO8yDwzUgSXlr80iFyWiXFh8UjdJ3nr+hnZ0o/qUUZ3HBZL
        qI9POk2eBARXqIN/abL7O228afgxyoJ8OJAq2i5WoA==
X-Google-Smtp-Source: ADUXVKJoBCcsnnck8VjS36joU0FxB/ZWcS9lGtvlevklgez4lN+sVTBbKhJfHTUuBJrxp+Bfh/YX8fjXsF7wPYaZ0mU=
X-Received: by 2002:a9d:1531:: with SMTP id u46-v6mr2801813otf.197.1528881690831;
 Wed, 13 Jun 2018 02:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 02:21:30
 -0700 (PDT)
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180612183123.GB30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-15-mszeredi@redhat.com>
 <20180610041243.GJ30522@ZenIV.linux.org.uk> <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com>
 <20180612022926.GY30522@ZenIV.linux.org.uk> <20180612024029.GZ30522@ZenIV.linux.org.uk>
 <CAJfpegvUkcUw0GXxFesT6V2f27EXW7jkvBpvnG4XB49BPdvjjA@mail.gmail.com>
 <20180612182423.GA30522@ZenIV.linux.org.uk> <20180612183123.GB30522@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Jun 2018 11:21:30 +0200
Message-ID: <CAJfpegsnvxUNCaE4c1_UDKq169i8WBTMuWzyvyo8UvenqZCUXg@mail.gmail.com>
Subject: Re: [PATCH 14/39] ovl: stack file ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 8:31 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Jun 12, 2018 at 07:24:23PM +0100, Al Viro wrote:

>> I hate it, but... consider path_open() objections withdrawn for now.

Is that an ACK for the pull if I follow up with fixes for mmap botch, etc?

>> Uses of ->vm_file (and rules for those) are too convoluted to untangle
>> at the moment.  I still would love to get that straightened out, but
>> it's not this cycle fodder, more's the pity...

Looked at some other options...  What coda mmap does looks very
dubious.  It only sets f_mapping, not vm_file.  That's going to get
into all sorts of trouble when underlying fs tries to look at
file_inode() or worse, ->private_data.  Looks like that should be
converted to what overlayfs does, to have a remote chance of actually
not crashing on most filesystems.  Does anybody actually use coda
still?

> PS: conversion of ->f_path.dentry is easy and that can probably go this
> cycle - it's a fairly trivial change, with no functional changes unless
> overlayfs is used with <filesystem>, fixing really bad shit if it ever
> gets used thus.  I'm not asking to put that into overlayfs pull *and*
> it's independent from the "want to kill that fucking kludge" stuff.
> The latter is too hard for this cycle, unfortunately.

So this is about adding a file_dentry_check() (or whatever we want to
call it) helper to be used by all filesystems when dereferecing
f_path.dentry, right?

Thanks,
Miklos
