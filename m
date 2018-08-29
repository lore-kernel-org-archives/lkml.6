Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D47DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CFC2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iEUXVHqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CFC2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeH3BCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:02:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3BCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y55IHZkqBenWSxLAokBXoxwcPJCN7xaIs0bfOip9KEc=; b=iEUXVHqPHQDirspJnE1EHvlkp
        hlNOZe3wV6Stupl5rGT1o5H6/L30hMwcqxQuuhHdaNHfoG+uX0OxefLxVe32FW2Q7Awg0UOVMMrvB
        34iI9N2glxgPqqiGZq4C/1d/2IbTnQjjdXULqJLNkZXFtFFm0Xm4b3QLeyOmu7aPR88FbA08sPidu
        DHLD1q/rXP0uOSPctS+7cHxNM3uQOH7sCu/PUE1nX49qpg34UPzEDDOh0SO0z1kMH4f4P8SMS7SnW
        tGpALuz7N61/rAdZfJl9ocx1KH71ouJdKMJNbQYUFeLhGIULcj4B4v93iLzO0Hp574jy1u4TVxpfN
        cSp5NDaSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fv7dE-0002HI-RM; Wed, 29 Aug 2018 21:04:04 +0000
Date:   Wed, 29 Aug 2018 14:04:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be
 reclaimed
Message-ID: <20180829210404.GA2925@bombadil.infradead.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com>
 <20180828160150.9a45ee293c92708edb511eab@linux-foundation.org>
 <20180829175405.GA17337@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829175405.GA17337@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:54:05AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 28, 2018 at 04:01:50PM -0700, Andrew Morton wrote:
> > People often use the term "the foo() function".  I don't know why -
> > just say "foo()"!
> 
> For whatever it is worth...
> 
> I tend to use "The foo() function ..." instead of "foo() ..." in order
> to properly capitalize the first word of the sentence.  So I might say
> "The call_rcu() function enqueues an RCU callback." rather than something
> like "call_rcu() enqueues an RCU callback."  Or I might use some other
> trick to keep "call_rcu()" from being the first word of the sentence.

I tend to write 'Use call_rcu() to enqueue a callback." or "When
call_rcu() returns, the callback will have been enqueued".

