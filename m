Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B757C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC73222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSBiZm2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbfBMV02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:26:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732849AbfBMV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PFhbqswd53Y8SIJj48uZuOFAkq8mx1eO7ZIznryNB54=; b=lSBiZm2eGmokVB72+F+bRMd2U
        A7E5bNgqU8qzQ2IkC3I02oCoVscObSZoBwUBuLHn6Yof6h+Hb+tHZN6Zce1fKf61sBe0OmWKYBBB9
        C96+7IY8KIgp7sDgTP7MbZWjCJdaniPpHtC2MUhGpJOSijpRjQ9ToxImmyhlobodEoYvmObx56xKE
        1ekZXHqzrxZMy5qNdqZsXZLzrjbL9kFuk6nGWhQo738FCSguF3SN15zg+YrfmDW3SZ6qqv0bY0QwH
        dHHnpB68DL7iAwzzklzqhhqI/38NMkiQBeTx7LUejnQY3O7j9O7VGNTJ37mGtxOfHCS63KM2MOSSj
        mbEKYMpFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu22y-0007t6-5c; Wed, 13 Feb 2019 21:26:24 +0000
Date:   Wed, 13 Feb 2019 13:26:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20190213212621.GW12668@bombadil.infradead.org>
References: <20190212162003.1aa1ffbd@canb.auug.org.au>
 <20190212161528.GN12668@bombadil.infradead.org>
 <20190212162324.GU24706@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212162324.GU24706@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:23:31PM +0000, Jason Gunthorpe wrote:
> On Tue, Feb 12, 2019 at 08:15:28AM -0800, Matthew Wilcox wrote:
> > Seriously, there are several defects in the published API which do
> > warrant a change.  The most severe one is that it's really easy to
> > forget to initialise the start index.  And while I'm making that change,
> > I should fix smaller things like the errno at the same time.
> 
> I hope you will send your tree in the 2nd week of the merge window
> with all these merge fixes in it..
> 
> I think Linus will not like it if he has to fix this when merging
> rdma.

Ahhahhahhah.  No.  Burned once.  Not doing that again.

https://lore.kernel.org/lkml/CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com/

> > @@ -750,7 +738,7 @@ int ib_register_device(struct ib_device *device, const char *name)
> >  	int ret;
> >  
> >  	ret = assign_name(device, name);
> > -	if (ret)
> > +	if (ret < 0)
> >  		return ret;
> 
> This <0 should be near the xa_alloc_cyclic, I don't want the unusual
> '1' to propogate.. Far too likely that someone will forget about
> the special case.

Feel free to propose an alternate fix for sfr to put in his tree and we
can both include it as a proposed patch in our respective pull requests.
