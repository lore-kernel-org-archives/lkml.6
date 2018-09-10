Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E3DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D44820833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D44820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIJNqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:46:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbeIJNqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:46:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1945981663CE;
        Mon, 10 Sep 2018 08:53:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9F5E63F62;
        Mon, 10 Sep 2018 08:53:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C88A64FD7D; Mon, 10 Sep 2018 10:53:16 +0200 (CEST)
Date:   Mon, 10 Sep 2018 10:53:16 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jiandi An <jiandi@amd.com>, brijesh.singh@amd.com,
        srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        virtualization@lists.linux-foundation.org, paulus@samba.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        robh@kernel.org, jean-philippe.brucker@arm.com, mpe@ellerman.id.au,
        thomas.lendacky@amd.com, marc.zyngier@arm.com, linuxram@us.ibm.com,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, joe@perches.com, jiandi.an@amd.com,
        robin.murphy@arm.com, haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180910085316.yzjbvoohqhdng2vb@sirius.home.kraxel.org>
References: <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
 <20180809054013.GA20507@infradead.org>
 <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
 <20180910061947.GA30666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910061947.GA30666@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 08:53:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 08:53:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > this to set the VIRTIO_F_IOMMU_PLATFORM flag. But for example
> > QEMU has the use of iommu_platform attribute disabled for virtio-gpu
> > device.  So would also like to move towards not having to specify
> > the VIRTIO_F_IOMMU_PLATFORM flag.
> 
> Specifying VIRTIO_F_IOMMU_PLATFORM is the right thing for your 
> platform given that you can't directly use physical addresses.
> Please fix qemu so that virtio-gpu works with VIRTIO_F_IOMMU_PLATFORM.

This needs both host and guest side changes btw.

Guest side patch is in drm-misc (a3b815f09bb8) and should land in the
next merge window.

Host side patches are here:
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/virtio-gpu-iommu

Should also land in the next qemu version.

cheers,
  Gerd

