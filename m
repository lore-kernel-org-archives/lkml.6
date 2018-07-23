Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1143ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5343820846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5343820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbeGWKJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:09:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388048AbeGWKJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:09:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B255401DEA8;
        Mon, 23 Jul 2018 09:08:49 +0000 (UTC)
Received: from redhat.com (ovpn-120-12.rdu2.redhat.com [10.10.120.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id B2B982026D65;
        Mon, 23 Jul 2018 09:08:43 +0000 (UTC)
Date:   Mon, 23 Jul 2018 12:08:42 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
        jasowang@redhat.com, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
        david@gibson.dropbear.id.au
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180723120511-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720161541-mutt-send-email-mst@kernel.org>
 <8f51d2c6-cc0c-9e42-f0fd-a8a33acc8b83@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f51d2c6-cc0c-9e42-f0fd-a8a33acc8b83@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 09:08:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 09:08:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:58:23AM +0530, Anshuman Khandual wrote:
> On 07/20/2018 06:46 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 20, 2018 at 09:29:37AM +0530, Anshuman Khandual wrote:
> >> This patch series is the follow up on the discussions we had before about
> >> the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
> >> for virito devices (https://patchwork.kernel.org/patch/10417371/). There
> >> were suggestions about doing away with two different paths of transactions
> >> with the host/QEMU, first being the direct GPA and the other being the DMA
> >> API based translations.
> >>
> >> First patch attempts to create a direct GPA mapping based DMA operations
> >> structure called 'virtio_direct_dma_ops' with exact same implementation
> >> of the direct GPA path which virtio core currently has but just wrapped in
> >> a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
> >> the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
> >> existing semantics. The second patch does exactly that inside the function
> >> virtio_finalize_features(). The third patch removes the default direct GPA
> >> path from virtio core forcing it to use DMA API callbacks for all devices.
> >> Now with that change, every device must have a DMA operations structure
> >> associated with it. The fourth patch adds an additional hook which gives
> >> the platform an opportunity to do yet another override if required. This
> >> platform hook can be used on POWER Ultravisor based protected guests to
> >> load up SWIOTLB DMA callbacks to do the required (as discussed previously
> >> in the above mentioned thread how host is allowed to access only parts of
> >> the guest GPA range) bounce buffering into the shared memory for all I/O
> >> scatter gather buffers to be consumed on the host side.
> >>
> >> Please go through these patches and review whether this approach broadly
> >> makes sense. I will appreciate suggestions, inputs, comments regarding
> >> the patches or the approach in general. Thank you.
> > I like how patches 1-3 look. Could you test performance
> > with/without to see whether the extra indirection through
> > use of DMA ops causes a measurable slow-down?
> 
> I ran this simple DD command 10 times where /dev/vda is a virtio block
> device of 10GB size.
> 
> dd if=/dev/zero of=/dev/vda bs=8M count=1024 oflag=direct
> 
> With and without patches bandwidth which has a bit wide range does not
> look that different from each other.
> 
> Without patches
> ===============
> 
> ---------- 1 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.95557 s, 4.4 GB/s
> ---------- 2 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.05176 s, 4.2 GB/s
> ---------- 3 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.88314 s, 4.6 GB/s
> ---------- 4 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.84899 s, 4.6 GB/s
> ---------- 5 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.37184 s, 1.6 GB/s
> ---------- 6 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.9205 s, 4.5 GB/s
> ---------- 7 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 6.85166 s, 1.3 GB/s
> ---------- 8 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.74049 s, 4.9 GB/s
> ---------- 9 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 6.31699 s, 1.4 GB/s
> ---------- 10 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.47057 s, 3.5 GB/s
> 
> 
> With patches
> ============
> 
> ---------- 1 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.25993 s, 3.8 GB/s
> ---------- 2 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.82438 s, 4.7 GB/s
> ---------- 3 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.93856 s, 4.4 GB/s
> ---------- 4 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.83405 s, 4.7 GB/s
> ---------- 5 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 7.50199 s, 1.1 GB/s
> ---------- 6 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.28742 s, 3.8 GB/s
> ---------- 7 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.74958 s, 1.5 GB/s
> ---------- 8 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.99149 s, 4.3 GB/s
> ---------- 9 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.67647 s, 1.5 GB/s
> ---------- 10 ---------
> 1024+0 records in
> 1024+0 records out
> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.93957 s, 2.9 GB/s
> 
> Does this look okay ?

You want to test IOPS with lots of small writes and using
raw ramdisk on host.

-- 
MST
