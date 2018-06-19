Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC3BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B4B20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tJc5uYWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B4B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030488AbeFSUY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:24:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757263AbeFSUYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iPfuRF8/lB1y9WixdTQfIf+ZaHyxQoHHsRa1eKKlV6w=; b=tJc5uYWgi69iMOvVgFBOm1dbq
        MzjQJwB49at68n+oZYWbuTpuuRE1qn5YGoFH27dnQDEDiRv3WkGK/kJd97qhty//tHXLS4iONV0lm
        oddT+DeYXbInJwnAOLgUux5wx+uKotHpKnQENLPBjYgxVIlgZlPqGW8/TunOTJDeGz2ULPpfJdJOV
        EwJQ0sNc9znMlqnfO6jVxUS0TpxzOsVQrOdQyWnayp8K26y8chI44dJshtjjvmtI65qzIktDWhZuj
        lS3HCYKX3kG2f6hVE/wlSYb8fghJ1cvgVIKmJ7YkvsMxFGCFOoQB7htsLqtw26XVt/zP/zAbUFv4t
        9/2jtR0EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVNAB-0008No-E7; Tue, 19 Jun 2018 20:23:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E16F20298BAC; Tue, 19 Jun 2018 22:23:36 +0200 (CEST)
Date:   Tue, 19 Jun 2018 22:23:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" 
        <kvm@vger.kernel.org>, Len Brown <len.brown@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [PATCH v11 00/13] Intel SGX1 support
Message-ID: <20180619202336.GU2458@hirez.programming.kicks-ass.net>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180612105011.GA26931@amd>
 <20180619145943.GC8034@linux.intel.com>
 <20180619200414.GA3143@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619200414.GA3143@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:04:15PM +0200, Pavel Machek wrote:
> What are some non-evil uses for SGX?

Soft-TPM is one that was proposed at some time.
