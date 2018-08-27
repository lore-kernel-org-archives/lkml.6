Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3857DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DAB208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DAB208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeH0SLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:11:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:36769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeH0SLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:11:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 07:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="252270665"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2018 07:24:13 -0700
Date:   Mon, 27 Aug 2018 07:22:04 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [RFC PATCH 00/20] x86/intel_rdt: Start abstraction for a second
 arch
Message-ID: <20180827142204.GA223688@romley-ivt3.sc.intel.com>
References: <20180824104519.11203-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 11:44:59AM +0100, James Morse wrote:
> Hi folks,
> 
> ARM have some upcoming CPU features that are similar to Intel RDT. Resctrl
> is the defacto ABI for this sort of thing, but it lives under arch/x86.
> 
> To get existing software working, we need to make resctrl work with arm64.
> This series is the first chunk of that. The aim is to move the filesystem/ABI
> parts into /fs/resctrl, and implement a second arch backend.
> 
> 
> What are the ARM features?
> Future ARM SoCs may have a feature called MPAM: Memory Partitioning and
> Monitoring. This is an umbrella term like RDT, and covers a range of controls
> (like CAT) and monitors (like MBM, CMT).

Please send a link to MPAM spec.

> 
> This series is almost all about CDP. MPAM has equivalent functionality, but
> it doesn't need enabling, and doesn't affect the available closids. (I'll
> try and use Intel terms). MPAM expects the equivalent to IA32_PRQ_MSR to
> be configured with an Instruction closid and a Data closid. These are the
> same for no-CDP, and different otherwise. There is no need for them to be
> adjacent.
> 
> To avoid emulating CDP in arm64's arch code, this series moves all the ABI
> parts of the CDP behaviour, (half the closid-space, each having two
> configurations) into the filesystem parts of resctrl. These will eventually
> be moved to /fs/.

Do you have the patches that moves code to /fs/resctrl?

> 
> MPAMs control and monitor configuration is all memory mapped, the base
> addresses are discovered via firmware tables, so we won't have a table of
> possible resources that just need alloc_enabling.
> 
> Is this it? No... there are another two series of a similar size that
> abstract the MBM/CMT overflow threads and avoid 'fs' code accessing things
> that have moved into the 'hw' arch specific struct.
> 
> 
> I'm after feedback on the general approach taken here, bugs, as there are
> certainly subtleties I've missed, and any strong-opinions on what should be
> arch-specific, and what shouldn't.
> 
> This series is based on v4.18, and can be retrieved from:
> git://linux-arm.org/linux-jm.git -b mpam/resctrl_rework/rfc_1

Could you please publish MPAM patches as well? Then we can have better idea
on ARM's specific code. This patch set only has Intel RDT part.

Thanks.

-Fenghua
