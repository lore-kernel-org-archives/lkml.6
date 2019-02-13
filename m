Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0463C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81EE218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392219AbfBMNos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:44:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388864AbfBMNop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:44:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF983C002961;
        Wed, 13 Feb 2019 13:44:45 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A17E10018FB;
        Wed, 13 Feb 2019 13:44:17 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:44:14 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] virtio: hint if callbacks surprisingly might sleep
Message-ID: <20190213144414.6543cd22.cohuck@redhat.com>
In-Reply-To: <20190131102713-mutt-send-email-mst@kernel.org>
References: <20190131125314.29647-1-cohuck@redhat.com>
        <20190131102713-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 13 Feb 2019 13:44:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 10:27:53 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 31, 2019 at 01:53:14PM +0100, Cornelia Huck wrote:
> > A virtio transport is free to implement some of the callbacks in
> > virtio_config_ops in a matter that they cannot be called from
> > atomic context (e.g. virtio-ccw, which maps a lot of the callbacks
> > to channel I/O, which is an inherently asynchronous mechanism).
> > This can be very surprising for developers using the much more
> > common virtio-pci transport, just to find out that things break
> > when used on s390.
> > 
> > The documentation for virtio_config_ops now contains a comment
> > explaining this, but it makes sense to add a might_sleep() annotation
> > to various wrapper functions in the virtio core to avoid surprises
> > later.
> > 
> > Note that annotations are NOT added to two classes of calls:
> > - direct calls from device drivers (all current callers should be
> >   fine, however)
> > - calls which clearly won't be made from atomic context (such as
> >   those ultimately coming in via the driver core)
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> 
> Makes sense to me. I don't think we should push our luck in
> this release though, better defer until the merge window.

Friendly ping, as we're quite close to the release of 5.0 now.
