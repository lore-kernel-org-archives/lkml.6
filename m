Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D65C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B218208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B218208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeLMKBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:01:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbeLMKBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:01:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D49A30C6DF0;
        Thu, 13 Dec 2018 10:01:10 +0000 (UTC)
Received: from work-vm (ovpn-117-213.ams2.redhat.com [10.36.117.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AAE218E5F;
        Thu, 13 Dec 2018 10:01:01 +0000 (UTC)
Date:   Thu, 13 Dec 2018 10:00:59 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, stefanha@redhat.com, sweil@redhat.com,
        swhiteho@redhat.com
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the
 capabilities
Message-ID: <20181213100058.GC2313@work-vm>
References: <20181210171318.16998-1-vgoyal@redhat.com>
 <20181210171318.16998-19-vgoyal@redhat.com>
 <de46a955-813b-355d-49f2-4d866603a8fa@redhat.com>
 <20181213091320.GA2313@work-vm>
 <d8c093db-9dda-1342-41c2-d08083cc150b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c093db-9dda-1342-41c2-d08083cc150b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Dec 2018 10:01:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand (david@redhat.com) wrote:
> On 13.12.18 10:13, Dr. David Alan Gilbert wrote:
> > * David Hildenbrand (david@redhat.com) wrote:
> >> On 10.12.18 18:12, Vivek Goyal wrote:
> >>> Instead of assuming we had the fixed bar for the cache, use the
> >>> value from the capabilities.
> >>>
> >>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>> ---
> >>>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
> >>>  1 file changed, 17 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> >>> index 60d496c16841..55bac1465536 100644
> >>> --- a/fs/fuse/virtio_fs.c
> >>> +++ b/fs/fuse/virtio_fs.c
> >>> @@ -14,11 +14,6 @@
> >>>  #include <uapi/linux/virtio_pci.h>
> >>>  #include "fuse_i.h"
> >>>  
> >>> -enum {
> >>> -	/* PCI BAR number of the virtio-fs DAX window */
> >>> -	VIRTIO_FS_WINDOW_BAR = 2,
> >>> -};
> >>> -
> >>>  /* List of virtio-fs device instances and a lock for the list */
> >>>  static DEFINE_MUTEX(virtio_fs_mutex);
> >>>  static LIST_HEAD(virtio_fs_instances);
> >>> @@ -518,7 +513,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >>>  	struct dev_pagemap *pgmap;
> >>>  	struct pci_dev *pci_dev;
> >>>  	phys_addr_t phys_addr;
> >>> -	size_t len;
> >>> +	size_t bar_len;
> >>>  	int ret;
> >>>  	u8 have_cache, cache_bar;
> >>>  	u64 cache_offset, cache_len;
> >>> @@ -551,17 +546,13 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >>>          }
> >>>  
> >>>  	/* TODO handle case where device doesn't expose BAR? */
> >>
> >> For virtio-pmem we decided to not go via BARs as this would effectively
> >> make it only usable for virtio-pci implementers. Instead, we are going
> >> to export the applicable physical device region directly (e.g.
> >> phys_start, phys_size in virtio config), so it is decoupled from PCI
> >> details. Doing the same for virtio-fs would allow e.g. also virtio-ccw
> >> to make eventually use of this.
> > 
> > That makes it a very odd looking PCI device;  I can see that with
> > virtio-pmem it makes some sense, given that it's job is to expose
> > arbitrary chunks of memory.
> > 
> > Dave
> 
> Well, the fact that your are
> 
> - including <uapi/linux/virtio_pci.h>
> - adding pci related code
> 
> in/to fs/fuse/virtio_fs.c
> 
> tells me that these properties might be better communicated on the
> virtio layer, not on the PCI layer.
> 
> Or do you really want to glue virtio-fs to virtio-pci for all eternity?

No, these need cleaning up; and the split within the bar
is probably going to change to be communicated via virtio layer
rather than pci capabilities.  However, I don't want to make our PCI
device look odd, just to make portability to non-PCI devices - so it's
right to make the split appropriately, but still to use PCI bars
for what they were designed for.

Dave

> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
