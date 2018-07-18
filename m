Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176CCECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA57E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA57E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeGRWFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:05:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeGRWFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:05:21 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCBB030DECEC;
        Wed, 18 Jul 2018 21:25:33 +0000 (UTC)
Received: from t450s.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40A732010CBA;
        Wed, 18 Jul 2018 21:25:32 +0000 (UTC)
Date:   Wed, 18 Jul 2018 15:25:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        kvm@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>,
        benh@kernel.crashing.org
Subject: Re: [RFC PATCH] vfio/pci: map prefetchble bars as writecombine
Message-ID: <20180718152531.60f7df6b@t450s.home>
In-Reply-To: <CABe79T7eVS5Z5+CkNRfWik=jFeejq54xheUOS=Jc9oU6qX8=kA@mail.gmail.com>
References: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com>
        <20180717092207.775e381c@t450s.home>
        <CABe79T7eVS5Z5+CkNRfWik=jFeejq54xheUOS=Jc9oU6qX8=kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 18 Jul 2018 21:25:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 00:05:18 +0530
Srinath Mannam <srinath.mannam@broadcom.com> wrote:

> Hi Alex,
> 
> On Tue, Jul 17, 2018 at 8:52 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Fri, 13 Jul 2018 10:26:17 +0530
> > Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> >  
> >> By default all BARs map with VMA access permissions
> >> as pgprot_noncached.
> >>
> >> In ARM64 pgprot_noncached is MT_DEVICE_nGnRnE which
> >> is strongly ordered and allows aligned access.
> >> This type of mapping works for NON-PREFETCHABLE bars
> >> containing EP controller registers.
> >> But it restricts PREFETCHABLE bars from doing
> >> unaligned access.
> >>
> >> In CMB NVMe drives PREFETCHABLE bars are required to
> >> map as MT_NORMAL_NC to do unaligned access.
> >>
> >> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> >> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> >> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> >> ---  
> >
> > This has been discussed before:
> >
> > https://www.spinics.net/lists/kvm/msg156548.html  
> Thank you for inputs.. I have gone through the long list of mail chain
> discussion.
> >
> > CC'ing the usual suspects from the previous thread.  I'm not convinced
> > that the patch here has considered anything other than the ARM64
> > implications and it's not clear that it considers compatibility with
> > existing users or devices at all.  Can we guarantee for all devices and
> > use cases that WC is semantically equivalent and preferable to UC?  If
> > not then we need to device an extension to the interface that allows
> > the user to specify WC.  Thanks,
> >  
> To implement with user specified WC flags, many changes need to be done.
> Suppose In DPDK, prefetcable BARs map using WC flag, then also same
> question comes
> that WC may be different for different CPUs.
> As per functionality, both WC and PREFETCHABLE are same, like merging writes and
> typically WC is uncached.
> So, based on prefetchable BARs behavior and usage we need to map bar memory.
> Is it right to map prefetchable BARs as strongly ordered, aligned
> access and uncached?

Is it possible to answer that question generically?  Whether to map a
BAR as UC or WC is generally a question for the driver.  Does the
device handle unaligned accesses?  Does the device need strong memory
ordering?  If this is a driver level question then the driver that
needs to make that decision is the userspace driver.  VFIO is just a
pass-through here and since we don't offer the user a choice of
mappings, we take the safer and more conservative mapping, ie. UC.

You're suggesting that there are many changes to be done if we modify
the vfio interface to expose WC under the user's control rather than
simply transparently impose WC for all mappings, but is that really the
case?  Most devices on most platforms seem to work fine now.  Perhaps WC
is a performance optimization, but this is the first instance I've seen
of it as a functional issue.  Does that suggest that the imposed
alignment on your platform is perhaps unique and the relaxed alignment
should be implemented at the architecture specific memory flags for UC
mappings?  For instance, does x86 require this change for the same
device?  The chance for regressions of other devices on other platforms
seems rather high as proposed. Thanks,

Alex
