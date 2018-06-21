Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806BAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FB20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Hm6Iem3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308FB20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeFUBPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:15:33 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:50862 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752983AbeFUBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1529543730;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=tDMCHpXs4aAfoFmX/Dj6MYiopWJT0Kumn/E0Fpazef0=;
        b=Hm6Iem3fK3/RdTpn40e0UXcN7X1bLBmENQaZyjqU4+OgLXsO1NBFpeAIsuKuVj7a
        1DYC4L6uvMvjee6NoUSgUjYT5v51pcXaHtXyjWRXyMIfarAYWP2YMcnyDXhoe/VWcDb
        /Z998R9aytQJhbKmio4VuXr5gO+o4hunL0i+K06U=
Date:   Thu, 21 Jun 2018 01:15:30 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Shakeel Butt <shakeelb@google.com>
cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] slub: track number of slabs irrespective of
 CONFIG_SLUB_DEBUG
In-Reply-To: <20180620224147.23777-1-shakeelb@google.com>
Message-ID: <010001641fe92599-9006a895-d1ea-4881-a63c-f3749ff9b7b3-000000@email.amazonses.com>
References: <20180620224147.23777-1-shakeelb@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.06.21-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Shakeel Butt wrote:

> For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> allocated per node for a kmem_cache. Thus, slabs_node() in
> __kmem_cache_empty(), __kmem_cache_shrink() and __kmem_cache_destroy()
> will always return 0 for such config. This is wrong and can cause issues
> for all users of these functions.


CONFIG_SLUB_DEBUG is set by default on almost all builds. The only case
where CONFIG_SLUB_DEBUG is switched off is when we absolutely need to use
the minimum amount of memory (embedded or some such thing).

> The right solution is to make slabs_node() work even for
> !CONFIG_SLUB_DEBUG. The commit 0f389ec63077 ("slub: No need for per node
> slab counters if !SLUB_DEBUG") had put the per node slab counter under
> CONFIG_SLUB_DEBUG because it was only read through sysfs API and the
> sysfs API was disabled on !CONFIG_SLUB_DEBUG. However the users of the
> per node slab counter assumed that it will work in the absence of
> CONFIG_SLUB_DEBUG. So, make the counter work for !CONFIG_SLUB_DEBUG.

Please do not do this. Find a way to avoid these checks. The
objective of a !CONFIG_SLUB_DEBUG configuration is to not compile in
debuggin checks etc etc in order to reduce the code/data footprint to the
minimum necessary while sacrificing debuggability etc etc.

Maybe make it impossible to disable CONFIG_SLUB_DEBUG if CGROUPs are in
use?

