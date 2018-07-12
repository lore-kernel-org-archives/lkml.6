Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6BAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8A820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hK0Lp1Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8A820BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeGLLct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:32:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeGLLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eJ8a7MWh+sOxA/5UNBc6Nl1IDk8LeAbCzZdyXZSerAs=; b=hK0Lp1YxizZRDM5WSZU3dYyth
        8z6YZHjqkrCqChPHp/SDKTatKZvUBIjvR4I51Oz9M+3A8Y+vedDDttAUpVX+gKsCLeO+ra9tARiJ0
        3jJAeTvxagWBan6TmuxNu5fhlciVhKoyXJgGGlv0OueSBGaMqtbt0XML46DE0/yXhDCo2Ds6te/CK
        P5NSqFUSCnI2eSJnIicdbz7AJANRxJhVsntdJ+Vl3PpYerGsuGRn9X1aEyX8jw4uOcxBSSnkxtdNL
        xgeiMyl5DscGp0vbHHGUu0fxIUajxJwCT/ajEPAkhQDBBy5UqOleFT/BvWVTGCaJNVWTfFezngwBs
        jSuTtA2yw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdZh7-00013l-R2; Thu, 12 Jul 2018 11:23:33 +0000
Date:   Thu, 12 Jul 2018 04:23:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] 9p: Replace the fidlist with an IDR
Message-ID: <20180712112333.GA15277@bombadil.infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-4-willy@infradead.org>
 <20180712111726.GA17774@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712111726.GA17774@nautica>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:17:26PM +0200, Dominique Martinet wrote:
> Matthew Wilcox wrote on Wed, Jul 11, 2018:
> > diff --git a/net/9p/client.c b/net/9p/client.c
> > index 389a2904b7b3..b89c7298267c 100644
> > --- a/net/9p/client.c
> > +++ b/net/9p/client.c
> >  	memset(&fid->qid, 0, sizeof(struct p9_qid));
> 
> Ah, I had missed that you didn't update this memset as you said in reply
> to comment on v1.

Rather than update the memset, I ... 

> Could you resend just this patch and either initialize fid->fid or use
> kzalloc for the fid allocation?
> 
> > +	fid->fid = 0;

Did that instead ;-)

If I were going to initialise the entire structure to 0, I'd replace
the kmalloc with kzalloc and drop the memset altogether.

> If you do resend, alignment here was wrong.

I think this warning from checkpatch is complete bullshit.  It's
really none of checkpatch's business how I choose to align function
arguments.

That said, if you want it to be aligned some particular way, feel free
to adjust the whitespace.  I don't care.
