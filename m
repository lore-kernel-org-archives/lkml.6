Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0022EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FDB21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FDB21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389254AbeIULfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIULfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BB23445E1;
        Fri, 21 Sep 2018 05:47:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2CF67B03E;
        Fri, 21 Sep 2018 05:47:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 777CC1FCF7; Fri, 21 Sep 2018 07:47:52 +0200 (CEST)
Date:   Fri, 21 Sep 2018 07:47:52 +0200
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
Message-ID: <20180921054752.gjeaznoboqf2giit@sirius.home.kraxel.org>
References: <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
 <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
 <d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
 <20180919113807.6mwqxkdg6f55h6fg@sirius.home.kraxel.org>
 <bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
 <20180920063201.nt7kw555s4clshzr@sirius.home.kraxel.org>
 <95778dd4-8aca-eff6-f84a-c8efdd3b355d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95778dd4-8aca-eff6-f84a-c8efdd3b355d@amd.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 21 Sep 2018 05:47:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Just pass it down, the call sites all know it (see patch just sent).
> 
> Tested that patch you sent.  Together with this patch it also resolves
> the virtio gpu graphical display issue for SEV guest.

Cool.  Can you ack or review the patch so I can commit it?

> Is there a way to optimize the dma_sync_sg to only sync on the pages
> being updated instead of all the pages in the obj sgl list every time?

Well, the rectangle is passed to virtio_gpu_cmd_transfer_to_host_2d, so
it should be possible to figure which pages are affected and trim the
scatter list accordingly.

cheers,
  Gerd

