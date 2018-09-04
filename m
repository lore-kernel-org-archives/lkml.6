Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B34C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F050820661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F050820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeIDMM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:12:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56412 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:12:58 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fx657-0000W5-BF; Tue, 04 Sep 2018 09:49:01 +0200
Date:   Tue, 4 Sep 2018 09:49:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
In-Reply-To: <76cf0aca5a2f8e9b94fd0631274a3d4ad825d077.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1809040947040.1462@nanos.tec.linutronix.de>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>  <1534814186-37067-2-git-send-email-bin.yang@intel.com>  <alpine.DEB.2.21.1809032127550.1462@nanos.tec.linutronix.de> <76cf0aca5a2f8e9b94fd0631274a3d4ad825d077.camel@intel.com>
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

On Tue, 4 Sep 2018, Yang, Bin wrote:
> On Mon, 2018-09-03 at 23:57 +0200, Thomas Gleixner wrote:
> > 
> > The last patch which does the overlap check is equally broken:
> 
> Sorry that I did not understand the broken of last patch.

I meant 4/5 sorry. That's the one which introduces the overlap check and
does this:

> > +       /*
> > +        * Ensure that the requested pgprot does not violate static protection
> > +        * requirements.
> > +        */
> > +       new_prot = static_protections(req_prot, address,
> > +                                     numpages << PAGE_SHIFT, pfn);
> > 
> > It expands new_prot to the whole range even if the protections only
> > overlap. That should not happen in practice, but we have no checks for that
> > at all.
> 
> Below code in patch #3 should cover this check. It will double check
> new_prot in whole large page range.

Which is exactly what is wrong. Read again what I wrote.

Thanks,

	tglx
