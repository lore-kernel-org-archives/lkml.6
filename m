Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73795ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F4020661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F4020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGTNw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:52:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbeGTNw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:52:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA0AF307D86F;
        Fri, 20 Jul 2018 13:04:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC24E5C1A1;
        Fri, 20 Jul 2018 13:04:15 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 928694BB78;
        Fri, 20 Jul 2018 13:04:15 +0000 (UTC)
Date:   Fri, 20 Jul 2018 09:04:15 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Luiz Capitulino <lcapitulino@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org,
        david@redhat.com, ross zwisler <ross.zwisler@intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        hch@infradead.org, imammedo@redhat.com, mst@redhat.com,
        niteshnarayanlal@hotmail.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, nilal@redhat.com
Message-ID: <1832644023.52851886.1532091855557.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180719084819.730b7971@doriath>
References: <20180713075232.9575-1-pagupta@redhat.com> <20180713075232.9575-4-pagupta@redhat.com> <20180718085529.133a0a22@doriath> <367397176.52317488.1531979293251.JavaMail.zimbra@redhat.com> <20180719121635.GA28107@stefanha-x1.localdomain> <20180719084819.730b7971@doriath>
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.193.70, 10.4.195.18]
Thread-Topic: qemu: Add virtio pmem device
Thread-Index: lg4rWpxgdnhQI+PfnM/uab2D63zWJw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 20 Jul 2018 13:04:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > > +
> > > > > +typedef struct VirtIOPMEMresp {
> > > > > +    int ret;
> > > > > +} VirtIOPMEMResp;
> > > > > +
> > > > > +typedef struct VirtIODeviceRequest {
> > > > > +    VirtQueueElement elem;
> > > > > +    int fd;
> > > > > +    VirtIOPMEM *pmem;
> > > > > +    VirtIOPMEMResp resp;
> > > > > +} VirtIODeviceRequest;
> > > > > +
> > > > > +static int worker_cb(void *opaque)
> > > > > +{
> > > > > +    VirtIODeviceRequest *req = opaque;
> > > > > +    int err = 0;
> > > > > +
> > > > > +    /* flush raw backing image */
> > > > > +    err = fsync(req->fd);
> > > > > +    if (err != 0) {
> > > > > +        err = errno;
> > > > > +    }
> > > > > +    req->resp.ret = err;
> > > > 
> > > > Host question: are you returning the guest errno code to the host?
> > > 
> > > No. I am returning error code from the host in-case of host fsync
> > > failure, otherwise returning zero.
> > 
> > I think that's what Luiz meant.  errno constants are not portable
> > between operating systems and architectures.  Therefore they cannot be
> > used in external interfaces in software that expects to communicate with
> > other systems.
> 
> Oh, thanks. Only saw this email now.
> 
> > It will be necessary to define specific constants for virtio-pmem
> > instead of passing errno from the host to guest.
> 
> Yes, defining your own constants work. But I think the only fsync()
> error that will make sense for the guest is EIO. The other errors
> only make sense for the host.

Agree.

Thanks,
Pankaj
