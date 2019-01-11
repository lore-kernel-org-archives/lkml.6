Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACFAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A0020657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HqWRPPSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfAKQy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:54:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbfAKQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yTgfkkdtMIoi23ux2f75q9TFNcJ9LY9AiM9jb/rIyCA=; b=HqWRPPSNy8nRRFaK5UH00k4DS
        2xgbFuAUFbqf2EBzUiLY1rR4d8cCPNNCriTh6MI0hhhb9UnlITI4qhe4Oi96ON7Z/ldTsLrmC4ox7
        6wsr6SPfg1NyR3JAJFSglyVVqWZcCDWvBMji+semi3UoGzsrVCH7fCFOzykKhMOB3NSHSAzLZo1wl
        0N8GKtVJ3ZOrTTYxFKOEtfGian9qN23PL6qwyiS6s5vxqbYjUyy1yu4dYGoBaZVmt0GEDdATRX33L
        TMFx9zeG2QAlN1mxHaZO2TkXIEh7ZJ86d/IzAmXCbMdhrjkHYQZufagHJsUJ89KTXalIpXkszrAVT
        LwRxPgUCA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gi053-0005JS-Sf; Fri, 11 Jan 2019 16:54:49 +0000
Date:   Fri, 11 Jan 2019 08:54:49 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: advansys: use struct_size() in kzalloc()
Message-ID: <20190111165449.GG6310@bombadil.infradead.org>
References: <20190104212209.GA15250@embeddedor>
 <05420a5c-c268-b87d-9d75-f5d18a4b7f7a@suse.de>
 <1547224903.2793.10.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547224903.2793.10.camel@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:41:43AM -0800, James Bottomley wrote:
> On Fri, 2019-01-11 at 16:46 +0100, Hannes Reinecke wrote:
> > > -		asc_sg_head = kzalloc(sizeof(asc_scsi_q->sg_head)
> > > +
> > > -			use_sg * sizeof(struct asc_sg_list),
> > > GFP_ATOMIC);
> > > +		asc_sg_head = kzalloc(struct_size(asc_sg_head,
> > > sg_list, use_sg),
> > > +				      GFP_ATOMIC);
> > If you want ...
> 
> Are we sure there's a benefit to this?  It's obvious that the current
> code is correct but no-one's likely to test the new code for quite some
> time, so changing the code introduces risk. What's the benefit of
> making the change in legacy drivers?  Just because we have a new, shiny
> macro doesn't mean we have to force its use everywhere.
> 
> I would recommend we have a rational needs test: so run the coccinelle
> script over all the drivers to find out where this construct is used,
> but only update those that are actually buggy with the new macro.

It's hard to tell whether they're buggy.  The problem being defended
against here is integer overflow.  So can 'use_sg' ever get large enough
that sizeof(asc_scsi_q->sg_head) + use_sg * sizeof(struct asc_sg_list)
is larger than 4 billion?  Probably not; I imagine there's some
rational sane limit elsewhere that says "No more than 256 SG elements"
or something.

But I don't know without checking.  Is there some device-specific ioctl
where the user can specify 2^31 scatterlist entries and somebody forgot
to check?  This macro is a defense-in-depth strategy, so using it as
widely as possible makes more sense than arguing about whether there
are already adequate safeguards in place.
