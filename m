Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15269C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA74120843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA74120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeGYWer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:34:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:33248 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731243AbeGYWer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:34:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 14:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,402,1526367600"; 
   d="scan'208";a="75931220"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2018 14:21:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D915EF3; Thu, 26 Jul 2018 00:21:22 +0300 (EEST)
Date:   Thu, 26 Jul 2018 00:21:22 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dmitry Malkin <d.malkin@real-time-systems.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180725212122.f2m3cfiqb4az3cb7@black.fi.intel.com>
References: <f1fb3e5e-f18a-9f89-84c5-1dc73e08ceef@real-time-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1fb3e5e-f18a-9f89-84c5-1dc73e08ceef@real-time-systems.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 05:26:02PM +0000, Dmitry Malkin wrote:
> there may be some other reasons which may cause undefined behavior (reboot
> for example):
> 
> in arch/x86/boot/compressed/pgtable_64.c in function paging_prepare():
> 
> 1. structure "paging_config" allocated on stack without setting default
> value for flag "l5_required":
> >>struct paging_config paging_config = {};
> l5_required is set only if CONFIG_X86_5LEVEL is defined

Hm? C99 initializer zeros the structure.

> 2. reading from memory which may be reserved in case of EFI systems:
> >>    ebda_start = *(unsigned short *)0x40e << 4;
> >>    bios_start = *(unsigned short *)0x413 << 10;
> Also, on EFI system without CSM it will results in all zeros. Which will
> place trampoline_start to 0x9d000. And it also may be reserved memory. In
> fact I have such system and it is causes instant reboot (when code starts
> copying to "trampoline_start").

Could you show dmesg from such system?

> 3. paging_prepare(void) returns "struct paging_config". Copy by value. Is it
> really specified by ABI or GCC itself that the second field (which is flag
> "l5_required") will go to RDX register?

https://github.com/hjl-tools/x86-psABI/wiki/x86-64-psABI-1.0.pdf

3.2.3 Parameter Passing

...

Returning of Values
The returning of values is done according to the following algorithm:

...

3.  If the class is INTEGER, the next available register of the sequence
%rax, %rdx is used.

-- 
 Kirill A. Shutemov
