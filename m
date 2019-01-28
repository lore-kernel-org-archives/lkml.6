Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F692171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548680834;
	bh=ZZy4IW0tNo/vxRJRlDpP7k0GeqZuSjMY3Oa/4SRja8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n+2w+PK5ghNB7U/ajyFwZmhKcv0CiI8aiN6e2kvLrwjFqVwiyE2kTfvZm/1fdEH3z
	 bkqbiKVD/pB4Tu3ScC7BIuwZy3YyDtRNKH5RTIEgzqzkXs3aLVhMkKBeX+EcdYIgOv
	 P3hR9llVB6kXUtd1qz+E3ohOj3qv6s4rGkx4Ll0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA1NHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:07:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:39808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfA1NHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:07:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD45DAC70;
        Mon, 28 Jan 2019 13:07:10 +0000 (UTC)
Date:   Mon, 28 Jan 2019 14:07:09 +0100
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
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH RFC] mm: migrate: don't rely on PageMovable() of newpage
 after unlocking it
Message-ID: <20190128130709.GJ18811@dhcp22.suse.cz>
References: <20190128121609.9528-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128121609.9528-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 13:16:09, David Hildenbrand wrote:
[...]
> My theory:
> 
> In __unmap_and_move(), we lock the old and newpage and perform the
> migration. In case of vitio-balloon, the new page will become
> movable, the old page will no longer be movable.
> 
> However, after unlocking newpage, I think there is nothing stopping
> the newpage from getting dequeued and freed by virtio-balloon. This
> will result in the newpage
> 1. No longer having PageMovable()
> 2. Getting moved to the local list before finally freeing it (using
>    page->lru)

Does that mean that the virtio-balloon can change the Movable state
while there are other users of the page? Can you point to the code that
does it? How come this can be safe at all? Or is the PageMovable stable
only under the page lock?

-- 
Michal Hocko
SUSE Labs
