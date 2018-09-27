Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68EEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95CC216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95CC216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeI1A1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:27:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1A1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:27:07 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5ahJ-0000z1-L3; Thu, 27 Sep 2018 20:07:33 +0200
Date:   Thu, 27 Sep 2018 20:07:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [patch V3 09/11] x86/mm/cpa: Optimize same protection check
In-Reply-To: <9bf16a03-d54f-d424-46fb-d16a80ec5cc5@intel.com>
Message-ID: <alpine.DEB.2.21.1809272003160.8118@nanos.tec.linutronix.de>
References: <20180917142906.384767038@linutronix.de> <20180917143546.424477581@linutronix.de> <9bf16a03-d54f-d424-46fb-d16a80ec5cc5@intel.com>
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

On Fri, 21 Sep 2018, Dave Hansen wrote:
> On 09/17/2018 07:29 AM, Thomas Gleixner wrote:
> > When the existing mapping is correct and the new requested page protections
> > are the same as the existing ones, then further checks can be omitted and the
> > large page can be preserved. The slow path 4k wise check will not come up with
> > a different result.
> > 
> > Before:
> > 
> >  1G pages checked:                    2
> >  1G pages sameprot:                   0
> >  1G pages preserved:                  0
> >  2M pages checked:                  540
> >  2M pages sameprot:                 466
> >  2M pages preserved:                 47
> >  4K pages checked:               800709
> >  4K pages set-checked:             7668
> > 
> > After:
> > 
> >  1G pages checked:                    2
> >  1G pages sameprot:                   0
> >  1G pages preserved:                  0
> >  2M pages checked:                  538
> >  2M pages sameprot:                 466
> >  2M pages preserved:                 47
> >  4K pages checked:               560642
> >  4K pages set-checked:             7668
> 
> With this new path added, I would have expected "2M pages sameprot" or
> "1G pages sameprot" to go up.  The "checked" pages go down, which makes
> sense, but I don't see either of the "sameprot"s going up.
> 
> I did a quick look back at the stats patch and didn't see any obvious
> buglets that can account for it.  Both that and this code look sane, but
> the stats just don't seem to square for some reason.

sameprot does not go up, because the change merily leaves early when it
detected the same prot and full mapping size. So it really just avoids the
extra scanning of the large pages in 4k steps which obviously does not come
to a different conclusion. So quite the contrary if the same prot count
would go up then the early dropout would be wrong because the 4k loop finds
a violation.

Thanks,

	tglx
