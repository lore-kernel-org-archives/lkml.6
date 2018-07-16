Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92978208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vGZBFbwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92978208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:10:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33572 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbeGPPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:10:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ACC8F8EE1DD;
        Mon, 16 Jul 2018 07:42:28 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pBwIdhHv1rgj; Mon, 16 Jul 2018 07:42:28 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5BDD28EE055;
        Mon, 16 Jul 2018 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1531752148;
        bh=iY7NsuSeiC+PXz/Ajbq1MCS9othzTsFVp96pDDktKic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vGZBFbwYkHjhdndgKR7ukJVdyKv8Z9OMBMqsb8o7pPR/vIEDWj8xa4E7pKK4FlBI9
         bzQyUhOFPrwEYH6ocX6pQbWO7IjsIOnt766tzxjjL40QKmBskAZW+KlxdSU0sQcAZi
         nbPckJqGB2Hfxhly+Xwkcj9m50qBcMZ0CcW+KtrA=
Message-ID: <1531752146.3171.2.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Michal Hocko <mhocko@kernel.org>
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
Date:   Mon, 16 Jul 2018 07:42:26 -0700
In-Reply-To: <20180716091040.GH17280@dhcp22.suse.cz>
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
         <20180716091040.GH17280@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 11:10 +0200, Michal Hocko wrote:
> On Fri 13-07-18 08:46:52, James Bottomley wrote:
> > On Fri, 2018-07-13 at 10:36 +1000, Dave Chinner wrote:
> > > On Thu, Jul 12, 2018 at 12:57:15PM -0700, James Bottomley wrote:
> > > > What surprises me most about this behaviour is the steadiness
> > > > of the page cache ... I would have thought we'd have shrunk it
> > > > somewhat given the intense call on the dcache.
> > > 
> > > Oh, good, the page cache vs superblock shrinker balancing still
> > > protects the working set of each cache the way it's supposed to
> > > under heavy single cache pressure. :)
> > 
> > Well, yes, but my expectation is most of the page cache is clean,
> > so easily reclaimable.  I suppose part of my surprise is that I
> > expected us to reclaim the clean caches first before we started
> > pushing out the dirty stuff and reclaiming it.  I'm not saying it's
> > a bad thing, just saying I didn't expect us to make such good
> > decisions under the parameters of this test.
> 
> This is indeed unepxected. Especially when the current LRU reclaim
> balancing logic is highly pagecache biased. Are you sure you were not
> running in a memcg with a small amount of the pagecache?

Yes, absolutely: I just compiled and ran the programme on my laptop
with no type of containment (I trust Linus, right ...)

To be clear, the dirty anon push out was quite slow, so I don't think
mm was using it as a serious source of reclaim, it was probably just
being caught up in some other page clearing process.

James

