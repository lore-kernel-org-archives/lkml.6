Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB52DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F97320868
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMwIDcRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F97320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeH2C5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:57:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeH2C5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2lXeXX0eGefe3ZB1TpW2VjliUPLzWzFuM8t0WhzEhAc=; b=IMwIDcRE5Jl9g/P4F280YzPdS
        XVPWjBsIr5orowLxVlKms7bzZ80PlNDc82HnMZ5ZtbCnLTTzi6hOW+DxkuaJ6P/Vx+3eMUgN4Shjg
        OaOeVydH1uDkUan0IeyoV1e+3Z7PhassSFBbw6uBxG2jzLUznyskSmJsEO604EOV3GUybkcHWOv+c
        mlCi3UAX2ZVbeABoIW5e2eMtKH/2NcFcaTW5WXhXEykugtX0Ol164QpNi4nitI0SWFRwZgW9MeuYL
        pE5uW7YD3DAkT99z6aEIjcVB64HfGu3J1sDLD24ko21xSzMlvc6AFktNhO6UNyDh+lCWEL1LAfJzY
        CGikjRQBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fun1F-0004yc-Io; Tue, 28 Aug 2018 23:03:29 +0000
Date:   Tue, 28 Aug 2018 16:03:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Tagged pointers in the XArray
Message-ID: <20180828230329.GE11400@bombadil.infradead.org>
References: <20180828222727.GD11400@bombadil.infradead.org>
 <fc15502d-8bf3-b7e3-af82-4645dc84e9cd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc15502d-8bf3-b7e3-af82-4645dc84e9cd@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 03:39:01PM -0700, Randy Dunlap wrote:
> Just a question, please...
> 
> On 08/28/2018 03:27 PM, Matthew Wilcox wrote:
> > 
> > diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> > index c74556ea4258..d1b383f3063f 100644
> > --- a/include/linux/xarray.h
> > +++ b/include/linux/xarray.h
> > @@ -150,6 +150,54 @@ static inline int xa_err(void *entry)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * xa_tag_pointer() - Create an XArray entry for a tagged pointer.
> > + * @p: Plain pointer.
> > + * @tag: Tag value (0, 1 or 3).
> > + *
> 
> What's wrong with a tag value of 2?

That conflicts with the XArray's internal entries and you get a WARN_ON
when you try to store it in the array.

> and what happens when one is used?  [I don't see anything preventing that.]

Right, there's nothing preventing you from using the value 5 or 19
or 16777216 either ... I did put in a WARN_ON_ONCE to begin with, but
decided that was unnecessary.

Right now our only user uses 0 and 1, so even documenting 3 as a
possibility isn't _necessary_, but some day somebody is going to want
to add FILE_NOT_FOUND
https://thedailywtf.com/articles/What_Is_Truth_0x3f_
