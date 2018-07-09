Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1F4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F0A20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bauIVkCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F0A20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeGIQa3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:30:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeGIQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GI7wjWFg9FGJGV0rSVskFibXKKuTgM2Pt/ilSBrnXi4=; b=bauIVkCnpD5eesXEdfNZXEZGp
        dK2sjlv0Tv9BYlNK5ibRv0p/5advxuU247rWOPWQl5OSdOScsqih811LgiOKoIMZlDfAoGuTddyOm
        XzU9pZRi/OdU/jQ2hZ3SDrUvyXvAJbugp6yx3lRWW6rVZJUgadMVlA8qqCYkoW6JCIzHPVx4ViDA/
        nQzXpblbQbnBEW/mi3bgYnIXmK+Ahw+m2ZGB5yapDXh3UFMxBXFpkWenn58KUcmoIfBKSIkRntIJ7
        mTpofzWYcqe5zAEw2B/Jw1hysXbxcXf6KioBtNvFpbfpjmIETZ+UaYpSXSDbaZDNuZgs/KmuGIzGj
        bn5G3M+Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcZ3R-00053N-UL; Mon, 09 Jul 2018 16:30:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25A9920289CF4; Mon,  9 Jul 2018 18:30:23 +0200 (CEST)
Date:   Mon, 9 Jul 2018 18:30:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 11/12] sched: use for_each_if in topology.h
Message-ID: <20180709163023.GB2476@hirez.programming.kicks-ass.net>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch>
 <20180709103656.GH2476@hirez.programming.kicks-ass.net>
 <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
 <20180709151258.GV2476@hirez.programming.kicks-ass.net>
 <20180709155204.GD3008@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709155204.GD3008@phenom.ffwll.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:52:04PM +0200, Daniel Vetter wrote:
> for_each_something(foo)
> 	if (foo->bla)
> 		call_bla(foo);
> 	else
> 		call_default(foo);

Note that the kernel coding style 'discourages' this style and would
like you to write:

	for_each_something(foo) {
		if (foo->bla)
			call_bla(foo);
		else
			call_default(foo);
	}

Which avoids the entire problem. See CodingStyle-3:

  Also, use braces when a loop contains more than a single simple statement:

  .. code-block:: c

	  while (condition) {
		  if (test)
			  do_something();
	  }
