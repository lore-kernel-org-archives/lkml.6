Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37F2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+dn8b5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B37F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbeGPNIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:08:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeGPNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zPEqDOFprwoXXn63mjwk15X67uYxvwTZxSf1rrlNs6M=; b=U+dn8b5vlK1cX8FCLp89UNn4R
        IT1AyYuys9JF/h9mNac33UahDPjqSFWLtzgaIgoP+ONNNOHEL/yqsgMqnvrBb/XsR6YAUSc4MG7b8
        NJ1I0yxOawJy4qIf7fP/QvVie/Ub3GhiscQEjE/VbeQaZMKJQS543fyYn1iay3B/DBQ2TRm9tvjhv
        NXXo0XGf7ZvD2d5XST2nJLQWqQkm9BowyWE4TN/NUdIIFNpx8CH/nULl+cYBk8m2Kod3K6guoTRf6
        7kiucijhA04b68KUVg/yYJjcaHoVMewJShkboMxqNPJ+hhjvEMqG0ziejIEw8TbfhVgRGT20NEai3
        L2RYSeisQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff2oV-0006nN-Pe; Mon, 16 Jul 2018 12:41:15 +0000
Date:   Mon, 16 Jul 2018 05:41:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180716124115.GA7072@bombadil.infradead.org>
References: <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
 <1531336913.3260.18.camel@HansenPartnership.com>
 <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
 <1531411494.18255.6.camel@HansenPartnership.com>
 <20180712164932.GA3475@bombadil.infradead.org>
 <1531416080.18255.8.camel@HansenPartnership.com>
 <CA+55aFzfQz7c8pcMfLDaRNReNF2HaKJGoWpgB6caQjNAyjg-hA@mail.gmail.com>
 <1531425435.18255.17.camel@HansenPartnership.com>
 <20180713003614.GW2234@dastard>
 <20180716090901.GG17280@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716090901.GG17280@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:09:01AM +0200, Michal Hocko wrote:
> On Fri 13-07-18 10:36:14, Dave Chinner wrote:
> [...]
> > By limiting the number of negative dentries in this case, internal
> > slab fragmentation is reduced such that reclaim cost never gets out
> > of control. While it appears to "fix" the symptoms, it doesn't
> > address the underlying problem. It is a partial solution at best but
> > at worst it's another opaque knob that nobody knows how or when to
> > tune.
> 
> Would it help to put all the negative dentries into its own slab cache?

Maybe the dcache should be more sensitive to its own needs.  In __d_alloc,
it could check whether there are a high proportion of negative dentries
and start recycling some existing negative dentries.
