Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB4C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74498222FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546719147;
	bh=dM5MdUykqxmNlTt7rLCNqp9ExUUXi3EX+lD9xP5/WRY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=qXoWrObtAIKSiHFzPWNapbvRiL20eBLUe+N7YM+j4wvz2alcQSRfMEocX0kewcJSk
	 z4di6pYHxUkiBKhBnfO4JX33W80YZK7S54c5jadmhbQSV4Oev4u/d9HbhkJOprp5hK
	 +IrFAIXua+I0S9vsLQtsf/HI1F9Fldqzqaq1kZhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfAEUMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:12:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:37144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbfAEUMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:12:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E196ADBE;
        Sat,  5 Jan 2019 20:12:23 +0000 (UTC)
Date:   Sat, 5 Jan 2019 21:12:22 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1901052108390.16954@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2019, Linus Torvalds wrote:

> > There are possibilities [1] how mincore() could be used as a converyor of
> > a sidechannel information about pagecache metadata.
> 
> Can we please just limit it to vma's that are either anonymous, or map
> a file that the user actually owns?
> 
> Then the capability check could be for "override the file owner check"
> instead, which makes tons of sense.

Makes sense. 

I am still not completely sure what to return in such cases though; we can 
either blatantly lie and always pretend that the pages are resident (to 
avoid calling process entering some prefaulting mode), or return -ENOMEM 
for mappings of files that don't belong to the user (in case it's not 
CAP_SYS_ADMIN one).

-- 
Jiri Kosina
SUSE Labs

