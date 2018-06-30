Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC566C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40732549B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/mkcPX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40732549B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeF3UlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbeF3UlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:41:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28B22549A;
        Sat, 30 Jun 2018 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530391262;
        bh=XaWkty2LvxM/KIe16XUrDmVndxzR9bG6ZALL6imLe8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/mkcPX3tXLTd+i0/mhJYVChhC6hGFLTRVh1IBNrFPNF9GRaPGT1r7iesNSJE7lMk
         9NctboND/jRzK1UsAFMjX7RH3Jh1fVyQtw8CsnqRP5Pc25kFDtIyOLw0Xt8bs4zJdH
         qLjsrlSxKPJHk5qvYmnrfujV0FgE5wJ+2WWXQsn4=
Date:   Sat, 30 Jun 2018 15:41:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH 0/4] Expose PCIe AER stats via sysfs
Message-ID: <20180630204100.GF9547@bhelgaas-glaptop.roam.corp.google.com>
References: <20180621234829.224566-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:48:25PM -0700, Rajat Jain wrote:
> This is a follow up to:
> https://lkml.org/lkml/2018/5/22/1057
> 
> Respinning as a new patchset because the old one has been refactored
> to include new patches (that were not part of original), and dropping
> some patches. The major changes are:
> 
> * Provide breakdown of Fatal / non fatal errors separately
> * Include the "total" in the same file
> * do some PCI cleanup before the actual aer_stats stuff
> * Include documentation in the main patch
> * Rename variables / attributes to better match the newer reality.
> 
> Rajat Jain (4):
>   PCI: Move pci_aer_init() and pci_no_aer() declarations to
>     drivers/pci/pci.h
>   PCI/AER: Define and allocate aer_stats structure for AER capable
>     devices
>   PCI/AER: Add sysfs attributes to provide AER stats and breakdown
>   PCI/AER: Add sysfs attributes for rootport cumulative stats
> 
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 122 +++++++++++
>  Documentation/PCI/pcieaer-howto.txt           |   5 +
>  drivers/pci/pci-sysfs.c                       |   3 +
>  drivers/pci/pci.h                             |  11 +
>  drivers/pci/pcie/aer.c                        | 198 +++++++++++++++++-
>  drivers/pci/probe.c                           |   1 +
>  include/linux/pci.h                           |   5 +-
>  7 files changed, 337 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

Applied to pci/aer for v4.19, thanks!
