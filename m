Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF79C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD4C20869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD4C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIEPMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:12:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59184 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIEPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:12:22 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxVGg-0000rr-G8; Wed, 05 Sep 2018 12:42:38 +0200
Date:   Wed, 5 Sep 2018 12:42:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v15 19/26] x86/tsc: calibrate tsc only once
In-Reply-To: <b4f947f1-72e3-8dc1-7e9b-591d92306e55@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809051240560.1416@nanos.tec.linutronix.de>
References: <b4f947f1-72e3-8dc1-7e9b-591d92306e55@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Chuan Hua, Lei wrote:

> > static unsigned long __init get_loops_per_jiffy(void)
> > {
> > 	unsigned long lpj = tsc_khz * KHZ;
> > 
> > 	do_div(lpj, HZ);
> > 	return lpj;
> > }
> Just tried this with 4.19-rc2 on x86(32bit). lpj return as zero which is not
> expected
> After disassembling the code,
> 	0xc1239a9e <+199>:   imul   $0x3e8,0xc12296e4,%edx
> 	0xc1239aa8 <+209>:   xor    %ecx,%ecx
> 	0xc1239aaa <+211>:   test   %edx,%edx
> 	0xc1239aac <+213>:   mov    %eax,%ebx
> 	0xc1239aae <+215>:   je     0xc1239abd <tsc_init+230>
> 	0xc1239ab0 <+217>:   mov    $0x64,%ecx
> 	0xc1239ab5 <+222>:   mov    %edx,%eax
> 	0xc1239ab7 <+224>:   xor    %edx,%edx
> 	0xc1239ab9 <+226>:   div    %ecx
> 	0xc1239abb <+228>:   mov    %eax,%ecx
> 	0xc1239abd <+230>:   mov    %ebx,%eax
> 	0xc1239abf <+232>:   mov    $0x64,%ebx
> 	0xc1239ac4 <+237>:   div    %ebx
> 	0xc1239ac6 <+239>:   mov    %ecx,%edx
> imul will load the result into %edx, %edx supposed to be high 32 bit which is
> not zero,
> It should be zero in this case. both lpj and tsc_khz should be u64 to work
> properly.

Good catch! Care to send a patch?

Thanks,

	tglx
