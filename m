Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E74C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B83621A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B83621A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbeHFSoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:44:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:16870 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbeHFSod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:44:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 09:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="62692972"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.32])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2018 09:34:28 -0700
Date:   Mon, 6 Aug 2018 09:34:28 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Kenneth Lee <liguozhu@hisilicon.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Zaibo Xu <xuzaibo@huawei.com>, sanjay.k.kumar@intel.com,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Hao Fang <fanghao11@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, linuxarm@huawei.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cornelia Huck <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 3/7] vfio: add spimdev support
Message-ID: <20180806163428.GB32409@otc-nc-03>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-4-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290F7B@SHSMSX101.ccr.corp.intel.com>
 <20180802034727.GK160746@Turing-Arch-b>
 <AADFC41AFE54684AB9EE6CBC0274A5D19129102C@SHSMSX101.ccr.corp.intel.com>
 <20180802073440.GA91035@Turing-Arch-b>
 <20180802103528.0b863030.cohuck@redhat.com>
 <20180802124327.403b10ab@t450s.home>
 <20180806014004.GF91035@Turing-Arch-b>
 <20180806094940.47c70be9@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806094940.47c70be9@t450s.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:49:40AM -0600, Alex Williamson wrote:
> On Mon, 6 Aug 2018 09:40:04 +0800
> Kenneth Lee <liguozhu@hisilicon.com> wrote:
> > 
> > 1. It supports thousands of processes. Take zip accelerator as an example, any
> > application need data compression/decompression will need to interact with the
> > accelerator. To support that, you have to create tens of thousands of mdev for
> > their usage. I don't think it is a good idea to have so many devices in the
> > system.
> 
> Each mdev is a device, regardless of whether there are hardware
> resources committed to the device, so I don't understand this argument.
>  
> > 2. The application does not want to own the mdev for long. It just need an
> > access point for the hardware service. If it has to interact with an management
> > agent for allocation and release, this makes the problem complex.
> 
> I don't see how the length of the usage plays a role here either.  Are
> you concerned that the time it takes to create and remove an mdev is
> significant compared to the usage time?  Userspace is certainly welcome
> to create a pool of devices, but why should it be the kernel's
> responsibility to dynamically assign resources to an mdev?  What's the
> usage model when resources are unavailable?  It seems there's
> complexity in either case, but it's generally userspace's responsibility
> to impose a policy.
> 

Can vfio dev's created representing an mdev be shared between several 
processes?  It doesn't need to be exclusive.

The path to hardware is established by the processes binding to SVM and
IOMMU ensuring that the PASID is plummed properly.  One can think the 
same hardware is shared between several processes, hardware knows the 
isolation is via the PASID. 

For these cases it isn't required to create a dev per process. 

Cheers,
Ashok
