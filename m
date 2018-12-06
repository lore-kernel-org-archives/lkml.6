Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F93BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F3208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V2UEIS5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77F3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeLFKDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:03:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HlaGWWi8LkZfqvCi2OdFYWS0HdAJJvaQ0rex+PNIDyo=; b=V2UEIS5YF021vFI58ictaGnxp
        g5HPOaY9rAtn8EMcbq4NWDAomLwowHYsDcgR+Z7w2zySR87q7bKO4IRiCGiL7f69kXd6xDRq9UyUp
        Mg/+chWT2r5dzN13N8WfVY6/5pgv+GqJJeYR2kegSYGUGYVJlV77iQumfCeQrn77Ry1AduIfFeFPs
        s5+7CPj4d386BrDajQ8cquyLMdemoP+4uprDFqhPIwBatkyntaAk77JIw0MtabfCEWeI75ChVO3so
        KhPKq2Ix1wsGZ205AAw1V/LohZYt5fdxaxZofnQhL5FT3jH+WJ2DK7QYhb9qA/N9L6LipNCVMUtQJ
        ZrLaoruzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUqVO-0007bk-Pl; Thu, 06 Dec 2018 10:03:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D26C200FBC3D; Thu,  6 Dec 2018 11:03:37 +0100 (CET)
Date:   Thu, 6 Dec 2018 11:03:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 00/14] x86/alternative: text_poke() enhancements
Message-ID: <20181206100337.GF13538@hirez.programming.kicks-ass.net>
References: <20181205013408.47725-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205013408.47725-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:33:54PM -0800, Nadav Amit wrote:
> Which leads me to (b) - the patch-set is big "enough" IMHO. Indeed,
> there are open security issues in the kernel when it comes to W^X.  But
> some people would want to use Andy's temporary mm-struct for other uses.
> So additional security hardening may be left for future patches.

Yes, at the very least we should get the first 7 patches merged, since
they work and clean up the text poking irrespective of all that W^X
munging.

(also, I think you lost my ACK)
