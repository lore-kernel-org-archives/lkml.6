Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED69206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbfAIOtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbfAIOta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:49:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE3CCCD263;
        Wed,  9 Jan 2019 14:49:29 +0000 (UTC)
Received: from redhat.com (ovpn-123-72.rdu2.redhat.com [10.10.123.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id C5A8E411A;
        Wed,  9 Jan 2019 14:49:28 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:49:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v3 1/3] virtio-balloon: tweak config_changed
 implementation
Message-ID: <20190109094844-mutt-send-email-mst@kernel.org>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
 <1546844466-38079-2-git-send-email-wei.w.wang@intel.com>
 <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
 <5C343688.2060609@intel.com>
 <20f5fb20-612a-fe37-c5e1-af5ecb98f5d3@de.ibm.com>
 <5C35CE55.6030200@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C35CE55.6030200@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 09 Jan 2019 14:49:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:35:01PM +0800, Wei Wang wrote:
> On 01/08/2019 04:46 PM, Christian Borntraeger wrote:
> > 
> > On 08.01.2019 06:35, Wei Wang wrote:
> > > On 01/07/2019 09:49 PM, Christian Borntraeger wrote:
> > > > On 07.01.2019 08:01, Wei Wang wrote:
> > > > > virtio-ccw has deadlock issues with reading the config space inside the
> > > > > interrupt context, so we tweak the virtballoon_changed implementation
> > > > > by moving the config read operations into the related workqueue contexts.
> > > > > The config_read_bitmap is used as a flag to the workqueue callbacks
> > > > > about the related config fields that need to be read.
> > > > > 
> > > > > The cmd_id_received is also renamed to cmd_id_received_cache, and
> > > > > the value should be obtained via virtio_balloon_cmd_id_received.
> > > > > 
> > > > > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > > > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > > > > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > > > Together with
> > > >     virtio_pci: use queue idx instead of array idx to set up the vq
> > > >     virtio: don't allocate vqs when names[i] = NULL
> > > > 
> > > > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > OK. I don't plan to send a new version of the above patches as no changes needed so far.
> > > 
> > > Michael, if the above two patches look good to you, please help add the related tested-by
> > > and reviewed-by tags. Thanks.
> > Can we also make sure that
> > 
> > virtio_pci: use queue idx instead of array idx to set up the vq
> > virtio: don't allocate vqs when names[i] = NULL
> > 
> > also land in stable?
> > 
> 
> You could also send the request to stable after it gets merged to Linus'
> tree.
> The stable review committee will decide whether to take it.
> 
> Please see Option 2:
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> 
> Best,
> Wei

That's mostly for 3rd party reporters.
Why not Cc stable directly in the patches?

-- 
MST
