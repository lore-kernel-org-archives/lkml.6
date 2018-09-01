Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B17C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31BE2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31BE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeIAQoy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:44:54 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52917 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726991AbeIAQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:44:54 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 13468153-1500050 
        for multiple; Sat, 01 Sep 2018 13:32:56 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180901122041.2357-1-baijiaju1990@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20180901122041.2357-1-baijiaju1990@gmail.com>
Message-ID: <153580517420.12034.2035309606925619207@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] gpu: drm: drm_mm: Fix a sleep-in-atomic-context bug in
 show_leaks()
Date:   Sat, 01 Sep 2018 13:32:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jia-Ju Bai (2018-09-01 13:20:41)
> The driver may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] kmalloc(GFP_KERNEL)
> drivers/gpu/drm/drm_mm.c, 130: 
>         kmalloc in show_leaks
> drivers/gpu/drm/drm_mm.c, 913: 
>         show_leaks in drm_mm_takedown
> drivers/gpu/drm/drm_vma_manager.c, 107: 
>         drm_mm_takedown in drm_vma_offset_manager_destroy
> drivers/gpu/drm/drm_vma_manager.c, 106: 
>         _raw_write_lock in drm_vma_offset_manager_destroy
> 
> [FUNC] kmalloc(GFP_KERNEL)
> drivers/gpu/drm/drm_mm.c, 130: 
>         kmalloc in show_leaks
> drivers/gpu/drm/drm_mm.c, 913: 
>         show_leaks in drm_mm_takedown
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 71: 
>         drm_mm_takedown in amdgpu_vram_mgr_fini
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 70: 
>         spin_lock in amdgpu_vram_mgr_fini
> 
> [FUNC] kmalloc(GFP_KERNEL)
> drivers/gpu/drm/drm_mm.c, 130: 
>         kmalloc in show_leaks
> drivers/gpu/drm/drm_mm.c, 913: 
>         show_leaks in drm_mm_takedown
> drivers/gpu/drm/ttm/ttm_bo_manager.c, 128: 
>         drm_mm_takedown in ttm_bo_man_takedown
> drivers/gpu/drm/ttm/ttm_bo_manager.c, 126: 
>         spin_lock in ttm_bo_man_takedown
> 
> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

The bug are above, since those spinlocks do not protect the data and
imply use-after-free.
-Chris
