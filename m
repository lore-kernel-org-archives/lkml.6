Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB36C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FDF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FDF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeHAV0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbeHAV0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:26:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03500308FB9B;
        Wed,  1 Aug 2018 19:38:57 +0000 (UTC)
Received: from t450s.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 076526A036;
        Wed,  1 Aug 2018 19:38:54 +0000 (UTC)
Date:   Wed, 1 Aug 2018 13:38:54 -0600
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
Message-ID: <20180801133854.62b872f9@t450s.home>
In-Reply-To: <CABe79T7-+qL3siCDc6SeEqEaj3TJQ6O_sVTZzm+wXoYJQWyvbA@mail.gmail.com>
References: <1531457777-11825-1-git-send-email-srinath.mannam@broadcom.com>
        <20180717092207.775e381c@t450s.home>
        <CABe79T7eVS5Z5+CkNRfWik=jFeejq54xheUOS=Jc9oU6qX8=kA@mail.gmail.com>
        <20180718152531.60f7df6b@t450s.home>
        <CABe79T6G2_eegbQ_SOy4W38xXngQE3b4RBPys-tO+yBd2jq_fQ@mail.gmail.com>
        <20180719091252.749f2433@t450s.home>
        <CABe79T7A2ud3jbm9B43S9RQvOdJ0b29NUb3s9yKNTv257sfEMw@mail.gmail.com>
        <20180720142728.572dd2d7@t450s.home>
        <CABe79T5du2Ctx9LuFU8_5eO+9ckm6+BMB0vMf6yL2A_wNwE1TQ@mail.gmail.com>
        <CABe79T7-+qL3siCDc6SeEqEaj3TJQ6O_sVTZzm+wXoYJQWyvbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 01 Aug 2018 19:38:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 23:28:53 +0530
Srinath Mannam <srinath.mannam@broadcom.com> wrote:

> Hi Alex,
> 
> In user space UIO driver (DPDK) implementation, sysfs interface
> "/sys/devices/pci/.../resource0_wc" is used to map prefetchable PCI
> resources as WC.
> Platforms which support write-combining maps of PCI resources have
> arch_can_pci_mmap_wc() flag enabled. So that it allows to map resources as WC.
> In this approach mmap calls "pci_mmap_resource_range" kernel function
> with write_combine parameter set.
> "drivers/pci/pci-sysfs.c" kernel file has this implementation.
> 
> If this approach fits to vfio driver, then code change in vfio driver are
> 
>  if (arch_can_pci_mmap_wc() &&
>      (pci_resource_flags(pdev, index) & IORESOURCE_PREFETCH))
>             vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>         else
> vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> Please provide your feedback.

Let me see if I've got this straight, UIO (in reality pci-sysfs)
provides a separate interface such that a driver can *choose* to get
either a UC or, at their discretion, a WC mapping to a region, and
you're using that as justification that vfio-pci should arbitrarily
convert all existing users from UC mappings to WC mappings, without
their consent, any time the architecture supports WC mappings.  The fact
that pci-sysfs provides separate interfaces such that drives can choose
their preferred mapping attributes only reaffirms to me that this needs
to be a driver decision.  How would we ever validate that a change like
you're proposing above would not introduce regressions for existing
users?  Thanks,

Alex
