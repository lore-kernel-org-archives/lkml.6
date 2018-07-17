Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD72ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115CA208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="prMEXW23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115CA208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeGQCAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:00:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbeGQCAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=czN7jOJWpm/rgLyOjwTMG+zoi04Fq/yNxExsVbMaPJ8=; b=prMEXW23nwb9YRKtJPa0vvKBk
        XNIi2Am2DtJudPmSfegVTxlpf7T1RtIEPYGwUB7biWuNo4L9Qk6XK6DJKzVpMhYU2zmyg502f93Zf
        45N3FwealTExf5tQnnL31lgfbD+67Z/2aBJSjVT1fzd2Cbd4eDw6grHF4XnwleTpvaiPuZo/TcmF2
        3vLp+wI/3xW/JZVs9HurWCp1jSP2/SL9LmdDHYpqjxExTBKhD1PeggjNsR1J1vvxoI7dFnJIbRTCe
        NOoTU0BJjrItVuriGyNFuAYtndbVZDcJracoev3t2hNz2AKyDGFHHHedZD4BDlUF55zeC8PIIgA53
        HSUDnsUAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffEol-0007gB-Hh; Tue, 17 Jul 2018 01:30:19 +0000
Date:   Mon, 16 Jul 2018 18:30:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180717013019.GA7934@bombadil.infradead.org>
References: <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
 <1531411494.18255.6.camel@HansenPartnership.com>
 <20180712164932.GA3475@bombadil.infradead.org>
 <1531416080.18255.8.camel@HansenPartnership.com>
 <CA+55aFzfQz7c8pcMfLDaRNReNF2HaKJGoWpgB6caQjNAyjg-hA@mail.gmail.com>
 <1531425435.18255.17.camel@HansenPartnership.com>
 <20180713003614.GW2234@dastard>
 <20180716090901.GG17280@dhcp22.suse.cz>
 <20180716124115.GA7072@bombadil.infradead.org>
 <20180716164032.94e13f765c5f33c6022eca38@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716164032.94e13f765c5f33c6022eca38@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 04:40:32PM -0700, Andrew Morton wrote:
> On Mon, 16 Jul 2018 05:41:15 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Mon, Jul 16, 2018 at 11:09:01AM +0200, Michal Hocko wrote:
> > > On Fri 13-07-18 10:36:14, Dave Chinner wrote:
> > > [...]
> > > > By limiting the number of negative dentries in this case, internal
> > > > slab fragmentation is reduced such that reclaim cost never gets out
> > > > of control. While it appears to "fix" the symptoms, it doesn't
> > > > address the underlying problem. It is a partial solution at best but
> > > > at worst it's another opaque knob that nobody knows how or when to
> > > > tune.
> > > 
> > > Would it help to put all the negative dentries into its own slab cache?
> > 
> > Maybe the dcache should be more sensitive to its own needs.  In __d_alloc,
> > it could check whether there are a high proportion of negative dentries
> > and start recycling some existing negative dentries.
> 
> Well, yes.
> 
> The proposed patchset adds all this background reclaiming.  Problem is
> a) that background reclaiming sometimes can't keep up so a synchronous
> direct-reclaim was added on top and b) reclaiming dentries in the
> background will cause non-dentry-allocating tasks to suffer because of
> activity from the dentry-allocating tasks, which is inappropriate.

... and it's an awful lot of code (almost 600 lines!) to implement
something fairly conceptually simple.

> I expect a better design is something like
> 
> __d_alloc()
> {
> 	...
> 	while (too many dentries)
> 		call the dcache shrinker
> 	...
> }
> 
> and that's it.  This way we have a hard upper limit and only the tasks
> which are creating dentries suffer the cost.

I think the "too many total dentries" is probably handled just fine
by the core MM.  What the dentry cache needs to prevent is adding a
disproportionately large number of useless negative dentries.  

So I'd rather see:

	if (too_many_negative(nr_dentry, nr_dentry_neg))
		reclaim_negative_dentries(16);
	...

16 feels like a fairly natural batch size.  I don't know what
too_many_negative() looks like.  Maybe it's:

bool too_many_negative(unsigned int total, unsigned int neg)
{
	if (neg < 100)
		return false;
	if (neg * 5 < total * 2)
		return false;
	return true;
}

but it could be almost arbitrarily complex.  I do think it needs to
scale with the total number of dentries, not scale with memory size of
the machine or the number of CPUs or anything similar.
