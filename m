Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097BBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76462175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfBGQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:24:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:55635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBGQYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:24:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 08:24:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="144987198"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2019 08:24:12 -0800
Date:   Thu, 7 Feb 2019 08:24:12 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Artem S. Tashkinov" <ultrafine@gmx.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: On the issue of CPU model-specific registers write protection in
 UEFI secure boot mode
Message-ID: <20190207162411.GA1144@linux.intel.com>
References: <8d1f8adc-222b-40df-4573-67f28819126c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1f8adc-222b-40df-4573-67f28819126c@gmx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 01:37:16AM +0000, Artem S. Tashkinov wrote:
> Hello LKML,
> 
> Is there a serious reason why CPU MSR is write protected in UEFI secure boot
> mode in Linux?
>  * In order to even use MSR you have to be root to `modprobe msr`.
>  * In order to read/write from/to MSR you have to be root as /dev/cpu/*/msr
> is accessible only by root.
>  * CPU registers don't survive reboot/power cycles.
>  * I'm not a CPU designer but if I'm not mistaken MSR cannot be used to
> create any sort of stealth malware.

Rewriting SYSENTER MSRs allows arbitrary ring0 code execution.  That's
the most obvious example, there are undoubtedly other attacks that can
be concocted by modifying MSRs.

https://lkml.kernel.org/r/20130208191213.GA25081@www.outflux.net
https://lkml.kernel.org/r/149141201983.30815.1240162780237131881.stgit@warthog.procyon.org.uk

> So, I'm asking this question because these registers allow to fine tune
> Intel CPU power parameters ( https://github.com/georgewhewell/undervolt )
> like voltage and others and make it possible to run your system both faster
> and cooler and right now it's not possible under Linux and perfectly
> possible under competing proprietary OSes.
> 
> Of course, the user can
> 
>  * fetch his distro kernel sources
>  * apply a patch from (
> https://github.com/intel/intel-cmt-cat/wiki/UEFI-Secure-Boot-Compatibility )
>  * install his own UEFI certificate
>  * compile, sign and install a patched MSR kernel module
> 
> However this all has to be done for each new kernel release and many Linux
> users just cannot do anything on this list.
> 
> Best regards,
> Artem
