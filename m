Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3332D2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfAGNpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:45:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfAGNpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:45:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACC3A394D20;
        Mon,  7 Jan 2019 13:45:41 +0000 (UTC)
Received: from redhat.com (ovpn-122-143.rdu2.redhat.com [10.10.122.143])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91EBF19741;
        Mon,  7 Jan 2019 13:45:40 +0000 (UTC)
Date:   Mon, 7 Jan 2019 08:45:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v3 0/3] virtio-balloon: tweak config_changed
Message-ID: <20190107084502-mutt-send-email-mst@kernel.org>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 07 Jan 2019 13:45:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:01:03PM +0800, Wei Wang wrote:
> Since virtio-ccw doesn't work with accessing to the config space
> inside an interrupt context, this patch series avoids that issue by
> moving the config register accesses to the related workqueue contexts.

So is this enough to get ccw going again or do we also need
the patches that deal with NULL VQ names?

> v2->v3 ChangeLog:
>     - rename cmd_id_received to cmd_id_received_cache, and have call sites
>       read the latest value via virtio_balloon_cmd_id_received. (Still
>       kept Cornelia and Halil's reviewed-by as it's a minor change)
>     - remove zeroing vb->num_free_page_blocks in probe since vb is
>       allocated via kzalloc.
> v1->v2 ChangeLog:
>     - add config_read_bitmap to indicate to the workqueue callbacks about
>       the necessity of reading the related config fields.
> 
> Wei Wang (3):
>   virtio-balloon: tweak config_changed implementation
>   virtio-balloon: improve update_balloon_size_func
>   virtio_balloon: remove the unnecessary 0-initialization
> 
>  drivers/virtio/virtio_balloon.c | 104 ++++++++++++++++++++++++++--------------
>  1 file changed, 69 insertions(+), 35 deletions(-)
> 
> -- 
> 2.7.4
