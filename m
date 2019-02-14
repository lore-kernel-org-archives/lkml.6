Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4126AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136D2218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbfBNVRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:17:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:24020 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392553AbfBNVRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:17:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 13:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,370,1544515200"; 
   d="scan'208";a="134404045"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2019 13:17:28 -0800
Date:   Thu, 14 Feb 2019 14:17:15 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc:     Takao Indoh <indou.takao@fujitsu.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190214211715.GA9613@localhost.localdomain>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
 <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:44:48PM -0800, Elliott, Robert (Persistent Memory) wrote:
> 
> The PCIe and NVMe specifications dosn't standardize a way to tell the device
> when to use RO, which leads to system workarounds like this.
> 
> The Enable Relaxed Ordering bit defined by PCIe tells the device when it
> cannot use RO, but doesn't advise when it should or shall use RO.

In general, it is always safe to use RO for any memory writes that have
no order dependency on other RO writes. It's impossible for the PCIe spec
to standardize what packets may or may not have a such a dependency:
that is specific to the higher protocol of device, so RO behavior has
to be out of scope for PCI spec. It only says to don't use it when it
isn't safe to do so, like for MSI.

For NVMe, there is no order dependency on PRP/SGL data since it is
perfectly valid for the controller to transfer these out-of-order
already. Letting the memory controller re-order them would also have to
be spec compliant.

The host is not allowed to assume the data is there until it observes
the CQE for that command, so the CQE is the only NVMe protocol dev->host
transfer that has a strict order depenency and not valid for RO (you
risk data corruption if you do this wrong).

The NVMe spec does't spell this out, but some controller implementations
do this today anyway. If it is really that confusing to hardware vendors,
though, I don't think it'd be harmful to propose an ECN to clarify
appropriate RO usage, and also a plus if it would get more vendors to
take notice of this optimization.
 
> For SCSI Express (SOP+PQI), we were going to allow specifying these
> on a per-command basis:
> * TLP attributes (No Snoop, Relaxed Ordering, ID-based Ordering)
> * TLP processing hints (Processing Hints and Steering Tags)
>
> to be used by the data transfers for the command. In some systems, one
> setting per queue or per device might suffice. Transactions to the
> queues and doorbells require stronger ordering.
> 
> For this workaround:
> * making an extra pass through the SGL to set the address bit is
> inefficient; it should be done as the SGL is created.
> * why doesn't it support PRP Lists?
> * how does this interact with an iommu, if there is one? Must the
> address with bit 56 also be granted permission, or is that
> stripped off before any iommu comparisons?
