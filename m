Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0D206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfAIOwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:52:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731895AbfAIOwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:52:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E319FC073D7D;
        Wed,  9 Jan 2019 14:52:18 +0000 (UTC)
Received: from redhat.com (ovpn-123-72.rdu2.redhat.com [10.10.123.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 527DA601A3;
        Wed,  9 Jan 2019 14:52:08 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:52:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v3 1/3] virtio-balloon: tweak config_changed
 implementation
Message-ID: <20190109095048-mutt-send-email-mst@kernel.org>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
 <1546844466-38079-2-git-send-email-wei.w.wang@intel.com>
 <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
 <5C343688.2060609@intel.com>
 <20f5fb20-612a-fe37-c5e1-af5ecb98f5d3@de.ibm.com>
 <5C35CE55.6030200@intel.com>
 <8f0977ee-1cc1-56da-f4a6-641b8887648a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f0977ee-1cc1-56da-f4a6-641b8887648a@de.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 14:52:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:07:16PM +0100, Christian Borntraeger wrote:
> On 09.01.2019 11:35, Wei Wang wrote:
> > On 01/08/2019 04:46 PM, Christian Borntraeger wrote:
> >>
> >> On 08.01.2019 06:35, Wei Wang wrote:
> >>> On 01/07/2019 09:49 PM, Christian Borntraeger wrote:
> >>>> On 07.01.2019 08:01, Wei Wang wrote:
> >>>>> virtio-ccw has deadlock issues with reading the config space inside the
> >>>>> interrupt context, so we tweak the virtballoon_changed implementation
> >>>>> by moving the config read operations into the related workqueue contexts.
> >>>>> The config_read_bitmap is used as a flag to the workqueue callbacks
> >>>>> about the related config fields that need to be read.
> >>>>>
> >>>>> The cmd_id_received is also renamed to cmd_id_received_cache, and
> >>>>> the value should be obtained via virtio_balloon_cmd_id_received.
> >>>>>
> >>>>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> >>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> >>>> Together with
> >>>>     virtio_pci: use queue idx instead of array idx to set up the vq
> >>>>     virtio: don't allocate vqs when names[i] = NULL
> >>>>
> >>>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>> OK. I don't plan to send a new version of the above patches as no changes needed so far.
> >>>
> >>> Michael, if the above two patches look good to you, please help add the related tested-by
> >>> and reviewed-by tags. Thanks.
> >> Can we also make sure that
> >>
> >> virtio_pci: use queue idx instead of array idx to set up the vq
> >> virtio: don't allocate vqs when names[i] = NULL
> >>
> >> also land in stable?
> >>
> > 
> > You could also send the request to stable after it gets merged to Linus' tree.
> > The stable review committee will decide whether to take it.
> > 
> > Please see Option 2:
> > 
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> 
> Those patches are not upstream yet, Correct?
> 
> Michael,
> 
> can you add the stable tag before submitting? If not, can you give me a heads up when doing the
> pull request so that I can ping the stable folks.

Can you reply to patches that you feel are needed on stable with just

Cc: stable@vger.kernel.org

in the message body?

Then it's all automatically handled by ack attaching scripts.

-- 
MST
