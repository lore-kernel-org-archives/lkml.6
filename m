Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26AEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882472089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AvLrHRmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882472089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeGIPPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:15:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57692 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeGIPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IiXrJCqkGKKz8YQAOZ4MCFXytioFKWp3332mXDhzwB8=; b=AvLrHRmLxAutHbKYRML01lpkP
        mU1t37MbcxaC6GGFqRLzWj4Fj0aK8KUe3dVQLhBPWCe/qtX8kM9J/XnWFaBiZbcUNv3S6E2+zGS1p
        ooeVTd/eJ6fg8j5lZutQfG5ROlrKPEos2xtq+Q5C6BOPfJyrz1A18Q4jyhbVc+JA9R8xpznb2DvjP
        RtavPHLGDLsrrJK8qpcr75IOzpjAra5O8v3bQxj9M9lAGsdcl2MxUjNEd6Jzl15Ho9HMPLlMjkApY
        pdQhyx1k53pd6uMgx2aWGHxPLRYWjkek2+4/M4Pu7hhr623H8NSkGWTFIKU9xM/cw/MDu9Dtwu2I1
        v/C35GzcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcXsG-0002at-DG; Mon, 09 Jul 2018 15:14:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EF9520289CE4; Mon,  9 Jul 2018 17:14:47 +0200 (CEST)
Date:   Mon, 9 Jul 2018 17:14:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709151447.GW2476@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
 <dd7f96e4b08644769865adb302eb7d53@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7f96e4b08644769865adb302eb7d53@AcuMS.aculab.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:02:08PM +0000, David Laight wrote:

> Mostly related to the fpu - probably including the fpu save area.

So for the FPU save area in particular I know we play some horrific
games. As to the rest I really dont know.

I wouldn't mind it being changed, but from a cursory look, I couldn't
see it being anything other than 4 for x86_32.

