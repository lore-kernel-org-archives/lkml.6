Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402A52173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1SsAkKfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfBRPHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:07:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfBRPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V7D2tb83B/k3a0MhgQcMPKpK5/X7LK+ZuAqk/vZ9Klo=; b=1SsAkKfQnl9ei2xyBX4OwT7OT
        eliuZz8M4KgN0McIytxvaXv5qqOVzh6BNRG8Cg2dWNzcsmqQcGQ17F2PgBl1UHrPH/Is/TtQIo3Gg
        d2KriK7PI5tCFSiTsH4pqttHYmChKm10yKUZ1qPpLynWTQ6hQeNh7tQXqfUtZux7gXXIw2OSoYRWl
        f8rINapsFGNEonzpQR26+Ari4nmdOw0OnVVh1ffyXPNVq7nwnU+Q0gaD4rXWf7nbO5Wdvoj3z+vxT
        CMa72il8jPuzM2HpbK3Mnm7cyIahaBf1Qt6rsUYvfbTwtufYMUGs4MAjUb+r20b/qzt85XE1c8GBW
        YrZUG53FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvkVY-0007qs-O1; Mon, 18 Feb 2019 15:07:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B66FE201A4F68; Mon, 18 Feb 2019 16:06:57 +0100 (CET)
Date:   Mon, 18 Feb 2019 16:06:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Price <steven.price@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
Message-ID: <20190218150657.GU32494@hirez.programming.kicks-ass.net>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-2-steven.price@arm.com>
 <20190218112922.GT32477@hirez.programming.kicks-ass.net>
 <fe36ed1c-b90d-8062-f7a9-e52d940733c4@arm.com>
 <20190218142951.GA10145@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218142951.GA10145@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 02:29:52PM +0000, Mark Rutland wrote:
> I think that Peter means p?d_huge(x) should imply p?d_large(x), e.g.
> 
> #define pmd_large(x) \
> 	(pmd_sect(x) || pmd_huge(x) || pmd_trans_huge(x))
> 
> ... which should work regardless of CONFIG_HUGETLB_PAGE.

Yep, that.
