Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61968C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C59208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nVRiZhfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfACOgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:36:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfACOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tiQoXd/a2FvLeiSGGBHciz46H6zCMyv8T91A/0oDYx4=; b=nVRiZhfeavh7Anvyl8q4U9bG9
        TkyOuj4duA4o5cdv789+AikFVXbXDGRgZft+reupt19vuoVkfQhUj8oM+Yf0cOSJdJuBk+MFM4FSy
        yO0HxpT8LCATnkQo4ntBa2/U0bgkIApjRiOk+wJ2NohPw69rcm3BH2nbU3wSS+pnal6OtvHav2QyQ
        vFYVQwjR44FaUmbuQoZuicn9kmjFer+YosxuCDB/6CHjzCUqRUs0maLkkSgj+uoBP880SJ2Uo+gS7
        gHfo6VYpBctwhGA33PkpGefUwcYlAc2pkba8AAHlNBHU4BWFopc9iu/sprAS7tFMpHE9n1NWrC0wC
        chUzwZSNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gf475-0000Rk-Mp; Thu, 03 Jan 2019 14:36:47 +0000
Date:   Thu, 3 Jan 2019 06:36:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103143647.GP6310@bombadil.infradead.org>
References: <20190103002126.GM6310@bombadil.infradead.org>
 <20190103143116.GB3395@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103143116.GB3395@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 09:31:16AM -0500, Jerome Glisse wrote:
> On Wed, Jan 02, 2019 at 04:21:26PM -0800, Matthew Wilcox wrote:
> > 
> > One of the paths in follow_pte_pmd() initialised the mmu_notifier_range
> > incorrectly.
> > 
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
> > Tested-by: Dave Chinner <dchinner@redhat.com>
> 
> Actually now that i have read the code again this is not ok to
> do so. The caller of follow_pte_pmd() will call range_init and
> follow pmd will only update the range address. So existing code
> is ok.

The only caller of follow_pte_pmd() does not call range_init() because it
doesn't know the address.  That's the point of follow_pte_pmd().

> I know this is kind of ugly but i do not see a way around that
> uglyness.

You wrote the code ...
