Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06667C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9151217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igAXdNTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfBERJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:09:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfBERJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9R9ZXCz0D3Q3SQKt5ylVRBb//IvkNJnDZEoY0+2+lyk=; b=igAXdNTA+VdYxB5R/7hWhXwf+
        FueeB8VjYlzaMj8/It6/veiRVJW9H47NqmEHvO/qTdpoCHn/l+py7XC3Fc0LZS+TT3zdymOLQywGg
        Nff3B8nlpBIJDNK9cAEfujFS/SmRR8yRiyTL+2Ja317bBYo7NUi8QABSioBqb8R8q1SG4b5ExvghR
        FsNOS82bw/K48UuzLWXYQ7ApZYNW5rgpVIcO5ZKwq9rM++t2t7vlBixf94Nse2TuQ/JBuNy17OXMS
        w0EKIoGoI1gKdMEGlfFYHDfBkI59CwUbKkzdcHD1L5KjRtGssZfNpZi/mw/gDQhQMFrUUwZh50yVr
        iPHqYbhbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr4DZ-0002Rt-S7; Tue, 05 Feb 2019 17:09:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DD682029FA03; Tue,  5 Feb 2019 18:09:04 +0100 (CET)
Date:   Tue, 5 Feb 2019 18:09:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205170904.GH17550@hirez.programming.kicks-ass.net>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190204214044.GN29639@zn.tnic>
 <722af610-da30-2318-9ddd-d991238ce334@intel.com>
 <20190205061801.GC21801@zn.tnic>
 <92020eb5-e2c2-0b33-a366-784e36a69652@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92020eb5-e2c2-0b33-a366-784e36a69652@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 08:46:23AM -0800, Dave Hansen wrote:
> On 2/4/19 10:18 PM, Borislav Petkov wrote:

> > Well, if it breaks old apps, it probably needs to be opt-in anyway.
> 
> Yes, this was my assumption.

It _should_ not break portable code (because RISC has much stronger #AC
requirements).

That said; I really do think we want it default enabled and allow
individual apps to opt-out with a system-wide override to disable the
opt-out.

The cloud vendors and RT thingies will want to disable the opt-out for
example.
