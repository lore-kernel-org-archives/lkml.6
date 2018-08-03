Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA67C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A1421775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rzHQ6qxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1421775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeHCRse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:48:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43530 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeHCRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zIT2p2+d9OFDxCvEpm23B3eicecu9yq6ED8hD7wibLk=; b=rzHQ6qxhdk+I5oHXlUt+gnZZ4
        wrbJlbA9A0D1b1s1KeXoH8GUmsmcPQoOKPvMh4m5pxd63xjv54iAHAR1vHbshH0BNtRASR3mevFz0
        1rCJ+BgTU7Q8zKJnUKduAHFmraebOdLAe+wa8Qn7iS7wTGNjQzaPm2B/BeMaWmc/8buCtAsDOH/CJ
        MLRkKH8bjAN3oKjCJdhNcD1FlHgrLVcFL9cXRjJ5dc3iSWa7mr8eho9U9Wio2XCBxUymMBNA/Qw3r
        l3h1BnsWjxGd+DBOkYrA6zT273yxCZJx0tReUTkPQvricNRS/3XbJI3J9Y0ZjKDQyy97rk11yMMhx
        oI17ttwMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flcMX-00072T-T2; Fri, 03 Aug 2018 15:51:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9428520267E51; Fri,  3 Aug 2018 17:51:31 +0200 (CEST)
Date:   Fri, 3 Aug 2018 17:51:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, fenghua.yu@intel.com,
        Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] x86/intel_rdt: Restoration of Cache
 Pseudo-Locked regions
Message-ID: <20180803155131.GZ2476@hirez.programming.kicks-ass.net>
References: <cover.1532463771.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1808031343020.1745@nanos.tec.linutronix.de>
 <05a621ec-adce-42b1-ea99-3bd8bac00e16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a621ec-adce-42b1-ea99-3bd8bac00e16@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 08:40:25AM -0700, Reinette Chatre wrote:

> > Can we just get rid of WBINVD?
> 
> While directed at me I am not able to answer this. native_wbinvd() is
> used in a few areas that appear important to me.

Some, like the crusty AGP gart or boot time mem_encrypt usage is fine,
the former nobody cares about, the latter is not interresting because
boot-time.

But others like the drm_cache usage is utter nonense and should really
be replaced like we already do in cpa_flush_array() for PREEMPT, and
this should really be made unconditional.
