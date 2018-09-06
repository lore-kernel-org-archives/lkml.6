Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E385C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66E92075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LWoc1Tav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66E92075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeIGAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:21:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeIGAVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=brM57uSLv+79utGzg8/ycxNYkzjduY99pzqRA63hKAc=; b=LWoc1Tavp3UBGn/Kzdb6jAg0d
        8+IkennhCZFzQaCtbuUQx1WN102z+dvfLs5OS5F+W0LpkXfU993HmR5W6UuWVMJj2MZ/43DEv0g2G
        sdTaIQm+ALNGsBUXNZdk5XHnnMkO+DjKYqOXA+xHqIix0AvbNUv1vqvchVYWPSNVguc6VY+ngbZay
        Sapl9eGFwjqsUXmlty3xv/vE0crqtAP+oodRnd4zOY/2NVPpBr3234t8lTcJXd5h+Cevttg98iRk9
        Xp5UY8U/VjiGtv57CgEEfEbITHl6EkMo01BlXK4ayGutGpPvWN3nZlEjEt8NMrfYh8Rt88wYc2wc0
        z9jDfe4YA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy0Cv-0002JJ-MF; Thu, 06 Sep 2018 19:44:50 +0000
Received: by worktop (Postfix, from userid 1000)
        id 6BBB16E0AA9; Thu,  6 Sep 2018 21:44:41 +0200 (CEST)
Date:   Thu, 6 Sep 2018 21:44:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for
 measurements
Message-ID: <20180906194441.GA9358@worktop.programming.kicks-ass.net>
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
 <20180906141524.GF24106@hirez.programming.kicks-ass.net>
 <40894b6f-c421-32fb-39c3-3dddbed5aa91@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40894b6f-c421-32fb-39c3-3dddbed5aa91@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:21:59PM -0700, Reinette Chatre wrote:
> If you do have suggestions on how I can improve the implementation while
> maintaining (or improving) the accuracy of the measurements I would
> greatly appreciate it.

You can reduce the code duplication by using __always_inline functions
with const function arguments.
