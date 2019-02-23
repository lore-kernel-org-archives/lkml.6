Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF32C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342020675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfBWDKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:10:52 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46163 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBWDKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:10:52 -0500
Received: by mail-qt1-f174.google.com with SMTP id z25so4806605qti.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 19:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVo2yvPkQcOfnCvpRVWOLfbTevOVnB/+yEXQwluhnxg=;
        b=TrExlnwxIHL6D6vpsHbzpO6SsNRIOgDw8CU0/iROfLtT23NEOJf+JACwAHm06AHdff
         cVmQ9jDQewwIu35eKJ0GCCSdqFweDrDCW4tlzg1rPgJLdWNuBW70g7iB/+Exd+Otxj9d
         h+rRLPTcQFviiFvQMv0Wu6JEt5kEs8pMHcBWBJG8dn4Z5llDYyroboEuXBistb4w2Znt
         1hKcP1D/TGiFcG0x721nYngbSjc4il1CxCWS5vXckax9mHH962UQf2k6wKjAQcy1Ep55
         L1kfkrIDeBgfcamVRQ3qtcCpRriWOscVGlrbkPKPJcJTgBc2m/OgukUqF/dABJVFDggn
         LUog==
X-Gm-Message-State: AHQUAuZnhomdcemtvfcL0Lfml0/iDDjD40Fe0ShAvZXv2/w2giif/Tk7
        Uck9Xb8Jw+Kwjp34e+CGcFn4Jj8k+4JDOBDH+bf26g==
X-Google-Smtp-Source: AHgI3Ia151HevhdKkieKfFIh0xt3StuTG7l/w5zA9LNpkBZ4YAfvv6MudmiETtuMEoiILVcbUgqQkxYXUtvEB1KfIbI=
X-Received: by 2002:a0c:93ab:: with SMTP id f40mr5721776qvf.59.1550891451403;
 Fri, 22 Feb 2019 19:10:51 -0800 (PST)
MIME-Version: 1.0
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name> <20190222211006.GA10987@redhat.com>
 <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk> <20190222235459.GA11726@redhat.com>
 <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com> <20190223024402.GA12407@redhat.com>
In-Reply-To: <20190223024402.GA12407@redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Fri, 22 Feb 2019 22:10:39 -0500
Message-ID: <CAMeeMh9qLkTByWJewPR4o844wPkA-g5Hnm7aGjszuPopPAe8vA@mail.gmail.com>
Subject: Re: block: be more careful about status in __bio_chain_endio
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm also worried about the other two versions, though:

memory-barriers.txt#1724:

1724 (*) The compiler is within its rights to invent stores to a variable,

i.e. the compiler is free to decide __bio_chain_endio looks like this:

static struct bio *__bio_chain_endio(struct bio *bio)
{
  struct bio *parent = bio->bi_private;
  blk_status_t tmp = parent->bi_status;
  parent->bi_status = bio->bi_status;
  if (!bio->bi_status)
    parent->bi_status = tmp;
  bio_put(bio);
  return parent;
}

In which case, the read and later store on the two different threads
may overlap in such a way that bio_endio sometimes sees success, even
if one child had an error.

As a result, I believe the setting of parent->bi_status needs to be a
WRITE_ONCE() and the later reading needs to be a READ_ONCE()
[although, since the later reading happens in many different
functions, perhaps some other barrier to make sure all readers get the
correct value is in order.]
