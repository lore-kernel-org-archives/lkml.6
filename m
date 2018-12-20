Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D08EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F221720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbeLTIgR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:36:17 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:60055 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbeLTIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:36:17 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14981347-1500050 
        for multiple; Thu, 20 Dec 2018 08:36:01 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From:   Chris Wilson <chris@chris-wilson.co.uk>
User-Agent: alot/0.6
To:     airlied@linux.ie, alek.du@intel.com, bin.yang@intel.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jani.saarinen@intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com
References: <20181220080135.9059-1-bin.yang@intel.com>
In-Reply-To: <20181220080135.9059-1-bin.yang@intel.com>
Message-ID: <154529495460.10782.18092727751160821897@skylake-alporthouse-com>
Subject: Re: [PATCH] drm/i915: Fix i915_gem_wait_for_idle oops due to active_requests
 check
Date:   Thu, 20 Dec 2018 08:35:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bin Yang (2018-12-20 08:01:35)
> Normally, i915_request_alloc() and i915_request_add() will be called
> in sequence with drm.struct_mutex locked. But in
> intel_vgpu_create_workload(), it will pre-allocate the request and
> call i915_request_add() in the workload thread for performance
> optimization. The above issue will be triggered.

That's your bug. It's not normally, it's a strict requirement that the
struct_mutex (request generation mutex) be held over the course of
generating the request.
-Chris
