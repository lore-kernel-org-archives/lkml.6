Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FFEC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F0D218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548426648;
	bh=t9mzlbKxUhp4Q4SILCrwQd3WO53MmwSKzCQqv1I8R80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wVi2j8/6tQRr/0i+4ov35oxsxM/i1MLD8N8+FWXJL/RUJY+74lp+K6LSPaNU2sMlG
	 e/3lx1vrRpbHldUzmbUEn8WrW/RT8qlBMuPD5gq6Zvw0QyY4V0Q7FBlu2fgQKJTsS5
	 OEWmtmneRM+VSPcFIl83ZY5JRo7il6s3dGvTiaUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfAYOar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:30:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:36972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfAYOaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:30:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90CE8AEF3;
        Fri, 25 Jan 2019 14:30:45 +0000 (UTC)
Date:   Fri, 25 Jan 2019 15:30:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        keith.busch@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@suse.de
Subject: Re: [PATCH v7 2/3] mm: Move buddy list manipulations into helpers
Message-ID: <20190125143044.GO3560@dhcp22.suse.cz>
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690327612.676627.7469591833063917773.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154690327612.676627.7469591833063917773.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-01-19 15:21:16, Dan Williams wrote:
> In preparation for runtime randomization of the zone lists, take all
> (well, most of) the list_*() functions in the buddy allocator and put
> them in helper functions. Provide a common control point for injecting
> additional behavior when freeing pages.

Looks good in general and it actually makes the code more readable.
One nit below

[...]
> +static inline void rmv_page_order(struct page *page)
> +{
> +	__ClearPageBuddy(page);
> +	set_page_private(page, 0);
> +}
> +

I guess we do not really need this helper and simply squash it to its
only user.

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
