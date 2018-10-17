Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4B8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE8921476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OtQLwcKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE8921476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeJRDJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:09:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44954 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJRDJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:09:56 -0400
Received: by mail-io1-f67.google.com with SMTP id s6-v6so8889863ioa.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UdE+IhzO9w1b99QSn8+Vi4bVlAuA8dqyG0qOb8ZWjKg=;
        b=OtQLwcKslQOTFOAwhYLUvumiTGGqyqAlPn/8qpw8Ze2PC0tVUXjKUF0lkwbewEDo54
         eWE45OAsLWGdSwgyhxOV2+WcwFdaEDxhpKzgUjv5nLvwyDH2n/Bc1jGlmSwI9jnv4e7f
         jmkg6Y5HL6DzNK4+LGZVvKKhYQKA0sfAOZMmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UdE+IhzO9w1b99QSn8+Vi4bVlAuA8dqyG0qOb8ZWjKg=;
        b=E6gkosEdFLQMRfyJQDOrAoPINfVHwjrspDN66yWl5513JVJSmBQuj9e183LCZ29XXA
         TKxMM5RNef2JFepW2DT/7pPXSHSeFOaBUzOri6efpH5AxADb9o1Wi2qiRGJ0zLH9PCoe
         ZtRQjMl0N0iIyrP5ZXWG0TKlzv2dRdHNSzxkSTDK5Rabs8eceDZfU6vF3yuY5kJxePz3
         hpqJSW1KAyAKTbVsqkVRCAfU/lCvAQ7URDuhYkFZPlXGE9FaR1a46CZLM7ytHRHFqUAF
         8+GPpRQQw2HKdhGCBlRjyJHMwF+zmeUV+ARaruw1LwV4BSBXiVta7vgPLaLsuOWUp711
         GyZA==
X-Gm-Message-State: ABuFfogA0eBHyB6h5KTG00QutojARsf0yDC+AVJcHi+1NzF+sCTsHPl3
        r5pY9G9d93QZ7YlcmP2BQDR7nLrrXkQa7leSzgdq1A==
X-Google-Smtp-Source: ACcGV63mO++qnvlaLvfYAJCM85WeqevSqXbNLw/4BR0GQ6xTIvN6zzShn/RGThs+gBHOPjxtgkJWuTiCOqtfbkNA8mU=
X-Received: by 2002:a5e:8b06:: with SMTP id g6-v6mr14950348iok.144.1539803078141;
 Wed, 17 Oct 2018 12:04:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 12:04:37
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Oct 2018 21:04:37 +0200
Message-ID: <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
Subject: Re: statx(2) API and documentation
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 8:45 PM, Andreas Dilger <adilger@dilger.ca> wrote:
> On Oct 17, 2018, at 12:24 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> I'm trying to implement statx for fuse and ran into the following issues:
>>
>> - Need a STATX_ATTRIBUTES bit, so that userspace can explicitly ask
>> for stx_attribute; otherwise if querying has non-zero cost, then
>> filesystem cannot do it without regressing performance.
>
> Seems reasonable.
>
>> - STATX_ALL definition is unclear, can this change, or is it fixed?
>> If it's the former, than that's a backward compatibility nightmare.
>> If it's the latter, then what's the point?
>
> The value can change over time.  It is intended to reflect the current
> state of affairs at the time the userspace program and kernel are compiled.
> The value sent from userspace lets the kernel know what fields are in
> the userspace struct, so it doesn't try to set fields that aren't there.

What's the point of a userspace program specifying STATX_ALL?  Without
a way to programmatically query the interface definition it's useless:
there's no way to guess which mask bit corresponds to which field, and
what that field represents.

And there will be programs out there which specify STATX_ALL without
considering that in the future it may become slower as it is now due
to a recompile.

So what's the point exactly?

> The value in the kernel allows masking off new fields from userspace that
> it doesn't understand.

Okay, but that has nothing to do with the UAPI.  Even as an internal
flag we should be careful, as it might grow uses which can have
similar issues as the userspace one above.

>
>> - STATX_ATIME is cleared from stx_mask on SB_RDONLY, and on NFS it is
>> also cleared on MNT_NOATIME, but not on MNT_RDONLY.  We need some sort
>> of guideline in the documentation about what constitutes
>> "unsupported": does atime become unsupported because filesystem is
>> remounted r/o?  If so, why isn't this case handled consistently in the
>> VFS and filesystems?
>
> Strange.  I'd think that if userspace is requesting atime, it should
> get an atime value.  The fact that the kernel is not updating atime
> due to mount options just means that atime might be old.  That doesn't
> mean (IMHO) that atime doesn't exist.

Right, OTOH I sort of see the value in  NFS: no roundtrip to server if
atime value is useless anyway.

>> - What about fields that are not cached when statx() is called with
>> AT_STATX_DONT_SYNC?  E.g. stx_btime is supported by the filesystem,
>> but getting it requires a roundtrip to the server.  Requesting
>> STATX_BTIME in the mask and adding  AT_STATX_DONT_SYNC to the flags
>> means the filesystem has to decide which it will honor.   My feeling
>> is that it should honor AT_STATX_DONT_SYNC and clear STATX_BTIME in
>> stx_mask.   Documentation has no word about this case.
>
> The btime value shouldn't change over the lifetime of a file, so
> DONT_SYNC shouldn't have any effect on its validity?

Not validity, but presence in the cache.  Network filesystem or fuse
may or may not have it available in the cache at the time the inode is
first initialized on loookup.  So when statx(..., AT_STATX_DONT_SYNC,
STATX_BTIME) comes along, it may need a roundtrip to the server.  What
should it do?

Thanks,
Miklos
