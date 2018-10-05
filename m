Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F852098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F852098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeJEQZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:25:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeJEQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:25:28 -0400
Received: from tmo-098-72.customers.d1-online.com ([80.187.98.72] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8MON-0006Vl-24; Fri, 05 Oct 2018 11:27:27 +0200
Date:   Fri, 5 Oct 2018 11:27:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <joro@8bytes.org>
cc:     Borislav Petkov <bp@alien8.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>, linux-mm@kvack.org,
        x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86/mm: Found insecure W+X mapping at address
 (ptrval)/0xc00a0000
In-Reply-To: <20181004080321.GA3630@8bytes.org>
Message-ID: <alpine.DEB.2.21.1810051124320.3960@nanos.tec.linutronix.de>
References: <e75fa739-4bcc-dc30-2606-25d2539d2653@molgen.mpg.de> <alpine.DEB.2.21.1809191004580.1468@nanos.tec.linutronix.de> <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de> <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de> <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de> <20181003212255.GB28361@zn.tnic> <20181004080321.GA3630@8bytes.org>
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

On Thu, 4 Oct 2018, Joerg Roedel wrote:

> On Wed, Oct 03, 2018 at 11:22:55PM +0200, Borislav Petkov wrote:
> > On Fri, Sep 28, 2018 at 04:55:19PM +0200, Thomas Gleixner wrote:
> > > Sorry for the delay and thanks for the data. A quick diff did not reveal
> > > anything obvious. I'll have a closer look and we probably need more (other)
> > > information to nail that down.
> 
> I also triggered this when working in the PTI-x32 code. It always
> happens on a 32-bit PAE kernel for me.
> 
> Tracking it down I ended up in (iirc) arch/x86/mm/pageattr.c
> 	function static_protections():
> 
> 		/*
> 		 * The BIOS area between 640k and 1Mb needs to be executable for
> 		 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
> 		 */
> 	#ifdef CONFIG_PCI_BIOS
> 		if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
> 			pgprot_val(forbidden) |= _PAGE_NX;
> 	#endif
> 
> I think that is the reason we are seeing this in that configuration.

Uurgh. Yes.

If pcibios is enabled and used, need to look at the gory details of that
first, then the W+X check has to exclude that region. We can't do much
about that.

Thanks,

	tglx
