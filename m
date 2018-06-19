Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E7C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0877220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btwVvfHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0877220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030578AbeFSStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:49:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56138 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030283AbeFSStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ny60tXFFGW56tzPrk9E9VM+3xmwqemMW88ML5zYwPjw=; b=btwVvfHuU0YKqDWDbHHsZ1z4z
        N3OkyG/RN9Pjg+sTta+wSHrY+8nVvzMqIqK0BYlsLs/1lms1+luHd1Ln61xVRaeelqSDWd+E+4ohH
        pCr+bxeYC9loJb/0xtNVA7QyE72syc8iTNEzSUXCBFJB7GatpAOv/JfoQNdoBh1uMKMhX49075L2c
        QlS4JJzpvbQFbJBjERc9J5vw/JoUqFU4iY+w+iWYOE3bL3T7IwUJ2PaIUoGOVlygKzvnPEnb6vPi9
        XQ1S8y/dzPHLV8U19XSWmB5T1LzA1u6RLIcOHufiUisEuXFU6sMj1iUBLzOMq1haQn4FuutuVVCvn
        vMGrlSz7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVLeZ-0007Aq-Rh; Tue, 19 Jun 2018 18:46:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AAA02026ACCD; Tue, 19 Jun 2018 20:46:54 +0200 (CEST)
Date:   Tue, 19 Jun 2018 20:46:54 +0200
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
Subject: Re: [PATCH v10 1/7] x86/tsc: remove tsc_disabled flag
Message-ID: <20180619184654.GG2494@hirez.programming.kicks-ass.net>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-2-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806191928040.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806191928040.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 07:32:49PM +0200, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Pavel Tatashin wrote:
> 
> > tsc_disabled is set when notsc is passed as kernel parameter. The reason we
> > have notsc is to avoid timing problems on multi-socket systems.  We already
> > have a mechanism, however, to detect and resolve these issues by invoking
> > tsc unstable path. Thus, make notsc to behave the same as tsc=unstable.
> 
> notsc also excludes TSC from being used at all

It does not; there is TSC usage even if you boot with notsc on. See how
it does not clear X86_FEATURE_TSC for instance.


