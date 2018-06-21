Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80862C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3635420837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3635420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeFUPBa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:01:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:32795 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932747AbeFUPB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:01:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB52CAD68;
        Thu, 21 Jun 2018 15:01:26 +0000 (UTC)
Date:   Thu, 21 Jun 2018 17:01:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] slub: track number of slabs irrespective of
 CONFIG_SLUB_DEBUG
Message-ID: <20180621150122.GB13063@dhcp22.suse.cz>
References: <20180620224147.23777-1-shakeelb@google.com>
 <010001641fe92599-9006a895-d1ea-4881-a63c-f3749ff9b7b3-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001641fe92599-9006a895-d1ea-4881-a63c-f3749ff9b7b3-000000@email.amazonses.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-06-18 01:15:30, Cristopher Lameter wrote:
> On Wed, 20 Jun 2018, Shakeel Butt wrote:
> 
> > For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> > allocated per node for a kmem_cache. Thus, slabs_node() in
> > __kmem_cache_empty(), __kmem_cache_shrink() and __kmem_cache_destroy()
> > will always return 0 for such config. This is wrong and can cause issues
> > for all users of these functions.
> 
> 
> CONFIG_SLUB_DEBUG is set by default on almost all builds. The only case
> where CONFIG_SLUB_DEBUG is switched off is when we absolutely need to use
> the minimum amount of memory (embedded or some such thing).

I thought those would be using SLOB rather than SLUB.

> 
> > The right solution is to make slabs_node() work even for
> > !CONFIG_SLUB_DEBUG. The commit 0f389ec63077 ("slub: No need for per node
> > slab counters if !SLUB_DEBUG") had put the per node slab counter under
> > CONFIG_SLUB_DEBUG because it was only read through sysfs API and the
> > sysfs API was disabled on !CONFIG_SLUB_DEBUG. However the users of the
> > per node slab counter assumed that it will work in the absence of
> > CONFIG_SLUB_DEBUG. So, make the counter work for !CONFIG_SLUB_DEBUG.
> 
> Please do not do this. Find a way to avoid these checks. The
> objective of a !CONFIG_SLUB_DEBUG configuration is to not compile in
> debuggin checks etc etc in order to reduce the code/data footprint to the
> minimum necessary while sacrificing debuggability etc etc.
> 
> Maybe make it impossible to disable CONFIG_SLUB_DEBUG if CGROUPs are in
> use?

Why don't we simply remove the config option altogether and make it
enabled effectively.
-- 
Michal Hocko
SUSE Labs
