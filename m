Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9B020827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AaQzgaPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfAHAMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:12:45 -0500
Received: from ozlabs.org ([203.11.71.1]:57891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAHAMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:12:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43YXlF3ftgz9sCr;
        Tue,  8 Jan 2019 11:12:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546906362;
        bh=cMTDZtCI1H59M+pn3p1TP7P3b+Xt+dG4315tizUTpmc=;
        h=Date:From:To:Cc:Subject:From;
        b=AaQzgaPDGftjeSkQnSAERObD5uAQOk6yAyvZ71I+UzvLVeVdDtJQG4FserEAX7u7U
         pWXm2uwvA8l0aCDlj4wcr7ZNOHZF3qTAo1eZYU8lvt9eStPIpaeS3nB5VnZEOKTGjB
         xIFjHgv2PPLaKV/wx2WlrJ0ksrCS1z03li+kPOFwnsMX2E3czx4IQXrzBIcgbrCOya
         LwiVdwiSn7jtLzqyYwUyNdqBDq8udsmARW+O6qFcne2dUHBdhOCrVzZa8RtyKRdn5z
         vA5nSli7/ZYVdXvyrm37UtWDYsIP2B3IizJvKqR4VuYd/CS5ieFJT3pYCl+ifAPElq
         BPGwzE/urkAwQ==
Date:   Tue, 8 Jan 2019 11:12:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190108111230.2dd3abd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_mode_config_init':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1695:30: error: passing argument 1 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
  drm_atomic_private_obj_init(&adev->dm.atomic_obj,
                              ^~~~~~~~~~~~~~~~~~~~
In file included from include/drm/drm_dp_mst_helper.h:27,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
                 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
include/drm/drm_atomic.h:437:53: note: expected 'struct drm_device *' but argument is of type 'struct drm_private_obj *'
 void drm_atomic_private_obj_init(struct drm_device *dev,
                                  ~~~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1696:9: error: passing argument 2 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
         &state->base,
         ^~~~~~~~~~~~
In file included from include/drm/drm_dp_mst_helper.h:27,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
                 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
include/drm/drm_atomic.h:438:30: note: expected 'struct drm_private_obj *' but argument is of type 'struct drm_private_state *'
      struct drm_private_obj *obj,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1697:9: error: passing argument 3 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
         &dm_atomic_state_funcs);
         ^~~~~~~~~~~~~~~~~~~~~~
In file included from include/drm/drm_dp_mst_helper.h:27,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
                 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
include/drm/drm_atomic.h:439:32: note: expected 'struct drm_private_state *' but argument is of type 'struct drm_private_state_funcs *'
      struct drm_private_state *state,
      ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1695:2: error: too few arguments to function 'drm_atomic_private_obj_init'
  drm_atomic_private_obj_init(&adev->dm.atomic_obj,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/drm/drm_dp_mst_helper.h:27,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
                 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
include/drm/drm_atomic.h:437:6: note: declared here
 void drm_atomic_private_obj_init(struct drm_device *dev,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")

interacting with commit

  eb3dc8978596 ("drm/amd/display: Use private obj helpers for dm_atomic_state")

from Linus' tree (merged during the merge window).

Its not obvious how to fix this up, so I have used the drm-misc tree
from next-20190107 for today.

-- 
Cheers,
Stephen Rothwell
