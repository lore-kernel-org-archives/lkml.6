Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E64CC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3662190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R6Z8237Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390405AbeLUU3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:29:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbeLUU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CJK0vlftLh59hb5ucUvK/RXaMuhgiOcUq6O0AB1Qu8w=; b=R6Z8237YCp2CV7LnsI6mgRRIE
        DN0uygBaz2qpK4IgmubzHiSeLPC+GsnmJO9v1PyGUvOJzJ+3yYA3Jktunqf8MXNTB48RxZQ88tn2M
        klkacMpbM7a/gkO1/wd8lyhZtk0+9RBjOq3C/cfa7x0oPRHf15ucXY1Sk6r1C2gw+E9EnLhOEd/US
        TcVDouOC+9A0tZ2NQZo44xyb1RPkJiv8T6VMj48bYZKbqhSEQn2fIj4AKJqjZRkdhfiQIBPEpYBJc
        chjwGSyUgr73c7r6dExVL94O0O7IfY7tLM9smjTbtO0OyPNO3Zu3AVlLBvMFu2B+37PcRB2pOH0dz
        VPNDJOWXw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaRQY-0005qa-RD; Fri, 21 Dec 2018 20:29:46 +0000
Date:   Fri, 21 Dec 2018 12:29:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] x86_64: memset_user()
Message-ID: <20181221202946.GJ10600@bombadil.infradead.org>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-2-igor.stoppa@huawei.com>
 <20181221182515.GF10600@bombadil.infradead.org>
 <20181221200546.GA8441@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221200546.GA8441@uranus>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:05:46PM +0300, Cyrill Gorcunov wrote:
> On Fri, Dec 21, 2018 at 10:25:16AM -0800, Matthew Wilcox wrote:
> > On Fri, Dec 21, 2018 at 08:14:12PM +0200, Igor Stoppa wrote:
> > > +unsigned long __memset_user(void __user *addr, int c, unsigned long size)
> > > +{
> > > +	long __d0;
> > > +	unsigned long  pattern = 0;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < 8; i++)
> > > +		pattern = (pattern << 8) | (0xFF & c);
> > 
> > That's inefficient.
> > 
> > 	pattern = (unsigned char)c;
> > 	pattern |= pattern << 8;
> > 	pattern |= pattern << 16;
> > 	pattern |= pattern << 32;
> 
> Won't
> 
> 	pattern = 0x0101010101010101 * c;
> 
> do the same but faster?

Depends on your CPU.  Some yes, some no.

(Also you need to cast 'c' to unsigned char to avoid someone passing in
0x1234 and getting 0x4646464646464634 instead of 0x3434343434343434)
