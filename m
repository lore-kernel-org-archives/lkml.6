Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBFC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88C420872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cBXOKv3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88C420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754852AbeFTJPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:15:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbeFTJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JFFxQqKJL/axiF2rgD0fif9FN4hU8JRtTGECO2nHdY4=; b=cBXOKv3uhTwhvortJOUZ+8ysV
        0Jxpc4bj/qOVHRcQ9kk0/M2VImOIxm08RyhvqqP33LUThDBJWfORWv3tzfsn/UFRnmDfDWd9Yct10
        zxgE64Xsw/+TKrYDyb6tZvk1UC83Fjh0c9ZbkdXIOD/vC3SFIcAUnYcowZXM83cHK8wbCGsae+fwf
        zQxtXRrH6R9k3mpA5/IWZ4+mDzYFzoBfMEkmHAIh1q4mgnDUOq3Ys4eh6+VELaZMDsWrJsVJ92Y3V
        jjYEV38aUiXv7iQkV5RIoZGVNye9zfjxgq9ZsrP8w3FP/rR6qNVKEBhqj9heMY+WYUb8qoFeksd8+
        +nkFDPDmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVZDC-0007n7-4M; Wed, 20 Jun 2018 09:15:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25FFC2029F1DD; Wed, 20 Jun 2018 11:15:32 +0200 (CEST)
Date:   Wed, 20 Jun 2018 11:15:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
Message-ID: <20180620091532.GK2476@hirez.programming.kicks-ass.net>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-8-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 01:52:10AM +0200, Thomas Gleixner wrote:
>  u64 native_sched_clock(void)
>  {
> +	if (static_branch_likely(&__use_tsc))
> +		return cycles_2_ns(rdtsc());
>  
> +	if (static_branch_unlikely(&tsc_early_enabled)) {
> +		if (tsc_early_sched_clock)
> +			return cycles_2_ns(rdtsc());
>  	}

I'm still puzzled by the entire need for tsc_early_enabled and all that.
Esp. since both branches do the exact same thing:

	return cycles_2_ns(rdtsc());
