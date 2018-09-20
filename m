Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5928CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8582083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8582083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbeITMNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:13:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731240AbeITMNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:13:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAE99308212B;
        Thu, 20 Sep 2018 06:32:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EDEB18A2F;
        Thu, 20 Sep 2018 06:32:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 773C4204A8; Thu, 20 Sep 2018 08:32:01 +0200 (CEST)
Date:   Thu, 20 Sep 2018 08:32:01 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jiandi An <jiandi@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Dave Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Message-ID: <20180920063201.nt7kw555s4clshzr@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
 <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
 <d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
 <20180919113807.6mwqxkdg6f55h6fg@sirius.home.kraxel.org>
 <bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 20 Sep 2018 06:32:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>                                         uint32_t resource_id, uint64_t offset,
> ...
>      struct virtio_gpu_fbdev *vgfbdev = vgdev->vgfbdev;
>      struct virtio_gpu_framebuffer *fb = &vgfbdev->vgfb;
>      struct virtio_gpu_object *obj = gem_to_virtio_gpu_obj(fb->base.obj[0]);

Ah, right.  Should have noticed this on review.  You sync the fbcon
framebuffer unconfitionally ...

> Is there better way to get to the virtio_gpu_object created in the
> virtio_gpu_mode_dumb_create() path from virtio_gpu_device or somehow from drm_file
> via gem_handle down at the layer of virtio_gpu_cmd_transfer_to_host()?

Just pass it down, the call sites all know it (see patch just sent).

cheers,
  Gerd

