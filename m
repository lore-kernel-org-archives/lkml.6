Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E51C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A832054F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBW4Oyv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A832054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLHSNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:13:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLHSNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xJEBp/3asiHVeZps7v/zV1QboJYOn6XLUjrWKYUW3XE=; b=BBW4Oyv+pinFAiV/fYKMbsdlv
        vCGwnzOHMuWRTFHYh8EgYfkACZoJx0cvPifMz7AZPa6tSTl02gvzyCDQzcHhLU6Gpaf1K/TngOUVC
        1N946RqCYEUAatBvDuBzRqOBOshBQB+v28xnYBcTIpmpiTHSPm7VCyPNZC9W65CAde8XJ2Fpq00bt
        e0iBmhuCjuUvYQN+AGPrt9+cBzfTMFpB/WAP2qgSK+wivjv/FRBx2RV0nR7ANEPzGfZOZH2MV8BXU
        hmU+Q8moa7QUpSoFs512IMObs9PpRr4f05p7yRiP23xCCRQYyj0UxotFIzhWiY8SgXvNO7KrwQr/h
        5UYP0D2Cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVh63-0003Pd-2C; Sat, 08 Dec 2018 18:12:59 +0000
Date:   Sat, 8 Dec 2018 10:12:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181208181258.GA13075@infradead.org>
References: <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <CAPcyv4hwtMA+4qc6500ucn5vf6fRrNdfyMHru_Jhzx86=1Wwww@mail.gmail.com>
 <20181208163353.GA2952@redhat.com>
 <20181208164825.GA26154@infradead.org>
 <CAPcyv4hP1XrheKTrapANmrg10xz6dpG7cj=qEG8La9L34bCKDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hP1XrheKTrapANmrg10xz6dpG7cj=qEG8La9L34bCKDQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 10:09:26AM -0800, Dan Williams wrote:
> Another fix that may put pressure 'struct page' is resolving the
> untenable situation of dax being incompatible with reflink, i.e.
> reflink currently requires page-cache pages. Dave has talked about
> silently establishing page-cache entries when a dax-page is cow'd for
> reflink, but I wonder if we could go the other way and introduce the
> mechanism of a page belonging to multiple mappings simultaneously and
> managed by the filesystem.

FYI, I had a a prototype for DAX + reflink that didn't require
the page cache, although it badly reimplemented parts of it.  But
that was a long time ago, before we started requiring struct page
for the DAX memory.
