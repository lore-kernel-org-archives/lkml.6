Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C637C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B35A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c2oWu7Yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B35A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeH2UPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:15:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbeH2UPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wqy/Im9VKf5NH9FoBC0zvAegxQ0fzRIJDYJp/E447UU=; b=c2oWu7Ypf1TjfjnvhxQ3fxQ/p
        4jvVxDF4CxFwmSre3hDNxWTc0uDiBcB4JTohVwJOaiZpknobPGfBm1bmkFpSyzwTvZXzDf2SvSKPQ
        6QDWhiO3nv+p2zEbvmOrl6VYQ4SYJmR4UnftoDjsIZHo8/i8s5HqyKN6SVSD64E4O2sAn/0wfIIKN
        Q8w5OYCXHx6KqINPzR1l6lGIT06hwIb8D8GlLxhDM6tyrktNyMznq0nURfyVPnuHyq5hzKAQGhIRm
        e+LQuvXbttYImFNxwx8VL/baUT5ICpsRiZurAh+LagYyI4ex4F7valr9l8RMrSKUpIMD8rSQcj8yM
        doJ/tgzZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fv3AK-0006C9-G4; Wed, 29 Aug 2018 16:17:56 +0000
Date:   Wed, 29 Aug 2018 09:17:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Tagged pointers in the XArray
Message-ID: <20180829161756.GB30396@bombadil.infradead.org>
References: <20180828222727.GD11400@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828222727.GD11400@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 03:27:27PM -0700, Matthew Wilcox wrote:
> I find myself caught between two traditions.
> 
> On the one hand, the radix tree has been calling the page cache dirty &
> writeback bits "tags" for over a decade.
> 
> On the other hand, using some of the bits _in a pointer_ as a tag has been
> common practice since at least the 1960s.
> https://en.wikipedia.org/wiki/Tagged_pointer and
> https://en.wikipedia.org/wiki/31-bit
> 
> EROFS wants to use tagged pointers in the radix tree / xarray.  Right now,
> they're building them by hand, which is predictably grotty-looking.
> I think it's reasonable to provide this functionality as part of the
> XArray API, _but_ it's confusing to have two different things called tags.
> 
> I've done my best to document my way around this, but if we want to rename
> the things that the radix tree called tags to avoid the problem entirely,
> now is the time to do it.  Anybody got a Good Idea?

I have two ideas now.

First, we could rename radix tree tags to xarray marks.  That is,

xa_mark_t
xa_set_mark()
xas_clear_mark()
xas_for_each_marked() { }
xa_marked()
etc

Second, we could call the tagged pointers typed pointers.  That is,

void *xa_mk_type(void *p, unsigned int type);
void *xa_to_ptr(void *entry);
int xa_ptr_type(void *entry);

Any better ideas, or violent revulsion to either of the above ideas?
