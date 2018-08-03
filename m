Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C3C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CDB217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L24yqu5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CDB217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeHDAcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:32:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731682AbeHDAcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3g8LMtp7L2orVKXiybY3tn8pSapKfU/I1pTsITWrQSc=; b=L24yqu5CQkAAiWEYuIZ+W88Md
        O2FWVq5qTdQUT9IX6FvfVe4Cvzo75+IpNpEPRZ5RvSz/xzt1EH/oLCkqTAYWJvCVbobYHoz4zW+Cz
        qlzyvJYMSIA5Qf/6QnCeb4z3kRqZc43gIkFYejR5IxLF7GAY7AcMlYkAdFfBPqSlPDBJoDVoBdqxy
        zi+de08Nc/fLeCb34qpWMrmRkL1B1j1oTawi2XZLHfz1E5LiS433XuvIBTEgJpoM7GHkq0Aoupovy
        8lVv20/kkpXKA2q54J7aiqF4Gvbt6tGIT4LCleVkpFrDZBO65Dqf76i2Dme5QtXKbGbQhma6w7ieW
        41fgyI/xg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flidx-0007aA-D7; Fri, 03 Aug 2018 22:33:57 +0000
Date:   Fri, 3 Aug 2018 15:33:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
Message-ID: <20180803223357.GA23284@bombadil.infradead.org>
References: <20180411060320.14458-1-willy@infradead.org>
 <20180411060320.14458-3-willy@infradead.org>
 <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake>
 <20180411192448.GD22494@bombadil.infradead.org>
 <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
 <20180411235652.GA28279@bombadil.infradead.org>
 <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake>
 <20180412142718.GA20398@bombadil.infradead.org>
 <20180412191322.GA21205@bombadil.infradead.org>
 <20180803212257.GA5922@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803212257.GA5922@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 02:22:57PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Apr 12, 2018 at 12:13:22PM -0700, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > __GFP_ZERO requests that the object be initialised to all-zeroes,
> > while the purpose of a constructor is to initialise an object to a
> > particular pattern.  We cannot do both.  Add a warning to catch any
> > users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> > a constructor.
> > 
> > Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Seen with v4.18-rc7-139-gef46808 and v4.18-rc7-178-g0b5b1f9a78b5 when
> booting sh4 images in qemu:

Thanks!  It's under discussion here:

https://marc.info/?t=153301426900002&r=1&w=2

also reported here with a bogus backtrace:

https://marc.info/?l=linux-sh&m=153305755505935&w=2

Short version: It's a bug that's been present since 2009 and nobody
noticed until now.  And nobody's quite sure what the effect of this
bug is.
