Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4987C21476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ScrVJRy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4987C21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeGLGt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:49:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45001 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbeGLGtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:49:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id d17-v6so8925397eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K39FGz4yuoXYsblBiFTiFm05dq4DaKKnHuLdgzsGv5o=;
        b=ScrVJRy5oBQZjQDcWFuOoaZJ9jfvOBa2W0Esn7d8bSRZ/Znp5keKPoehtW2rRK089p
         05jJ0qXXPt0izeuAe1D27wnG9/1CP2pb2ZMzGh+EYplc45uGII7HvWr4hg3MH3ThC02C
         4sgz3aCIOhdlwpTY2o4z3aMu5uiXVUBUiAIvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=K39FGz4yuoXYsblBiFTiFm05dq4DaKKnHuLdgzsGv5o=;
        b=traXOWN561UsJnhYCUHjtWJb/ocKmPRkWlPfkx4heD7URQCIw0HYFkGtIvHdS1EtDu
         14l1CqYwQqNls9ULeaV9uhvqeyjz+FabgKd+Om2iiX3mSP/WLZixlzl9axNqdFabZbvq
         zzdRo+qJUx5CrOI/Ph23jej9dXMf54FWodlbBoOaFDKqnWLyftL4JkPuDuOKRERu+K5E
         ZtHrTQV7MAA7i5jX/1ah8e2wMwslauTt+Er/opT6bzImCX2ga1yyFIH/FDZEofrtz3MN
         yyyaHZtkfwS3Z7Gx2yCs1EWUly33G8H7yBdj1Cs31zqGxu7OQgLaI1swNKGPySq/y8S7
         MZLg==
X-Gm-Message-State: AOUpUlGidNn1yLmG1WlsVPaSUIwemjmyaoUdjXZ2l7dV33FYRTxUO0Ff
        fmih2KeCk1axt8BdL6djXURMiw==
X-Google-Smtp-Source: AAOMgpfausxGPbHy0Ch+IzDO7VTDUz98MF97kVMWuKmKXgq8ojXx5S0INpn77Z1EB05P4ZBGrI0Idw==
X-Received: by 2002:a50:bb41:: with SMTP id y59-v6mr1223905ede.10.1531377705605;
        Wed, 11 Jul 2018 23:41:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id s19-v6sm5770506edd.53.2018.07.11.23.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 23:41:44 -0700 (PDT)
Date:   Thu, 12 Jul 2018 08:41:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/12] blk: use for_each_if
Message-ID: <20180712064142.GB3008@phenom.ffwll.local>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>, Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com>
 <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
 <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
 <85df8c40-dac9-5f97-f81a-6de061cfdfa8@kernel.dk>
 <20180711200641.GJ72677@devbig577.frc2.facebook.com>
 <CAKMK7uGBWwbuSr7k83w0JAQ9bUKYvreYCJpBwpEqcUe3DZVrrQ@mail.gmail.com>
 <5bacce40-d29d-8eaf-f3bb-2ac2889bbeb0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bacce40-d29d-8eaf-f3bb-2ac2889bbeb0@kernel.dk>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:13:00PM -0600, Jens Axboe wrote:
> On 7/11/18 3:08 PM, Daniel Vetter wrote:
> > On Wed, Jul 11, 2018 at 10:06 PM, Tejun Heo <tj@kernel.org> wrote:
> >> On Wed, Jul 11, 2018 at 01:31:51PM -0600, Jens Axboe wrote:
> >>> I don't think there's a git easy way of sending it out outside of
> >>> just ensuring that everybody is CC'ed on everything. I don't mind
> >>> that at all. I don't subscribe to lkml, and the patches weren't
> >>> sent to linux-block. Hence all I see is this stand-alone patch,
> >>> and logic would dictate that it's stand-alone (but it isn't).
> > 
> > Hm yeah I forgot to add linux-block. But others where there's no
> > dedicated list (or get_maintainers.pl didn't have one) also complained
> > about not getting Cc'ed, and I can't Cc everyone for sweeping changes.
> 
> I don't personally see a problem with just CC'ing everyone.
> 
> >> What I sometimes do is including a short blurb on each patch giving
> >> the overview and action hints (e.g. this is part of patchset doing XYZ
> >> and should be routed such and such).  It's a bit redundant but has
> >> worked pretty well for patchsets with dependenat & sweeping changes.
> > 
> > Yeah I guess I can just copypaste/summarize patch 1 to all the
> > subsequent patches, sounds like the best option.
> 
> Another approach might be to submit the first independent patch
> separately. Once that's in the kernel, you can send out the rest
> as independent patches instead of doing a cross-kernel series that
> all depend on one single patch. Seems to me that's where you run
> into issues, and it can be avoided quite easily.

Well patch 1 died in a bikeshed (or is on live support at most). I kinda
hoped that showing it's somewhat widely used pattern in the kernel would
help it's cause, but alas not going to happen.

Anyway for next time around I'll crank up the Cc: knob to the max :-)

Thanks anyway for comments and stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
