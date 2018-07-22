Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 03:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A1020856
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 03:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lvXuDhyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A1020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeGVErJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 00:47:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeGVErJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 00:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FBbkfAZQnwc0ObRQJskOpyrQUchp94B+qJpkDlkRfhE=; b=lvXuDhyIO1ZGBm2voJ32Fbk37
        Bt6uUPnAY5B8ECVPzDyIosUIMXSWQ3PzKc10fQ8brW4DWrxNWK7kAEb271U6vLFOI5CFb2s9CkNJN
        jK1uavdJkmq9ZGyRBIUNpdDiJAX76Qal0QjxhEnPAVrQtoC/xoPMK3XixB6ut3ZMZnLgslDxf6oT4
        NGF9p6KDODgKdZxYNGbx8QVO2mWea/mRSU06wJlh/Yo3TEHJGxIH2xjGOaLDwo2fv/RJGqz5ZWBCA
        cxboc+rNsPYvvqmeE3jcAFti6sLuGwe7/juV4USpvO3Kg9arKltkl3AQP+L5DlZQq/BTtbZTI+JbW
        c98j+soBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fh5PY-0003WA-Da; Sun, 22 Jul 2018 03:51:56 +0000
Date:   Sat, 21 Jul 2018 20:51:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill@shutemov.name, hughd@google.com, aaron.lu@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
Message-ID: <20180722035156.GA12125@bombadil.infradead.org>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
 <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
 <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
 <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:05:52PM -0700, David Rientjes wrote:
> The huge zero page can be reclaimed under memory pressure and, if it is, 
> it is attempted to be allocted again with gfp flags that attempt memory 
> compaction that can become expensive.  If we are constantly under memory 
> pressure, it gets freed and reallocated millions of times always trying to 
> compact memory both directly and by kicking kcompactd in the background.
> 
> It likely should also be per node.

Have you benchmarked making the non-huge zero page per-node?
