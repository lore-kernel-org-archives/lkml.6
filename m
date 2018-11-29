Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24215C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9F52081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OV4opozB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9F52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeK3AED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:04:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK3AED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=viT4Erl/lf99MowhyCv9Arfq7SWceDt/JW8of8ieUoo=; b=OV4opozBqhoiA7Ly4z5pQuIEM
        86rlHLMpEalVHMJVULBbjzCuWvGUkboyIaTvdA0jll1km2k2LqjXxxt0ETTyFvckjjzabAr0J4QEH
        xhaBzOBT5vIEscbwANEIN2Hd9X2RFYsxo7CrSlJwCP31j4MlqTpdI38hgtQHjQ17i7daRZb616KvW
        hR3Z/xDrnfNzrWJRj5w8kJiafRyWKq2O5NZj7qKkx6n787nZUoKAnzbCmkxlOFE08q2JNIbbtB6w2
        e7C4bYy/aZzLnka/Jcpylu4B37vieiNZGnH0pNwhBZTZVPbieyveQNX/qyh9gN9mncdJLBWvp6Vw0
        sucts0EdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSLtu-0002Dm-1s; Thu, 29 Nov 2018 12:58:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 635E02029FD58; Thu, 29 Nov 2018 13:58:36 +0100 (CET)
Date:   Thu, 29 Nov 2018 13:58:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v6 00/10] x86/alternative: text_poke() fixes
Message-ID: <20181129125836.GM2131@hirez.programming.kicks-ass.net>
References: <20181120203545.34928-1-namit@vmware.com>
 <20181126103252.GN2113@hirez.programming.kicks-ass.net>
 <60FD8780-DA8B-421F-A136-4CFB6271DD6D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60FD8780-DA8B-421F-A136-4CFB6271DD6D@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:46:09PM +0000, Nadav Amit wrote:

> One small request - on [02/10], since after your review the patch changed to
> be the single line that you provided, I set you as a co-developer. IIUC this
> requires your signed-off-by.

I really wouldn't know. Feel free to do as you with. It's just a few
lines.
