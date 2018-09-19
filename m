Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA672083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA672083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbeITE1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725755AbeITE1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B12E73082A27;
        Wed, 19 Sep 2018 22:47:42 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE9832CFC6;
        Wed, 19 Sep 2018 22:47:41 +0000 (UTC)
Date:   Wed, 19 Sep 2018 16:47:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Alan Cox" <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Message-ID: <20180919164741.76fbcc88@t450s.home>
In-Reply-To: <9184057F7FC11744A2107296B6B8EB1E44721113@fmsmsx101.amr.corp.intel.com>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
        <20180809134417.50de7fe7@t450s.home>
        <20180912174618.GA19551@araj-mobl1.jf.intel.com>
        <20180918215957.0d155684@t450s.home>
        <20180919194617.GA14924@otc-nc-03>
        <9184057F7FC11744A2107296B6B8EB1E44721113@fmsmsx101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Sep 2018 22:47:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 22:25:03 +0000
"Eads, Gage" <gage.eads@intel.com> wrote:

> > This looks good and also addresses Alan's concern that don't
> > silently hide under the rug for all devices. We'll also queue it
> > for testing just to confirm and keep you posted.
> > 
> > Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> >   
> 
> Hi Alex,
> 
> I've confirmed that the patch works as intended for the 8086:270c
> device, and negative tested the warning by commenting out the
> device's entry in known_bogus_vf_intx_pin.
> 
> For what it's worth, my positive test case - launching a QEMU VM with
> a VFIO-owned 0x270c device - did not trigger the warning. This is
> because the change to vfio_pci_config.c caused QEMU to read a
> PCI_INTERRUPT_PIN value of 0, and so didn't execute a codepath that
> calls vfio_pci_get_irq_count(). Instead, I used a simple C program
> that calls the VFIO_DEVICE_GET_IRQ_INFO ioctl for negative testing.
> 
> Also, there's one typo in the comment: 'quite' -> 'quiet'
> 
> Tested-by: Gage Eads <gage.eads@intel.com>

Thanks for the thorough testing, Gage!  So it sounds like we're not
quite generating the desired result.  We'd really like QEMU, as the
predominant userspace driver for VFIO, to generate the warning,
otherwise there's hardly any purpose to having it.  That suggests I
should have put the warning where the config space emulation is setup
rather than the irq count path.  Thanks,

Alex
