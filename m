Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D942C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5C2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F5C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeIAV0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:26:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59266 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeIAV0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:26:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fw9Sl-0003cq-1X; Sat, 01 Sep 2018 17:13:31 +0000
Date:   Sat, 1 Sep 2018 18:13:31 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Juergen Gross <jgross@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: Access to non-RAM pages
Message-ID: <20180901171330.GF19965@ZenIV.linux.org.uk>
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm>
 <b1b5ef64-d49b-e3f7-98b4-0ae3fd57b812@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b5ef64-d49b-e3f7-98b4-0ae3fd57b812@suse.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 12:47:48PM +0200, Juergen Gross wrote:
> On 31/08/18 23:18, Jiri Kosina wrote:
> > On Wed, 29 Aug 2018, Juergen Gross wrote:
> > 
> >> While being very unlikely I still believe this is possible. Any
> >> thoughts?
> > 
> > So in theory we should somehow test whether the next page is some form of 
> > mmio/gart/... mapping, but I guess that by itself would kill the 
> > performance advantage of the whole load_unaligned_zeropad() trick.
> > 
> > And yes, the sideffects of reading from mmio mapping is a real thing -- 
> > see for example the issue fixed by 2a3e83c6f9.
> > 
> > If noone has any clever idea how to work this around (I don't), I am 
> > afraid we'd have to ditch the whole DCACHE_WORD_ACCESS optimization, as 
> > it's silently dangerous.
> 
> Are there any architectures which can still use DCACHE_WORD_ACCESS?
> 
> x86 shouldn't, what about powerpc, arm and arm64?

IMO that's crap.  In absolute majority of cases there is a guaranteed gap
between the end of accessed object and the next page boundary.  Penalizing
each syscall that does pathname resolution to deal with something that
might only happen when the pathname length is just under 4Kb looks like
a bloody bad idea.
