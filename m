Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A136920869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bf1xZD0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A136920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeJTEKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:10:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47488 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJTEKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oPdpR5gcW7QHsL2d/MOijsg33e39WfrLH8GatrLJgno=; b=bf1xZD0tJSCBvniqENLJUkjNZ
        G09Ctify2NSsLBAB8TiRrRpp5VWYhnmJV64GeYfujciY0ql5IfPJ1tRyCO9bflSPxWl+5Sk3YwhE7
        eo+bY573wWpXPtg6G62hCYdAk0pgamV8xNRK8eV7sZbDHrE2xnVW50F9ERmyn9SDr6ymCPyDLqi5g
        mt2Wk3hAzvk5P85odjmg0g7XWYdSnEq+ZmAP25w0i3eUSuQqBFpAqwLk2JapN8YcapEitajJUnplc
        ro59DfyCZSRjLo7fbA7dy5Ul00Sej/hrC5KRuCH+JAUj9D+c63b2sEVjUFlN7Fig8sgYVtBAslyny
        3SeBBVbmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDayb-0000k4-VN; Fri, 19 Oct 2018 20:02:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28503202A40A2; Fri, 19 Oct 2018 22:02:27 +0200 (CEST)
Date:   Fri, 19 Oct 2018 22:02:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 06/13] mm: Pass task instead of task->mm as argument
 to set_dumpable
Message-ID: <20181019200227.GC31016@hirez.programming.kicks-ass.net>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
 <c793fcd092063a68f1de7ce982df2ebb347a3542.1539798901.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c793fcd092063a68f1de7ce982df2ebb347a3542.1539798901.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:59:34AM -0700, Tim Chen wrote:
> Change the argument to set_dumpable from task->mm to task.  This allows us
> to later add hooks to modify a task's property according to whether it is
> a non-dumpable task. Non dumpable tasks demand a higher level of security.
> Changes the dumpable value from in to unsigned int as negative number is
> not allowed.

Per task dumpable doesn't make any kind of sense. Dumpable is about
coredumps, that's an mm property.

If you want to introduce other (per task) state; give that a new name
and check for that explicitly. Don't create confusion like this.
