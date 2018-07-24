Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D969ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D7D20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D7D20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeGXEsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:48:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:26623 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbeGXEr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:47:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 20:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,396,1526367600"; 
   d="scan'208";a="218517863"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2018 20:43:23 -0700
Date:   Mon, 23 Jul 2018 20:42:06 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 5/7] x86/vdso: Add vDSO functions for direct store
 instructions
Message-ID: <20180724034205.GA245659@romley-ivt3.sc.intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
 <1532350557-98388-6-git-send-email-fenghua.yu@intel.com>
 <10870309-993a-0abc-635a-92c05bbad140@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10870309-993a-0abc-635a-92c05bbad140@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:48:00PM -0700, Andy Lutomirski wrote:
> On 07/23/2018 05:55 AM, Fenghua Yu wrote:
> >The instructions can be implemented in intrinsic functions in future
> >GCC. But the vDSO interfaces are available to user without the
> I'm not convinced that any of this belongs in the vDSO at all.  You could
> just add AT_HWCAP (or AT_HWCAP2) flags for the new instructions. Or user

Thomas asked to use vDSO. Please see the discussion thread:
https://lkml.org/lkml/2018/6/19/316

> code could use CPUID just like for any other new instruction. But, if there
> really is some compelling reason to add this to the vDSO, then see below:
> >+notrace bool __vdso_movdiri_supported(void)
> >+{
> >+	return _vdso_funcs_data->movdiri_supported;
> return static_cpu_has(X86_FEATURE_MOVDIRI);

But boot_cpu_data (used in static_cpu_has) cannot be accessed by user
unless mapped in VVAR. So this change cannot be compiled.

> And all the VVAR stuff can be removed.

The VVAR stuff needs to map the kernel data _vdso_funcs_data to user
space before user can access it.

Thanks.

-Fenghua
