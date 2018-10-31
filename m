Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D2CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4550C205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4550C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeJaXXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:23:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729289AbeJaXXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D78FAFD6;
        Wed, 31 Oct 2018 14:24:59 +0000 (UTC)
Date:   Wed, 31 Oct 2018 15:24:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181031142458.GP32673@dhcp22.suse.cz>
References: <20181031081945.207709-1-vovoy@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031081945.207709-1-vovoy@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-10-18 16:19:45, Kuo-Hsin Yang wrote:
[...]
> The previous mapping_set_unevictable patch is worse on gem_syslatency
> because it defers to vmscan to move these pages to the unevictable list
> and the test measures latency to allocate 2MiB pages. This performance
> impact can be solved by explicit moving pages to the unevictable list in
> the i915 function.

As I've mentioned in the previous version and testing results. Are you
sure that the lazy unevictable pages collecting is the real problem
here? The test case was generating a lot of page cache and we simply do
not reclaim anon LRUs at all. Maybe I have misunderstood the test
though. I am also wondering whether unevictable pages culling can be
really visible when we do the anon LRU reclaim because the swap path is
quite expensinve on its own.
-- 
Michal Hocko
SUSE Labs
