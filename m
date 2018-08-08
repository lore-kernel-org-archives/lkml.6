Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9ABC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898C821A38
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SZbwqnzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898C821A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHHTIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:08:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42682 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHHTIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oxx36Ug6tmCvJSE43lk8X40JWg+YwFnx7aF4rmAI6C0=; b=SZbwqnzzbxx8iIVEjJlJBDL2c
        mWlQREj7vjHZZLwLNB8HudMwjMEkPhdI0My7hG3VAIoKqoOQQ/rmdE3JN+FsARliG6tclKcQeiFtC
        YubR4i4vdXBXQu39dLh1JQEI5r0k4vvHIl194MhdPmVRFVsTO/8m42o8B1d7J6fPIipYuwxGD2Pao
        XkHzFoPEpePCT9VGE8Yjytsr/yw8CvH2VRnCv7UPD3C+p4WIVAa3YPsr/2AmoqpKuqDygJ86lpnh/
        sx56uGgFU054IOYVKT6222vQh7R85dLIr4QIBSJ3kYG97IM7fJaeddK9tY6SNd/g9lkz/kNtBe+Wp
        Y2CVhhMow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnRcL-0003Ii-7b; Wed, 08 Aug 2018 16:47:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DCD220437393; Wed,  8 Aug 2018 18:47:22 +0200 (CEST)
Date:   Wed, 8 Aug 2018 18:47:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "Hindman, Gavin" <gavin.hindman@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180808164722.GR2494@hirez.programming.kicks-ass.net>
References: <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7D3A10EF@ORSMSX110.amr.corp.intel.com>
 <413c3b6f-770d-9549-4249-c2407267b63c@intel.com>
 <20180808074111.GM2494@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7D3A1B83@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D3A1B83@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:55:54PM +0000, Luck, Tony wrote:
> > So _why_ doesn't this work? As said by Tony, that first call should
> > prime the caches, so the second and third calls should not generate any
> > misses.
> 
> How much code/data is involved? If there is a lot, then you may be unlucky
> with cache coloring and the later parts of the "prime the caches" code path
> may evict some lines loaded in the early parts.

Well, Reinette used perf_event_read_local() which is unfortunately quite
a bit. But the inline I proposed is a single load and depending on
rdpmcl() or native_read_pmc() a call to or just a single inline asm
rdpmc instruction.

That should certainly work I think.
