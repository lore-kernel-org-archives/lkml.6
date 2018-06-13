Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AD3C7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CF5208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJTmspSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CF5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935522AbeFMSRD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:17:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934975AbeFMSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TsqNpqAGEc/PuecdVkKAU4hJ+8CWDMd89drVwKoHIpY=; b=pJTmspSpB/c9CWGXb08HWqMy/
        kygOHRWvl8b8LD+zohTqBDpb+ejBm9FduLZ+wA3mnnqfoFeHYLK1XsX7F2T3F2Y9t/ybj0E1wCoYL
        bOzEY/WVioj38RkQAireOrok/0iRccJJPcpwPcuhKbhECx8Bm9ZZqIzbM2R/hwFropw7GYFOnt6x7
        NWMOuI4fSuYbOvnUBLytxbrym9WKRI3u8CQObKQ77XZUlB/UD4ZXNntef+eYH+99ULMe/5mzepJvd
        xEtmDXk6ueERdD2NI5vcqJ4wev4Bmaz9rb6v2E67H+xmJu9wVngGsbLwLD8sMAjKkVv5G7DRNRKfK
        Kr0iB4kzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTAKE-0006Z9-5T; Wed, 13 Jun 2018 18:16:54 +0000
Date:   Wed, 13 Jun 2018 11:16:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] slab: introduce the flag SLAB_MINIMIZE_WASTE
Message-ID: <20180613181654.GA24315@infradead.org>
References: <alpine.DEB.2.20.1804170940340.17557@nuc-kabylake>
 <alpine.LRH.2.02.1804171454020.26973@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.DEB.2.20.1804180952580.1334@nuc-kabylake>
 <alpine.LRH.2.02.1804251702250.9428@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1804251917460.2429@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.DEB.2.20.1804261354230.6674@nuc-kabylake>
 <alpine.LRH.2.02.1804261508430.26980@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.DEB.2.20.1804271136390.11686@nuc-kabylake>
 <alpine.LRH.2.02.1804271513320.16558@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1806131300370.1012@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1806131300370.1012@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 01:01:22PM -0400, Mikulas Patocka wrote:
> Hi
> 
> I'd like to ask about this patch - will you commit it, or do you want to 
> make some more changes to it?

How about you resend it with the series adding an actual user once
ready?  I haven't actually seen patches using it posted on any list yet.
