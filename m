Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A5ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD4A20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD4A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeINQOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:14:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728131AbeINQOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:14:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB35EAF4D;
        Fri, 14 Sep 2018 11:00:42 +0000 (UTC)
Date:   Fri, 14 Sep 2018 13:00:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v6 1/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732144BFBC@ORSMSX107.amr.corp.intel.com>
Message-ID: <nycvar.YFH.7.76.1809141259010.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121105330.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144BFBC@ORSMSX107.amr.corp.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Schaufler, Casey wrote:

> > -	return security_ptrace_access_check(task, mode);
> > +	if (!(mode & PTRACE_MODE_NOACCESS_CHK))
> > +		return security_ptrace_access_check(task, mode);
> > +	return 0;
> 
> Because PTRACE_MODE_IBPB includes PTRACE_MODE_NOAUDIT you
> shouldn't need this change. 

That is true, but that's not my concern here. 

	security_ptrace_access_check() -> call_int_hook() -> P->hook.FUNC().

If it's somehow guaranteed that all functions called this ways are fine to 
be called from scheduler context (wrt. locks), then it's all fine and I'll 
happily drop that check.

Is it guaranteed?

Thanks,

-- 
Jiri Kosina
SUSE Labs

