Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A98BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D2821726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfBAILC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:11:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBAILA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:11:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53A38D3C38;
        Fri,  1 Feb 2019 08:11:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1D11992A;
        Fri,  1 Feb 2019 08:10:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3B526A1E8; Fri,  1 Feb 2019 09:10:59 +0100 (CET)
Date:   Fri, 1 Feb 2019 09:10:59 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 2/6] drm/virtio: use struct to pass params to
 virtio_gpu_object_create()
Message-ID: <20190201081059.44w2x6vwap724coz@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-3-kraxel@redhat.com>
 <46c0feb8-3a0d-eeac-180c-cb0f3147fe11@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c0feb8-3a0d-eeac-180c-cb0f3147fe11@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 01 Feb 2019 08:11:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	ret = virtio_gpu_gem_create(file_priv, dev, args->size, &gobj,
> > +	params.pinned = false,
> 
> You have a comma here, but assigning to false isn't really necessary
> since the struct is zeroed. Same goes for the same assignment further down.

Hmm, yes, but it likewise isn't used, so I think I can just scratch it
altogether.

It's also wrong, virtio-gpu objects don't move around, so they are all
pinned.  Not that this bug changes much in practice given virtio-gpu
supports a single kind of storage only, so there is no opportunity for
ttm to try move objects from one to another.  I'll fix it nevertheless
in v3.

cheers,
  Gerd

