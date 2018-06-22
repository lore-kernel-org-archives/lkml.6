Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD96C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01A324736
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01A324736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934268AbeFVS3r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:29:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:6857 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933869AbeFVS3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:29:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 11:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="scan'208";a="210351474"
Received: from hanvin-mobl2.sc.intel.com (HELO hanvin-mobl2.amr.corp.intel.com) ([10.144.152.78])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2018 11:29:45 -0700
Subject: Re: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in
 refresh_ldt_segments()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
 <20180621211754.12757-2-h.peter.anvin@intel.com>
 <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com>
From:   "H. Peter Anvin" <h.peter.anvin@intel.com>
Message-ID: <408ed97a-c64d-c523-c403-4e066d1f34c3@intel.com>
Date:   Fri, 22 Jun 2018 11:29:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/18 07:24, Andy Lutomirski wrote:
> 
> That RPL3 part is false.  The following program does:
> 
> #include <stdio.h>
> 
> int main()
> {
>     unsigned short sel;
>     asm volatile ("mov %%ss, %0" : "=rm" (sel));
>     sel &= ~3;
>     printf("Will write 0x%hx to GS\n", sel);
>     asm volatile ("mov %0, %%gs" :: "rm" (sel & ~3));
>     asm volatile ("mov %%gs, %0" : "=rm" (sel));
>     printf("GS = 0x%hx\n", sel);
>     return 0;
> }
> 
> prints:
> 
> Will write 0x28 to GS
> GS = 0x28
> 
> The x86 architecture is *insane*.
> 
> Other than that, this patch seems generally sensible.  But my
> objection that it's incorrect with FSGSBASE enabled for %fs and %gs
> still applies.
> 

Ugh, you're right... I misremembered.  The CPL simply overrides the RPL
rather than trapping.

We still need to give legacy applications which have zero idea about the
separate bases that apply only to 64-bit mode a way to DTRT.  Requiring
these old crufty applications to do something new is not an option.

As ugly as it is, I'm thinking the Right Thing is to simply make it a
part of the Linux ABI that if the FS or GS selector registers point into
the LDT then we will requalify them; if a 64-bit app does that then they
get that behavior.  This isn't something that will happen
asynchronously, and if a 64-bit process loads an LDT value into FS or
GS, they are considered to have opted in to that behavior.

The only other sensible option is to conditionalize this on the affected
process being in !64-bit mode.  I don't like that myself.

	-hpa
