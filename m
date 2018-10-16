Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA172C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7193C21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7193C21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJQCNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:13:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbeJQCNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:13:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EC5CAE8F;
        Tue, 16 Oct 2018 18:21:58 +0000 (UTC)
Date:   Tue, 16 Oct 2018 20:21:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        chris@chris-wilson.co.uk, peterz@infradead.org,
        dave.hansen@intel.com, corbet@lwn.net, hughd@google.com,
        joonas.lahtinen@linux.intel.com, marcheu@chromium.org,
        hoegsberg@chromium.org
Subject: Re: [PATCH 2/2] drm/i915: Mark pinned shmemfs pages as unevictable
Message-ID: <20181016182155.GW18839@dhcp22.suse.cz>
References: <20181016174300.197906-1-vovoy@chromium.org>
 <20181016174300.197906-3-vovoy@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016174300.197906-3-vovoy@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-10-18 01:43:00, Kuo-Hsin Yang wrote:
> The i915 driver use shmemfs to allocate backing storage for gem objects.
> These shmemfs pages can be pinned (increased ref count) by
> shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> wastes a lot of time scanning these pinned pages. Mark these pinned
> pages as unevictable to speed up vmscan.

I would squash the two patches into the single one. One more thing
though. One more thing to be careful about here. Unless I miss something
such a page is not migrateable so it shouldn't be allocated from a
movable zone. Does mapping_gfp_constraint contains __GFP_MOVABLE? If
yes, we want to drop it as well. Other than that the patch makes sense
with my very limited knowlege of the i915 code of course.
-- 
Michal Hocko
SUSE Labs
