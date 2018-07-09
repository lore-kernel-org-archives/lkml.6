Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00766C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D81720835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jpSnKR6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D81720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933729AbeGIPwL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:52:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45521 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGIPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:52:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so1296806eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3k83YPOjMQc9TxIjIfULVIR2/Ixa1HISJxm3xzghrfM=;
        b=jpSnKR6li/TUFqvkmBmpAwJWgsWc5EEPqjfExK7xowJ3bLuV2qyjfilcw1Ttqoturi
         u8R3uWamZCixl9RvMMS1QxEQRQKbUMwTDU46G9YIxerw8zdPFS02Sc5YuICY2fdvnV7u
         epfiACIA+5oaJIKaTAV/AGIZdhFLn1YvunDcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3k83YPOjMQc9TxIjIfULVIR2/Ixa1HISJxm3xzghrfM=;
        b=JfrimtPtsz42bn0HTMcZT6ViT7vYFD+22vBsyruZDMIn++VBW1k7YBzkO2PH9EbSTN
         W+B8LwWL2DF8yeXK405qzYkgQEqdDDPUSQk0AHjheN2826ZK+rpOfyxNIufbzcWfIGa7
         aHBECxHMY9BpCINMU5V3vsM7wi+5l1LFNDjpKR8n5HFgv/GozFtghVO1bY/d8EMrJuWb
         Ve+5q6vyLQzyzReiN/zKp93Qo/ol9JAtbzn9mbXuMXYwgKPm430hmsac8/L1bcav1nLO
         rOwBJp+UGKUA4hEYccfrlHlQHF4nbWIcqbkgWlefa8rXb3QGylPedIrPDXzCpG84mWN4
         18Tw==
X-Gm-Message-State: APt69E0Gsq1oAumh8PUPXqzNAFay56slm7QVUy8UOL1bHeJUqqejmFol
        O+m0aJMLNDWaIHZ1hV4/VXjphg==
X-Google-Smtp-Source: AAOMgpcuwttFldbox4CLjzZJmke60XCvbLQUFyqnsCXlvpMeRQQb1piKdqdaMqy2qGwzvUlA99usOg==
X-Received: by 2002:a50:8818:: with SMTP id b24-v6mr23706106edb.274.1531151527541;
        Mon, 09 Jul 2018 08:52:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id u3-v6sm972949edo.44.2018.07.09.08.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:52:06 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:52:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 11/12] sched: use for_each_if in topology.h
Message-ID: <20180709155204.GD3008@phenom.ffwll.local>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch>
 <20180709103656.GH2476@hirez.programming.kicks-ass.net>
 <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
 <20180709151258.GV2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709151258.GV2476@hirez.programming.kicks-ass.net>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:12:58PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 05:00:07PM +0200, Daniel Vetter wrote:
> > On Mon, Jul 9, 2018 at 12:36 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Mon, Jul 09, 2018 at 10:36:49AM +0200, Daniel Vetter wrote:
> 
> > >>  #define for_each_node_with_cpus(node)                        \
> > >>       for_each_online_node(node)                      \
> > >> -             if (nr_cpus_node(node))
> > >> +             for_each_if (nr_cpus_node(node))
> > >
> > > Not having gotten any of the other patches, I'm not really sure what
> > > this does and such, but improve readability it does not :/
> > 
> > Patch 1 in this series, which I dumped onto lkml as a whole:
> > 
> > https://lkml.org/lkml/2018/7/9/179
> 
> Right, so while I don't object to being Cc'ed to the whole series, I do
> mind not being Cc'ed to at least the generic bits required to understand
> the patch I do have to look at.
> 
> > Imo it does improve readability for the if (!cond) {} else pattern.
> > And (assuming my grep fu isn't too badly wrong) most places in the
> > kernel do use this pattern in for_each macros, so I guess its a real
> > thing. We've definitely hit it plenty in drm iterators (but we seem to
> > like if() checks in iterator macros maybe a bit too much).
> > 
> > I'm happy to drop this patch tough if you deem it offensive.
> 
> I'd just like to understand it better; what compiler complains about
> this and is the warning otherwise useful? These things don't seem
> mentioned in that initial patch either.
> 
> IOW I suppose I'm asking for the justification of this churn. If it's
> really needed and useful so be it, but so far I'm not seeing any.
> 
> At a while guess I'd say this is something new in gcc-8 (and while I
> have that installed on some machines, it doesn't seem to be the default,
> and so I've not actually seen its output). But is the warning actually
> useful, should we not just kill the warning like we tend to do some
> really silly ones.

for_each_something(foo)
	if (foo->bla)
		call_bla(foo);
	else
		call_default(foo);

Totally contrived, but this complains. Liberally sprinkling {} also shuts
up the compiler, but it's a bit confusing given that a plain for {;;} is
totally fine. And it's confusing since at first glance the compiler
complaining about nested if and ambigous else doesn't make sense since
clearly there's only 1 if there.

Wrt this being useful or not: We've had it for a while in drm, and Andy
and Yishen where rolling yet another open coded version of this on a patch
that flew past me on dri-devel. So I pointed them at the for_each_if() we
have and typed this series to move it to kernel.h.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
