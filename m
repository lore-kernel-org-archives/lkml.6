Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD8EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF66F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fnDfbY9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF66F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeKBDh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:37:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39967 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeKBDh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:37:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so18936888lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgZN2fOHhdE1HktUMGbNX9SDpKkmsiImhMyZAsfux3E=;
        b=fnDfbY9qaEgLbS2VnwRwSdwcGPPYVk3xYV4RtesuJZmdQQJ0Ov6Zh2qeBEp5gasPfc
         c7uVVwptE7b5S3emA+8syVoFh2N/2TXJbtAcTlSMGx83asjLzZ9drssjZC7RxTBaV9lV
         m4gBmgl7j7ttMEs0AS2UCmCOn3U3tykrgLD5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgZN2fOHhdE1HktUMGbNX9SDpKkmsiImhMyZAsfux3E=;
        b=JZbxWvFVDz1FIYPTyZb63RBqs1plpEEtWZ0Eq4tB8x7CTf/0bWVadjpT7FjTsJg8m6
         h5Ah9cabnevFoCVzGJMzsFyta8cMW+NK5Z4jUoNGlcEoxmhppFEFBLx/Okp1aXDc7L+1
         sIGJI3WW3FWvHb9H4gj8ciuw5LYpzmm7l7AE/hkvAmuK1BYtk2HLjIrxGPEYS2IvP89t
         wvhJ5CTPyfIhJjkIGpy/qKppEVhrgn6vff39TqBJqrpXrqPU8v8Vnza9pcbLVSuAwldw
         B59P8/HLNtZwHn41d/BVxmXD6ypTb02CrmhzYmICfWU2MVnuL0lHWCVGrsnPkRE17MkE
         yuww==
X-Gm-Message-State: AGRZ1gIZi0/gs103OC6EUsb4TgZ9ZP4NXf2KW/h9G1FWvWxI7nozdQ2X
        tA3b+f6fm2ScFYCpHXpcvUORSzhiotb+Ow==
X-Google-Smtp-Source: AJdET5dQWLenTQAjYOZ4rPLWuFQ8t+rHFSUz5f9phQFWf7Oie3flsEPbmusO9qvuXdEh9z0gIvFhCg==
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr5519988lja.108.1541097229407;
        Thu, 01 Nov 2018 11:33:49 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a18-v6sm1600838ljk.86.2018.11.01.11.33.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 11:33:48 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f3-v6so18938255ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:33:48 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr6099315ljj.6.1541097227764;
 Thu, 01 Nov 2018 11:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181031053355.GQ32577@ZenIV.linux.org.uk> <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
 <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com> <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com>
 <28156.1541092687@warthog.procyon.org.uk>
In-Reply-To: <28156.1541092687@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 11:33:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whysoVxJU8+TBw=D3xN00HOOqg-9Chc=i0Pt+Ozm3Z0Tg@mail.gmail.com>
Message-ID: <CAHk-=whysoVxJU8+TBw=D3xN00HOOqg-9Chc=i0Pt+Ozm3Z0Tg@mail.gmail.com>
Subject: Re: [git pull] mount API series
To:     dhowells@redhat.com
Cc:     swhiteho@redhat.com, john.johansen@canonical.com,
        alan.christopher.jenkins@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>, ebiederm@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:18 AM David Howells <dhowells@redhat.com> wrote:
>
> No.  What we have upstream now is most definitely *not* atomic.  That said,
> some of the steps of the sequence are atomic in their own right:

It's more that what we have traditionally is atomic wrt user space.
Use space does *one* indivisible operation. There's no way for
user-space to do a half-way mount and say "ok, that's it, I'll just
exit now" (or skip a phase and fool the kernel into handling a
half-way setup issue).

So the new model does require a bit more care in tear-down etc. I'm
not so worried about this, actually, but it *is* different.

Afaik, some of the bugs were exactly in this half-way state bits.

[ And yes, looking back at some the reports I found, it was Alan
Jenkins and mainly the open-tree thing. ]

> Would you be willing to take just the *internal* fs_context changes and leave
> the UAPI for the next window?

Hmm. I had to think about that, but the more I thought about it, the
more I liked it.

Yes. Depending on how that is done, that would make a lot of my
worries go away. *Particularly* if it then allows us to do the
per-filesystem conversion one by one.

So if the patch series can be split up into a prep-phase that doesn't
change any user-visible semantics (including the security side), but
that uses the fs_context internally and allows the filesystems to be
converted to the new world order, than that would make merging the
early work much easier (and then my worry about the later phases would
probably be much less too).

It would be _really_ nice to see that prep-phase be done in a way
where each individual patch very obviously doesn't change semantics.
If it's obvious, then I'm happy to consider that pure prep-work and
willing to merge it after the merge window in order to make the _next_
merge window easier.

Al - can I ask you to look at helping David with something like that?
You tend to be very good at generating those patch-series with
"obviously no changes" for the individual patches, but the end result
ends up being totally different from the starting point (I'm thinking
of all the locking and dentry refcounting series).

              Linus
