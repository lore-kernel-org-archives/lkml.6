Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC89CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B6A208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B6A208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeGPJhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:37:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbeGPJhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:37:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A4C5AE3F;
        Mon, 16 Jul 2018 09:10:41 +0000 (UTC)
Date:   Mon, 16 Jul 2018 11:10:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180716091040.GH17280@dhcp22.suse.cz>
References: <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
 <1531336913.3260.18.camel@HansenPartnership.com>
 <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
 <1531411494.18255.6.camel@HansenPartnership.com>
 <20180712164932.GA3475@bombadil.infradead.org>
 <1531416080.18255.8.camel@HansenPartnership.com>
 <CA+55aFzfQz7c8pcMfLDaRNReNF2HaKJGoWpgB6caQjNAyjg-hA@mail.gmail.com>
 <1531425435.18255.17.camel@HansenPartnership.com>
 <20180713003614.GW2234@dastard>
 <1531496812.3361.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531496812.3361.9.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-07-18 08:46:52, James Bottomley wrote:
> On Fri, 2018-07-13 at 10:36 +1000, Dave Chinner wrote:
> > On Thu, Jul 12, 2018 at 12:57:15PM -0700, James Bottomley wrote:
> > > What surprises me most about this behaviour is the steadiness of
> > > the page cache ... I would have thought we'd have shrunk it
> > > somewhat given the intense call on the dcache.
> > 
> > Oh, good, the page cache vs superblock shrinker balancing still
> > protects the working set of each cache the way it's supposed to
> > under heavy single cache pressure. :)
> 
> Well, yes, but my expectation is most of the page cache is clean, so
> easily reclaimable.  I suppose part of my surprise is that I expected
> us to reclaim the clean caches first before we started pushing out the
> dirty stuff and reclaiming it.  I'm not saying it's a bad thing, just
> saying I didn't expect us to make such good decisions under the
> parameters of this test.

This is indeed unepxected. Especially when the current LRU reclaim balancing
logic is highly pagecache biased. Are you sure you were not running in a
memcg with a small amount of the pagecache?
-- 
Michal Hocko
SUSE Labs
