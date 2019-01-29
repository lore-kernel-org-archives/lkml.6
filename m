Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664922177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548746323;
	bh=1LMfKLqRs0c0hgphdHMeaA7aKqBAmP+N1UTc5ASaacY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dzVVIuLTRM0jC5knRz7Y5AdSMfLuyIsxbrQpQrvGWVEp3ZNT2c8gsm7Y0/DyWG3pg
	 zHbKmAkxA4GJXPEe3PN7HJcBPWxtn1TJLJGkO8NXvZ/dipIsOuAjOoe5BDg5IH9Bn6
	 QlCcpIjLgxq2iZ771bzp5QW/nVM4WfWy98a5d/AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfA2HSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:18:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:41316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbfA2HSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:18:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0B60AED7;
        Tue, 29 Jan 2019 07:18:39 +0000 (UTC)
Date:   Tue, 29 Jan 2019 08:18:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vratislav Bendel <vbendel@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
        Minchan Kim <minchan@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1] mm: migrate: don't rely on PageMovable() of newpage
 after unlocking it
Message-ID: <20190129071837.GZ18811@dhcp22.suse.cz>
References: <20190128160403.16657-1-david@redhat.com>
 <e3247625-b25c-a18a-a494-f1e9a0148932@redhat.com>
 <20190128201902.GW18811@dhcp22.suse.cz>
 <725cd2b9-984f-d69b-1967-660d32858ce4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725cd2b9-984f-d69b-1967-660d32858ce4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 22:09:14, David Hildenbrand wrote:
> On 28.01.19 21:19, Michal Hocko wrote:
[...]
> > David, could you reformulate the changelog accordingly please? My ack
> > still holds.
> 
> You mean reformulating + resending for stable kernels only?

I would merge your patch even if it doesn't fix any real problem _now_.
If for not other reasons it makes the code less subtle because we no
longer depend on this crazy __PageMovable is special. If the movable
flag is supposed to be synchronized with the page lock then do not do
tricks and make code more robust because the next time somebody would
like to fix up the current semantic he might reintroduce the bug easily.
-- 
Michal Hocko
SUSE Labs
