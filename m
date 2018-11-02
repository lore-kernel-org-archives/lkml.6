Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78013C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2F2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB2F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeKCDeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:34:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35339 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46FFD3C2CC7;
        Fri,  2 Nov 2018 18:26:01 +0000 (UTC)
Received: from redhat.com (ovpn-124-238.rdu2.redhat.com [10.10.124.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 86D4B60BF1;
        Fri,  2 Nov 2018 18:26:00 +0000 (UTC)
Date:   Fri, 2 Nov 2018 14:26:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Message-ID: <20181102142446-mutt-send-email-mst@kernel.org>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102182123.29420-1-v.mayatskih@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 02 Nov 2018 18:26:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 06:21:22PM +0000, Vitaly Mayatskikh wrote:
> vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
> driver allows VM to reach a near bare-metal disk performance. See IOPS
> numbers below (fio --rw=randread --bs=4k).
> 
> This implementation uses kiocb interface. It is slightly slower than
> going directly through bio, but is simpler and also works with disk
> images placed on a file system.
> 
> # fio num-jobs
> # A: bare metal over block
> # B: bare metal over file
> # C: virtio-blk over block
> # D: virtio-blk over file
> # E: vhost-blk bio over block
> # F: vhost-blk kiocb over block
> # G: vhost-blk kiocb over file
> #
> #  A     B     C    D    E     F     G
> 
> 1  171k  151k  148k 151k 195k  187k  175k
> 2  328k  302k  249k 241k 349k  334k  296k
> 3  479k  437k  179k 174k 501k  464k  404k
> 4  622k  568k  143k 183k 620k  580k  492k
> 5  755k  697k  136k 128k 737k  693k  579k
> 6  887k  808k  131k 120k 830k  782k  640k
> 7  1004k 926k  126k 131k 926k  863k  693k
> 8  1099k 1015k 117k 115k 1001k 931k  712k
> 9  1194k 1119k 115k 111k 1055k 991k  711k
> 10 1278k 1207k 109k 114k 1130k 1046k 695k
> 11 1345k 1280k 110k 108k 1119k 1091k 663k
> 12 1411k 1356k 104k 106k 1201k 1142k 629k
> 13 1466k 1423k 106k 106k 1260k 1170k 607k
> 14 1517k 1486k 103k 106k 1296k 1179k 589k
> 15 1552k 1543k 102k 102k 1322k 1191k 571k
> 16 1480k 1506k 101k 102k 1346k 1202k 566k
> 
> Vitaly Mayatskikh (1):
>   Add vhost_blk driver


Thanks!
Before merging this, I'd like to get some acks from userspace that it's
actually going to be used - e.g. QEMU block maintainers.

>  drivers/vhost/Kconfig  |  13 ++
>  drivers/vhost/Makefile |   3 +
>  drivers/vhost/blk.c    | 510 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 526 insertions(+)
>  create mode 100644 drivers/vhost/blk.c
> 
> -- 
> 2.17.1
