Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6782146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6782146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGQNoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:44:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731548AbeGQNoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:44:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09CEB83221;
        Tue, 17 Jul 2018 13:12:06 +0000 (UTC)
Received: from localhost (ovpn-117-28.ams2.redhat.com [10.36.117.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0929E111C481;
        Tue, 17 Jul 2018 13:11:58 +0000 (UTC)
Date:   Tue, 17 Jul 2018 14:11:56 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, jack@suse.cz,
        dan.j.williams@intel.com, riel@surriel.com,
        haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com,
        pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com,
        xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        imammedo@redhat.com, eblake@redhat.com
Subject: Re: [RFC v3 2/2] virtio-pmem: Add virtio pmem driver
Message-ID: <20180717131156.GA13498@stefanha-x1.localdomain>
References: <20180713075232.9575-1-pagupta@redhat.com>
 <20180713075232.9575-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20180713075232.9575-3-pagupta@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 17 Jul 2018 13:12:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 17 Jul 2018 13:12:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'stefanha@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Fri, Jul 13, 2018 at 01:22:31PM +0530, Pankaj Gupta wrote:
> + /* The request submission function */
> +static int virtio_pmem_flush(struct device *dev)
> +{
> +	int err;
> +	unsigned long flags;
> +	struct scatterlist *sgs[2], sg, ret;
> +	struct virtio_device *vdev = dev_to_virtio(dev->parent->parent);
> +	struct virtio_pmem *vpmem = vdev->priv;
> +	struct virtio_pmem_request *req = kmalloc(sizeof(*req), GFP_KERNEL);
> +
> +	req->done = false;
> +	init_waitqueue_head(&req->acked);
> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +
> +	sg_init_one(&sg, req, sizeof(req));

What are you trying to do here?

sizeof(req) == sizeof(struct virtio_pmem_request *) == sizeof(void *)

Did you mean sizeof(*req)?

But why map struct virtio_pmem_request to the device?  struct
virtio_pmem_request is the driver-internal request state and is not part
of the hardware interface.

> +	sgs[0] = &sg;
> +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> +	sgs[1] = &ret;
> +	err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> +	if (err) {
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");

This can happen if the virtqueue is full.  Printing a message and
failing the flush isn't appropriate.  This thread needs to wait until
virtqueue space becomes available.

> +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +		return -ENOSPC;

req is leaked.

> +	virtio_device_ready(vdev);

This call isn't needed.  Driver use it when they wish to submit buffers
on virtqueues before ->probe() returns.

> diff --git a/include/linux/virtio_pmem.h b/include/linux/virtio_pmem.h
> new file mode 100644
> index 0000000..0f83d9c
> --- /dev/null
> +++ b/include/linux/virtio_pmem.h

include/ is for declarations (e.g. kernel APIs) needed by other
compilation units.  The contents of this header are internal to the
virtio_pmem driver implementation and can therefore be in virtio_pmem.c.
include/linux/virtio_pmem.h isn't necessary since nothing besides
virtio_pmem.c will need to include it.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTescAAoJEJykq7OBq3PIwPQH/3keU8xWbvv1c729mwMrCSlT
GRJkt3AyzE2iIoaXFkeBpnjnpARsajzX0vH/EheCEse46G6aOtia9fALOzf0Fo2l
XRB1KM3WhEDIx+xNZuk4/WH5AaSHEJPjSBM6Isv410MASfrDJzyu0vuRSjzqEAT8
augb75qojqCkqkDQm5iMcN6zGwgjJ0MLrXZdN8EKIpgsqeMW7QmwWCwlmWwCgXrq
f5nor6oEl3jci/EYjw6ctjWsBCSKdDz813phHbQLCbcMD9IuEngGlZt5b9XwdfNY
5u2SaC66cIPqMYyogb6duBFMZ2AOzkrSZjHbHyh1HArf7Lhd/aoYYMLABy/hwTs=
=0jCu
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
