Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73850C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BE12150A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BE12150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935911AbeF2VpM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:45:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935556AbeF2VpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:45:11 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fZ1C9-0008IA-1z; Fri, 29 Jun 2018 23:44:45 +0200
Date:   Fri, 29 Jun 2018 23:44:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
In-Reply-To: <8fdfb671-f223-163b-12cd-3c97d94f91b4@intel.com>
Message-ID: <alpine.DEB.2.21.1806292334180.1595@nanos.tec.linutronix.de>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com> <1530282807-66555-3-git-send-email-fenghua.yu@intel.com> <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com> <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
 <20180629190346.GO18979@romley-ivt3.sc.intel.com> <alpine.DEB.2.21.1806292148510.1595@nanos.tec.linutronix.de> <20180629203844.GA68178@romley-ivt3.sc.intel.com> <8fdfb671-f223-163b-12cd-3c97d94f91b4@intel.com>
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

On Fri, 29 Jun 2018, Dave Hansen wrote:

> On 06/29/2018 01:38 PM, Fenghua Yu wrote:
> > How to handle data that is used in generic code which can be used on
> > non-Intel platform? For exmple, if I do this change for struct efi in
> > include/linux/efi.h because set_bit() sets bits in efi.flags:
> > -       unsigned long flags;
> > +       unsigned long flags __aligned(unsigned long);
> >  } efi;
> > 
> > People may argue that the alignment unnecessarily increases size of 'efi'
> > on non-Intel platform which doesn't have split lock issue. Do we care this
> > argument?
> 
> Unaligned memory accesses are bad, pretty much universally.  This is a
> general good practice that we should have been doing anyway.  Let folks
> complain.  Don't let it stop you.
> 
> Also, look at the size of that structure.  Look at how many pointers it
> has.  Do you think *anyone* is going to complain about an extra 4 bytes
> in a 400-byte structure?

But in the above case the compiler does already the right thing. Why?
Because struct members are aligned to their natural alignment unless the
struct is explicitely marked 'packed'. In that case the programmer has to
take care of the alignment.

Just look at it with pahole:

	struct efi_memory_map      memmap;               /*   280    56 */

	/* XXX last struct has 7 bytes of padding */

	/* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
	long unsigned int          flags;                /*   336     8 */

The issue with the capability arrays is that the data type is u32 which has
the natural alignment of 4 byte, while unsigned long has 8 byte on 64bit.

So just slapping blindly aligned(unsigned long) to anything which is
accessed by locked instructions is pointless.

Thanks,

	tglx




