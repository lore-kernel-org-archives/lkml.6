Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6108C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F70B20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F70B20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbeHAQY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:24:58 -0400
Received: from nautica.notk.org ([91.121.71.147]:40467 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389570AbeHAQY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:24:58 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 2EBF9C009; Wed,  1 Aug 2018 16:38:55 +0200 (CEST)
Date:   Wed, 1 Aug 2018 16:38:40 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH 1/2] net/9p: embed fcall in req to round
 down buffer allocs
Message-ID: <20180801143840.GA21463@nautica>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <20180801161413.0523a821@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801161413.0523a821@bahia.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kurz wrote on Wed, Aug 01, 2018:
> > @@ -263,13 +261,13 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
> >  	if (!req)
> >  		return NULL;
> >  
> > -	req->tc = p9_fcall_alloc(alloc_msize);
> > -	req->rc = p9_fcall_alloc(alloc_msize);
> > -	if (!req->tc || !req->rc)
> > +	if (p9_fcall_alloc(&req->tc, alloc_msize))
> > +		goto free;
> > +	if (p9_fcall_alloc(&req->rc, alloc_msize))
> >  		goto free;
> 
> Hmm... if the first allocation fails, we will kfree() req->rc.sdata.
> 
> Are we sure we won't have a stale pointer or uninitialized data in
> there ?

Yeah, Jun pointed that out and I have a v2 that only frees as needed
with an extra goto (I sent an incremental diff in my reply to his
comment here[1])

[1] https://lkml.kernel.org/r/20180731011256.GA30388@nautica

> And even if we don't with the current code base, this is fragile and
> could be easily broken.
> 
> I think you should drop this hunk and rather rename p9_fcall_alloc() to
> p9_fcall_alloc_sdata() instead, since this is what the function is
> actually doing with this patch applied.

Hmm. I agree the naming isn't accurate, but even if we rename it we'll
need to pass a pointer to fcall as argument as it inits its capacity.
p9_fcall_init(fc, msize) might be simpler?

(I'm not sure I follow what you mean by 'drop this hunk', to be honest,
did you want a single function call to init both maybe?)

-- 
Dominique
