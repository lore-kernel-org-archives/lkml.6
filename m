Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C71C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E60F20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1VinB0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E60F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404692AbeKVRJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:09:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbeKVRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:09:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so1243518pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 22:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NSYT83YZoZy4QAmHqqOPq78XYg/52X5pJej9J1FOp8=;
        b=Y1VinB0XFVA+hjmImym8p0a16vye/7XAPD6Zk0Z/W+k0WhuMT7a8ZC7LQckINudiWW
         CFSe62DJxPopHJKNBGDK69iHI7P9S1aSgppQYqc/mWHiy9Uf7PMfDV5yPfrBLmryOIQ+
         dL8Kxr5/S+pNuv+v+CbsnoV4M7ELVLbAOz23KkUVl3/7/hSgrCFbDo6Ui4DwotaTDbW1
         bn4y43EDiCZ7C3GXK9+1odoYTmfaYaiKsWZegVYfmqMhpZ/aHGoy0cxKgEKeowuve/PA
         uhijN+IfpcewXUHESlfhzlJneZP2S1Ww52BtdE6JvHH31Qh8Q9+2m1oVbv4xX37ZozgG
         TGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NSYT83YZoZy4QAmHqqOPq78XYg/52X5pJej9J1FOp8=;
        b=brExeVtoUvNVn9nc5npMVn5EJ5VjkC7OufPrgaK+QTTAFe1xRKu7iKC0sxqEX03t5w
         H1nt4bK+7AzsrjfpirfmoTkjaeEtstnxNvKY6npr7iHwzVdCRN1TWjW0+6B16N6Kc5BR
         5GWCJJxErK01tBswZCdzH+MVeAO93c6jrGhrWazeDgbSxy8TINO/RlPFBYoDv9z3XYSF
         f92jBLDcP1vX2W/q4L7QMbvUoCZ/LiUXNXT1yx+cln/pwTxwUrZBuOdnCq7p521jaAha
         MLfD2sEEKU6Mds29q1CGUmlskqv+ndE6oQvytqvcki89agN4xJQK92ylT2JPGcVm3d0I
         do6Q==
X-Gm-Message-State: AA+aEWZUup2zkGUu2ufh6aCO0pDL/zRCiYhmrSEQ3PfQdewXCkMMrF8K
        iBGiXk3o0e6P8eE2Jv1JaeVcPQjnZxM=
X-Google-Smtp-Source: AFSGD/VgZbEoV7eGAwA1KM3dj/ixg71h6QJKK4EtKAUe7cHwDL/7vjXxjiJSGeF1V1u5tNVcu5NcDA==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr8905151pgb.76.1542868268641;
        Wed, 21 Nov 2018 22:31:08 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l62-v6sm62641581pfl.28.2018.11.21.22.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 22:31:07 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:31:03 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181122063103.GB211816@google.com>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
 <20181121133408.GA103278@google.com>
 <20181122021442.GB3441@jagdpanzerIV>
 <20181122050437.GA182024@google.com>
 <20181122054040.GE3441@jagdpanzerIV>
 <20181122061542.GA211816@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122061542.GA211816@google.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:15:42PM +0900, Minchan Kim wrote:
> On Thu, Nov 22, 2018 at 02:40:40PM +0900, Sergey Senozhatsky wrote:
> > On (11/22/18 14:04), Minchan Kim wrote:
> > > 
> > > > additionally, it's too simple. It writes-back pages which can be
> > > > swapped in immediately; which basically means that we do pointless
> > > > PAGE_SIZE writes to a device which doesn't really like pointless
> > > > writes.
> > > 
> > > This patchset aims for *IDLE page* writeback and you can define
> > > what is IDLE page by yourself. It doesn't do pointless writeback.
> > > > 
> > > > It's a whole different story with idle, compressible pages writeback.
> > > 
> > > I don't understand your point.
> > 
> > Seems you misunderstood me. I'm not saying that IDLE writeback is bad.
> > On the contrary, I think IDLE writeback is x100 better than writeback
> > which we currently have.
> > 
> > The "pointless writeback" comment was about the existing writeback,
> > when we WB pages which we couldn't compress. We can have a relative
> > huge percentage of incompressible pages, and not all of them will end
> > up being IDLE:
> >  - we swap out page
> >  - can't compress it
> >  - writeback PAGE_SIZE
> >  - swap it in two seconds later
> 
> I got what you mean now. Let's call it as "incompressible page wrieback"
> to prevent confusing.
> 
> "incompressible page writeback" would be orthgonal feature. The goal is
> "let's save memory at the cost of *latency*". If the page is swapped-in
> soon, it's unfortunate. However, the design expects once it's swapped out,
> it means it's non-workingset so soonish swappined-in would be rather not
> many, theoritically compared to other workingset.
> If's it's too frequent, it means system were heavily overcommitted.

Havid said, I agree it's not a good idea to enable incompressible page
writeback with idle page writeback. If you don't oppose, I want to add
new knob to "enable incompressible page writeback" so by default,
although we enable CONFIG_ZRAM_WRITEBACK, incompressible page writeback
is off until we enable the knob.
It would make some regressison if someone have used the feature but
I guess we are not too late.

What do you think?

