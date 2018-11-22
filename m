Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A395C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD12081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395298AbeKWAjX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:39:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:16564 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388851AbeKWAjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:39:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 05:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,266,1539673200"; 
   d="scan'208";a="98256393"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.251.82.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2018 05:59:51 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     jglisse@redhat.com, linux-kernel@vger.kernel.org
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20180910005736.5805-3-jglisse@redhat.com>
Cc:     =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
References: <20180910005736.5805-1-jglisse@redhat.com>
 <20180910005736.5805-3-jglisse@redhat.com>
Message-ID: <154289518994.19402.3481838548028068213@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] gpu/i915: use HMM mirror for userptr buffer object.
Date:   Thu, 22 Nov 2018 15:59:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

Bit late reply, but here goes :)

We're working quite hard to avoid pinning any pages unless they're in
the GPU page tables. And when they are in the GPU page tables, they must
be pinned for whole of that duration, for the reason that our GPUs can
not take a fault. And to avoid thrashing GPU page tables, we do leave
objects in page tables with the expectation that smart userspace
recycles buffers.

So what I understand of your proposal, it wouldn't really make a
difference for us in the amount of pinned pages (which I agree,
we'd love to see going down). When we're unable to take a fault,
the first use effectively forces us to pin any pages and keep them
pinned to avoid thrashing GPU page tables.

So from i915 perspective, it just seems to be mostly an exchange of
an API to an another for getting the pages. You already mentioned
the fast path is being worked on, which is an obvious difference.
But is there some other improvement one would be expecting, beyond
the page pinning?

Also, is the requirement for a single non-file-backed VMA in the
plans of being eliminated or is that inherent restriction of the
HMM_MIRROR feature? We're currently not imposing such a limitation.

Regards, Joonas

Quoting jglisse@redhat.com (2018-09-10 03:57:36)
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> This replace existing code that rely on get_user_page() aka GUP with
> code that now use HMM mirror to mirror a range of virtual address as
> a buffer object accessible by the GPU. There is no functional changes
> from userspace point of view.
> 
> From kernel point of view we no longer pin pages for userptr buffer
> object which is a welcome change (i am assuming that everyone dislike
> page pin as i do).
> 
> Another change, from kernel point of view, is that it does no longer
> have a fast path with get_user_pages_fast() this can eventually added
> back through HMM.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
