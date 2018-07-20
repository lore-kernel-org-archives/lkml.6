Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5E6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5E6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeGTOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:06:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36560 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbeGTOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:06:33 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgVIA-0001si-MC; Fri, 20 Jul 2018 15:17:54 +0200
Date:   Fri, 20 Jul 2018 15:17:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 08/19] x86/mm: Introduce variables to store number,
 shift and mask of KeyIDs
In-Reply-To: <20180720123415.57m2fqbdjtvnietu@kshutemo-mobl1>
Message-ID: <alpine.DEB.2.21.1807201511560.1580@nanos.tec.linutronix.de>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com> <20180717112029.42378-9-kirill.shutemov@linux.intel.com> <1edc05b0-8371-807e-7cfa-6e8f61ee9b70@intel.com> <20180719102130.b4f6b6v5wg3modtc@kshutemo-mobl1> <alpine.DEB.2.21.1807191436300.1602@nanos.tec.linutronix.de>
 <20180719131245.sxnqsgzvkqriy3o2@kshutemo-mobl1> <alpine.DEB.2.21.1807191515150.1602@nanos.tec.linutronix.de> <20180719132312.75lduymla2uretax@kshutemo-mobl1> <alpine.DEB.2.21.1807191539370.1602@nanos.tec.linutronix.de>
 <20180720123415.57m2fqbdjtvnietu@kshutemo-mobl1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Kirill A. Shutemov wrote:
> On Thu, Jul 19, 2018 at 03:40:41PM +0200, Thomas Gleixner wrote:
> > > > I still don't see how that's supposed to work.
> > > > 
> > > > When the inconsistent CPU is brought up _AFTER_ MKTME is enabled, then how
> > > > does clearing the variables help? It does not magically make all the other
> > > > stuff go away.
> > > 
> > > We don't actually enable MKTME in kernel. BIOS does. Kernel makes choose
> > > to use it or not. Current design targeted to be used by userspace.
> > > So until init we don't have any other stuff to go away. We can just
> > > pretend that MKTME was never there.
> > 
> > Hotplug is not guaranteed to happen _BEFORE_ init. Think about physical
> > hotplug.
> 
> Ouch. I didn't think about this. :/
> 
> In this case I don't see how to handle the situation properly.
> Is it okay to WARN() && pray()?

Not really. First of all, you want to do the initial checking on the boot
CPU and then when secondary CPUs are brought up, verify that they have
matching parameters. If they do not, then we should just shut them down
right away before they can touch anything which is TME related and mark
them as 'don't online again'. That needs some extra logic in the hotplug
code, but I already have played with that for different reasons. Stick a
fat comment into that 'not matching' code path for now and I'll give you
the magic for preventing full bringup after polishing it a bit.

Thanks,

	tglx
