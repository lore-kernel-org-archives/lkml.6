Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C5AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5062147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="miYwX0uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfAGX7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:59:01 -0500
Received: from ozlabs.org ([203.11.71.1]:40751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGX7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:59:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43YXRN60Zvz9sCr;
        Tue,  8 Jan 2019 10:58:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546905538;
        bh=z7ZUO/L/+FHA7MNpKwkPDWZVLkxHBrCysloh/3s7ieA=;
        h=Date:From:To:Cc:Subject:From;
        b=miYwX0uoBJaVQKSQq23ylRDLHlxJu0mhTmdb8E2eCJ6NGTEU9OwFKxxsTa7SZEkuc
         eUlKvxM7czFKY+td4z6LiqZClxqDxjQjLlFklct4f9RoUYPbyVGc3f/uk6mhbKITJe
         KTuu2LKVQOt1r3myowdfBbyiSz7992ifmwQFi5rkVITMGLm3hjstSPiZmGsrzAGVze
         1Vl0JlRBIy90nRJlVWFEdsRnxfS2V9ZJDiuTuKLkatTysMniwVKexQtF5UeF0ivkxh
         yIwx0pFQTWfDBVXcSxvZbbpV80Cps8rgZFbpIFJRqReLWuxK+d9c5+F7nsPFE9e127
         5qCfjdgDtRMpg==
Date:   Tue, 8 Jan 2019 10:58:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20190108105846.001acca6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the drm-misc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpu/drm/msm/msm_gem.c: In function 'describe_fence':
drivers/gpu/drm/msm/msm_gem.c:761:36: warning: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
   seq_printf(m, "\t%9s: %s %s seq %u\n", type,
                                   ~^
                                   %llu
drivers/gpu/drm/msm/msm_gem.c:764:5:
     fence->seqno);
     ~~~~~~~~~~~~

Introduced by commit

  b312d8ca3a7c ("dma-buf: make fence sequence numbers 64 bit v2")

-- 
Cheers,
Stephen Rothwell
