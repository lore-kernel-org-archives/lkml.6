Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89850C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F082146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F082146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeITEGT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:06:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:36754 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeITEGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:06:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 15:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="264084669"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2018 15:25:03 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 19 Sep 2018 15:25:03 -0700
Received: from fmsmsx101.amr.corp.intel.com ([169.254.1.66]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.242]) with mapi id 14.03.0319.002;
 Wed, 19 Sep 2018 15:25:03 -0700
From:   "Eads, Gage" <gage.eads@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Alan Cox" <gnomes@lxorguk.ukuu.org.uk>
Subject: RE: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Thread-Topic: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Thread-Index: AQHUMBhwgw3Bqzb7MUON4Icrv3qZWKS4R9+AgDVOToCAChlvgIABCGiA//+1QFA=
Date:   Wed, 19 Sep 2018 22:25:03 +0000
Message-ID: <9184057F7FC11744A2107296B6B8EB1E44721113@fmsmsx101.amr.corp.intel.com>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
 <20180809134417.50de7fe7@t450s.home>
 <20180912174618.GA19551@araj-mobl1.jf.intel.com>
 <20180918215957.0d155684@t450s.home> <20180919194617.GA14924@otc-nc-03>
In-Reply-To: <20180919194617.GA14924@otc-nc-03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTk5ZmVmMzgtNzI4MC00MzIwLWI5M2MtOGE2NWJiZmJiNjQ1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaDExZEtTN3ZxR1FsSXB5QzU2RGtmdUtnNng4XC80MWdDV2p5cUdXV2RYT2NDMDNLUVVUTjdJTlwvRTdpSkV0bWVmIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This looks good and also addresses Alan's concern that don't silently hide under
> the rug for all devices. We'll also queue it for testing just to confirm and keep
> you posted.
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 

Hi Alex,

I've confirmed that the patch works as intended for the 8086:270c device, and negative tested the warning by commenting out the device's entry in known_bogus_vf_intx_pin.

For what it's worth, my positive test case - launching a QEMU VM with a VFIO-owned 0x270c device - did not trigger the warning. This is because the change to vfio_pci_config.c caused QEMU to read a PCI_INTERRUPT_PIN value of 0, and so didn't execute a codepath that calls vfio_pci_get_irq_count(). Instead, I used a simple C program that calls the VFIO_DEVICE_GET_IRQ_INFO ioctl for negative testing.

Also, there's one typo in the comment: 'quite' -> 'quiet'

Tested-by: Gage Eads <gage.eads@intel.com>

Thanks,
Gage
