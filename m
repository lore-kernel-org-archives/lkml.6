Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E97C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47B921915
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546716246;
	bh=I4KK7Qagc/1zyHir0MqzIgmRr+UlAJCocCic9HsWfaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=vq0IteohSzLTFEWfLR4pFnBkpctmVtIUochSkhOaAgCFHTSJmMTzIVBqjbNdQn7Rr
	 qK+1FmgQ++vvyB43pndOcaW2FnRf2hqroVH8M2VpNGSmGPiABvpokF83y7d/Vv0/DC
	 +97T9AxUv58Qwm5MOTPRSHaLCLL8ISg34MPZRFxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAETYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:24:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:33462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfAETYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:24:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A0CAACE8;
        Sat,  5 Jan 2019 19:24:04 +0000 (UTC)
Date:   Sat, 5 Jan 2019 20:24:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <d4846cb2-2a4b-b8b3-daac-e5f51751bbf1@suse.cz>
Message-ID: <nycvar.YFH.7.76.1901052016250.16954@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <d4846cb2-2a4b-b8b3-daac-e5f51751bbf1@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2019, Vlastimil Babka wrote:

> > There are possibilities [1] how mincore() could be used as a converyor of 
> > a sidechannel information about pagecache metadata.
> > 
> > Provide vm.mincore_privileged sysctl, which makes it possible to mincore() 
> > start returning -EPERM in case it's invoked by a process lacking 
> > CAP_SYS_ADMIN.
> 
> Haven't checked the details yet, but wouldn't it be safe if anonymous private
> mincore() kept working, and restrictions were applied only to page cache?

I was considering that, but then I decided not to do so, as that'd make 
the interface even more confusing and semantics non-obvious in the 
'privileged' case.

> > The default behavior stays "mincore() can be used by anybody" in order to 
> > be conservative with respect to userspace behavior.
> 
> What if we lied instead of returned -EPERM, to not break userspace so 
> obviously? I guess false positive would be the safer lie?

So your proposal basically would be

if (privileged && !CAP_SYS_ADMIN)
	if (pagecache)
		return false;
	else
		return do_mincore()

right ?

I think userspace would hate us for that semantics, but on the other hand 
I can sort of understand the 'mincore() is racy anyway, so what' argument, 
if that's what you are suggesting.

But then, I have no idea what userspace is using mincore() for. 
https://codesearch.debian.net/search?q=mincore might provide some insight 
I guess (thanks Matthew).

-- 
Jiri Kosina
SUSE Labs

