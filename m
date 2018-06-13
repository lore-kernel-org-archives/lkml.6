Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E2F29C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BF820020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BF820020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935740AbeFMNtn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:49:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935515AbeFMNtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE24587A80;
        Wed, 13 Jun 2018 13:49:41 +0000 (UTC)
Received: from redhat.com (ovpn-122-133.rdu2.redhat.com [10.10.122.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 09AD510FD2A5;
        Wed, 13 Jun 2018 13:49:39 +0000 (UTC)
Date:   Wed, 13 Jun 2018 16:49:39 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        david@gibson.dropbear.id.au, cohuck@redhat.com, pawel.moll@arm.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180613161806-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180608063655.GA32080@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608063655.GA32080@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 13:49:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 13:49:42 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 11:36:55PM -0700, Christoph Hellwig wrote:
> > This seems to be what was being asked for in this thread,
> > with comments claiming IOMMU flag adds too much overhead.
> 
> Right now it means implementing a virtual iommu, which I agree is
> way too much overhead.

Well not really. The flag in question will have a desired effect without
a virtual iommu.

> > SEV guys report that they just set the iommu flag and then it all works.
> > I guess if there's translation we can think of this as a kind of iommu.
> > Maybe we should rename PLATFORM_IOMMU to PLARTFORM_TRANSLATION?
> 
> VIRTIO_F_BEHAVES_LIKE_A_REAL_PCI_DEVICE_DONT_TRY_TO_OUTSMART_ME
> 
> as said it's not just translations, it is cache coherence as well.

Well it's only for DMA. So maybe PLATFORM_DMA.

I suspect people will then come and complain that they
do *not* want cache coherence tricks because virtio is
running on a CPU, but we'll see.

> > And apparently some people complain that just setting that flag makes
> > qemu check translation on each access with an unacceptable performance
> > overhead.  Forcing same behaviour for everyone on general principles
> > even without the flag is unlikely to make them happy.
> 
> That sounds like a qemu implementation bug.  If qemu knowns that
> guest physiscall == guest dma space there is no need to check.

Possibly. Or it's possible it's all just theoretical, no one
posted any numbers.

-- 
MST
