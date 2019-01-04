Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147F921871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfADMjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:39:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfADMjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:39:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 189A97F3EC;
        Fri,  4 Jan 2019 12:39:47 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7271B5D6A6;
        Fri,  4 Jan 2019 12:39:41 +0000 (UTC)
Date:   Fri, 4 Jan 2019 13:39:39 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        Wei Wang <wei.w.wang@intel.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: document virtio_config_ops restrictions
Message-ID: <20190104133939.7d52ebb3.cohuck@redhat.com>
In-Reply-To: <20190103112627-mutt-send-email-mst@kernel.org>
References: <20190103160804.21438-1-cohuck@redhat.com>
        <20190103160804.21438-3-cohuck@redhat.com>
        <20190103112627-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 04 Jan 2019 12:39:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019 11:28:28 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 03, 2019 at 05:08:04PM +0100, Cornelia Huck wrote:
> > Some transports (e.g. virtio-ccw) implement virtio operations that
> > seem to be a simple read/write as something more involved that
> > cannot be done from an atomic context.
> > 
> > Give at least a hint about that.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 7087ef946ba7..987b6491b946 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -12,6 +12,11 @@ struct irq_affinity;
> >  
> >  /**
> >   * virtio_config_ops - operations for configuring a virtio device
> > + * Note: Do not assume that a transport implements all of the operations
> > + *       getting/setting a value as a simple read/write! Generally speaking,
> > + *       any of @get/@set, @get_status/@set_status, or @get_features/
> > + *       @finalize_features are NOT safe to be called from an atomic
> > + *       context.
> >   * @get: read the value of a configuration field
> >   *	vdev: the virtio_device
> >   *	offset: the offset of the configuration field  
> 
> Then might_sleep in virtio_cread/virtio_cwrite and
> friends would be appropriate? I guess we'll need to fix
> balloon first.

Yes, it makes sense to go over the code and add might_sleep to
functions where it makes sense after the balloon changes have been
merged.
