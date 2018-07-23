Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D720852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0D720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbeGWXsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:48:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:30783 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388179AbeGWXsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:48:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 15:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="74865130"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2018 15:45:06 -0700
Date:   Mon, 23 Jul 2018 16:45:08 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: NVMe device specific reset quirk
Message-ID: <20180723224507.GA11656@localhost.localdomain>
References: <20180723221533.4371.90064.stgit@gimli.home>
 <20180723222431.4371.25962.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723222431.4371.25962.stgit@gimli.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:24:31PM -0600, Alex Williamson wrote:
> Take advantage of NVMe devices using a standard interface to quiesce
> the controller prior to reset, including device specific delays before
> and after that reset.  This resolves several NVMe device assignment
> scenarios with two different vendors.  The Intel DC P3700 controller
> has been shown to only work as a VM boot device on the initial VM
> startup, failing after reset or reboot, and also fails to initialize
> after hot-plug into a VM.  Adding a delay after FLR resolves these
> cases.  The Samsung SM961/PM961 (960 EVO) sometimes fails to return
> from FLR with the PCI config space reading back as -1.  A reproducible
> instance of this behavior is resolved by clearing the enable bit in
> the configuration register and waiting for the ready status to clear
> (disabling the NVMe controller) prior to FLR.
> 
> As all NVMe devices make use of this standard interface and the NVMe
> specification also requires PCIe FLR support, we can apply this quirk
> to all devices with matching class code.

Shouldn't this go in the nvme driver's reset_prepare/reset_done callbacks?
