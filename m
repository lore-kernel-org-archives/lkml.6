Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE7BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6CF22AC6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNA96Wzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6CF22AC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeGGAOk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:14:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeGGAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KfdH+p09hrv53dPJnVsiVYUBTEnikxanFI+6z4VZa4g=; b=VNA96WziN/K9WPe5y/HQ9NcuB
        +XzDQyFd2UwOK9JS2g/9x8kaq5DNXT7pvaFRlXfwG1pY4wixGNzfNluL36VbrFRSAd6L0wS5JjsTB
        kJMgxFjN7mFSEfVXEnaDBro5u8d+jZ7+pEfN6uDxmbwtFPXUZb9aI/ST0OkYJym/a4dJDi+X6ztCt
        veerNfXQZTRMY074/lg9SpxHH9iiDQuUE9EfjpLMyK1TVI2aBmzmGZVGkWVJKH0X8cCqZTaGzaj6d
        q31f5sOMhjgiTsR3Jam26NO3O9CxM7fXa35EGtnHFz0EufrX1UQQln1QkAlNXR1ArS+cf1rmW6OS2
        UT32GeH0g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbas0-0001sD-EH; Sat, 07 Jul 2018 00:14:36 +0000
Date:   Fri, 6 Jul 2018 17:14:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        valdis.kletnieks@vt.edu
Subject: Re: [PATCH] radix-tree: avoid NULL dereference
Message-ID: <20180707001436.GA31699@bombadil.infradead.org>
References: <20180706134144.48446-1-mark.rutland@arm.com>
 <20180706142540.GB20816@bombadil.infradead.org>
 <20180706143603.xrjt4wn5pkuy25sf@lakrids.cambridge.arm.com>
 <20180706153640.53ot2cqm3varx7td@lakrids.cambridge.arm.com>
 <20180706144534.be6de0d9222e9755a3a09a2e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706144534.be6de0d9222e9755a3a09a2e@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:45:34PM -0700, Andrew Morton wrote:
> On Fri, 6 Jul 2018 16:36:41 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > > > 
> > > > Acked-by: Matthew Wilcox <willy@infradead.org>
> > > 
> > > Cheers!
> > > 
> > > I assume that Andrew will pick this up, if he's also happy with it.
> > 
> > I've just started fuzzing, and found this also applies with
> > node_tag_set(). I'll spin a v2 with that fixed up, too.
> 
> Thanks.  Please also give some thought to whether the fix should be
> backported and if so, which patch(es) it Fixes:.

I would say this goes all the way back to
0a835c4f090 ("Reimplement IDR and IDA using the radix tree")

I don't know if it's worth backporting though.  If the compiler does
the normal optimisation, nobody will hit it.  If it doesn't, the first
use of an IDR will trip the bug.  So it's not like a user-exploitable bug.
