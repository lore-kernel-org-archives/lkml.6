Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27EAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D402084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YzddsPPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D402084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeGSLQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:16:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeGSLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GZU7/Jg9QgvJ79XlZwq4RTMJ18LO6g2ICcqmNVAasQk=; b=YzddsPPvjeGM3KGYUJnhQSG3j
        jrU5OD7uwpX8DziK3sDzxLAGTf2cXTX/Q2EXLGqkl2kpfW3T7QY5YWGJKOWV8PTvCKQxCEyfc+36o
        oD4qoSSSE0iL15N772GQu6b9pEPu433McNbkQT+rCefX4rToAbVlQaSdTegAqrps1SvEuW5PtWo3D
        cT8JxxVn4jywfhme6Ozk/WOF/G07AcO9/n25t8QIxNH3Js1en8WW6Y0oPGvqTV4+zp5Xc/mxDLG7f
        0HuTVhJTvR0JesAcx59sVxuwBMtFPsK1zKd0fF0EVyV52pbkNJEpV9WurgrIHtPpiG2IqF3edypBO
        +XvZc++NQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg6Fi-000561-W0; Thu, 19 Jul 2018 10:33:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F73420289335; Thu, 19 Jul 2018 12:33:40 +0200 (CEST)
Date:   Thu, 19 Jul 2018 12:33:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
Message-ID: <20180719103340.GA2494@hirez.programming.kicks-ass.net>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718022211.6259-21-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:22:06PM -0400, Pavel Tatashin wrote:
> During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
> and the second time in tsc_init().
> 
> Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
> the calibration is done only early, and make tsc_init() to use the values
> already determined in tsc_early_init().
> 
> Sometimes it is not possible to determine tsc early, as the subsystem that
> is required is not yet initialized, in such case try again later in
> tsc_init().

It might be nice to preserve some of the information tglx dug out during
review of all this. Like the various methods of calibrate_*() and their
dependencies.

And I note that this patch relies on the magic of native_calibrate_cpu()
working really early and not exploding in the quick calibration run.
This either wants fixing or documenting.

I think the initial idea was to only do the fast_calibrate (cpuid, msr
and possibly the quick_pit) things early and delay the HPET/PMTIMER
magic until later.
