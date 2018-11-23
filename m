Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F32C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DF9206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktDZD9Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502068AbeKWRG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:06:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33805 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:06:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so10194733plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 22:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cg/H6WaU4s+HYC/VIJ/iqRYH+mU+CTQ/aTwcR+Clv6s=;
        b=ktDZD9Xca0q8HgFsuw60g/eQWHjLvhuPLfE69W7v6nQwx38R6+tBVLtBAUG78Q3gFA
         /wHanWHCzBfG6Yg8052iXTDaaXXBF4ggP9gpluUQPJQDO8GeZoJTBXyA79ZQYBE5GCjw
         hxXLf2cnb3fHXTLkf/341F3tIIvwNiLTvmc2uuB2MrujZz3MSS647UjdNdKjdXEmeW8P
         cnFaYdeXfGu6lxi9idETElwfdG4r6zS+lhWTC4FeNlmWi40WjQr6IlsRzlVnkpfviyLY
         U5ljLDePI6rGP1AUCy7xz1RAReiF2wiYb693xXR7UbSA9FOdavjks12HmuJmlC6v7FGT
         tksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cg/H6WaU4s+HYC/VIJ/iqRYH+mU+CTQ/aTwcR+Clv6s=;
        b=e24hBdOtyHgsnTaDdjI6uAkI6kTjLNjRnhZEYhiKhMclfWzZO7ifFBKR2B75sEQGxl
         3XShRnOVVj91UEufGBDLPMlzyVz2Vls9YXC1Uxm89a8T2sR0dOYaDovC1snZBeAPvp19
         lVxPh9V4SMc4DCAnThEdXR7MzlONasMpkrUf8oR6XJ7LE1gsLu7y+GmozOPst3JKWryW
         jilmQ9CFoZhVp/x6oB2m/7JGl+Lwu+OHM1Fq3DGYI7ewnTvq3w2uXyO4hl9Le02OfPOo
         DctLIwdfl3HJaET5Jd4FexTq13IN22dKenBAhwhSGe5OhHNo8/bp1+xzOcG9jvQfloWE
         4OXg==
X-Gm-Message-State: AA+aEWb+p29igLgYcEi96s6yEMm3jxxFSod++KBkFPEZmcoxCpMOwPXN
        gZmIa7hpLdU9bgOvndTnNto=
X-Google-Smtp-Source: AFSGD/UCQ82IQOHS8dVgG+tVhnJyn8hWsCxSNL9XhReFbJAWbEos/TA5w6GbH7rBo7aM2Nc98fWwjA==
X-Received: by 2002:a17:902:6113:: with SMTP id t19mr13917605plj.248.1542954217372;
        Thu, 22 Nov 2018 22:23:37 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id c12-v6sm64579172pfb.174.2018.11.22.22.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 22:23:35 -0800 (PST)
Date:   Fri, 23 Nov 2018 15:23:31 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181123062331.GA87907@google.com>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
 <20181121133408.GA103278@google.com>
 <20181122021442.GB3441@jagdpanzerIV>
 <20181122050437.GA182024@google.com>
 <20181122054040.GE3441@jagdpanzerIV>
 <20181122061542.GA211816@google.com>
 <20181122063103.GB211816@google.com>
 <20181122065926.GG3441@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122065926.GG3441@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:59:26PM +0900, Sergey Senozhatsky wrote:
> On (11/22/18 15:31), Minchan Kim wrote:
> > > 
> > > I got what you mean now. Let's call it as "incompressible page wrieback"
> > > to prevent confusing.
> > > 
> > > "incompressible page writeback" would be orthgonal feature. The goal is
> > > "let's save memory at the cost of *latency*". If the page is swapped-in
> > > soon, it's unfortunate. However, the design expects once it's swapped out,
> > > it means it's non-workingset so soonish swappined-in would be rather not
> > > many, theoritically compared to other workingset.
> > > If's it's too frequent, it means system were heavily overcommitted.
> > 
> > Havid said, I agree it's not a good idea to enable incompressible page
> > writeback with idle page writeback. If you don't oppose, I want to add
> > new knob to "enable incompressible page writeback" so by default,
> > although we enable CONFIG_ZRAM_WRITEBACK, incompressible page writeback
> > is off until we enable the knob.
> > It would make some regressison if someone have used the feature but
> > I guess we are not too late.
> > 
> > What do you think?
> 
> Yes, totally works for me!
> 
> 
> "IDLE writeback" is superior to "incompressible writeback".
> 
> "incompressible writeback" is completely unpredictable and
> uncontrollable; it depens on data patterns and compression algorithms.
> While "IDLE writeback" is predictable.
> 
> I even suspect, that, *ideally*, we can remove "incompressible
> writeback". "IDLE pages" is a super set which also includes
> "incompressible" pages. So, technically, we still can do
> "incompressible writeback" from "IDLE writeback" path; but a much
> more reasonable one, based on a page idling period.
> 
> I understand that you want to keep "direct incompressible writeback"
> around. ZRAM is especially popular on devices which do suffer from
> flash wearout, so I can see "incompressible writeback" path becoming
> a dead code, long term.

Okay, both options makes regression if someone use it. Then, let's try
to remove it. It would make more clean with new idle writeback.

Thanks!

