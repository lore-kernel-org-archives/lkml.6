Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B49C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0056A20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="upgnXJwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0056A20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeKAR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:58:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeKAR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3wRT7muTyIV4pFRdJFffwKR8WBv1D/kBcY4kzhUZeC0=; b=upgnXJwQUGiMfYJbAGVnmwE8N
        myBtVphSaxOhWY7XXiwDXYw/MyWlvw1pcLKmi7DCuvp7FLTE1jpTwgdnUxEYk/r3GWbpPSbc2rXHy
        Evwfd668DBShD9RiMEmWPypYiRlmVegV/O1UMofoV5Yod7K+LgSmkiX3p0L4Upd7d1ieIDBmnW6Xo
        4oITbkdmHBN23XRyc6TEudu4MDq5XKhV4EtFCTBglLNyAjgQnM7YlW/MXZXcx51ChcJXZ//mzy16K
        eJEh98IrqiHj7Lni8ZqF22FU/iC8F9CXFKCZvLspuqpu/XT5FUJw2JNxeNWJ7cJlYCjEMmWj+uzy4
        Rp3DYu1sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI8mL-0005eO-Fj; Thu, 01 Nov 2018 08:56:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDB0E20296F15; Thu,  1 Nov 2018 09:56:34 +0100 (CET)
Date:   Thu, 1 Nov 2018 09:56:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk, tglx@linutronix.de,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, bp@suse.de,
        hpa@zytor.com
Subject: Re: [PATCH 3/3] kprobes/x86: Simplify indirect-jump check in
 retpoline
Message-ID: <20181101085634.GC3159@hirez.programming.kicks-ass.net>
References: <cc8f9981-f327-4238-8378-262579584db4@default>
 <20181030083650.GB1459@hirez.programming.kicks-ass.net>
 <849ae148-85cd-5f46-d98b-b827cc9c605c@oracle.com>
 <20181031135320.GC13237@hirez.programming.kicks-ass.net>
 <20181031140032.GB13257@hirez.programming.kicks-ass.net>
 <04040fa2-02c6-9aa6-15fe-609ad21b3426@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04040fa2-02c6-9aa6-15fe-609ad21b3426@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 10:02:14AM +0800, Zhenzhong Duan wrote:
> > Hmm, what about the case where we have RETPOLINE runtime disabled? Then
> > the CALL_NOSPEC alternative patches in an indirect call again, and the
> > retpolines are gone.
> 
> Is RETPOLINE runtime toggle supported in upstream? I don't see such code.

arch/x86/kernel/cpu/bugs.c look for the "nospectre_v2" and related
options. That will avoid X86_FEATURE_RETPOLINE from being set, and thus
the JMP_NOSPEC and CALL_NOSPEC alternatives will not patch out the
indirect jump / call.
