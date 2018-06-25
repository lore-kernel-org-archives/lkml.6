Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447BA2598B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447BA2598B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755419AbeFYMwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:52:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:55908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeFYMwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:52:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 05:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="61023959"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga002.fm.intel.com with SMTP; 25 Jun 2018 05:52:05 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Jun 2018 15:52:04 +0300
Date:   Mon, 25 Jun 2018 15:52:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: shpchp: Fix probing logic inversion
Message-ID: <20180625125204.GH2558@lahna.fi.intel.com>
References: <20180621164715.28160-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621164715.28160-1-marc.zyngier@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:47:15PM +0100, Marc Zyngier wrote:
> Until recently, shpc_probe() would bail out pretty early in the
> absence of the SHPC capability. A logic change in the way the
> driver now checks that capability makes it go and probe the
> firmware anyway, with ugly consequences if the system is not
> ACPI based (my arm64 ThunderX is DT driven, and explodes in
> a spectacular way after getting a NULL root bridge from the
> non-existent ACPI tables...).

Could you share log from the failure? I would like to understand a bit
better where it crashes and why.

> Take this opportunity to move the call to shpchp_is_native()
> back into shpc_probe(), making it clear that a non-ACPI system
> is not expected to use this driver.

It is fine to use SHPC in non-ACPI systems. However, in ACPI systems we
should negotiate whether it is the OS or the firmware who handles it.
