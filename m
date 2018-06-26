Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D928C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4826269D1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gr8awIT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4826269D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934572AbeFZLbP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:31:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbeFZLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g3CYTxThdejzIUPC/s3asGC0UiYzpA2rj+ae9F3ytt0=; b=gr8awIT7jRTV7+y7j8A33twen
        cA2/IcV+NJcRffUx3+YriWcsgChaK2hQG4VC75PKonkZyhZJiUCghaTe+65UR5YpK0KcH9HIPNBXn
        o6SZfpAEh31reoKj/eE5nIYoqNW2PhpsXHJEO7+32cnAOZNN6iSkkHzTthOqfK3zOAd6yoj5mP9pO
        K91pv7gfCGklcQP4ri1gXlfQ/ex1xmbODWkUzCuwS4zhM36RBT4xjOZxSDPWD4G43prrDepYt7TVB
        NWNtLsO7vt0U7qvL60BnkYZpzezOxBbJN5oqtsMlR3YGKbM5HPW+F4k3N6SHPak/wfyGwRePZnEmc
        1cVlqEK9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXmBd-00080z-P1; Tue, 26 Jun 2018 11:31:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A4752029F1D9; Tue, 26 Jun 2018 13:31:03 +0200 (CEST)
Date:   Tue, 26 Jun 2018 13:31:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Alan Cox <alan@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 06/16] x86/split_lock: Save #AC setting for split
 lock in firmware in boot time and restore the setting in reboot
Message-ID: <20180626113103.GB2458@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-7-git-send-email-fenghua.yu@intel.com>
 <20180621195823.GD13636@worktop.programming.kicks-ass.net>
 <1529680267.4364.50.camel@linux.intel.com>
 <20180626090521.GF2494@hirez.programming.kicks-ass.net>
 <20180626120221.7fbd0eff@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626120221.7fbd0eff@alans-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:02:21PM +0100, Alan Cox wrote:
> > But then how do we deal with SMIs ?
> 
> On a system doing that level of real time you don't do SMIs.

And where do I buy one of those systems? SMIs are a real problem today,
we need help to make them go away.
