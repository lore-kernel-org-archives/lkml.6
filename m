Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7963020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hs3+90oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7963020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeGYPuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:50:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=flikRzjsIyrBZ/3YFHHY9qeSJTh3nRKuMjJpCdb8Azo=; b=hs3+90oMaqXuvTC+Gp839Z29A
        Op9AekYZFvBjFIWfopiDNgK1kucHIECpQ/exFhia+GvGzx5f+t0mqye++jUgn+L26v7kmbZEZNeIa
        z/Fc24PXxWTM0ZGFkAU2O4leWmLBdvK46kUzy/pGFJQfpOrFQ6StkfV6olCyUo4YguWT/BYkHsUDy
        2+wS5s5Kw/FXJBG05JUo9U20BHCuvRtk83iwOoVnfRoK32dLItgDQcF3YZH5VNnInD7Giwr5QO1kC
        YgDC6wbBomdJUslvYvV0ZwnV9E3GOwiO/irYTAzH/+L0vSeJvflx0GiF2aDstF8BneB9gnn5doWu6
        tcOYttIkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiKwE-0001bM-9u; Wed, 25 Jul 2018 14:38:50 +0000
Date:   Wed, 25 Jul 2018 07:38:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
Message-ID: <20180725143850.GA2886@bombadil.infradead.org>
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com>
 <DF4PR8401MB11806B9D2A7FE04B1F5ECBF8AB540@DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF4PR8401MB11806B9D2A7FE04B1F5ECBF8AB540@DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 05:02:46AM +0000, Elliott, Robert (Persistent Memory) wrote:
> Even with that, one CPU core won't saturate the memory bus; multiple
> CPU cores (preferably on the same NUMA node as the memory) need to
> share the work.

It's probably OK to not saturate the memory bus; it'd be nice if other
cores were allowed to get work done.  If your workload is single-threaded,
you're right, of course, but who has a single-threaded workload these
days?!
