Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F98C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1566D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeIEApE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:45:04 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38319 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:45:03 -0400
Received: by mail-yw1-f66.google.com with SMTP id n21-v6so1773678ywh.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 13:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtiujjw9kM3fzqrI3E64FFtzh2VqdmcHQC5kKXmTHcY=;
        b=rujzBwx7PoA7kEbJoqkRVg/s7Q9L4icG+RD6dQAkQzJWi2k4nuOi05iFKyHOZhE+V4
         W2fdnm9Nd0QajtlAGlo3SocNFfuXgSpCP3X9Q3PrB1as8H0VPm0xc+NmlS9eWcxLfguq
         yhng0gbNG/gPr/FNStdMcKlnR2Rz/rU47C/l7pwHXA9QNOCyrFE7FqWeN5G48REL1acN
         wFstVQTs7mrfuUVGHtK69daLUQr2bBjaKgfpemAiS4Z6GVwpBhMCy+cs/H9uK8K0IeH1
         ucvid/fUtV2iHSm673qzSxqwtnDPm2Zz2ATEvoFWerlz8PWJx2nnGFlaouW61emMeXMZ
         6UXg==
X-Gm-Message-State: APzg51DaIdfSnzi7X3uJzRqeDz5T9sQMWsiBnh4AoELRCR1LdGLQFpg4
        jqcoNMz51mStLtXWBGVETGUlbg==
X-Google-Smtp-Source: ANB0VdbSIy1FTnLcJLtjmpwhGzn/1xB3J5F4gGDB9rCtrCtRD8CPj+P3oVbkq4PLEyhCf5BUjtcv9Q==
X-Received: by 2002:a81:8602:: with SMTP id w2-v6mr19206641ywf.61.1536092300396;
        Tue, 04 Sep 2018 13:18:20 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-161.dyn6.twc.com. [2606:a000:1100:db::161])
        by smtp.gmail.com with ESMTPSA id y144-v6sm11499236ywy.79.2018.09.04.13.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 13:18:19 -0700 (PDT)
Message-ID: <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc:     =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Sep 2018 16:18:18 -0400
In-Reply-To: <20180904185411.GA22166@fieldses.org>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
         <20180904075347.GH11854@BitWizard.nl>
         <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
         <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
         <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
         <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
         <20180904161203.GD17478@fieldses.org> <20180904162348.GN17123@BitWizard.nl>
         <20180904185411.GA22166@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-04 at 14:54 -0400, J. Bruce Fields wrote:
> On Tue, Sep 04, 2018 at 06:23:48PM +0200, Rogier Wolff wrote:
> > On Tue, Sep 04, 2018 at 12:12:03PM -0400, J. Bruce Fields wrote:
> > > Well, I think the point was that in the above examples you'd prefer that
> > > the read just fail--no need to keep the data.  A bit marking the file
> > > (or even the entire filesystem) unreadable would satisfy posix, I guess.
> > > Whether that's practical, I don't know.
> > 
> > When you would do it like that (mark the whole filesystem as "in
> > error") things go from bad to worse even faster. The Linux kernel 
> > tries to keep the system up even in the face of errors. 
> > 
> > With that suggestion, having one application run into a writeback
> > error would effectively crash the whole system because the filesystem
> > may be the root filesystem and stuff like "sshd" that you need to
> > diagnose the problem needs to be read from the disk.... 
> 
> Well, the absolutist position on posix compliance here would be that a
> crash is still preferable to returning the wrong data.  And for the
> cases 焦晓冬 gives, that sounds right?  Maybe it's the wrong balance in
> general, I don't know.  And we do already have filesystems with
> panic-on-error options, so if they aren't used maybe then maybe users
> have already voted against that level of strictness.
> 

Yeah, idk. The problem here is that this is squarely in the domain of
implementation defined behavior. I do think that the current "policy"
(if you call it that) of what to do after a wb error is weird and wrong.
What we probably ought to do is start considering how we'd like it to
behave.

How about something like this?

Mark the pages as "uncleanable" after a writeback error. We'll satisfy
reads from the cached data until someone calls fsync, at which point
we'd return the error and invalidate the uncleanable pages.

If no one calls fsync and scrapes the error, we'll hold on to it for as
long as we can (or up to some predefined limit) and then after that
we'll invalidate the uncleanable pages and start returning errors on
reads. If someone eventually calls fsync afterward, we can return to
normal operation.

As always though...what about mmap? Would we need to SIGBUS at the point
where we'd start returning errors on read()?

Would that approximate the current behavior enough and make sense?
Implementing it all sounds non-trivial though...

-- 
Jeff Layton <jlayton@redhat.com>

