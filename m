Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF9C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7BF2242B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7BF2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeHJTYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:24:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:20893 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbeHJTYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:24:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 09:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,220,1531810800"; 
   d="scan'208";a="75562515"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.32])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2018 09:54:06 -0700
Date:   Fri, 10 Aug 2018 09:54:05 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Message-ID: <20180810165405.GA82669@otc-nc-03>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
 <20180809134417.50de7fe7@t450s.home>
 <20180809230311.GA79703@otc-nc-03>
 <20180810174836.66d9791b@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810174836.66d9791b@alans-desktop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 05:48:36PM +0100, Alan Cox wrote:
> > The hardware isn't public yet, so can't talk about it :-(. Once this patch gets 
> > merged, will let the OSV engagement folks drive it for inclusions. We 
> > could mark this for stable, but i would rather wait until we know the 
> > timeline when they are expecting it to be in. It shouldn't break anything
> > since we are just enforcing the spec.
> 
> Until a new better spec appears...

Well, here we are talking about PIN interrupts and VF's. IMO it would be
weird to allow Virtual functions and physical interrupts other than MSIx.

There are other things in the PCIe spec which could be enforced in SW
or expect devices to implement them.  

What might be ok is probably doing the right thing in SW as done in this
patch, additionaly maybe we can flag them and say "Your device is busted"
message. 

> 
> I know there is always fun when it comes to the people involved in
> such a screwup having to admit it in public but this should IMHO be
> tied to a PCI identifier table so that we know what the afflicted
> hardware is. Otherwise some day in the future SRIOV will grow new features
> and we'll have no idea what particular devices we need to narrow the
> workaround too and indeed not necessarily even know this device is the
> only one, as we'll silently fix other stuff then have it break on us
> later.
> 
> Alan
