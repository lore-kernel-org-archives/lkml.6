Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35690C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B2C22488
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NjZJxa8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B2C22488
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932127AbeGBWVM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:21:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbeGBWVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YJS7wkjVmdY9gLqR3ssohD7nm4By8vZkst7AhWSG5RU=; b=NjZJxa8Fd3MJRGNYeIA5SCd1k
        JJldhf6bgpL7hc73pUJcFACGT3uXJqQALAdV8mZ9JxpgzKsNkQFOxZyuLFLoauqeam9kJiRxocoyL
        I9Vd9tM74YepWYND8k+OTgXL/D6EYc4NyOyfeJYuJeDexTZzz9T9KAszKR1bsFVlLk8bBz1U6yjT4
        Kw5DQNwvQ1iFvGcfyql813nM4ILECnYuU9t8Cx8HpPSaquG2UhHd6CH3w4Rma9vHqTOxVQCLp2UtN
        sFTYdUAdV1+A0nevIrs5ROAzdLumHsK4yLLU7Q3nXG2MbIMlNxYijNKExZ838qFl4Es66Pg//sv7x
        UlKfauV7Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa7By-0006PZ-6j; Mon, 02 Jul 2018 22:21:06 +0000
Date:   Mon, 2 Jul 2018 15:21:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180702222105.GA2438@bombadil.infradead.org>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:18:11PM -0700, Andrew Morton wrote:
> In the [5/6] changelog it is mentioned that a large number of -ve
> dentries can lead to oom-killings.  This sounds bad - -ve dentries
> should be trivially reclaimable and we shouldn't be oom-killing in such
> a situation.
> 
> Dumb question: do we know that negative dentries are actually
> worthwhile?  Has anyone checked in the past couple of decades?  Perhaps
> our lookups are so whizzy nowadays that we don't need them?

I can't believe that's true.  Have you looked at strace of a typical
program startup recently?

$ strace -o ls.out ls 
$ grep -c ENOENT ls.out 
10

There's a few duplicates in there (6 accesses to /etc/ld.so.nohwcap), so
we definitely want those negative entries.
