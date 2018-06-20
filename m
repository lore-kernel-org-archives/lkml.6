Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF90C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B537320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jQp64O6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B537320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeFTKKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:10:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeFTKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wphsx1ie+vTTS1ccDffy8jDITyX2/OntPApbDAJa+rI=; b=jQp64O6htK4v7GaYkXTUApwU/
        iJ0qhYXB6+ykubcjn5RvgNqK5J30xUwEdC9VNoRMhsALkpvrPmkuCqniLNd8fvxWwnrrghKP9J9VD
        MfuVVmiSdKgBopjqqYRI+hyQbkMcsxOvKj6SBCqvxurCJIah+0tQbMGaq9T20UpYv59Yg4TaVrhZL
        qnZsLLgI9BKDW/Xc61mrg4+YXELWHw/0qwpioB4pBOV0Fxycv3ytM9ZvTcnzbm1ZIw64GwEURL0Rc
        VGymFj/7sEaIC4m6m+XjXGHPY3q6Qc4gC0AJ9wn/isH6aSAtd1fqQ5QKqrdfIfUQUiE6CW5FV6w1C
        oXyvPMrsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVa4F-0001LX-Kg; Wed, 20 Jun 2018 10:10:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68F4D2029FA0A; Wed, 20 Jun 2018 12:10:21 +0200 (CEST)
Date:   Wed, 20 Jun 2018 12:10:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 6/9] x86: prevent inline distortion by paravirt ops
Message-ID: <20180620101021.GA2530@hirez.programming.kicks-ass.net>
References: <20180619194854.69486-1-namit@vmware.com>
 <20180619194854.69486-7-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194854.69486-7-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:48:51PM -0700, Nadav Amit wrote:
> +#define paravirt_alt							\
> +	"PARAVIRT_CALL type=\"%c[paravirt_typenum]\""			\
> +	" clobber=\"%c[paravirt_clobber]\""				\
> +	" pv_opptr=\"%c[paravirt_opptr]\""

That wants to be:

+     " pv_opptr=\"%c[paravirt_opptr]\";"

And other than that I would suggest: 's/paravirt_alt/paravirt_call/g'.

