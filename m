Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB95C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C772075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o5vIjI4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C772075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030635AbeFSUBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:01:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030407AbeFSUBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o5e71xF0DP1UwbQ0MedHn5Xi66q63qmw7BloKGBmJvI=; b=o5vIjI4S/fUhsWO0ZqJNlz8k4
        CfE/385M9W8r+o1A86lUeWtEia8/TMEnlT0M2Dv01jIXcWOqPlchd+d0a49Ill2V0SicjAGPvUgfb
        QeVhiI+2rTt+O3bi6uU5YO/cVgFsS6OMYiu7vju6UWj4PPJtVW4KLa8ObzaEQunL7xhz6XH8NTLN2
        tjIiCeF+23Ew00vMnXjafqP4mF7jShigiySNlAd5IE1k/xsyj0TMxDKcM7rEpBjsQtLaOjbDGdNug
        MyTvzzfYdakBbloDW88KCUrIO8sIqrLJIVKVzS9CIK8lwE3qyD0FTPHx325W7koFIazlyHSbaCzDW
        Vjcp3ZfuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVMoX-0002WQ-LG; Tue, 19 Jun 2018 20:01:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41F82202A607E; Tue, 19 Jun 2018 22:01:15 +0200 (CEST)
Date:   Tue, 19 Jun 2018 22:01:15 +0200
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
Message-ID: <20180619200115.GH2494@hirez.programming.kicks-ass.net>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-2-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806191928040.10546@nanos.tec.linutronix.de>
 <20180619184654.GG2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806192110230.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806192110230.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:12:45PM +0200, Thomas Gleixner wrote:
> On Tue, 19 Jun 2018, Peter Zijlstra wrote:
> > It does not; there is TSC usage even if you boot with notsc on. See how
> > it does not clear X86_FEATURE_TSC for instance.
> 
> Well, kinda. There is some stuff in the apic calibration which uses TSC
> independent of tsc_disabled, but that's about it.

Still, that precludes booting on hardware without TSC, so what's the
point of having notsc? I'm all for killing the thing.
