Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76512087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuhTIrml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfAHS6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:58:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbfAHS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sIpAEAGlSMv194QjCj2KclvPSTcPSpdvrQNngqRckqQ=; b=NuhTIrml0b8OtLtssq8Jlpxyc
        qx/Gf2ta0yggMSmEDqYZHeDkiAlhSTJYuHAqJujFd3Neknpuh0Zq8ztoNsrTz5jLZE0mlFekxDV4j
        UwcjAhRXAQqzdsZkyzLpmv2eri3lEK6koZbH5lbnqb3gyrDN87C8QbSbc2kjoWe6XjSsRPB/LDmcr
        PpU3aeJGT7253eDpDqr7J3c/NHhv5J+NC+IKYVkCNUcCp2yeDVq/euq73X+iQmsLhNrvxgu3USMFW
        /rW3ZKu/IBAwvkoljWxHhMXMCzyQbyFQ2kam9gl+3Cdx1F/7Y5J8hP/qSzYc4pfrkSqxYk8nl9yuR
        QFf5LSu6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggwZV-0003FN-IW; Tue, 08 Jan 2019 18:57:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39E6020280450; Tue,  8 Jan 2019 19:57:51 +0100 (CET)
Date:   Tue, 8 Jan 2019 19:57:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Message-ID: <20190108185751.GB1900@hirez.programming.kicks-ass.net>
References: <20181231072112.21051-1-namit@vmware.com>
 <87zhshe66w.fsf@linux.intel.com>
 <20190107163227.GH14122@hirez.programming.kicks-ass.net>
 <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108172721.GN6118@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:27:21AM -0800, Andi Kleen wrote:
> It doesn't work when the code is modified in place, like the
> patch in the $SUBJECT.

For in-place modification a-la jump_label / static_call etc. we can
'trivially' log the new instruction and the decoder can do matching
in-place kcore adjustments.


