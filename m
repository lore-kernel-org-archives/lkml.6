Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12665C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B403B2177D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fAzZnERp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B403B2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeHMJYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:24:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8IO/Q3Xizwokgt1XtFKixU9s4MPvfjrTtvynynL/VJ0=; b=fAzZnERpi7zW6QdjGDoQt9dEB
        oNQGq25xPUTfITex7vuijxNDMy8cKQAmA02wUBYfEIv9chgrYSieV4xG2vNrNcTsdLuhFE3uMwvtK
        MEuaxL++6EoXBjPvFNAv6BAgELsaK3GUB+y34GfdjK4pGpSN+b3oOIKPsFP7Xg3VJXXEUTtxh6sDV
        nKfVJ36BVsyxQR0qqoa0GPpQucMxcQNtRKtRL2TopCL7YMBst9TO3DBIZvb5x0BF8TewaSL1qhEiI
        2F3ucsObVRc2G/7edqca8C7EP6KMfUFU8g9w/UVTPqXIwIjzosh4NQKvgKuIcLrgz/RtlmfftrR07
        l1G4C8mrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fp6ZW-0008U4-2c; Mon, 13 Aug 2018 06:43:22 +0000
Date:   Sun, 12 Aug 2018 23:43:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
Message-ID: <20180813064321.GA6039@infradead.org>
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
 <1533792728-6304-2-git-send-email-ego@linux.vnet.ibm.com>
 <20180809132743.GB42474@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809132743.GB42474@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:27:43AM -0700, Srikar Dronamraju wrote:
> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-09 11:02:07]:
> 
> > 
> >  int threads_per_core, threads_per_subcore, threads_shift;
> > +bool has_big_cores;
> >  cpumask_t threads_core_mask;
> >  EXPORT_SYMBOL_GPL(threads_per_core);
> >  EXPORT_SYMBOL_GPL(threads_per_subcore);
> >  EXPORT_SYMBOL_GPL(threads_shift);
> > +EXPORT_SYMBOL_GPL(has_big_cores);
> 
> Why do we need EXPORT_SYMBOL_GPL?

Because it is deeply internal, and in that matches the other related
exports.
