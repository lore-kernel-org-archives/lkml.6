Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D9420869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDpMJdzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D9420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeIGAGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:06:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48606 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeIGAGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zt5lShDTuY1ZzO+3P83YEWISa3s6DGfkvvVHNsgF6p4=; b=gDpMJdzcePMVY7vNLpRIuFaGe
        zIXLOHxY4zr3I2RU8ZGNt/vS+WxCKbIkTrDTlxm7EGOm4A/nUMCb5kWDDbhaSHK+chQ7ODnyt0C5g
        6SYOQQZjZPUR3o+qQ3QEI0/aN3OjLOHdPf9Jt2jF7syXLxtXCoJPh82u9c1Fs/4RJX2c2lsdoThdi
        5Pj9p8vxx0zkQhznBLHEfWO3vEDBJxgZz8btTFHr1WehpPVEAmktlDgbHbIU1jjHywXgv5kPE9P+i
        Yb0Dr4NS1zAhw7eK+hH/1mlAyfR23FXhatQVNGjCSlzaX2vMRucdqZWp1Hqxg8mKE1vB0CzNFVfR0
        rUPdzmHNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxzxc-0004b8-A6; Thu, 06 Sep 2018 19:29:01 +0000
Received: by worktop (Postfix, from userid 1000)
        id BA7D66E0AA9; Thu,  6 Sep 2018 21:28:52 +0200 (CEST)
Date:   Thu, 6 Sep 2018 21:28:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86: use WRITE_ONCE() when setting PTEs
Message-ID: <20180906192852.GC4816@worktop.programming.kicks-ass.net>
References: <20180902181451.80520-1-namit@vmware.com>
 <8aef58c7-c27c-5df8-69b3-b188dd5f64e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aef58c7-c27c-5df8-69b3-b188dd5f64e8@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:21:38AM -0700, Dave Hansen wrote:
> There's probably a massive number of things that would break if we
> assumed sane 64-bit writes can be observed piecemeal.

Do assume, it has been observed. WRITE_ONCE()/READ_ONCE() are _required_
if you cannot have load/store tearing.

