Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6104FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315862245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315862245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeKNRMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:12:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:43936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbeKNRMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:12:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5393AB08D;
        Wed, 14 Nov 2018 07:10:54 +0000 (UTC)
Date:   Wed, 14 Nov 2018 08:10:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kyungtae Kim <kt0755@gmail.com>, pavel.tatashin@microsoft.com,
        vbabka@suse.cz, osalvador@suse.de, rppt@linux.vnet.ibm.com,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        alexander.h.duyck@linux.intel.com, mgorman@techsingularity.net,
        lifeasageek@gmail.com, threeearcat@gmail.com,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181114071052.GA23419@dhcp22.suse.cz>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
 <20181113094305.GM15120@dhcp22.suse.cz>
 <20181113152941.cc328e48d5c0c2f366f5db83@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113152941.cc328e48d5c0c2f366f5db83@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-11-18 15:29:41, Andrew Morton wrote:
[...]
> But do we really need to do this?  Are there any other known potential
> callsites?

The main point is that the code as it stands is quite fragile, isn't it?
Fixing up all the callers is possible but can you actually think of a
reason why this would cause any measurable effect in the fast path?
The order argument is usually in a register and comparing it to a number
with unlikely branch should be hardly something visible.

Besides that we are talking few cycles at best compared to a fragile
code that got broken by accident without anybody noticing for quite some
time.

I vote for the maintainability over few cycles here. Should anybody find
this measurable we can rework the code by other means.

-- 
Michal Hocko
SUSE Labs
