Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C91C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E2124738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZtzdazhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E2124738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeGDGyV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:54:21 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41452 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbeGDGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:54:20 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so8726303oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3JZAna4K1S7RDnyRMH+zS6EGut936NeGI9mcgaVb4TM=;
        b=ZtzdazhAwIOwRw66FDUuCvq48j6OSYnbOdXtnRUJNcMRUa9Vv3tXUryDeKwHMxcaBm
         4IAGrn1JrRTwBFV+kf1q/l+GKhCjNz3wDI4z7Iru/R9S0we2JcgPHX5P+UmuSlUdai/J
         vlzHqahBgUV+8piFVs3cIcoWqa2v9yYBxxB/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3JZAna4K1S7RDnyRMH+zS6EGut936NeGI9mcgaVb4TM=;
        b=qu99aV50veiX6YziqTZHphud4mmC9+m8+MShgEPm4N/6HselomkSS6LufIVPL9DaeA
         cP9iGIskJzDE1iOCslAXy+ZUa3SmYP8RyP2A0dyv2gDWZp4Erwzh7g4z1gmEno4QyzC2
         6E6u3pj7RYP7tvLQp/xh7QWCj2fBBNoyRiiCiM4KXpVEyaBCOFQZZ9XY0925FZyllx2d
         NK5CWx1d/8o97NOTLZtq/SAq7nSemnpZTmHDrMgO3a8xOJisL885h0jYjiG2HwfKkHUu
         OfoAr2mCXFPqa//XkelnpOiUYV4Ow/jjl5fEKUpHXVGFSxvF7qMJPS4AGtrpoRf/LawN
         3mSA==
X-Gm-Message-State: APt69E2Xwvxc6xWVid4xAF8FsWo82VXn7FtTdxFinWGZECG8uW0f1I3s
        LbIdKBCiS5DFiElgy4Od4CvR0Y5BvtWLR6EMj6ZJkcllhaw=
X-Google-Smtp-Source: AAOMgpe8f6YDjYPEw7OW7s1NuqMl6yzxT30wkJoP3S7zbZaIYtI/LBxjFQBUvGo9YTc5Beo6v/oSnVT9bMagr5Hehbo=
X-Received: by 2002:aca:4ac6:: with SMTP id x189-v6mr874206oia.211.1530687259416;
 Tue, 03 Jul 2018 23:54:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:640a:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 23:54:18 -0700 (PDT)
In-Reply-To: <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca>
 <20180621162101.GB11859@linux.intel.com> <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
 <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com>
From:   Louis Collard <louiscollard@chromium.org>
Date:   Wed, 4 Jul 2018 14:54:18 +0800
Message-ID: <CAKNRAJV8Jb=n=cZTmkAUVLwYv5778ykACd7ZUhYA7rfa0Wu3zw@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To:     "David R. Bild" <david.bild@xaptum.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 9:03 PM, David R. Bild <david.bild@xaptum.com> wrote:
> On Wed, Jun 27, 2018 at 1:11 AM, Louis Collard
> <louiscollard@chromium.org> wrote:
>>
>> On some systems we have seen large delays in boot time, due to
>> blocking on a call to getrandom() before the entropy pool has been
>> initialized. On these systems the usual sources of entropy are not
>> sufficient to initialize the pool in any kind of reasonable time -
>> delays of minutes have been observed; the most common workaround is to
>> mash the keyboard for a bit ;)
>>
>> Setting a non-zero quality score causes the hwrng to be used as a
>> source of entropy for the pool, the pool is therefore initialized
>> early during boot, and no delay is observed.
>>
>
> We have the same issue on our embedded devices and thus carry patches
> in our tree that set the quality.  This would be a welcome change.

Glad to hear this!

>
> As a point of clarification (and correct me if I'm wrong), the TPM is
> always ready used to seed the rng. It just doesn't update the entropy
> pool estimate.

Good point.

>
> So, perhaps the default value for the TPM hwrng quality should be
> non-zero (in addition to the module param that lets users override
> it)?

That makes sense to me, however I can imagine that some users would
prefer to not have the TPM enabled as an ongoing source of entropy by
default.

Following on from your previous point - perhaps we can just make a
small change to how the initial seeding is done: maybe we can replace
the call to crng_slow_load (via add_early_randomness and
add_device_randomness) with a call (indirectly) to crng_fast_load. (We
might also need to increase the amount of data read at this point.)

This would update crng_init_cnt and crng_init, and calls to getrandom
[without GRND_RANDOM] would not block.

This obviously doesn't solve the issue if there are blocking calls on
boot that are querying random rather than urandom; I don't believe
that would be a problem for our use case though.

Thoughts?

Thanks,
Louis
